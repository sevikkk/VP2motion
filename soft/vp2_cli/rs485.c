#include <conio.h>
#include <stdint.h>
#include "cmdline.h"
#include "io.h"
#include "io_uart.h"

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

static uint8_t cmd[16];
static int8_t cmd_ptr = 0;

#define IDLE 0
#define HDR 1
#define DATA 2
#define CRC 3

static int8_t state = IDLE;

int8_t rc;
uint8_t ch;
uint8_t bytes;

void
rs485MainLoop(void) {
	rc = rs485_getc(&ch);
	if (!rc)
		return;

	switch (state) {
		case IDLE:
			if (ch == 0xD5) {
				state = HDR;
			} else {
				cprintf("noise char: %x\n", ch);
			};
			break;
		case HDR:
			bytes = ch;
			if (bytes < 16) {
				cmd_ptr = 0;
				state = DATA;
				crc = 0;
			} else {
				cprintf("len too big: %d\n", ch);
				state = IDLE;
			};
			break;
		case DATA:
			cmd[cmd_ptr] = ch;
			cmd_ptr++;
			update_crc(ch);
			if (cmd_ptr == bytes) {
				state = CRC;
			};
			break;
		case CRC:
			if (crc != ch) {
				cprintf("crc error: %x != %x\n", ch, crc);
			}
			cprintf("got packet:");
			for (ch=0; ch <bytes; ch++) {
				cprintf(" %x", cmd[ch]);
			};
			cprintf("\n");
			state = IDLE;
	};
}

void
do_sendcmd(void) {
	int8_t i, a;
	int8_t cmd[8];
	char *arg;

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

	rs485_putc(0xd5);
	rs485_putc(a);
	crc = 0;
	for (i=0; i < a; i++) {
		rs485_putc(cmd[i]);
		update_crc(cmd[i]);
	};

	rs485_putc(crc);
}
