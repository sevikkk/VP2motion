unsigned char ch;
unsigned char ch1;
unsigned char ch2;
unsigned char *ptr;

void putc(char ch) {
	while (((*((char*)0xA000)) & 0x2) == 0) {};
	*((char *)0xA000) = ch;
}

void putstr(const char *ptr) {
	while (*ptr) {
		putc(*ptr);
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
	while (((*((char*)0xA000)) & 0x10) == 0) {};
	return *((char *)0xC000);
}

/*
char getc_nowait(char *res) {
	if (((*((char*)0xA000)) & 0x10) == 0)
		return 0;
	*res = *((char *)0xC000);
	return 1;
}
*/

void main_loop() {
	*((char *)0x8002) = 1; /* init */
	*((char *)0x8003) = 1; /* start */

	while (*((char *)0x8004)) {}; /* busy */

	ch = *((char *)0x8005);  /* error code */
	if (ch != 0) {
		putstr("Init: ");
		puthex(ch);
		putnl();
		return;
	}

	putstr("Load ");
	ptr = ((char *) 0x400); /* Load addr */
	for (ch = 1; ch < 15; ch++) { /* 14 sectors starting from 1 */
		*((char *)0x8007) = 0;   /* offset in bytes */
		*((char *)0x8008) = ch << 1;
		*((char *)0x8009) = 0;
		*((char *)0x800A) = 0;

		*((char *)0x8002) = 2; /* read sectors */
		*((char *)0x8003) = 1; /* start */

		while (*((char *)0x8004)) {}; /* busy */

		ch1 = *((char *)0x8005);  /* error code */
		if (ch1 != 0) {
			putstr("Read: ");
			puthex(ch1);
			putnl();
			return;
		}

		for (ch1=0; ch1<128; ch1++) {
			ch2 = *((char *)0x8010);
			*(ptr++) = ch2;
			ch2 = *((char *)0x8010);
			*(ptr++) = ch2;
			ch2 = *((char *)0x8010);
			*(ptr++) = ch2;
			ch2 = *((char *)0x8010);
			*(ptr++) = ch2;
		};
		putc('.');
	};
	putstr(" done\r\nStart...\r\n");
	asm("jmp $400");
}

int main() {
	while (1) {
		putstr("Loader v3\r\n");
		main_loop();
		for (ch = 0; ch < 20; ch++) 
			for (ch1 = 0; ch1 < 200; ch1++) 
			{};
	};
};
