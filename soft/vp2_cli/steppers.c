#include <conio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "io.h"
#include "io_steppers.h"
#include "io_uart.h"
#include "steppers.h"
#include "cmdline.h"
#include "sdcard.h"
#include "util.h"
#include "rs485.h"

#define STATE_IDLE 0
#define STATE_MOVING_TO 1
#define STATE_MOVING_AWAY 2
#define STATE_BRAKING 3
#define STATE_IDLE_ON_STOP 4

static int8_t step_state[4] = { STATE_IDLE, STATE_IDLE, STATE_IDLE, STATE_IDLE};

int buf_used;
int buf_idx;
int eof = 0;
int preread_ready = 0;
uint8_t command_buf[512];

uint16_t ms1, ms2;
uint16_t ms_max = 0;

uint8_t pop8_with_preread(uint8_t preread) {
	if (eof) return 0;

	if (buf_idx >= buf_used) {
		if (preread_ready) {
			if (preread_ready > 0) {
				buf_used = preread_ready;
				preread_ready = 0;
			} else {
				buf_used = 0;
			};
		} else {
			buf_used = readfile();
		};

		if (buf_used <= 0) {
			eof = 1;
			return 0;
		} else {
			memcpy(command_buf, buf, 512);
		};
		buf_idx = 0;
	};

	if (preread && (preread_ready == 0)) {
		ms1 = CLOCK_MS;
		preread_ready = readfile();
		ms2 = CLOCK_MS;
		if (ms2 - ms1 > ms_max) {
			ms_max = ms2 - ms1;
			cprintf("read time: %d\n", ms_max);
		};
		if (preread_ready == 0) {
			preread_ready = -1;
		};
	};
		
	return command_buf[buf_idx++];
};

#define pop8() pop8_with_preread(0)

int16_t pop16() {
	union {
		int16_t a;
		struct {
			uint8_t data[2];
		} b;
	} shared;
	shared.b.data[0] = pop8();
	shared.b.data[1] = pop8();
	return shared.a;
};

int32_t pop32() {
	union {
		int32_t a;
		struct {
			uint8_t data[4];
		} b;
	} shared;
	shared.b.data[0] = pop8();
	shared.b.data[1] = pop8();
	shared.b.data[2] = pop8();
	shared.b.data[3] = pop8();
	return shared.a;
}

#define BUILD_STATE_NONE 0
#define BUILD_STATE_WAIT_STEP 1
#define BUILD_STATE_WAIT_TOOL_REPLY 2
#define BUILD_STATE_WAIT_TOOL_READY 3
#define BUILD_STATE_WAIT_TOOL_RETRY 4
#define BUILD_STATE_DELAY 5

static int8_t state = BUILD_STATE_NONE;
static int16_t delay = 0;
uint8_t cmd_buf[16];

void
parse_tool(void) {
	uint8_t idx, cmd, len;
	int16_t temp;

	idx = pop8();
	cmd = pop8();
	len = pop8();
	if (idx != 0) {
		cprintf("Unknown tool idx: %d\n", idx);
		eof = 1;
		return;
	};
	switch (cmd) {
		case 3: 
			temp = pop16();
			cprintf("Set temp to %d\n", temp);
			cmd_buf[0] = 0;
			cmd_buf[1] = 3;
			cmd_buf[2] = temp & 0xff;
			cmd_buf[3] = (temp >>8) & 0xff;
			rs485_sendcmd(cmd_buf, 4);
			state = BUILD_STATE_WAIT_TOOL_REPLY;
			break;
		case 4: 
			cmd = pop8();
			cprintf("Set fan pwm to %d\n", cmd);
			break;
		case 27: 
			cmd = pop8();
			cprintf("Toggle ABP to %d\n", cmd);
			break;
		case 31: 
			temp = pop16();
			cprintf("Set platform temp to %d\n", temp);
			cmd_buf[0] = 0;
			cmd_buf[1] = 31;
			cmd_buf[2] = temp & 0xff;
			cmd_buf[3] = (temp >>8) & 0xff;
			rs485_sendcmd(cmd_buf, 4);
			state = BUILD_STATE_WAIT_TOOL_REPLY;
			break;
		case 10: 
			cmd = pop8();
			cprintf("Set fan to %d\n", cmd);
			cmd_buf[0] = 0;
			cmd_buf[1] = 12;
			cmd_buf[2] = cmd & 1;
			rs485_sendcmd(cmd_buf, 3);
			state = BUILD_STATE_WAIT_TOOL_REPLY;
			break;
		default:
			cprintf("Unknown tool command: %d\n", cmd);
			eof = 1;
			break;
	};
};

