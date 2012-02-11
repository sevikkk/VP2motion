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

uint8_t	buf_cmd[16];
uint8_t	buf[512];
uint8_t	buf_fat[512];
uint8_t	buf_dir[512];

#define DOSBBSECTOR     0	/* DOS boot block relative sector number */
#define DOSPARTOFF      446
#define DOSPARTSIZE     16
#define NDOSPART        4
#define NEXTDOSPART     32
#define DOSMAGICOFFSET  510
#define DOSMAGIC        0xAA55

struct dos_partition {
	uint8_t	dp_flag;	/* bootstrap flags */
	uint8_t	dp_shd;		/* starting head */
	uint8_t	dp_ssect;	/* starting sector */
	uint8_t	dp_scyl;	/* starting cylinder */
	uint8_t	dp_typ;		/* partition type */
	uint8_t	dp_ehd;		/* end head */
	uint8_t	dp_esect;	/* end sector */
	uint8_t	dp_ecyl;	/* end cylinder */
	uint8_t	dp_start[4];	/* absolute starting sector number */
	uint8_t	dp_size[4];	/* partition size in sectors */
};

struct bootsector {
	uint8_t	bsJump [3];		/* jump inst E9xxxx or EBxx90 */
	uint8_t	bsOemName[8];		/* OEM name and version */
	uint8_t	bpbBytesPerSec[2];	/* bytes per sector */
	uint8_t	bpbSecPerClust;		/* sectors per cluster */
	uint8_t	bpbResSectors[2];	/* number of reserved sectors */
	uint8_t	bpbFATs;		/* number of FATs */
	uint8_t	bpbRootDirEnts[2];	/* number of root directory entries */
	uint8_t	bpbSectors[2];		/* total number of sectors */
	uint8_t	bpbMedia;		/* media descriptor */
	uint8_t	bpbFATsecs[2];		/* number of sectors per FAT */
	uint8_t	bpbSecPerTrack[2];	/* sectors per track */
	uint8_t	bpbHeads[2];		/* number of heads */
	uint8_t	bpbHiddenSecs[4];	/* number of hidden sectors */
	uint8_t	bpbHugeSectors[4];	/* # of sectors if bpbSectors == 0 */
	uint8_t	bsExt   [26];		/* Bootsector Extension */
	uint8_t	bsBootCode[448];	/* pad so structure is 512b */
	uint8_t	bsBootSectSig0;
	uint8_t	bsBootSectSig1;
#define BOOTSIG0        0x55
#define BOOTSIG1        0xaa
};

struct direntry {
	uint8_t	deName [8];	/* filename, blank filled */
#define SLOT_EMPTY      0x00		/* slot has never been used */
#define SLOT_E5         0x05		/* the real value is 0xe5 */
#define SLOT_DELETED    0xe5		/* file in this slot deleted */
	uint8_t	deExtension[3];	/* extension, blank filled */
	uint8_t	deAttributes;	/* file attributes */
#define ATTR_NORMAL     0x00		/* normal file */
#define ATTR_READONLY   0x01		/* file is readonly */
#define ATTR_HIDDEN     0x02		/* file is hidden */
#define ATTR_SYSTEM     0x04		/* file is a system file */
#define ATTR_VOLUME     0x08		/* entry is a volume label */
#define ATTR_DIRECTORY  0x10		/* entry is a directory name */
#define ATTR_ARCHIVE    0x20		/* file is new or modified */
	uint8_t	deLowerCase;	/* NT VFAT lower case flags */
#define LCASE_BASE      0x08		/* filename base in lower case */
#define LCASE_EXT       0x10		/* filename extension in lower case */
	uint8_t	deCHundredth;	/* hundredth of seconds in CTime */
	uint8_t	deCTime[2];	/* create time */
	uint8_t	deCDate[2];	/* create date */
	uint8_t	deADate[2];	/* access date */
	uint8_t	deHighClust[2];	/* high bytes of cluster number */
	uint8_t	deMTime[2];	/* last update time */
	uint8_t	deMDate[2];	/* last update date */
	uint8_t	deStartCluster[2];	/* starting cluster of file */
	uint8_t	deFileSize[4];	/* size of file in bytes */
};


