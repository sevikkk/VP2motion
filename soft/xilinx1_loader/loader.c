#include <sys/types.h>
#include <stdint.h>

unsigned char ch;
unsigned char ch1;
unsigned char ch2;
unsigned char *ptr;

#define REG(x) (*((char *)(x)))

#define UART_DATA REG(0xD000)
#define UART_STATUS REG(0xD001)
#define		UART_STATUS_TREGE	0x01
#define		UART_STATUS_TBUFE	0x02
#define		UART_STATUS_FERR	0x04
#define		UART_STATUS_OERR	0x08
#define		UART_STATUS_DRDY	0x10

#define ETH_DATA REG(0xD100)
#define ETH_CMD REG(0xD101)
#define		ETH_CMD_NEXT_RX	0x01
#define		ETH_CMD_NEXT_TX	0x02
#define		ETH_CMD_ENABLE	0x80
#define ETH_STATUS REG(0xD101)
#define		ETH_STATUS_RX_DONE	0x01
#define		ETH_STATUS_RX_ERROR	0x02
#define		ETH_STATUS_RX_EMPTY	0x04
#define		ETH_STATUS_TX_DONE	0x08

#define RAM_BANK(x) REG(0xD200) = (x) & 0xff; REG(0xD201) = (x) >> 8
#define RAM_DATA(x) REG(0xC000 + (x))

#define SPI_VERSION REG(0xD300)
#define SPI_CONTROL REG(0xD301)
#define SPI_TRANS_TYPE REG(0xD302)
#define SPI_TRANS_CTRL REG(0xD303)
#define SPI_TRANS_STS REG(0xD304)
#define SPI_TRANS_ERROR REG(0xD305)
#define SPI_DIRECT_DATA REG(0xD306)
#define SPI_SD_ADDR0 REG(0xD307)
#define SPI_SD_ADDR1 REG(0xD308)
#define SPI_SD_ADDR2 REG(0xD309)
#define SPI_SD_ADDR3 REG(0xD30A)
#define SPI_CLK_DEL REG(0xD30B)
#define SPI_RXFIFO_DATA REG(0xD310)
#define SPI_RXFIFO_STATUS REG(0xD311)
#define SPI_RXFIFO_COUNT1 REG(0xD312)
#define SPI_RXFIFO_COUNT2 REG(0xD313)
#define SPI_RXFIFO_CONTROL REG(0xD314)
#define SPI_TXFIFO_DATA REG(0xD320)
#define SPI_TXFIFO_STATUS REG(0xD321)
#define SPI_TXFIFO_COUNT1 REG(0xD322)
#define SPI_TXFIFO_COUNT2 REG(0xD323)
#define SPI_TXFIFO_CONTROL REG(0xD324)

void putc(char ch) {
	while (!(UART_STATUS & UART_STATUS_TBUFE)) {};
	UART_DATA = ch;
}

void putstr(const char *ptr) {
	while (*ptr) {
		putc(*ptr);
		if (*ptr == '\n')
			putc('\r');
		ptr++;
	};
}

void puthex4(char ch) {
	if (ch<10) {
		putc('0' + ch);
	} else {
		putc('A' - 10 + ch);
	};
}

void putnl() {
	putc('\r');
	putc('\n');
}

void puthex(char ch) {
	puthex4((ch>>4) & 0xf);
	puthex4(ch & 0xf);
}

char getc() {
	while (!(UART_STATUS & UART_STATUS_DRDY)) {};
	return UART_DATA;
}

/*
char getc_nowait(char *res) {
	if (!(UART_STATUS & UART_STATUS_DRDY))
		return 0;
	*res = UART_DATA;
	return 1;
}
*/

#if 0
#define putstr(x) (x)
#define putc(x) (x)
#define puthex4(x) (x)
#endif

enum {
	EVT_RX_START,
	EVT_RX_DATA,
	EVT_RX_END
};

