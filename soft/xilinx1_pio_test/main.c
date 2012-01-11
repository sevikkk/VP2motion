#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <conio.h>

#define REG(x) (*((char *)(x)))

#define PIO_PORT(x) REG(0xD400+(x))
#define PIO_DDR(x) REG(0xD440+(x))
#define PIO_INPUT_SELECT REG(0xD480)
#define PIO_INPUT REG(0xD400)

#define UART_DATA REG(0xD000)
#define UART_STATUS REG(0xD001)
#define         UART_STATUS_TREGE       0x01
#define         UART_STATUS_TBUFE       0x02
#define         UART_STATUS_FERR        0x04
#define         UART_STATUS_OERR        0x08
#define         UART_STATUS_DRDY        0x10

void __fastcall__ cputc(char c) {
        while (!(UART_STATUS & UART_STATUS_TBUFE)) {};
        UART_DATA = c & 0xff;
}

void putnl() {
        cputc('\r');
        cputc('\n');
}

char getc() {
        while ((UART_STATUS & UART_STATUS_DRDY) == 0) {};
        return UART_DATA;
}

char getc_nowait(char *res) {
        if ((UART_STATUS & UART_STATUS_DRDY) == 0)
                return 0;
        *res = UART_DATA;
        return 1;
}

char *names[456] = {
"Y2", "W1", "AB5", "AA2", "AC2", "AB4", "AC1", "AB1", "AC4", "AD4", "Y1",
"AD3", "AC3", "AA1", "AD2", "AE3", "AG4", "AF3", "AE1", "AH1", "AJ4", "AK2",
"AL3", "AM2", "AL4", "AN1", "AM4", "AP1", "AN2", "AP2", "AN3", "AR1", "AN4",
"AT1", "AR2", "AP4", "AT2", "AR3", "AT3", "AR4", "AU2", "AB37", "AA36", "W39",
"AB36", "W37", "W36", "U38", "T39", "V38", "T38", "V35", "R39", "U37", "U36",
"R38", "U35", "P39", "T37", "P38", "T36", "N39", "N38", "R37", "R36", "M38",
"P37", "L39", "P36", "N37", "L38", "N36", "K39", "M37", "K38", "K36", "H39",
"L37", "J38", "K37", "G38", "L36", "H38", "J37", "G39", "J39", "E39", "F39",
"H37", "F38", "H36", "J36", "G37", "E38", "G36", "D39", "F37", "D38", "F36",
"D37", "E37", "C38", "B37", "E3", "C2", "F4", "D3", "F3", "D2", "G4", "D1",
"G3", "E2", "H4", "E1", "H3", "F2", "J4", "F1", "J3", "G1", "J2", "H1", "L4",
"K4", "L3", "J1", "M3", "N3", "N4", "P3", "K1", "L2", "K2", "P4", "M2", "M1",
"T4", "T3", "P2", "P1", "U4", "R2", "U3", "R1", "V4", "T2", "V3", "W4", "U2",
"AA4", "V2", "W2", "V1", "W3", "D35", "B36", "C35", "A36", "D34", "B35", "C34",
"A35", "D33", "B34", "C33", "A34", "D32", "B33", "C32", "D31", "A33", "C31",
"B32", "B31", "A32", "D30", "A31", "C30", "B30", "D29", "A30", "A29", "B29",
"B28", "A28", "C28", "B27", "D27", "A27", "C27", "B26", "D26", "C26", "A26",
"B25", "C25", "A24", "D24", "A25", "B22", "B23", "B24", "A23", "E23", "A22",
"D23", "B21", "C23", "A21", "E22", "B20", "D22", "C22", "AT22", "AV20", "AR22",
"AW20", "AV23", "AW21", "AU23", "AV21", "AT23", "AW22", "AR23", "AW23", "AV24",
"AW24", "AV22", "AU24", "AW25", "AT24", "AV25", "AU25", "AW26", "AT25", "AV26",
"AW27", "AU26", "AV27", "AT26", "AW28", "AU27", "AW29", "AT27", "AW30", "AU28",
"AV30", "AV29", "AW31", "AU29", "AV31", "AT29", "AW32", "AU30", "AW33", "AT30",
"AV33", "AU31", "AT31", "AW34", "AV32", "AV34", "AU32", "AW35", "AT32", "AV35",
"AU33", "AV36", "AU36", "AT34", "AU4", "AV5", "AV3", "AT6", "AV4", "AU6",
"AW4", "AT7", "AW5", "AV6", "AU8", "AT9", "AU9", "AW8", "AT10", "AV9", "AW9",
"AT11", "AV10", "AU11", "AW10", "AU12", "AV11", "AT13", "AW11", "AV12",
"AU14", "AU13", "AT14", "AT15", "AU15", "AW13", "AW14", "AU16", "AV15",
"AR17", "AW15", "AU17", "AV17", "AT18", "AW16", "AT19", "AV18", "AU19",
"AW18", "AU21", "AV19", "AT21", "AR36", "AT38", "AR37", "AR38", "AP36",
"AT39", "AP37", "AR39", "AP38", "AN36", "AN38", "AN37", "AM36", "AM38",
"AM37", "AL36", "AM39", "AL37", "AL38", "AK36", "AL39", "AK37", "AK38",
"AJ36", "AK39", "AJ37", "AJ38", "AH38", "AJ39", "AF37", "AH39", "AD38",
"AC38", "AH37", "AF36", "AG36", "AG38", "AF39", "AC35", "AE37", "AB38",
"AG39", "AG37", "AF38", "AE39", "AE38", "Y38", "AD39", "AD37", "AD36", "AC39",
"V36", "AE36", "AA37", "AB35", "AC36", "AB39", "Y39", "AA39", "U39", "V39",
"A19", "C21", "B19", "C19", "A18", "D19", "B18", "C18", "A17", "D18", "B17",
"E18", "A16", "C17", "D17", "C16", "B15", "D16", "A14", "D15", "B13", "A12",
"D14", "B12", "D13", "C12", "B11", "C11", "A10", "D11", "B10", "C10", "A9",
"D10", "B9", "C9", "D9", "B8", "A8", "A7", "C8", "B7", "A6", "C7", "B6", "D7",
"A5", "B5", "D6", "A4", "C5", "B4", "D5", "-", "-", "-", "-", "-", "-"};

