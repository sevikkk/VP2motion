#include <conio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include "io.h"
#include "io_steppers.h"
#include "steppers.h"
#include "cmdline.h"

#define STATE_IDLE 0
#define STATE_MOVING_TO 1
#define STATE_MOVING_AWAY 2
#define STATE_BRAKING 3
#define STATE_IDLE_ON_STOP 4

static int8_t state[4] = { STATE_IDLE, STATE_IDLE, STATE_IDLE, STATE_IDLE};

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
			cprintf("x: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(2), STEPPERS_REG32(3), STEPPERS_REG32(4), STEPPERS_REG(13, 0), state[0]);
			cprintf("y: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(5), STEPPERS_REG32(6), STEPPERS_REG32(7), STEPPERS_REG(13, 1), state[1]);
			cprintf("z: %8ld %10ld %8ld %3d %d\n", STEPPERS_REG32(8), STEPPERS_REG32(9), STEPPERS_REG32(10), STEPPERS_REG(13, 2), state[2]);
			cprintf("a: %8ld %10ld          %d\n", STEPPERS_REG32(11), STEPPERS_REG32(12), state[3]);
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
	state[axis] = STATE_BRAKING;
};

int8_t steppers_move_to(uint8_t axis, int32_t target_position, uint32_t target_time, uint8_t relative) {
	int8_t set_offset = axis * (STEPPERS_SET_Y_START - STEPPERS_SET_X_START );
	int8_t in_offset = axis * (STEPPERS_IN_Y_CUR_POS - STEPPERS_IN_X_CUR_POS );
	int8_t ends, to_end, brake = 0;
	int32_t cur_position;

	cprintf("axis %d: move to %ld in %ld rel: %d\n", axis, target_position, target_time, relative);
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
		state[axis] = STATE_MOVING_TO;
	} else {
		state[axis] = STATE_MOVING_AWAY;
	};

	if (relative) {
		STEPPERS_MISC_OUT0 |= rel_mask[axis];
	} else {
		STEPPERS_MISC_OUT0 &= ~rel_mask[axis];
	};

	cprintf("axis %d: step cmd: pos: %ld in %ld rel: %d\n", axis, target_position, target_time, relative);
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
		if ((state[axis] == STATE_MOVING_TO || state[axis] == STATE_MOVING_AWAY || state[axis] == STATE_BRAKING) && (done & done_mask[axis])) {
			cprintf("axis %d: movement done\n", axis);
			if (ends & ends_mask[axis]) {
				state[axis] = STATE_IDLE_ON_STOP;
			} else {
				state[axis] = STATE_IDLE;
			};
		};
		if (state[axis] == STATE_MOVING_TO && (ends & ends_mask[axis])) {
			state[axis] = STATE_BRAKING;
			cprintf("axis %d: hit endstop, braking\n", axis);
			steppers_brake(axis);
		};
	};
};


