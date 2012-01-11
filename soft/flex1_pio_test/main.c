#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>

#define REG(x) (*((char *)(x)))

#define PIO_PORT(x) REG(0x2000+(x))
#define PIO_DDR(x) REG(0x2040+(x))
#define PIO_INPUT_SELECT REG(0x2080)
#define PIO_INPUT REG(0x2000)

void putc(char ch) {
        while ((REG(0xA000) & 0x2) == 0) {};
        REG(0xA000) = ch;
}

void putnl() {
        putc('\r');
        putc('\n');
}

void puthex4(char ch) {
        if (ch<10) {
                putc('0' + ch);
        } else {
                putc('A' - 10 + ch);
        };
}

void puthex(char ch) {
        puthex4((ch>>4) & 0xf);
        puthex4(ch & 0xf);
}

void putstr(const char *ptr) {
        while (*ptr) {
		if (*ptr == '\n')
			putc('\r');
                putc(*ptr);
                ptr++;
        };
}

char getc() {
        while ((REG(0xA000) & 0x10) == 0) {};
        return REG(0xC000);
}

char getc_nowait(char *res) {
        if ((REG(0xA000) & 0x10) == 0)
                return 0;
        *res = REG(0xC000);
        return 1;
}

char *names[456] = {
"AK5", "W3", "E1", "C17", "F32", "V34", "AL35", "AL19", "AL4", "W2",
"E3", "B17", "E33", "V33", "AL34", "AN19", "AM3", "W1", "F4", "A17",
"E34", "V31", "AL33", "AP19", "AM2", "V5", "G5", "B19", "E35", "W35",
"AK32", "AR19", "AM1", "V4", "D1", "D19", "F33", "W34", "AJ31", "AP18",
"AJ5", "V3", "D2", "E19", "G32", "W33", "AM35", "AR17", "AL2", "V2",
"D3", "B20", "H31", "W32", "AM34", "AP17", "AK4", "V1", "E4", "C20",
"F34", "W31", "AM33", "AN17", "AL1", "U5", "A6", "E20", "G33", "Y35",
"AL32", "AM17", "AK3", "U4", "E7", "A21", "G34", "Y34", "AL29", "AL17",
"AJ4", "U2", "C7", "B21", "G35", "Y33", "AM29", "AR16", "AH5", "U1", "B7",
"C21", "H32", "Y32", "AN29", "AP16", "AK2", "T5", "A7", "D21", "J31", "Y31",
"AP29", "AN16", "AK1", "T4", "E8", "E21", "H33", "AA35", "AR29", "AM16",
"AJ3", "T3", "D8", "A22", "H34", "AA34", "AL28", "AL16", "AJ2", "T2", "B8",
"B22", "H35", "AA32", "AM28", "AR15", "AJ1", "R4", "A8", "C22", "J32", "AA31",
"AN28", "AP15", "AH4", "R3", "E9", "D22", "J33", "AB35", "AP28", "AM15",
"AH3", "R1", "D9", "E22", "J34", "AB34", "AR28", "AL15", "AH2", "P4", "C9",
"A23", "K31", "AB33", "AL27", "AR14", "AH1", "P3", "B9", "B23", "J35", "AB32",
"AM27", "AP14", "AG4", "P2", "A9", "D23", "K33", "AB31", "AN27", "AN14",
"AG3", "P1", "E10", "E23", "K34", "AC35", "AP27", "AM14", "AG2", "N5", "D10",
"A24", "K35", "AC34", "AR27", "AL14", "AF5", "N4", "C10", "B24", "L32", "AC33",
"AL26", "AR13", "AG1", "N3", "B10", "C24", "L31", "AC32", "AN26", "AP13",
"AF4", "N2", "A10", "A25", "L33", "AC31", "AP26", "AN13", "AF3", "N1", "E11",
"B25", "L34", "AD34", "AR26", "AL13", "AF2", "M1", "D11", "E24", "L35", "AD33",
"AL25", "AR12", "AF1", "M5", "C11", "C25", "M34", "AD32", "AM25", "AP12", "AE2",
"M4", "B11", "D25", "M33", "AD31", "AN25", "AN12", "AE1", "M3", "D12", "E25",
"M32", "AE35", "AL24", "AM12", "AD5", "L1", "C12", "A26", "M31", "AE34", "AP25",
"AP11", "AD4", "L2", "B12", "B26", "M35", "AE33", "AR25", "AN11", "AD3", "L3",
"A12", "C26", "N35", "AE32", "AM24", "AM11", "AD2", "L5", "E13", "D26", "N33",
"AE31", "AN24", "AL11", "AD1", "L4", "D13", "E26", "N32", "AF35", "AR24",
"AR10", "AC5", "K2", "C13", "B27", "N31", "AF34", "AL23", "AP10", "AC4", "K3",
"B13", "C27", "P35", "AF33", "AM23", "AN10", "AC3", "K4", "A13", "D27", "P34",
"AG35", "AN23", "AM10", "AC2", "J1", "E14", "E27", "P33", "AF31", "AP23",
"AL10", "AC1", "K5", "D14", "A28", "P32", "AG34", "AL22", "AR9", "AB4", "J2",
"C14", "B28", "P31", "AG33", "AM22", "AP9", "AB3", "J3", "B14", "C28", "R33",
"AG32", "AN22", "AN9", "AB2", "J4", "A14", "D28", "R32", "AH35", "AP22", "AM9",
"AB1", "H2", "E15", "E28", "R31", "AH34", "AR22", "AL9", "AA5", "H3", "D15",
"A29", "T34", "AH33", "AL21", "AR8", "AA4", "J5", "B15", "B29", "T33", "AG31",
"AM21", "AP8", "AA3", "H4", "A15", "C29", "T32", "AH32", "AN21", "AM8", "AA2",
"G1", "E16", "D29", "T31", "AJ35", "AP21", "AL8", "AA1", "G2", "D16", "E29",
"U35", "AJ34", "AR21", "AR7", "Y5", "G3", "C16", "A30", "U34", "AJ33", "AL20",
"AP7", "Y4", "F1", "B16", "B30", "U33", "AK34", "AM20", "AN7", "Y3", "F2",
"A16", "D33", "U32", "AH31", "AN20", "AM7", "Y1", "H5", "E17", "D35", "U31",
"AJ32", "AP20", "AL7", "W5", "G4", "D17", "G31", "V35", "AK33", "AR20", "AR6",
"W4", "F3", "-", "-", "-", "-", "-", "-"};

