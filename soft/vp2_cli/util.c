#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <conio.h>
#include <ctype.h>
#include "cmdline.h"

#include "io.h"
#include "io_uart.h"

#include "util.h"

void __fastcall__ cputc(char c) {
	if (c == '\n')
		cputc('\r');

	while (!(UART0_STATUS & UART_STATUS_TRDY)) {};
	UART0_DATA = c & 0xff;
}

void putnl() {
        cputc('\r');
        cputc('\n');
}

void puthex4(char ch) {
        if (ch<10) {
                cputc('0' + ch);
        } else {
                cputc('A' - 10 + ch);
        };
}

void puthex(char ch) {
        puthex4((ch>>4) & 0xf);
        puthex4(ch & 0xf);
}

void putstr(const char *ptr) {
        while (*ptr) {
		if (*ptr == '\n')
			cputc('\r');
                cputc(*ptr);
                ptr++;
        };
}

char getc() {
        while ((UART0_STATUS & UART_STATUS_DRDY) == 0) {};
        return UART0_DATA;
}

char getc_nowait(char *res) {
        if ((UART0_STATUS & UART_STATUS_DRDY) == 0)
                return 0;
        *res = UART0_DATA;
        return 1;
}

void dump_buf(char *buf, int16_t cnt) {
	int i, j;

	for (i = 0; i < cnt; i++) {
		puthex(buf[i]);
		cputc(' ');
		if ((i & 15) == 15) {
			cputc('|');
			for (j = i-15; j <= i; j++) {
				if ((buf[j]>31) && (buf[j]<127)) {
					cputc(buf[j]);
				} else {
					cputc('.');
				};
			};
			cputc('|');

			putnl();
		};
	};
	if ((i & 15) != 0) {
		putnl();
	};
}

void dump_long(char *str, uint32_t val) {
	putstr(str);
	puthex((val>>24)&0xff);
	puthex((val>>16)&0xff);
	puthex((val>>8)&0xff);
	puthex(val&0xff);
	putnl();
}

static uint16_t reg = 0x1;
static uint16_t bit;

char
rand(void) {
	bit = (reg & 0x0001) ^
	    ((reg & 0x0004) >> 2) ^
	    ((reg & 0x0008) >> 3) ^
	    ((reg & 0x0020) >> 5);
	reg = (reg >> 1) | (bit << 15);
	return reg ^ (reg>>8);
}

void
get_arg(uint8_t idx, char *fname) {
	char *ptr;
	uint8_t i;

	ptr = cmdlineGetArgStr(idx);
	i = 0;
	while (*ptr && (*ptr != ' ') && (i < 20)) {
		fname[i++] = *(ptr++);
	};
	fname[i] = '\0';
}