uint8_t
sdinit(void)
{
	uint8_t ch;

	SPI_TRANS_ERROR = 0;
	SPI_TRANS_ERROR = 0;
	SPI_TRANS_ERROR = 0;
	SPI_TRANS_TYPE = 1;
	ch = SPI_TRANS_TYPE;
	SPI_TRANS_CTRL = 1;
	while (1) {
		ch = SPI_TRANS_STS;
		if (ch == 0)
			break;
	};
	ch = SPI_TRANS_ERROR;
	if (ch) {
		cprintf("SD Init Error: %x\n", ch);
	};
	return ch;
}

uint8_t
readblock(uint32_t n, uint8_t *buf)
{
	uint16_t i;
	SPI_SD_ADDR0 = 0;   /* offset in bytes */
	SPI_SD_ADDR1 = (n << 1) & 0xff;
	SPI_SD_ADDR2 = (n >> 7) & 0xff;
	SPI_SD_ADDR3 = (n >> 15) & 0xff;

	SPI_TRANS_ERROR = 0;
	SPI_TRANS_TYPE = 2;
	SPI_TRANS_CTRL = 1;

	while (SPI_TRANS_STS) {}; /* busy */

	if (SPI_TRANS_ERROR != 0) {
		return 1;
	}

	for (i = 0; i < 512; i++) {
		buf[i] = SPI_RXFIFO_DATA;
	};
	return 0;

}

uint8_t
writeblock(uint32_t n, uint8_t *buf)
{
	uint16_t i;
	SPI_SD_ADDR0 = 0;   /* offset in bytes */
	SPI_SD_ADDR1 = (n << 1) & 0xff;
	SPI_SD_ADDR2 = (n >> 7) & 0xff;
	SPI_SD_ADDR3 = (n >> 15) & 0xff;

	for (i = 0; i < 512; i++) {
		SPI_TXFIFO_DATA = buf[i];
	};

	SPI_TRANS_ERROR = 0;
	SPI_TRANS_TYPE = 3;
	SPI_TRANS_CTRL = 1;

	while (SPI_TRANS_STS) {}; /* busy */

	if (SPI_TRANS_ERROR != 0) {
		return 1;
	}

	return 0;

}
#define dos_partition(n) 	((struct dos_partition *)(buf+DOSPARTOFF + (n)*DOSPARTSIZE))
#define bootsector 		((struct bootsector *)buf)
#define direntry(n)	 	((struct direntry *)(buf_dir + (n)*32))

uint16_t
getushort(const void *pp)
{
        unsigned char const *p = (unsigned char const *)pp;

        return (((uint16_t)p[1] << 8) | p[0]);
}

uint32_t
getulong(const void *pp)
{
        unsigned char const *p = (unsigned char const *)pp;

        return (((uint32_t)p[3] << 24) | ((uint32_t)p[2] << 16) | ((uint32_t)p[1] << 8) | p[0]);
}

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

uint32_t	start, start_fat, start_root, secno, dir_secno;
uint32_t	buf_fat_secno = 0;

uint8_t		cluster_size, dir_entry, num_fats;
uint16_t	root_size, fat_size;

uint16_t	current_cluster;
uint8_t		current_sector;

int32_t		bytes_left;