char old_val[57];
char acc[57];
char i, ch, delta, mask, bit, changed;
uint16_t pin;

void gen() {
	putstr("Generator mode\n\n");
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

				putstr("reg ");
				puthex(i);
				putstr(" all:");
				for (bit = 0; bit<8; bit++) {
					putc(' ');
					putstr(names[i*8+bit]);
				};
				putstr("\n");
				mask = 0xff;
				bit = mask;
				PIO_DDR(i) = mask;
			};
			if ((ch>='0') && (ch <='7')) {
				ch = ch - '0';
				mask = 1 << ch;
				bit = mask;
				PIO_DDR(i) = mask;
				putstr("reg ");
				puthex(i);
				putc(' ');
				puthex4(ch);
				putc(':');
				putc(' ');
				putstr(names[i*8+ch]);
				putstr("\n");
			};
		};
		bit = bit ^ mask;
		PIO_PORT(i) = bit;
	};
};

void scan() {
	putstr("Scan mode\n\n");
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
						putstr(names[pin]);
						putc(' ');
					};
					mask = mask << 1;
					pin++;
				};
				old_val[i] = ch;
				changed = 1;
			};
		};
		if (changed) {
			putc('\r');
			putc('\n');
		};
		if (getc_nowait(&ch)) {
			if (ch == 'q')
				return; 

			for (ch=0; ch<50; ch++) putc('-');
			putc('\r');
			putc('\n');
			for(i=0; i<57;i++) {
				mask = 1;
				pin = i * 8;
				for (bit = 0; bit < 8; bit++) {
					if (acc[i] & mask) {
						/* puthex4((pin>>8) & 0x0f);
						puthex(pin & 0xff); */
						putstr(names[pin]);
						putc(' ');
					};
					mask = mask << 1;
					pin++;
				};
				acc[i] = 0;
			};
			putc('\r');
			putc('\n');
			for (ch=0; ch<50; ch++) putc('=');
			putc('\r');
			putc('\n');
		};
	};
};

int 
main(int argc, char **argv)
{
	putstr("PIO Test\n");
	scan();
	while (1) {
		putstr("Cmd?");
		ch = getc();
		putstr("\n");
		if (ch == 's') scan();
		if (ch == 'g') gen();
	};
	return 0;
}