enum {
	STATE_INIT,
	STATE_SKIP_HEADER,
	STATE_MAGIC,
	STATE_DATA,
	STATE_DATA1,
	STATE_SKIP_FOOTER,
};

typedef void (*fptr_t)(void);

void
fsm(int event, char data) {
	static char state = STATE_INIT;
	static uint16_t addr;
	static uint16_t len;
	static uint16_t cmd;
	static uint16_t cnt;

	switch (state) {
		case STATE_INIT:
			if (event == EVT_RX_START) {
				cnt = 0;
				state = STATE_SKIP_HEADER;
			};
			break;
		case STATE_SKIP_HEADER:
			if (event == EVT_RX_END) {
				state = STATE_INIT;
			} else if (event == EVT_RX_DATA) {
				cnt++;
				if (cnt == 0x54) {
					state = STATE_MAGIC;
					cnt = 0;
					addr = 0;
					len = 0;
					cmd = 0;
				};
			};
			break;
		case STATE_MAGIC:
			if (event == EVT_RX_END) {
				state = STATE_INIT;
			} else if (event == EVT_RX_DATA) {
				switch (cnt) {
					case 0:
						putc('!');
						if (data != 0xA) {
							state = STATE_SKIP_FOOTER;
						};
						break;
					case 1:
						putc('@');
						if (data != 0xB) {
							state = STATE_SKIP_FOOTER;
						};
						break;
					case 2:
						putc('#');
						if (data != 0xE) {
							state = STATE_SKIP_FOOTER;
						};
						break;
					case 3:
						putc('$');
						if (data != 0xC) {
							state = STATE_SKIP_FOOTER;
						};
						break;
					case 4:
						putc('c');
						cmd = data;
						break;
					case 5:
						putc('c');
						cmd |= ((uint16_t)data << 4);
						break;
					case 6:
						putc('c');
						cmd |= ((uint16_t)data << 8);
						break;
					case 7:
						putc('c');
						cmd |= ((uint16_t)data << 12);
						break;
					case 8:
						putc('a');
						addr = data;
						break;
					case 9:
						putc('a');
						addr |= ((uint16_t)data << 4);
						break;
					case 10:
						putc('a');
						addr |= ((uint16_t)data << 8);
						break;
					case 11:
						putc('a');
						addr |= ((uint16_t)data << 12);
						break;
					case 12:
						if (cmd == 1) {
							putc('l');
							len = data;
						} else {
							state = STATE_SKIP_FOOTER;
						};

						break;
					case 13:
						putc('l');
						len |= ((uint16_t)data << 4);
						break;
					case 14:
						putc('l');
						len |= ((uint16_t)data << 8);
						break;
					case 15:
						putc('l');
						putc('<');
						len |= ((uint16_t)data << 12);
						state = STATE_DATA;
						cnt = 0xffff;
						break;
				};
				cnt++;
			};
			break;
		case STATE_DATA:
			*((char *)(addr+cnt)) = data;
			state = STATE_DATA1;
			break;
		case STATE_DATA1:
			*((char *)(addr+cnt)) |= (data << 4);
			cnt++;
			if (cnt == len) {
				putc('>');
				state = STATE_SKIP_FOOTER;
			} else {
				putc(' ');
				state = STATE_DATA;
			};
			break;
		case STATE_SKIP_FOOTER:
			if (event == EVT_RX_END) {
				if (cmd == 1) {
					putstr("\nLoaded 0x");
					puthex(len>>8);
					puthex(len & 0xff);
					putstr(" bytes to 0x");
					puthex(addr>>8);
					puthex(addr & 0xff);
					putstr("\n");
				} else if (cmd == 2) {
					ETH_CMD = 0;
					putstr("\nStart from 0x");
					puthex(addr>>8);
					puthex(addr & 0xff);
					putstr("\n");
					(*((fptr_t)addr))();
					putstr("Exited\n");
					ETH_CMD = ETH_CMD_ENABLE;
				};
				state = STATE_INIT;
			};
			break;
	};
};

