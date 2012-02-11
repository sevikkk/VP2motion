#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <conio.h>
#include <ctype.h>
#include "cmdline.h"

#include "io.h"
#include "io_uart.h"
#include "io_sd.h"
#include "io_maxspi.h"
#include "io_steppers.h"

#include "rs485.h"
#include "steppers.h"
#include "sdcard.h"
#include "util.h"

uint8_t	buf_cmd[16];

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
do_help(void) {
	cprintf("Commands:\n"
		" help           - this help\n"
		" reset          - restart to loader\n"
		" ls             - root directory\n"
		" mv <src> <dst> - rename file\n"
		" rm <file>      - delete file\n"
		" dump <file>    - dump file contents\n"
		"\n"
	);
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

uint8_t
maxspi_ping(void) {
	uint8_t res, tmp;
	// PING
	cprintf("<ping>");
	tmp = MAXSPI_DATA;
	MAXSPI_STATUS = MAXSPI_STATUS_SS;
	MAXSPI_DATA = 0xCD;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	cprintf(" %02x", tmp);
	MAXSPI_DATA = 0x00;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	res = MAXSPI_DATA;
	MAXSPI_STATUS = 0;
	cprintf(" %02x\n", res);

	if (res == 0xab) {
		return 0;
	} else {
		return 1;
	};
}

uint8_t
maxspi_addr(uint32_t addr) {
	uint8_t res, tmp;
	// ADDR
	//cprintf("<addr %06lX>", addr);
	MAXSPI_STATUS = MAXSPI_STATUS_SS;

	MAXSPI_DATA = 0x1;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);

	MAXSPI_DATA = addr & 0xff;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);
	
	MAXSPI_DATA = (addr >> 8)& 0xff;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);
	
	MAXSPI_DATA = (addr >> 16)& 0xff;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);
	
	MAXSPI_DATA = 0x00;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	res = MAXSPI_DATA;
	//cprintf(" %02x\n", res);
	
	MAXSPI_STATUS = 0;
	
	if (res == 0x1) {
		return 0;
	} else {
		return 1;
	};
}


uint8_t
maxspi_read(uint32_t n, uint8_t *buf)
{
	uint16_t i;
	uint8_t res, tmp;

	// READ
	//cprintf("<read %06X>", n);

	MAXSPI_STATUS = MAXSPI_STATUS_SS;

	MAXSPI_DATA = 0x2;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);

	MAXSPI_DATA = 0;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	res = MAXSPI_DATA;
	//cprintf(" %02x |", res);

	for (i=0; i<n; i++) {
		MAXSPI_DATA = 0x00;
		while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
		buf[i] = MAXSPI_DATA;
		//cprintf(" %02x", buf[i]);
	};

	MAXSPI_STATUS = 0;
	//cprintf("\n");

	if (res == 0x1) {
		return 0;
	} else {
		return 1;
	};
}

uint8_t
maxspi_write(uint32_t n, uint8_t *buf)
{
	uint16_t i;
	uint8_t res, tmp;

	// READ
	n = n & (~1);
	MAXSPI_STATUS = MAXSPI_STATUS_SS;
	//cprintf("<write %06X>", n);

	MAXSPI_DATA = 0x3;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);

	for (i=0; i<n; i++) {
		MAXSPI_DATA = buf[i];
		while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
		tmp = MAXSPI_DATA;
		//cprintf("[%02x] %02x", buf[i], tmp);
	};

	MAXSPI_DATA = 0x0;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	res = MAXSPI_DATA;
	//cprintf(" | %02x\n", res);

	MAXSPI_STATUS = 0;

	return res;
}

uint8_t
maxspi_check_busy(uint32_t n)
{
	uint16_t i;
	uint8_t res, tmp;

	// READ
	n = n & (~1);
	MAXSPI_STATUS = MAXSPI_STATUS_SS;

	//cprintf("busy ");
	MAXSPI_DATA = 0x4;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	tmp = MAXSPI_DATA;
	//cprintf(" %02x", tmp);

	for (i=0; i<30000; i++) {
		MAXSPI_DATA = 0x0;
		while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
		res = MAXSPI_DATA;
		//cprintf("|\b");
		if (res == 0x2)
			break;
		MAXSPI_DATA = 0x0;
		while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
		res = MAXSPI_DATA;
		//cprintf("-\b");
		if (res == 0x2)
			break;
	};
	//cprintf("\b\b\b\b\b     \b\b\b\b\b");
	MAXSPI_STATUS = 0;
	if (res != 0x2)
		cprintf("\nstill busy...\n");

	return (res != 0x2);
}

