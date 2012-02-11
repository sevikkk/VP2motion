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

#include "sdcard.h"
#include "maxspi.h"
#include "util.h"

uint8_t	buf_cmd[16];

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
