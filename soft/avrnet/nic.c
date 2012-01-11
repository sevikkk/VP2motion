#define REG(x) (*((char *)(x)))

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

#include "nic.h"
#include <string.h>
#include <stdlib.h>
#include <conio.h>

void nicGetMacAddress(uint8_t* macaddr) {
	memcpy(macaddr, "\x00\x10\x11\x12\x13\x14", 6);
}

void nicInit(void) {
	ETH_CMD = ETH_CMD_ENABLE;
}

static int pktlen;
static char ch;

unsigned int nicPoll(unsigned int maxlen, unsigned char* packet) {
	if (!(ETH_STATUS & ETH_STATUS_RX_DONE)) // check for ready to use frame
		return 0;

	pktlen = 0;
	if (ETH_STATUS & ETH_STATUS_RX_ERROR)
		pktlen = maxlen + 10;

	while (1) {
		if (ETH_STATUS & ETH_STATUS_RX_EMPTY)
			break;
		ch = ETH_DATA;

		if (ETH_STATUS & ETH_STATUS_RX_EMPTY)
			break;

		ch |= ETH_DATA << 4;
		if (pktlen < maxlen) {
			packet[pktlen] = ch;
		};
		pktlen++;
	};

	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_RX; // enable rx of next packet
	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_RX; // enable rx of next packet
	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_RX; // enable rx of next packet
	//while (ETH_STATUS & ETH_STATUS_RX_DONE) {};
	ETH_CMD = ETH_CMD_ENABLE;

	if (pktlen > maxlen + 4)
		return 0;

	return pktlen - 4;
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
	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_TX; //start send
	ETH_CMD = ETH_CMD_ENABLE | ETH_CMD_NEXT_TX; //start send
	ETH_CMD = ETH_CMD_ENABLE;
	//while (ETH_STATUS & ETH_STATUS_TX_DONE) {};
	//ETH_CMD = ETH_CMD_ENABLE;
	//while (!(ETH_STATUS & ETH_STATUS_TX_DONE)) {};
}