void
do_flash(void) {
	int16_t rc;
	char fname[20];
	uint32_t addr;
	uint32_t last_block;
	int16_t i, k;
	int8_t j;

	rc = opendisk();
	if (rc) return;

	get_arg(1, fname);

	rc = openfile(fname);
	if (rc) return;

	addr = cmdlineGetArgHex(2);

	last_block = 1;
	cprintf("Flashing %s to %06lX\n", fname, addr);

	maxspi_ping();

	cprintf("Clear locks\n");
	maxspi_addr(addr);
	buf_cmd[0] = 0x50;
	buf_cmd[1] = 0x00;
	buf_cmd[2] = 0x60;
	buf_cmd[3] = 0x00;
	buf_cmd[4] = 0xd0;
	buf_cmd[5] = 0x00;
	maxspi_write(6, buf_cmd);

	maxspi_check_busy(1000);

	rc = 1;

	while (rc>0) {
		rc = readfile();
		if (rc <= 0)
			break;

		if ((addr & ~0xffff) != last_block) {
			cprintf("erase @%06lx", addr);

			maxspi_addr(addr);
			buf_cmd[0] = 0x50;
			buf_cmd[1] = 0x00;
			buf_cmd[2] = 0x20;
			buf_cmd[3] = 0x00;
			buf_cmd[4] = 0xd0;
			buf_cmd[5] = 0x00;
			maxspi_write(6, buf_cmd);

			maxspi_check_busy(1000);
			cprintf("\n");
			last_block = addr & ~0xffff;
		};
			
		cprintf("%d @%06lx", rc, addr);

		i = rc;
		k = 0;
		while (i > 0) {
			if (i>=32) {
				j = 15;
			} else {
				j = i;
				if (j&1) j++;
				j = (j >> 1) - 1;
			};

			maxspi_addr(addr);
			buf_cmd[0] = 0x50;
			buf_cmd[1] = 0x00;
			buf_cmd[2] = 0xE8;
			buf_cmd[3] = 0x00;
			buf_cmd[4] = j;
			buf_cmd[5] = 0x00;
			maxspi_write(6, buf_cmd);
			maxspi_check_busy(1000);

			maxspi_addr(addr);
			maxspi_write((j+1)*2, buf+k);

			buf_cmd[0] = 0xD0;
			buf_cmd[1] = 0x00;
			maxspi_write(2, buf_cmd);
			maxspi_check_busy(1000);

			k += 32;
			i -= 32;
			addr += 16;
		};
		cprintf("\n");
	};

	maxspi_addr(addr);
	buf_cmd[0] = 0xff;
	buf_cmd[1] = 0x0;
	maxspi_write(2, buf_cmd);
}

void
do_readmem(void) {
	uint32_t addr;

	addr = cmdlineGetArgHex(1);

	maxspi_ping();

	maxspi_addr(addr);
	buf_cmd[0] = 0xff;
	buf_cmd[1] = 0x0;
	maxspi_write(2, buf_cmd);
	maxspi_addr(addr);
	maxspi_read(512, buf);
	dump_buf(buf, 512);
}

void
do_spi_speed(void) {
	int16_t rc;

	rc = cmdlineGetArgHex(1);
	cprintf("old: %x\n", MAXSPI_DELAY);
	MAXSPI_DELAY = rc;
	cprintf("new: %x\n", MAXSPI_DELAY);
}


void
osram_write(uint8_t c) {
	MAXSPI_STATUS = MAXSPI_STATUS_SS | (1<<MAXSPI_STATUS_DEVNUM_SHIFT);
	MAXSPI_DATA = c;
	while (! (MAXSPI_STATUS & MAXSPI_STATUS_RXRDY)) {};
	c = MAXSPI_DATA;
	MAXSPI_STATUS = 0;
}