char old_val[57];
char acc[57];
char i, ch, delta, mask, bit, changed;
uint16_t pin;

void gen() {
	cprintf("Generator mode\r\n\r\n");
	for(i=0; i<57;i++) {
		PIO_DDR(i) = 0;
		PIO_PORT(i) = 0;
	};
	i = 0;
	mask = 0;
	bit = 0;
	while (1) {
		if (getc_nowait(&ch)) {
			if (ch == 'q') return;
			if ((ch=='n') || (ch == 'p') || (ch == 'a')) {
				PIO_DDR(i) = 0;
				PIO_PORT(i) = 0;
				if (ch == 'n') {
					i++;
					if (i>56) i = 0;
				};
				if (ch == 'p') {
					if (i == 0) {
						i = 56;
					} else {
						i--;
					};
				};

				cprintf("reg %d all:", i);
				for (bit = 0; bit<8; bit++) {
					cprintf(" %s", names[i*8+bit]);
				};
				cprintf("\r\n");
				mask = 0xff;
				bit = mask;
				PIO_DDR(i) = mask;
			};
			if ((ch>='0') && (ch <='7')) {
				ch = ch - '0';
				mask = 1 << ch;
				bit = mask;
				PIO_DDR(i) = mask;
				cprintf("reg %d %d: %s\n\r", i, ch, names[i*8+ch]);
			};
		};
		bit = bit ^ mask;
		PIO_PORT(i) = bit;
	};
};

void scan() {
	cprintf("Scan mode\r\n\r\n");
	for(i=0; i<57;i++) {
		PIO_DDR(i) = 0;
		PIO_PORT(i) = 0;
		old_val[i] = 0;
		acc[i] = 0;
	};

	while (1) {
		changed = 0;
		for(i=0; i<57;i++) {
			PIO_INPUT_SELECT = i;
			ch = PIO_INPUT;
			if (ch != old_val[i]) {
				delta = ch ^ old_val[i];
				acc[i] |= delta;
				mask = 1;
				pin = i * 8;
				for (bit = 0; bit < 8; bit++) {
					if (delta & mask) {
						/* puthex4((pin>>8) & 0x0f);
						puthex(pin & 0xff); */
						cprintf("%s ",names[pin]);
					};
					mask = mask << 1;
					pin++;
				};
				old_val[i] = ch;
				changed = 1;
			};
		};
		if (changed) {
			cprintf("\r\n");
		};
		if (getc_nowait(&ch)) {
			if (ch == 'q')
				return; 

			cprintf("---------------------------------\r\n");
			for(i=0; i<57;i++) {
				mask = 1;
				pin = i * 8;
				for (bit = 0; bit < 8; bit++) {
					if (acc[i] & mask) {
						cprintf("%s ",names[pin]);
					};
					mask = mask << 1;
					pin++;
				};
				acc[i] = 0;
			};
			cprintf("\r\n==============================\r\n");
		};
	};
};

int 
main(int argc, char **argv)
{
	cprintf("PIO Test\r\n");
	scan();
	while (1) {
		cprintf("Cmd?");
		ch = getc();
		cprintf("\r\n");
		if (ch == 's') scan();
		if (ch == 'g') gen();
	};
	return 0;
}
