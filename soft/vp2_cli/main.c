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
#include "maxspi.h"
#include "util.h"

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
	cmdlineAddCommand("rd", do_rd);
	cmdlineAddCommand("wr", do_wr);
	cmdlineAddCommand("rd32", do_rd32);
	cmdlineAddCommand("wr32", do_wr32);
	cmdlineAddCommand("step", do_step);
	cmdlineAddCommand("build", do_build);
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
