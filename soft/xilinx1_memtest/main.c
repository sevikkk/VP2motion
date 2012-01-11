#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>

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

uint8_t	buf[512];
uint8_t	buf_fat[512];

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
readblock(uint32_t n, uint8_t *buf)
{
	uint16_t i;
	*((char *)0x8007) = 0;   /* offset in bytes */
	*((char *)0x8008) = (n << 1) & 0xff;
	*((char *)0x8009) = (n >> 7) & 0xff;
	*((char *)0x800A) = (n >> 15) & 0xff;

	*((char *)0x8002) = 2; /* read sectors */
	*((char *)0x8003) = 1; /* start */

	while (*((char *)0x8004)) {}; /* busy */

	if (*((char *)0x8005) != 0) {
		return 1;
	}

	for (i = 0; i < 512; i++) {
		buf[i] = *((char *)0x8010);
	};

}

#define dos_partition(n) 	((struct dos_partition *)(buf+DOSPARTOFF + (n)*DOSPARTSIZE))
#define bootsector 		((struct bootsector *)buf)
#define direntry(n)	 	((struct direntry *)(buf+ (n)*32))

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

void putc(char ch) {
	while (!(UART_STATUS & UART_STATUS_TBUFE)) {};
	UART_DATA = ch;
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

#if 0
void dump_buf(char *buf) {
	int i;

	for (i = 0; i< 512; i++) {
		puthex(buf[i]);
		putc(' ');
		if ((i & 15) == 15) {
			putnl();
		};
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
#else
#define dump_buf(x) 
#define dump_long(x,y)

#endif

int 
readfat(int argc, char **argv)
{
	int		rc, i, j;
	uint32_t	start, start_fat, start_root, secno;
	uint32_t	buf_fat_secno = 0;

	uint8_t	cluster_size;
	uint16_t	root_size;

	uint16_t	current_cluster;
	uint8_t	current_sector;

	int32_t		bytes_left;

	putstr("JTAG Loader\n");
	putstr("--MBR--\n");
	rc = readblock(DOSBBSECTOR, buf);

	if (dos_partition(0)->dp_typ != 6) {
		putstr("bad partition type\n");
		return 1;
	};

	start = getulong(dos_partition(0)->dp_start);
	dump_long("start ", start);

	putstr("--BOOT--\n");
	rc = readblock(start, buf);
	if (getushort(bootsector->bpbBytesPerSec) != 512) {
		putstr("bad sector size\n");
		return 1;
	};

	cluster_size = bootsector->bpbSecPerClust;
	dump_long("cluster_size ", cluster_size);

	start_fat = start + getushort(bootsector->bpbResSectors);
	dump_long("start_fat ", start_fat);

	root_size = getushort(bootsector->bpbRootDirEnts);
	root_size = (root_size * 32+511)/512;
	dump_long("root_size ", root_size);

	dump_long("FATsecs ", getushort(bootsector->bpbFATsecs));
	dump_long("FATs ", bootsector->bpbFATs);
	start_root = start_fat + bootsector->bpbFATs * getushort(bootsector->bpbFATsecs);
	start = start_root + root_size - 2 * cluster_size; /* first data sector for 0-based clusters */
	dump_long("start_root ", start_root);

	current_cluster = 0;

	putstr("--ROOT--\n");
	for(j = 0; j<root_size; j++) {
		rc = readblock(start_root + j, buf);
		for(i = 0; i<16; i++) {
			rc = (direntry(i)->deName)[0];
			if (rc == SLOT_EMPTY || rc == SLOT_DELETED) continue;

			rc = direntry(i)->deAttributes & (ATTR_VOLUME|ATTR_DIRECTORY);
			if (rc) continue;

			current_cluster = getushort(direntry(i)->deStartCluster);
			bytes_left = getulong(direntry(i)->deFileSize);

			putstr(direntry(i)->deName);
			putnl();
			/* printf("%12s %02x %ld %ld\n", 
					direntry(i)->deName, 
					direntry(i)->deAttributes & 0x18, 
					current_cluster,
					bytes_left
					); */

			if (!strncmp(direntry(i)->deName, "BITSTRM0ACE", 11)) {
				break;
			};
			current_cluster = 0;
		};
		if (current_cluster) break;
	};

	if (!current_cluster) {
		putstr("file not found\n");
		return 1;
	};

	putstr("File ok\n");
	*((char*)0x6001) = 0;
	*((char*)0x6001) = 0;
	*((char*)0x6001) = 0;
	*((char*)0x6001) = 2;
	current_sector = 0;
	
	while (bytes_left >= 0) {
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
			secno = start + current_cluster * cluster_size;

		rc = readblock(secno, buf);
		for (i=0; i < 512; i++) {
			while (1) {
				rc = *((char*)0xA000);
				if (rc & 0x20) break;
				if (rc & 0x40) {
					putstr("ACE Error\n");
					return 0;
				};
				if (rc & 0x80) {
					putstr("ACE Done\n");
					return 0;
				};
			};
			*((char*)0x6000) = buf[i];
			*((char*)0x6001) = 3;
			rc = *((char*)0xA000);
			rc = *((char*)0xA000);
			rc = *((char*)0xA000);
			rc = *((char*)0xA000);
			*((char*)0x6001) = 2;
		};
		putc('.');
		bytes_left -= 512;
		secno++;
		current_sector++;
	};
	putstr("Done\n");
		
	return 0;
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

char ch, ch1;
int bank;
int 
main(int argc, char **argv)
{
	putstr("Main started\n");
	putstr("fill page\n");
	reg = 1;
	for (bank=0; bank<4096; bank++) {
		ch = rand();
		RAM_DATA(bank) = ch;
	};
	putstr("done\n");
	putstr("check page");
	for (ch1 = 0; ch1<100; ch1++) {
		putc(' ');
		puthex(ch1);
		reg = 1;
		for (bank=0; bank<4096; bank++) {
			ch = rand();
			if (RAM_DATA(bank) != ch) {
				putstr(" ");
				puthex(bank>>8);
				puthex(bank&255);
				putstr(":");
				puthex(ch);
				putstr(":");
				puthex(RAM_DATA(bank));
			};
		};
	};
	putstr(" done\n");
	putstr("fill banks\n");
	reg = 1;
	for (bank=0; bank<8192; bank++) {
		RAM_BANK(bank);
		ch = rand();
		RAM_DATA(0) = ch;
	};
	putstr(" done\n");
	putstr("check banks\n");
	for (ch1 = 0; ch1<100; ch1++) {
		putc(' ');
		puthex(ch1);
		reg = 1;
		for (bank=0; bank<8192; bank++) {
			RAM_BANK(bank);
			ch = rand();
			if (RAM_DATA(0) != ch) {
				putstr(" ");
				puthex(bank>>8);
				puthex(bank&255);
				putstr(":");
				puthex(ch);
				putstr(":");
				puthex(RAM_DATA(0));
			};
		};
	};
	putstr("\ndone\n");
		
	return 0;
}