void
do_build(void) {
	int16_t rc;
	char fname[20];
	uint8_t i, cmd, tool_or_platform = 0;
	uint8_t prev_cmd=0, wait, ch;
	int16_t feedrate;
	int32_t time, x, y, z, a, b, cmd_n, cmd_time;
	char *dir;
	int8_t abort_state = 0;
	int32_t speed, extr;

	state = BUILD_STATE_NONE;
	buf_used = 0;
	buf_idx = 0;
	eof = 0;
	preread_ready = 0;

	rc = opendisk();
	if (rc) return;

	get_arg(1, fname);

	speed = cmdlineGetArgInt(2);
	if (speed <= 0) {
		speed = 50;
	} else {
		speed = 50 * 100 / speed;
		if (speed < 5) {
			speed = 5;
		};
		if (speed > 500 ) {
			speed = 500;
		};
		cprintf("speed: %ld\n", speed);
	};

	extr = cmdlineGetArgInt(3);
	if (extr <= 0) {
		extr = 1000;
	} else {
		cprintf("extruder: %ld\n", extr);
	};
	rc = openfile(fname);
	if (rc) return;
	cmd_n = 0;
	cmd_time = 0;

	while (1) {
		cmd = pop8_with_preread(1);
		if (eof)
			break;

		wait = 1;
		while (wait) {
			if (getc_nowait(&ch)) {
				switch (abort_state) {
					case 0:
						if (ch == 'a') {
							abort_state++;
						} else {
							abort_state = 0;
						};
						break;
					case 1:
						if (ch == 'b') {
							abort_state++;
						} else {
							abort_state = 0;
						};
						break;
					case 2:
						if (ch == 'o') {
							abort_state++;
						} else {
							abort_state = 0;
						};
						break;
					case 3:
						if (ch == 'r') {
							abort_state++;
						} else {
							abort_state = 0;
						};
						break;
					case 4:
						if (ch == 't') {
							cprintf("manual abort\n");
							return;
						} else {
							abort_state = 0;
						};
						break;
				};
			};

			rs485MainLoop();
			steppersMainLoop();
			switch (state) {
				case BUILD_STATE_NONE:
					wait = 0;
					break;
				case BUILD_STATE_WAIT_TOOL_REPLY:
					if (rs485_state == RS485_STATE_IDLE) {
						if ((rs485_cmd_len == 0) && (rs485_buf_used > 0) && (rs485_buf[0] == 0x81)) {
							wait = 0;
							state = BUILD_STATE_NONE;
						} else {
							cprintf("tool command error, aborting\n");
							return;
						};
					};
					break;
				case BUILD_STATE_WAIT_TOOL_READY:
					if (rs485_state == RS485_STATE_IDLE) {
						if ((rs485_cmd_len == 0) && (rs485_buf_used > 0) && (rs485_buf[0] == 0x81)) {
							if (rs485_buf[1] == 1) {
								wait = 0;
								state = BUILD_STATE_NONE;
							} else {
								state = BUILD_STATE_WAIT_TOOL_RETRY;
								delay = CLOCK_MS;
							};
						} else {
							cprintf("tool command error, aborting\n");
							return;
						};
					};
					break;
				case BUILD_STATE_WAIT_TOOL_RETRY:
					if ((int16_t)(CLOCK_MS - delay) > 1000) {
						rs485_sendcmd(cmd_buf, 2);
						state = BUILD_STATE_WAIT_TOOL_READY;
					};
					break;
				case BUILD_STATE_WAIT_STEP:
					wait = 0;
					for (i = 0; i<4; i++) {
						if ((step_state[i] == STATE_IDLE) || (step_state[i] == STATE_IDLE_ON_STOP))
							continue;
						wait = 1;
					}
					if (!wait)
						state = BUILD_STATE_NONE;
					break;
				case BUILD_STATE_DELAY:
					wait = 0;
					state = BUILD_STATE_NONE;
					break;
			};
		};

		if ((prev_cmd == 142) && (cmd != 142)) {
			cprintf("\n");
		};

		cprintf("[%07ld %ld] ", cmd_n, cmd_time/1000L);
		cmd_n++;
		prev_cmd = cmd;

		switch (cmd) {
			case 131:
			case 132:
				if (cmd == 131) {
					dir = "min";
				} else {
					dir = "max";
				};

				cmd = pop8();
				feedrate = pop16();
				time = pop32();
				cprintf("Home %s on axes: %d %d %d %d %d with feed: %d timeout: %ld\n", dir, cmd&1, cmd&2, cmd&4, cmd&8, cmd&16, feedrate, time);
				if (cmd & 1) {
					steppers_move_to(0, -400000l, 200000l * feedrate * 50, 1);
					state = BUILD_STATE_WAIT_STEP;
				};
				if (cmd & 2) {
					steppers_move_to(1, 250000l, 200000l * feedrate * 50, 1);
					state = BUILD_STATE_WAIT_STEP;
				};
				if (cmd & 4) {
					steppers_move_to(2, 250000l, 200000l * feedrate * 50, 1);
					state = BUILD_STATE_WAIT_STEP;
				};
				break;
			case 133:
				time = pop32();
				cprintf("Wait for %ld\n", time);
				break;
			case 134:
				cmd = pop8();
				cprintf("Switch to tool %d\n", cmd);
				break;
			case 135:
			case 141:
				cmd_buf[0] = 0;
				if (cmd == 135) {
					dir = "tool";
					cmd_buf[1] = 22;
				} else {
					dir = "platform";
					cmd_buf[1] = 35;
				};
				rs485_sendcmd(cmd_buf, 2);
				state = BUILD_STATE_WAIT_TOOL_READY;

				cmd = pop8();
				feedrate = pop16();
				time = pop16();
				cprintf("Wait for %s %d for %ds\n", dir, cmd, time);
				break;
			case 136:
				parse_tool();
				break;
			case 137:
				cmd = pop8();
				cprintf("%s axes: %d %d %d %d %d \n", (cmd&128)?"Enable":"Disable", cmd&1, cmd&2, cmd&4, cmd&8, cmd&16);
				if (cmd & 128) {
					STEPPERS_MISC_OUT1 |= STEPPERS_MISC_OUT1_ENABLE_XYZ | STEPPERS_MISC_OUT1_ENABLE_A;
				} else {
					STEPPERS_MISC_OUT1 &= ~(STEPPERS_MISC_OUT1_ENABLE_XYZ | STEPPERS_MISC_OUT1_ENABLE_A);
				};
				break;
			case 139:
				x = pop32();
				y = pop32();
				z = pop32();
				a = pop32();
				b = pop32();
				time = pop32();
				cprintf("Abs move to: %ld %ld %ld %ld %ld at dda %ld\n", x, y, z, a, b, time);
				steppers_move_to(0, x, 200000L * 50 * time, 0);
				steppers_move_to(1, y, 200000L * 50 * time, 0);
				steppers_move_to(2, z, 200000L * 50 * time, 0);
				steppers_move_to(3, a, 200000L * 50 * time, 0);
				state = BUILD_STATE_WAIT_STEP;
				break;
			case 140:
				x = pop32();
				y = pop32();
				z = pop32();
				a = pop32();
				b = pop32();
				cprintf("Set position: %ld %ld %ld %ld %ld\n", x, y, z, a, b);
				STEPPERS_OUT_SELECT1 = 0;
				STEPPERS_REG32(0) = x;
				STEPPERS_SET_GEN = STEPPERS_SET_X_SET_POS;
				STEPPERS_REG32(0) = y;
				STEPPERS_SET_GEN = STEPPERS_SET_Y_SET_POS;
				STEPPERS_REG32(0) = z;
				STEPPERS_SET_GEN = STEPPERS_SET_Z_SET_POS;
				STEPPERS_REG32(0) = a;
				STEPPERS_SET_GEN = STEPPERS_SET_A_SET_POS;
				break;
			case 142:
				x = pop32();
				y = pop32();
				z = pop32();
				a = pop32();
				b = pop32();
				time = pop32();
				cmd = pop8();
				steppers_move_to(0, x, time * speed, cmd & 1);
				steppers_move_to(1, y, time * speed, cmd & 2);
				steppers_move_to(2, z, time * speed, cmd & 4);
				steppers_move_to(3, a * extr/1000, time * speed, cmd & 8);
				state = BUILD_STATE_WAIT_STEP;
				cprintf("Move to (%ld, %ld, %ld, %ld, %ld) in %ld rel: %d   \r", x, y, z, a, b, time, cmd);
				cmd_time += time/1000L;
				break;
			case 144:
				cmd = pop8();
				cprintf("Recall home on axes: %d %d %d %d %d\n", cmd&1, cmd&2, cmd&4, cmd&8, cmd&16);
				STEPPERS_OUT_SELECT1 = 0;
				if (cmd & 1) {
					STEPPERS_REG32(0) = -193000L;
					STEPPERS_SET_GEN = STEPPERS_SET_X_SET_POS;
				};
				if (cmd & 2) {
					STEPPERS_REG32(0) = 110000L;
					STEPPERS_SET_GEN = STEPPERS_SET_Y_SET_POS;
				};
				if (cmd & 4) {
					STEPPERS_REG32(0) = 213900L;
					STEPPERS_SET_GEN = STEPPERS_SET_Z_SET_POS;
				};
				if (cmd & 8) {
					STEPPERS_REG32(0) = 0;
					STEPPERS_SET_GEN = STEPPERS_SET_A_SET_POS;
				};
				break;
			default:
				cprintf("Unknown command: %d\n", cmd);
				eof = 1;
				break;
		};
	};
}

