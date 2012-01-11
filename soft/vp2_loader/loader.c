#include <sys/types.h>
#include <stdint.h>

#define REG(x) (*((char *)(x)))

#define UART_DATA REG(0xD000)
#define UART_STATUS REG(0xD001)
#define		UART_STATUS_TREGE	0x01
#define		UART_STATUS_TBUFE	0x02
#define		UART_STATUS_FERR	0x04
#define		UART_STATUS_OERR	0x08
#define		UART_STATUS_DRDY	0x10

#define SDC_VERSION 		REG(0xD100)
#define SDC_CONTROL 		REG(0xD101)
#define SDC_TRANS_TYPE 		REG(0xD102)
#define SDC_TRANS_CTRL 		REG(0xD103)
#define SDC_TRANS_STS 		REG(0xD104)
#define SDC_TRANS_ERROR 	REG(0xD105)
#define SDC_DIRECT_DATA 	REG(0xD106)
#define SDC_SD_ADDR0 		REG(0xD107)
#define SDC_SD_ADDR1 		REG(0xD108)
#define SDC_SD_ADDR2 		REG(0xD109)
#define SDC_SD_ADDR3 		REG(0xD10A)
#define SDC_CLK_DEL 		REG(0xD10B)
#define SDC_RXFIFO_DATA 	REG(0xD110)
#define SDC_RXFIFO_STATUS 	REG(0xD111)
#define SDC_RXFIFO_COUNT1 	REG(0xD112)
#define SDC_RXFIFO_COUNT2 	REG(0xD113)
#define SDC_RXFIFO_CONTROL 	REG(0xD114)
#define SDC_TXFIFO_DATA 	REG(0xD120)
#define SDC_TXFIFO_STATUS 	REG(0xD121)
#define SDC_TXFIFO_COUNT1 	REG(0xD122)
#define SDC_TXFIFO_COUNT2 	REG(0xD123)
#define SDC_TXFIFO_CONTROL 	REG(0xD124)

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

uint8_t
sdinit(void)
{
        uint8_t ch;

        SDC_TRANS_ERROR = 0;
        SDC_TRANS_ERROR = 0;
        SDC_TRANS_ERROR = 0;
        SDC_TRANS_TYPE = 1;
        ch = SDC_TRANS_TYPE;
        SDC_TRANS_CTRL = 1;
        while (1) {
                ch = SDC_TRANS_STS;
                if (ch == 0)
                        break;
        };
        ch = SDC_TRANS_ERROR;
        if (ch) {
                putstr("SD Init Error: ");
		puthex(ch);
		putnl();
        };
        return ch;
}

uint8_t
readblock(uint32_t n, uint8_t *buf)
{
        uint16_t i;
        SDC_SD_ADDR0 = 0;   /* offset in bytes */
        SDC_SD_ADDR1 = (n << 1) & 0xff;
        SDC_SD_ADDR2 = (n >> 7) & 0xff;
        SDC_SD_ADDR3 = (n >> 15) & 0xff;

        SDC_TRANS_ERROR = 0;
        SDC_TRANS_TYPE = 2;
        SDC_TRANS_CTRL = 1;

        while (SDC_TRANS_STS) {}; /* busy */

        if (SDC_TRANS_ERROR != 0) {
                return 1;
        }

        for (i = 0; i < 512; i++) {
                buf[i] = SDC_RXFIFO_DATA;
        };
        return 0;

}

char ch, ch1;
char *ptr;

void
main_loop() {
	ch = sdinit();
	if (ch) return;
	ptr = ((char *) 0x1000); /* Load addr */
	for (ch1 = 1; ch1 < 57; ch1++) { /* 56 sectors starting from 1 (full 32k - stack) */
		ch = readblock(ch1, ptr);
		if (ch != 0) {
			putstr("Read error: ");
			puthex(ch);
			putnl();
			return;
		}
		putc('.');
		ptr += 0x200;
	};
	putstr(" done\r\nStart...\r\n");
	asm("jmp $1000");
}

int
main() {
        while (1) {
                putstr("Loader v2\r\n");
                main_loop();
                for (ch = 0; ch < 20; ch++) 
                        for (ch1 = 0; ch1 < 200; ch1++) 
                        {};
        };
};