void
do_rd(void) {
	uint16_t rc;
	uint8_t val;
	rc = cmdlineGetArgHex(1);

	val = REG(rc);
	cprintf("%04X: %02X\n", rc, (uint16_t)val);
}


void
do_wr(void) {
	uint16_t rc;
	uint8_t val;
	rc = cmdlineGetArgHex(1);
	val = cmdlineGetArgHex(2);

	REG(rc) = val;
	cprintf("%04X <= %02X\n", rc, (uint16_t)val);
}

void
do_rd32(void) {
	uint16_t rc;
	uint32_t val;
	rc = cmdlineGetArgHex(1);

	val = REG32(rc);
	cprintf("%04X: %08lX\n", rc, val);
}


void
do_wr32(void) {
	uint16_t rc;
	uint32_t val;
	rc = cmdlineGetArgHex(1);
	val = cmdlineGetArgHex(2);

	REG32(rc) = val;
	cprintf("%04X <= %08lX\n", rc, val);
}
void
do_readrom(void) {
	int16_t rc;
	uint32_t addr;
	char fname[20];
	int i;

	rc = opendisk();
	if (rc) return;

	get_arg(1, fname);

	rc = openfile(fname);
	if (rc) return;

	addr = cmdlineGetArgHex(2);

	while (1) {
		REG(0xD303) = 1;
		for (i=0; i<512; i++) {
			REG(0xD300) = addr & 0xff;
			REG(0xD301) = (addr >> 8) & 0xff;
			REG(0xD302) = (addr >> 16) & 0xff;
			buf[i] = REG(0xD342);
			addr++;
		};

		dump_buf(buf, 512);
		writeblock(secno, buf);
		rc = readfile();
		if (rc != 512) break;
	};
}

void
do_osram(void) {
	int16_t rc;
	rc = cmdlineGetArgHex(1);

	osram_write(rc);
}

uint8_t osram_init[26] = {
	0x03, 0x0f,
	0xc5, 0x79, 0x86, 0x72, 0x0c, 0xf0,
	0x45, 0x01, 0x76, 0xfa, 0x84, 0x70,
	0x85, 0x01, 0x8e, 0x8a, 0x54, 0x20,
	0x05, 0x01, 0x76, 0x92, 0x94, 0x68
};

int 
main(int argc, char **argv)
{
	char ch;

	cprintf("Main started\nVersion: ");
	cprintf(MAIN_VERSION);
	cprintf("\n");

	for (ch = 0; ch < 26; ch++) {
		osram_write(osram_init[ch]);
	};

	rs485Init();
	steppersInit();

	cmdlineInit();
	cmdlineAddCommand("help", do_help);
	cmdlineAddCommand("?", do_help);
	cmdlineAddCommand("dump", do_dump);
	cmdlineAddCommand("ls", do_ls);
	cmdlineAddCommand("dir", do_ls);
	cmdlineAddCommand("mv", do_rename);
	cmdlineAddCommand("rename", do_rename);
	cmdlineAddCommand("rm", do_rm);
	cmdlineAddCommand("delete", do_rm);
	cmdlineAddCommand("spi_speed", do_spi_speed);
	cmdlineAddCommand("osram", do_osram);
	cmdlineAddCommand("flash", do_flash);
	cmdlineAddCommand("readmem", do_readmem);
	cmdlineAddCommand("readrom", do_readrom);
	cmdlineAddCommand("rd", do_rd);
	cmdlineAddCommand("wr", do_wr);
	cmdlineAddCommand("rd32", do_rd32);
	cmdlineAddCommand("wr32", do_wr32);
	cmdlineAddCommand("step", do_step);
	cmdlineAddCommand("sendcmd", do_sendcmd);
	cmdlineAddCommand("reset", (void *)0xE000);
	cmdlinePrintPrompt();

	while (1) {
		if (getc_nowait(&ch)) {
			cmdlineInputFunc(ch);
		};
		cmdlineMainLoop();
		rs485MainLoop();
		steppersMainLoop();
	};

	cprintf("\ndone\n");
		
	return 0;
}