void
do_step(void) {
	char *subcommand;
	int8_t i, a, relative;
	static int32_t time;
	int32_t delta;

	/*
	cprintf("100: %x\n", REG(0x100));
	cprintf("180: %x\n", REG(0x180));
	cprintf("200: %x\n", REG(0x200));
	cprintf("280: %x\n", REG(0x280));
	cprintf("300: %x\n", REG(0x300));
	cprintf("380: %x\n", REG(0x380));
	cprintf("700: %x\n", REG(0x700));
	cprintf("780: %x\n", REG(0x780));
	cprintf("D00: %x\n", REG(0xD00));
	cprintf("D80: %x\n", REG(0xD80));
	*/

	i = 1;
	while (1) {
		subcommand = cmdlineGetArgStr(i);
		i++;

		if (subcommand[0] == '\0')
			break;

		if (strncmp("enable", subcommand, 6) == 0) {
			cprintf("enable motors\n");
			STEPPERS_MISC_OUT1 |= STEPPERS_MISC_OUT1_ENABLE_XYZ | STEPPERS_MISC_OUT1_ENABLE_A;
		} else if (strncmp("disable", subcommand, 7) == 0){
			STEPPERS_MISC_OUT1 &= ~(STEPPERS_MISC_OUT1_ENABLE_XYZ | STEPPERS_MISC_OUT1_ENABLE_A);
			cprintf("disable motors\n");
		} else if (strncmp("time", subcommand, 4) == 0){
			time = cmdlineGetArgInt(i);
			time = time * 50000l;
			i++;
			cprintf("target time: %ld\n", time);
		} else if (strncmp("x", subcommand, 1) == 0){
			subcommand = cmdlineGetArgStr(i);
			relative = 0;
			if (subcommand[0] == '@') {
				relative = 1;
				subcommand++;
			};
			delta = strtol(subcommand, NULL, 0);
			i++;
			cprintf("x to %ld in %ld\n", delta, time);
			steppers_move_to(0, delta, time, relative);
		} else if (strncmp("y", subcommand, 1) == 0){
			subcommand = cmdlineGetArgStr(i);
			relative = 0;
			if (subcommand[0] == '@') {
				relative = 1;
				subcommand++;
			};
			delta = strtol(subcommand, NULL, 0);
			i++;
			cprintf("y to %ld in %ld\n", delta, time);
			steppers_move_to(1, delta, time, relative);
		} else if (strncmp("z", subcommand, 1) == 0){
			subcommand = cmdlineGetArgStr(i);
			relative = 0;
			if (subcommand[0] == '@') {
				relative = 1;
				subcommand++;
			};
			delta = strtol(subcommand, NULL, 0);
			i++;
			cprintf("z to %ld in %ld\n", delta, time);
			steppers_move_to(2, delta, time, relative);
		} else if (strncmp("a", subcommand, 1) == 0){
			subcommand = cmdlineGetArgStr(i);
			relative = 0;
			if (subcommand[0] == '@') {
				relative = 1;
				subcommand++;
			};
			delta = strtol(subcommand, NULL, 0);
			i++;
			cprintf("a to %ld in %ld\n", delta, time);
			steppers_move_to(3, delta, time, relative);
		} else if (strncmp("home", subcommand, 4) == 0){
			cprintf("set to 0\n");
			STEPPERS_REG32(1) = 0;
			STEPPERS_OUT_SELECT1 = 1;
			STEPPERS_SET_GEN = STEPPERS_SET_X_SET_POS;
			STEPPERS_SET_GEN = STEPPERS_SET_Y_SET_POS;
			STEPPERS_SET_GEN = STEPPERS_SET_Z_SET_POS;
			STEPPERS_SET_GEN = STEPPERS_SET_A_SET_POS;
		} else if (strncmp("status", subcommand, 6) == 0){
			STEPPERS_IN_SELECT = STEPPERS_IN_X_CUR_POS;
			STEPPERS_CAPTURE = 2;
			STEPPERS_IN_SELECT = STEPPERS_IN_X_CUR_VEL;
			STEPPERS_CAPTURE = 3;
			STEPPERS_IN_SELECT = STEPPERS_IN_X_ENDSTOP_POS;
			STEPPERS_CAPTURE = 4;
			STEPPERS_IN_SELECT = STEPPERS_IN_Y_CUR_POS;
			STEPPERS_CAPTURE = 5;
			STEPPERS_IN_SELECT = STEPPERS_IN_Y_CUR_VEL;
			STEPPERS_CAPTURE = 6;
			STEPPERS_IN_SELECT = STEPPERS_IN_Y_ENDSTOP_POS;
			STEPPERS_CAPTURE = 7;
			STEPPERS_IN_SELECT = STEPPERS_IN_Z_CUR_POS;
			STEPPERS_CAPTURE = 8;
			STEPPERS_IN_SELECT = STEPPERS_IN_Z_CUR_VEL;
			STEPPERS_CAPTURE = 9;
			STEPPERS_IN_SELECT = STEPPERS_IN_Z_ENDSTOP_POS;
			STEPPERS_CAPTURE = 10;
			STEPPERS_IN_SELECT = STEPPERS_IN_A_CUR_POS;
			STEPPERS_CAPTURE = 11;
			STEPPERS_IN_SELECT = STEPPERS_IN_A_CUR_VEL;
			STEPPERS_CAPTURE = 12;
			STEPPERS_IN_SELECT = STEPPERS_IN_ENDSTOP_CYCLES;
			STEPPERS_CAPTURE = 13;
			a = STEPPERS_MISC_IN1;
			STEPPERS_SET_GEN = STEPPERS_SET_DEBOUNCE_UNLOCK;
			cprintf("    pos     vel    end\n");
			cprintf("x: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(2), STEPPERS_REG32(3), STEPPERS_REG32(4), STEPPERS_REG(13, 0), step_state[0]);
			cprintf("y: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(5), STEPPERS_REG32(6), STEPPERS_REG32(7), STEPPERS_REG(13, 1), step_state[1]);
			cprintf("z: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(8), STEPPERS_REG32(9), STEPPERS_REG32(10), STEPPERS_REG(13, 2), step_state[2]);
			cprintf("a: %8ld %10ld          %d\n", STEPPERS_REG32(11), STEPPERS_REG32(12), step_state[3]);
			cprintf("endstops: %02x\n", a);
		};
	};
	/*
	cprintf("100: %x\n", REG(0x100));
	cprintf("180: %x\n", REG(0x180));
	cprintf("200: %x\n", REG(0x200));
	cprintf("280: %x\n", REG(0x280));
	cprintf("300: %x\n", REG(0x300));
	cprintf("380: %x\n", REG(0x380));
	cprintf("700: %x\n", REG(0x700));
	cprintf("780: %x\n", REG(0x780));
	cprintf("D00: %x\n", REG(0xD00));
	cprintf("D80: %x\n", REG(0xD80));
	*/
}

void steppersInit(void) {
	STEPPERS_MISC_OUT2 = 
		STEPPERS_MISC_OUT2_INVERT_DIR_Y | 
		STEPPERS_MISC_OUT2_INVERT_DIR_Z | 
		STEPPERS_MISC_OUT2_INVERT_DIR_A | 
		STEPPERS_MISC_OUT2_INVERT_END_X | 
		STEPPERS_MISC_OUT2_INVERT_END_Y | 
		STEPPERS_MISC_OUT2_INVERT_END_Z;
	STEPPERS_SET_GEN = STEPPERS_SET_DEBOUNCE_UNLOCK;
}


static int8_t ends_mask[4] = {
	STEPPERS_MISC_IN1_END_X,
	STEPPERS_MISC_IN1_END_Y,
	STEPPERS_MISC_IN1_END_Z,
	0
};

static int8_t rel_mask[4] = {
	STEPPERS_MISC_OUT0_REL_X,
	STEPPERS_MISC_OUT0_REL_Y,
	STEPPERS_MISC_OUT0_REL_Z,
	STEPPERS_MISC_OUT0_REL_A,
};

static int8_t done_mask[4] = {
	STEPPERS_MISC_IN0_DONE_X,
	STEPPERS_MISC_IN0_DONE_Y,
	STEPPERS_MISC_IN0_DONE_Z,
	STEPPERS_MISC_IN0_DONE_A,
};

#define END_MIN 0
#define END_MAX 1
#define END_NONE 2
static int8_t ends_dir[4] = { END_MIN, END_MAX, END_MAX, END_NONE };

#if 0
static int32_t max_speed[4] = { 20 * 3200, 20*3200, 5*3200, 5*3200 };
#endif

void steppers_brake(uint8_t axis) {
	cprintf("axis %d: braking\n", axis);
	steppers_move_to(axis, 0L, 5000000L, 1);
	step_state[axis] = STATE_BRAKING;
};

int8_t steppers_move_to(uint8_t axis, int32_t target_position, uint32_t target_time, uint8_t relative) {
	int8_t set_offset = axis * (STEPPERS_SET_Y_START - STEPPERS_SET_X_START );
	int8_t in_offset = axis * (STEPPERS_IN_Y_CUR_POS - STEPPERS_IN_X_CUR_POS );
	int8_t ends, to_end, brake = 0;
	int32_t cur_position;

	/* cprintf("axis %d: move to %ld in %ld rel: %d\n", axis, target_position, target_time, relative); */
	ends = STEPPERS_MISC_IN1 & ends_mask[axis];

	if (relative) {
		cur_position = 0;
	} else {
		STEPPERS_IN_SELECT = STEPPERS_IN_X_CUR_POS + in_offset;
		STEPPERS_CAPTURE = 0;

		cur_position = STEPPERS_REG32(0);
	};

	to_end = 0;
	if (ends_dir[axis] == END_MIN) {
		if (target_position < cur_position) to_end = 1;
	} else {
		if (target_position > cur_position) to_end = 1;
	};

	if (ends && to_end) {
		steppers_brake(axis);
		return 0;
	} else if (to_end){
		step_state[axis] = STATE_MOVING_TO;
	} else {
		step_state[axis] = STATE_MOVING_AWAY;
	};

	if (relative) {
		STEPPERS_MISC_OUT0 |= rel_mask[axis];
	} else {
		STEPPERS_MISC_OUT0 &= ~rel_mask[axis];
	};

	/* cprintf("axis %d: step cmd: pos: %ld in %ld rel: %d\n", axis, target_position, target_time, relative); */
	STEPPERS_REG32(0) = target_time;
	STEPPERS_OUT_SELECT1 = 0;
	STEPPERS_SET_GEN = STEPPERS_SET_X_SET_TARGET_TIME + set_offset;
	STEPPERS_REG32(0) = target_position;
	STEPPERS_SET_GEN = STEPPERS_SET_X_SET_TARGET_POS + set_offset;
	STEPPERS_SET_GEN = STEPPERS_SET_X_START + set_offset;
	return 1;
}

void steppersMainLoop(void) {
	int8_t ends, done;
	int8_t axis;

	done = STEPPERS_MISC_IN0;
	ends = STEPPERS_MISC_IN1;
	STEPPERS_SET_GEN = STEPPERS_SET_DEBOUNCE_UNLOCK;
	for (axis = 0; axis < 4; axis++) {
		if ((step_state[axis] == STATE_MOVING_TO || step_state[axis] == STATE_MOVING_AWAY || step_state[axis] == STATE_BRAKING) && (done & done_mask[axis])) {
			/* cprintf("axis %d: movement done\n", axis); */
			if (ends & ends_mask[axis]) {
				step_state[axis] = STATE_IDLE_ON_STOP;
			} else {
				step_state[axis] = STATE_IDLE;
			};
		};
		if (step_state[axis] == STATE_MOVING_TO && (ends & ends_mask[axis])) {
			step_state[axis] = STATE_BRAKING;
			cprintf("axis %d: hit endstop, braking\n", axis);
			steppers_brake(axis);
		};
	};
};


