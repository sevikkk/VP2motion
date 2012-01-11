/*! \file net.c \brief Network support library. */
//*****************************************************************************
//
// File Name	: 'net.c'
// Title		: Network support library
// Author		: Pascal Stang
// Created		: 8/30/2004
// Revised		: 7/3/2005
// Version		: 0.1
// Target MCU	: Atmel AVR series
// Editor Tabs	: 4
//
//*****************************************************************************

#include <stdint.h>
#include <conio.h>

#include "net.h"

uint16_t htons(uint16_t val)
{
	return (val<<8) | (val>>8);
}

uint32_t htonl(uint32_t val)
{
	return (htons(val>>16) | (uint32_t)htons(val&0x0000FFFF)<<16);
}


uint16_t netChecksum(void *data, uint16_t len)
{
    register uint32_t sum = 0;

    for (;;) {
        if (len < 2)
            break;
		//sum += *((uint16_t *)data)++;
		sum += *((uint16_t *)data);
		((char *)data)+=2;
        len -= 2;
    }
    if (len)
        sum += *(uint8_t *) data;

    while ((len = (uint16_t) (sum >> 16)) != 0)
        sum = (uint16_t) sum + len;

    return (uint16_t) sum ^ 0xFFFF;
}

void netPrintEthAddr(struct netEthAddr* ethaddr)
{
	cprintf("%02X:%02X:%02X:%02X:%02X:%02X", ethaddr->addr[0], ethaddr->addr[1], ethaddr->addr[2], ethaddr->addr[3], ethaddr->addr[4], ethaddr->addr[5]);
}

void netPrintIPAddr(uint32_t ipaddr)
{
	cprintf("%d.%d.%d.%d",
		((unsigned char*)&ipaddr)[3],
		((unsigned char*)&ipaddr)[2],
		((unsigned char*)&ipaddr)[1],
		((unsigned char*)&ipaddr)[0]);
}

/*
void netPrintEthHeader(struct netEthHeader* eth_hdr)
{
	rprintfProgStrM("Eth Packet Type: 0x");
	rprintfu16(eth_hdr->type);

	rprintfProgStrM(" SRC:");
	netPrintEthAddr(&eth_hdr->src);
	rprintfProgStrM("->DST:");
	netPrintEthAddr(&eth_hdr->dest);
	rprintfCRLF();
}

void netPrintIpHeader(struct netIpHeader* ipheader)
{
	rprintfProgStrM("IP Header\n");
	rprintf("Ver     : %d\n", (ipheader->vhl)>>4);
	rprintf("Length  : %d\n", htons(ipheader->len));
	if(ipheader->proto == IP_PROTO_ICMP)
		rprintfProgStrM("Protocol: ICMP\n");
	else if(ipheader->proto == IP_PROTO_TCP)
		rprintfProgStrM("Protocol: TCP\n");
	else if(ipheader->proto == IP_PROTO_UDP)
		rprintfProgStrM("Protocol: UDP\n");
	else
		rprintf("Protocol: %d\n", ipheader->proto);
	
	rprintfProgStrM("SourceIP: "); netPrintIPAddr(htonl(ipheader->srcipaddr));	rprintfCRLF();
	rprintfProgStrM("Dest  IP: "); netPrintIPAddr(htonl(ipheader->destipaddr));	rprintfCRLF();
}

void netPrintTcpHeader(struct netTcpHeader* tcpheader)
{
	rprintfProgStrM("TCP Header\n");
	rprintf("Src Port: %d\n", htons(tcpheader->srcport));
	rprintf("Dst Port: %d\n", htons(tcpheader->destport));
	rprintfProgStrM("Seq Num : 0x"); rprintfu32(htonl(tcpheader->seqno));	rprintfCRLF();
	rprintfProgStrM("Ack Num : 0x"); rprintfu32(htonl(tcpheader->ackno));	rprintfCRLF();
	rprintfProgStrM("Flags   : ");
	if(tcpheader->flags & TCP_FLAGS_FIN)
		rprintfProgStrM("FIN ");
	if(tcpheader->flags & TCP_FLAGS_SYN)
		rprintfProgStrM("SYN ");
	if(tcpheader->flags & TCP_FLAGS_RST)
		rprintfProgStrM("RST ");
	if(tcpheader->flags & TCP_FLAGS_PSH)
		rprintfProgStrM("PSH ");
	if(tcpheader->flags & TCP_FLAGS_ACK)
		rprintfProgStrM("ACK ");
	if(tcpheader->flags & TCP_FLAGS_URG)
		rprintfProgStrM("URG ");
	rprintfCRLF();
}
*/