uint8_t
opendisk(void)
{
	int		rc;

	buf_fat_secno = 0;
	dir_secno = 0;
	current_cluster = 0;
	bytes_left = 0;

	// putstr("--SDINIT--\n");
	rc = sdinit();
	if (rc)
		return rc;

	// putstr("--MBR--\n");
	rc = readblock(DOSBBSECTOR, buf);

	if (dos_partition(0)->dp_typ != 6) {
		putstr("bad partition type\n");
		return 1;
	};

	start = getulong(dos_partition(0)->dp_start);
	// dump_long("start ", start);

	// putstr("--BOOT--\n");
	rc = readblock(start, buf);
	if (getushort(bootsector->bpbBytesPerSec) != 512) {
		putstr("bad sector size\n");
		return 1;
	};

	cluster_size = bootsector->bpbSecPerClust;
	// dump_long("cluster_size ", cluster_size);

	start_fat = start + getushort(bootsector->bpbResSectors);
	// dump_long("start_fat ", start_fat);

	root_size = getushort(bootsector->bpbRootDirEnts);
	root_size = (root_size * 32+511)/512;
	// dump_long("root_size ", root_size);

	// dump_long("FATsecs ", getushort(bootsector->bpbFATsecs));
	// dump_long("FATs ", bootsector->bpbFATs);
	fat_size = getushort(bootsector->bpbFATsecs);
	num_fats = bootsector->bpbFATs;
	start_root = start_fat + num_fats * fat_size;
	start = start_root + root_size - 2 * cluster_size; /* first data sector for 0-based clusters */
	// dump_long("start_root ", start_root);
	
	return 0;
}

void
make83name(char *fname, char *fname83) {
	uint8_t i, j;

	for(i=0;i<8;i++) {
		if (fname[i] == '.' || fname[i] == '\0')
			break;
		fname83[i] = toupper(fname[i]);
	};
	j = i;
	for(;i<8;i++) {
		fname83[i] = ' ';
	};

	for(;j<20;j++) {
		if (fname[j] == '.') {
			j++;
			break;
		};
		if (fname[j] == '\0')
			break;
	};

	for(;i<11;i++,j++) {
		if (fname[j] == '\0')
			break;
		fname83[i] = toupper(fname[j]);
	};

	for(;i<11;i++) {
		fname83[i] = ' ';
	};

	fname83[11] = '\0';
}

uint8_t
openfile(char *fname)
{
	char fname83[12];
	uint8_t i, j, rc;

	make83name(fname, fname83);
	current_cluster = 0;

	// putstr("--ROOT--\n");
	for(j = 0; j<root_size; j++) {
		rc = readblock(start_root + j, buf_dir);
		for(i = 0; i<16; i++) {
			rc = (direntry(i)->deName)[0];

			if (rc == SLOT_EMPTY)
				goto scan_done;

			if (rc == SLOT_DELETED)
				continue;

			rc = direntry(i)->deAttributes & (ATTR_VOLUME|ATTR_DIRECTORY);
			if (rc)
				continue;

			if (!strncmp(direntry(i)->deName, fname83, 11)) {
				current_cluster = getushort(direntry(i)->deStartCluster);
				bytes_left = getulong(direntry(i)->deFileSize);
				dir_secno = start_root + j;
				dir_entry = i;
				goto scan_done;
			};
		};
	};
scan_done:
	if (!current_cluster) {
		putstr("file not found\n");
		return 1;
	};

	secno = start + (uint32_t)current_cluster * cluster_size;
	current_sector = 0;
	cprintf("Found, start cluster: %hu\n", current_cluster);
	return 0;
}

