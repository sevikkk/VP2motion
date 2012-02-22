#include <conio.h>
#include <stdint.h>
#include "cmdline.h"
#include "io.h"
#include "io_uart.h"
#include "rs485.h"

static uint8_t crc;
static uint8_t crc_table[] =                // dallas crc lookup table
	{
		0, 94,188,226, 97, 63,221,131,194,156,126, 32,163,253, 31, 65,
		157,195, 33,127,252,162, 64, 30, 95, 1,227,189, 62, 96,130,220,
		35,125,159,193, 66, 28,254,160,225,191, 93, 3,128,222, 60, 98,
		190,224, 2, 92,223,129, 99, 61,124, 34,192,158, 29, 67,161,255,
		70, 24,250,164, 39,121,155,197,132,218, 56,102,229,187, 89, 7,
		219,133,103, 57,186,228, 6, 88, 25, 71,165,251,120, 38,196,154,
		101, 59,217,135, 4, 90,184,230,167,249, 27, 69,198,152,122, 36,
		248,166, 68, 26,153,199, 37,123, 58,100,134,216, 91, 5,231,185,
		140,210, 48,110,237,179, 81, 15, 78, 16,242,172, 47,113,147,205,
		17, 79,173,243,112, 46,204,146,211,141,111, 49,178,236, 14, 80,
		175,241, 19, 77,206,144,114, 44,109, 51,209,143, 12, 82,176,238,
		50,108,142,208, 83, 13,239,177,240,174, 76, 18,145,207, 45,115,
		202,148,118, 40,171,245, 23, 73, 8, 86,180,234,105, 55,213,139,
		87, 9,235,181, 54,104,138,212,149,203, 41,119,244,170, 72, 22,
		233,183, 85, 11,136,214, 52,106, 43,117,151,201, 74, 20,246,168,
		116, 42,200,150, 21, 75,169,247,182,232, 10, 84,215,137,107, 53
	};

static uint8_t update_crc(uint8_t i)
{
        // update the crc global variable and return it
        crc = crc_table[crc^i];
        return crc;
}

static int8_t
rs485_putc(uint8_t c) {
	if (!(UART1_STATUS & UART_STATUS_TRDY))
		return 0;

	UART1_DATA = c;
	return 1;
}

static int8_t
rs485_getc(uint8_t *c) {
	if ((UART1_STATUS & UART_STATUS_DRDY) == 0)
                return 0;
        *c = UART1_DATA;
        return 1;
}

void
rs485Init(void) {
	UART1_DIVIDER = 0x51;
}

#define RS485_BUF_SIZE 32
uint8_t rs485_buf[RS485_BUF_SIZE];
int8_t rs485_buf_used = 0;

uint8_t *rs485_cmd;
int8_t rs485_cmd_len = 0;
int8_t rs485_cmd_retries = 0;

int8_t rs485_state = RS485_STATE_IDLE;
int16_t timeout = 0;

int8_t rc;
uint8_t ch;
uint8_t bytes;

void
rs485MainLoop(void) {
	uint8_t i;
	rc = rs485_getc(&ch);
	if (!rc) {
		switch (rs485_state) {
			case RS485_STATE_IDLE:
			case RS485_STATE_RETRY:
				if (rs485_cmd_len > 0) {
					if (--rs485_cmd_retries <= 0) {
						cprintf("rs485 send failed, no retries left");
						rs485_cmd_len = -1;
						rs485_state = RS485_STATE_IDLE;
						return;
					};
					cprintf("rs485 send cmd:");
					rs485_putc(0xd5);
					rs485_putc(rs485_cmd_len);
					crc = 0;
					for (i=0; i < rs485_cmd_len; i++) {
						rs485_putc(rs485_cmd[i]);
						update_crc(rs485_cmd[i]);
						cprintf(" %02x", rs485_cmd[i]);
					};

					cprintf("\n");
					rs485_putc(crc);
					rs485_state = RS485_STATE_WAIT;
					timeout = CLOCK_MS;
					return;
				};
				break;
			default:
				if (timeout > 0) {
					if ((int16_t)(CLOCK_MS - timeout) > 1000) {
						cprintf("rs485 timeout: %d %d %d\n", CLOCK_MS, timeout, (int16_t)(CLOCK_MS - timeout));
						if (rs485_cmd_len > 0) {
							rs485_state = RS485_STATE_RETRY;
						} else {
							rs485_state = RS485_STATE_IDLE;
						};
						timeout = 0;
						return;
					};
				};
		};
		return;
	};

	switch (rs485_state) {
		case RS485_STATE_IDLE:
		case RS485_STATE_WAIT:
		case RS485_STATE_RETRY:
			if (ch == 0xD5) {
				rs485_state = RS485_STATE_HDR;
				timeout = CLOCK_MS;
			} else {
				cprintf("noise char: %x\n", ch);
			};
			break;
		case RS485_STATE_HDR:
			bytes = ch;
			if (bytes < RS485_BUF_SIZE) {
				rs485_buf_used = 0;
				rs485_state = RS485_STATE_DATA;
				crc = 0;
			} else {
				cprintf("len too big: %d\n", ch);
				rs485_state = RS485_STATE_IDLE;
			};
			break;
		case RS485_STATE_DATA:
			rs485_buf[rs485_buf_used] = ch;
			rs485_buf_used++;
			update_crc(ch);
			if (rs485_buf_used == bytes) {
				rs485_state = RS485_STATE_CRC;
			};
			break;
		case RS485_STATE_CRC:
			if (crc != ch) {
				cprintf("crc error: %x != %x\n", ch, crc);
			}
			cprintf("got packet:");
			for (ch=0; ch <bytes; ch++) {
				cprintf(" %x", rs485_buf[ch]);
			};
			cprintf("\n");
			if (rs485_buf[0] & 128)
				rs485_cmd_len = 0;

			rs485_state = RS485_STATE_IDLE;
			timeout = 0;
	};
}


void
do_sendcmd(void) {
	int8_t i, a;
	char *arg;
	static uint8_t cmd[16];

	i = 1;
	a = 0;
	while (1) {
		arg = cmdlineGetArgStr(i);
		if (arg[0] == '\0')
			break;
		cmd[a] = cmdlineGetArgHex(i);
		i++;
		a++;
	};
	rs485_sendcmd(cmd, a);
}

void rs485_sendcmd(uint8_t *buf, int8_t len) {
	rs485_cmd = buf;
	rs485_cmd_len = len;
	rs485_cmd_retries = 5;
}
