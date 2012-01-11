#include <sys/types.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <conio.h>
#include <ctype.h>
#include "dhcp.h"
#include "ip.h"
#include "net.h"
#include "netstack.h"
#include "cmdline.h"

#define REG(x) (*((volatile char *)(x)))

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

	while (!(UART_STATUS & UART_STATUS_TBUFE)) {};
	UART_DATA = c & 0xff;
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
        while ((UART_STATUS & UART_STATUS_DRDY) == 0) {};
        return UART_DATA;
}

char getc_nowait(char *res) {
        if ((UART_STATUS & UART_STATUS_DRDY) == 0)
                return 0;
        *res = UART_DATA;
        return 1;
}

void dump_buf(char *buf, int16_t cnt) {
	int i;

	for (i = 0; i < cnt; i++) {
		puthex(buf[i]);
		cputc(' ');
		if ((i & 15) == 15) {
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

#define RRQ     01                      /* read request */
#define WRQ     02                      /* write request */
#define DATA    03                      /* data packet */
#define ACK     04                      /* acknowledgement */
#define ERROR   05                      /* error code */
#define OACK    06                      /* option acknowledgement */

struct tftphdr {
        unsigned short  th_opcode;              /* packet type */
        union {
                unsigned short  tu_block;       /* block # */
                unsigned short  tu_code;        /* error code */
                char    tu_stuff[1];    /* request packet stuff */
        } th_u;
        char    th_data[1];             /* data or error string */
};

#define th_block        th_u.tu_block
#define th_code         th_u.tu_code
#define th_stuff        th_u.tu_stuff
#define th_msg          th_data

#define EUNDEF          0               /* not defined */
#define ENOTFOUND       1               /* file not found */
#define EACCESS         2               /* access violation */
#define ENOSPACE        3               /* disk full or allocation exceeded */
#define EBADOP          4               /* illegal TFTP operation */
#define EBADID          5               /* unknown transfer ID */
#define EEXISTS         6               /* file already exists */
#define ENOUSER         7               /* no such user */
#define EOPTNEG         8               /* option negotiation failed */

#define TFTP_STATE_IDLE 0
#define TFTP_STATE_BUSY 1
#define TFTP_STATE_READ 2
#define TFTP_STATE_WRITE 3

char tftp_state = TFTP_STATE_IDLE;
uint16_t tftp_blocknum;
uint16_t tftp_blocksize;

void
send_nak(uint16_t code, char *msg) {
	struct tftphdr *tp;
	struct netUdpHeader* udp;
	struct netEthIpHeader* eth;
	uint16_t length;
	uint32_t dst_ip;

	cprintf("Send NAK %d %s\n", code, msg);
	eth = (struct netEthIpHeader*)(netstackGetBuffer());
	udp = (struct netUdpHeader*)((char *)eth + ETH_HEADER_LEN + IP_HEADER_LEN);
	tp = (struct tftphdr*)((char *)udp + UDP_HEADER_LEN);

	dst_ip = HTONL(eth->ip.srcipaddr);

	length = udp->destport;
        udp->destport = udp->srcport;
        udp->srcport = length;
        udp->udpchksum = 0;

	tp->th_opcode = htons((uint16_t)ERROR);
	tp->th_code = htons(code);
	strcpy(tp->th_msg, msg);
	length = strlen(msg);
	tp->th_msg[length] = '\0';

	length += 5;
	length += UDP_HEADER_LEN;
        udp->udplen = htons(length);

	dump_buf((char *)eth, length);
	ipSend(dst_ip, IP_PROTO_UDP, length, (uint8_t*)udp);
}

void
send_data() {
	struct tftphdr *tp;
	struct netUdpHeader* udp;
	struct netEthIpHeader* eth;
	uint16_t length;
	uint32_t dst_ip;

	//cprintf("Send data %d\n", tftp_blocknum);
	cputc('<');
	eth = (struct netEthIpHeader*)(netstackGetBuffer());
	udp = (struct netUdpHeader*)((char *)eth + ETH_HEADER_LEN + IP_HEADER_LEN);
	tp = (struct tftphdr*)((char *)udp + UDP_HEADER_LEN);

	dst_ip = HTONL(eth->ip.srcipaddr);

	length = udp->destport;
        udp->destport = udp->srcport;
        udp->srcport = length;
        udp->udpchksum = 0;

	tp->th_opcode = htons((uint16_t)DATA);
	tp->th_block = htons((uint16_t)tftp_blocknum);
	memcpy(tp->th_data, buf, tftp_blocksize);

	length = 5 + tftp_blocksize;
	length += UDP_HEADER_LEN;
        udp->udplen = htons(length);

	//dump_buf((char *)eth, length);
	ipSend(dst_ip, IP_PROTO_UDP, length, (uint8_t*)udp);
	cputc('>');
}

void tftpIn(int plen, void *payload) {
	struct tftphdr *th = payload;
	char *rptr, *wptr;
	uint8_t len;
	char filename[13];
	char ch;
	int16_t rc;

	//cprintf("TFTP Packet: %d\n", plen);
	switch (tftp_state) {
		case TFTP_STATE_IDLE:
			if (htons(th->th_opcode) == RRQ) {
				cprintf("RRQ\n");
				rptr = (char *)&(th->th_stuff);
				wptr = filename;
				len = plen - 2;
				while (len>0) {
					ch = *rptr;
					*wptr = ch;
					rptr++;
					wptr++;
					if (ch == 0)
						break;
				};
				if (ch!=0) {
					send_nak(EBADOP, "bad request");
					return;
				};
				cprintf("bin: %s\n", rptr);
				if (strncmp(rptr,"octet",6)) {
					send_nak(EBADOP, "binary mode required");
					return;
				};
				rc = opendisk();
				if (rc) {
					send_nak(ENOTFOUND, "opendisk() failed");
					return;
				};
				rc = openfile(filename);
				if (rc) {
					send_nak(ENOTFOUND, "file not found");
					return;
				};
				rc = readfile();
				if (rc<0) {
					send_nak(ENOTFOUND, "read error");
					return;
				};
				tftp_state = TFTP_STATE_READ;
				tftp_blocknum = 1;
				tftp_blocksize = rc;
				send_data();
				return;
			} else if (htons(th->th_opcode) == WRQ) {
				cprintf("WRQ\n");
				send_nak(EBADOP, "bad request");
				return;
			} else {
				cprintf("cmd: %d\n", htons(th->th_opcode));
				send_nak(EBADOP, "bad request");
				return;
			};
			break;
		case TFTP_STATE_READ:
			if (htons(th->th_opcode) == ACK) {
				if (htons(th->th_block) == tftp_blocknum - 1) {
					// resend of prev block
					send_data();
					return;
				} else if (htons(th->th_block) == tftp_blocknum) {
					rc = readfile();
					if (rc<0) {
						send_nak(ENOTFOUND, "read error");
						return;
					};
					if ((rc > 0) || (tftp_blocksize == 512)) {
						tftp_blocknum += 1;
						tftp_blocksize = rc;
						send_data();
					} else {
						tftp_state = TFTP_STATE_IDLE;
						cprintf("Send Done\n");
					};
				};
			} else {
				cprintf("cmd: %d\n", htons(th->th_opcode));
				send_nak(EBADOP, "bad request");
				tftp_state = TFTP_STATE_IDLE;
				return;
			};
			break;
	};
}

void netstackUDPIPProcess(unsigned int len, udpip_hdr* packet)
{
	uint16_t payloadlen=0;
	uint8_t* payloaddata=0;

	// get UDP payload length
	payloadlen = htons(packet->udp.udplen);
	payloadlen -= 8; // subtract header
	// get UDP payload data
	payloaddata = &((unsigned char*)packet)[IP_HEADER_LEN+UDP_HEADER_LEN];
	
//	cprintf("UDP packet, len: %d\n", len);
//	debugPrintHexTable(len, (unsigned char*)packet);

	if(packet->udp.destport == HTONS(68))
	{
		// command packet
		dhcpIn(payloadlen, (void *)payloaddata);
	}

	if(packet->udp.destport == HTONS(69))
	{
		// command packet
		tftpIn(payloadlen, (void *)payloaddata);
	}

	if(packet->udp.destport == HTONS(5000))
	{
		// command packet
		//cprintf("send_prg.py packet: %d\n", payloadlen);
		//dump_buf(payloaddata,payloadlen);
		if ((payloadlen == 6) && 
			(!strncmp(payloaddata,"\xBA\xCE\x02\x00\x00\xE0",6))) {
			cprintf("Loader Reset packet received\n");
			asm("jmp $E000");
		};
	}
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
	uint16_t rc;
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
int 
main(int argc, char **argv)
{
	char ch;
	cprintf("Main started\n");
	// readfat(0,0);

	/* netstackInit(3232235906,4294967040,3232235777); */
	netstackInit(0,0,0);

	//ipPrintConfig(NULL);

	dhcpRequest();
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
	cmdlineAddCommand("reset", (void *)0xE000);
	cmdlinePrintPrompt();

	while (1) {
		netstackService();
		if (getc_nowait(&ch)) {
			cmdlineInputFunc(ch);
		};
		cmdlineMainLoop();
	};

	cprintf("\ndone\n");
		
	return 0;
}