void main_loop() {
	putstr("M\n");
	ETH_CMD = ETH_CMD_ENABLE;
	while (1) {
#if 1
		while (!(ETH_STATUS & ETH_STATUS_RX_DONE)) {};
		if (ETH_STATUS & ETH_STATUS_RX_ERROR) {
			putc('e');
			while (!(ETH_STATUS & ETH_STATUS_RX_EMPTY)) {
				puthex4(ETH_DATA);
			};
		} else {
			putc('p');
			fsm(EVT_RX_START, 0);
			while (!(ETH_STATUS & ETH_STATUS_RX_EMPTY)) {
				ch = ETH_DATA;
				puthex4(ch);
				fsm(EVT_RX_DATA, ch);
			};
		};
		putc('.');
		ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_RX;
		while (ETH_STATUS & ETH_STATUS_RX_DONE) {};
		putstr("\n");
		ETH_CMD = ETH_CMD_ENABLE;
		fsm(EVT_RX_END, 0);
#endif

#if 0
		putc('S');
		ptr = "FF FF FF FF FF FF 01 51 2F 00 17 AC 80 00 54 00 00 45 23 A8 00 00 04 10 5C DC 0C 8A 00 20 0C 8A 00 FF 80 00 0B 65 BA 70 00 00 94 52 D4 42 00 00 B1 55 80 90 A0 B0 C0 D0 E0 F0 01 11 21 31 41 51 61 71 81 91 A1 B1 C1 D1 E1 F1 02 12 22 32 42 52 62 72 82 92 A2 B2 C2 D2 E2 F2 03 13 23 33 43 53 63 73";
		while (*ptr) {
			if (*ptr == ' ') {
				ptr++;
				continue;
			} else if (*ptr < 'A') {
				ch = *ptr - '0';
			} else {
				ch = *ptr - 'A' + 10;
			};
			ETH_DATA = ch;
			puthex4(ch);
			ptr++;
		};
		putc('s');
		ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_TX;
		while (ETH_STATUS & ETH_STATUS_TX_DONE) {};
		putc('.');
		ETH_CMD = ETH_CMD_ENABLE;
		while (!(ETH_STATUS & ETH_STATUS_TX_DONE)) {};
		putstr("\n");
#endif
	};

}

/*
static int pktlen;

void nicInit(void) {
	ETH_CMD = ETH_CMD_ENABLE;
}

void nicSend(unsigned int len, unsigned char* packet) {

	while (!(ETH_STATUS & ETH_STATUS_TX_DONE)) {}; // wait for end of sending of prev frame
	for (pktlen = 0; pktlen<len; pktlen++) {
		ch = packet[pktlen];
		ETH_DATA = ch & 0xf;
		ETH_DATA = (ch>>4) & 0xf;
	};
	while (pktlen<64) {
		ETH_DATA = 0;
		ETH_DATA = 0;
		pktlen++;
	};
	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_TX; //start send
	ETH_CMD = ETH_CMD_ENABLE;
	//while (ETH_STATUS & ETH_STATUS_TX_DONE) {};
	//ETH_CMD = ETH_CMD_ENABLE;
	//while (!(ETH_STATUS & ETH_STATUS_TX_DONE)) {};
}
*/

int main() {
	/* nicInit();
	nicSend(13, "0123456789abc");
	nicSend(13, "0123456789abc");
	*/

	while (1) {
		/* ch = RAM_DATA(0);
		ch = SPI_VERSION;
		ch = SPI_TXFIFO_DATA;
		RAM_DATA(0) = 13;
		RAM_BANK(13);
		SPI_TRANS_TYPE = 1;
		SPI_RXFIFO_DATA = 1;
		*/
		putstr("Loader v4\n");
		main_loop();
		for (ch = 0; ch < 20; ch++) 
			for (ch1 = 0; ch1 < 200; ch1++) 
			{};
	};
};