int16_t
readfile(void) {
	int16_t rc;

	if (!current_cluster)
		return 0;

	while (bytes_left <= 0) {
		current_cluster = 0;
		return 0;
	};

	if (current_sector == cluster_size) {
		secno = start_fat + (current_cluster >> 8);
		if (secno != buf_fat_secno) {
			rc = readblock(secno, buf_fat);
			buf_fat_secno = secno;
		};
		current_cluster = getushort(buf_fat+2*(current_cluster & 255));
		current_sector = 0;
	};

	if (current_sector == 0)
		secno = start + (uint32_t)current_cluster * cluster_size;

	rc = readblock(secno, buf);
	if (rc) {
		cprintf("Read error: %d\n", rc);
		return -rc;
	};

	if (bytes_left >= 512) {
		rc = 512;
	} else {
		rc = bytes_left;
	};

	bytes_left -= rc;
	secno++;
	current_sector++;

	return rc;
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
do_ls(void) {
	uint8_t rc, i, j, k, l;
	char fname[13];

	rc = opendisk();

	for(j = 0; j<root_size; j++) {
		rc = readblock(start_root + j, buf_dir);
		for(i = 0; i<16; i++) {
			rc = (direntry(i)->deName)[0];

			if (rc == SLOT_EMPTY)
				break;

			if (rc == SLOT_DELETED)
				continue;

			rc = direntry(i)->deAttributes & (ATTR_VOLUME|ATTR_DIRECTORY);
			if (rc)
				continue;

#define de_name(i) (direntry(i)->deName)
			k = 0;
			l = 0;
			for(k=0; k<8; k++) {
				if (de_name(i)[k] == ' ') break;
				fname[l] = tolower(de_name(i)[k]);
				l++;
			};
			fname[l] = '.';
			l++;
			for(k=8; k<11; k++) {
				if (de_name(i)[k] == ' ') break;
				fname[l] = tolower(de_name(i)[k]);
				l++;
			};
			fname[l] = '\0';
			cprintf(" %10ld   %-12s\n", getulong(direntry(i)->deFileSize),
					fname);
		};
	};
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

void
do_dump(void) {
	int16_t rc;
	char fname[20];

	rc = opendisk();
	if (rc) return;

	get_arg(1, fname);

	rc = openfile(fname);
	if (rc) return;

	rc = 1;

	while (rc>0) {
		rc = readfile();
		cprintf("len: %d\n", rc);
		if (rc>0)
			dump_buf(buf, rc);
	};
}

void
do_rename(void) {
	uint16_t rc;
	char fname[20];
	char fname83[12];
	char *ptr;

	rc = opendisk();
	if (rc) return;

	get_arg(2, fname);
	cprintf("checking target file: ");
	rc = openfile(fname);
	if (!rc) {
		cprintf("Target file already exist\n");
		return;
	};
	make83name(fname, fname83);

	get_arg(1, fname);

	cprintf("checking source file: ");
	rc = openfile(fname);
	if (rc) return;

	strncpy(de_name(dir_entry), fname83, 11);
	writeblock(dir_secno, buf_dir);
}


uint8_t
sync_fats(void) {
	uint8_t i;
	int8_t rc;

	if (!buf_fat_secno)
		return 0;

	//cprintf("============================\n");
	for (i=0; i<num_fats; i++) {
		//rc = readblock(buf_fat_secno + i*fat_size, buf);
		//dump_buf(buf, 512);
		//cprintf("--------------------------\n");
		rc = writeblock(buf_fat_secno + i*fat_size, buf_fat);
		if (rc) {
			return rc;
		};
	};
	return 0;
}

void
do_rm(void) {
	uint16_t rc;
	char fname[20];

	rc = opendisk();
	if (rc) return;

	get_arg(1, fname);
	rc = openfile(fname);
	if (rc) return;

	cprintf("Clusters: ");
	while (1) {
		cprintf(" %hu", current_cluster);
		secno = start_fat + (current_cluster >> 8);
		if (secno != buf_fat_secno) {
			rc = sync_fats();
			rc = readblock(secno, buf_fat);
			buf_fat_secno = secno;
		};
		rc = getushort(buf_fat+2*(current_cluster & 255));
		buf_fat[2*(current_cluster & 255)] = 0;
		buf_fat[2*(current_cluster & 255) + 1] = 0;

		current_cluster = rc;
		if ((current_cluster & 0xFFF8) == 0xFFF8)
			break;
		if (current_cluster == 0) {
			cprintf(" Unexpected free cluster...\n");
			break;
		};
	};
	rc = sync_fats();
	de_name(dir_entry)[0] = SLOT_DELETED;
	writeblock(dir_secno, buf_dir);
	cprintf("\n");

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
	int16_t rc;
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
