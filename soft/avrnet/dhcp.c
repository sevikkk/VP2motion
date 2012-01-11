/*! \file dhcp.c \brief DHCP Protocol Library. */
//*****************************************************************************
//
// File Name	: 'dhcp.c'
// Title		: DHCP Protocol Library
// Author		: Pascal Stang
// Created		: 9/17/2005
// Revised		: 9/17/2005
// Version		: 0.1
// Target MCU	: Atmel AVR series
// Editor Tabs	: 4
//
//*****************************************************************************

#include <conio.h>
#include "net.h"
#include "nic.h"
#include "ip.h"
#include "netstack.h"

#include "dhcp.h"

//#define DHCP_DEBUG
//#define NET_DEBUG 10

// global variables
uint32_t DhcpServerIP;		///< IP address of the DHCP server that offered lease
uint32_t DhcpTransactID;	///< Unique transaction ID that identifies DHCP request/replies
uint32_t DhcpLeaseTime;		///< Number of seconds left in DHCP lease

void dhcpInit(void)
{
	uint8_t	macaddr[6];
	
	// get interface mac address
	nicGetMacAddress(macaddr);
	// set transaction ID based on mac address
	DhcpTransactID = *((uint32_t*)&macaddr);
	// reset lease time
	DhcpLeaseTime = 0;
}

void dhcpIn(unsigned int len, struct netDhcpHeader* packet)
{
	uint8_t msgtype;
	uint32_t sid;
	uint8_t* optptr;
	uint32_t val;
	uint32_t netmask;
	uint32_t gateway;

	#if NET_DEBUG >= 3
	dhcpPrintHeader(packet);
	#endif

	// check that this is a reply, and for me
	if((packet->bootp.op != BOOTP_OP_BOOTREPLY) || (packet->bootp.xid != DhcpTransactID))
		return;

	// process incoming packet
	// check reply type
	dhcpGetOption(packet->options, DHCP_OPT_DHCPMSGTYPE, 1, &msgtype);
	#if NET_DEBUG >= 2
	cprintf("DHCP: Received msgtype = %d\n", msgtype);
	#endif
	
	if(msgtype == DHCP_MSG_DHCPOFFER)
	{
		// get DHCP server ID
		dhcpGetOption(packet->options, DHCP_OPT_SERVERID, 4, &sid);
		#ifdef DHCP_DEBUG
		cprintf("DHCP: Got offer from server "); netPrintIPAddr(htonl(sid)); cprintf("\n");
		#endif

		// build DHCP request (on top of this reply)
		packet->bootp.op = BOOTP_OP_BOOTREQUEST;		// request type
		// set operation
		val = DHCP_MSG_DHCPREQUEST;
		optptr = dhcpSetOption(packet->options, DHCP_OPT_DHCPMSGTYPE, 1, &val);
		// set the server ID
		optptr = dhcpSetOption(optptr, DHCP_OPT_SERVERID, 4, &sid);
		// request the IP previously offered
		optptr = dhcpSetOption(optptr, DHCP_OPT_REQUESTEDIP, 4, &packet->bootp.yiaddr);
		// request additional information
		((uint8_t*)&val)[0] = DHCP_OPT_NETMASK;
		((uint8_t*)&val)[1] = DHCP_OPT_ROUTERS;
		((uint8_t*)&val)[2] = DHCP_OPT_DNSSERVERS;
		((uint8_t*)&val)[3] = DHCP_OPT_DOMAINNAME;
		optptr = dhcpSetOption(optptr, DHCP_OPT_PARAMREQLIST, 4, &val);

		#ifdef DHCP_DEBUG
		cprintf("DHCP: Sending request in response to offer\n");
		#endif
		// send DHCP request
		DhcpServerIP = htonl(sid);
		udpSend(DhcpServerIP, DHCP_UDP_SERVER_PORT, DHCP_HEADER_LEN+3+6+6+6+1, (uint8_t*)packet);

	}
	else if(msgtype == DHCP_MSG_DHCPACK)
	{
		// get netmask
		dhcpGetOption(packet->options, DHCP_OPT_NETMASK, 4, &val);
		netmask = htonl(val);
		// get gateway
		dhcpGetOption(packet->options, DHCP_OPT_ROUTERS, 4, &val);
		gateway = htonl(val);
		// get gateway
		dhcpGetOption(packet->options, DHCP_OPT_LEASETIME, 4, &val);
		DhcpLeaseTime = htonl(val);

		// assign new network info
		ipSetConfig(htonl(packet->bootp.yiaddr), netmask, gateway);

		#ifdef DHCP_DEBUG
		cprintf("DHCP: Got request ACK, bind complete\n");
		//debugPrintHexTable(len-DHCP_HEADER_LEN, (packet->options));
		// print info
		#endif
		cprintf("DHCP bind complete\n");
		ipPrintConfig(ipGetConfig());
		cprintf("LeaseTm : %ld\n", DhcpLeaseTime);
	}
}

void dhcpRequest(void)
{
	struct netDhcpHeader* packet;
	uint32_t val;
	
	packet = (struct netDhcpHeader*)&netstackGetBuffer()[ETH_HEADER_LEN+IP_HEADER_LEN+UDP_HEADER_LEN];

	// build BOOTP/DHCP header
	packet->bootp.op = BOOTP_OP_BOOTREQUEST;		// request type
	packet->bootp.htype = BOOTP_HTYPE_ETHERNET;
	packet->bootp.hlen = BOOTP_HLEN_ETHERNET;
	packet->bootp.ciaddr = htonl(IpMyConfig.ip);
	packet->bootp.yiaddr = HTONL(0l);
	packet->bootp.siaddr = HTONL(0l);
	packet->bootp.giaddr = HTONL(0l);
	nicGetMacAddress(&(packet->bootp.chaddr[0]));	// fill client hardware address
	packet->bootp.xid = DhcpTransactID;
	packet->bootp.flags = HTONS(1);
	
	// build DHCP request
	// begin with magic cookie
	packet->cookie = 0x63538263;
	// set operation
	val = DHCP_MSG_DHCPDISCOVER;
	dhcpSetOption(packet->options, DHCP_OPT_DHCPMSGTYPE, 1, &val);

	#ifdef DHCP_DEBUG
	cprintf("DHCP: Sending Query\n");
	//dhcpPrintHeader(packet);
	#endif

	// send request
	udpSend(0xFFFFFFFF, DHCP_UDP_SERVER_PORT, DHCP_HEADER_LEN+3+1, (uint8_t*)packet);
}

void dhcpRelease(void)
{
	struct netDhcpHeader* packet;
	uint32_t val;
	uint8_t* optptr;
	
	packet = (struct netDhcpHeader*)&netstackGetBuffer()[ETH_HEADER_LEN+IP_HEADER_LEN+UDP_HEADER_LEN];

	// build BOOTP/DHCP header
	packet->bootp.op = BOOTP_OP_BOOTREQUEST;		// request type
	packet->bootp.htype = BOOTP_HTYPE_ETHERNET;
	packet->bootp.hlen = BOOTP_HLEN_ETHERNET;
	packet->bootp.ciaddr = htonl(ipGetConfig()->ip);
	packet->bootp.yiaddr = HTONL(0l);
	packet->bootp.siaddr = HTONL(0l);
	packet->bootp.giaddr = HTONL(0l);
	nicGetMacAddress(&packet->bootp.chaddr[0]);	// fill client hardware address
	packet->bootp.xid = DhcpTransactID;			// set trans ID (use part of MAC address)
	packet->bootp.flags = HTONS(1);
	
	// build DHCP request
	// begin with magic cookie
	packet->cookie = 0x63538263;
	// set operation
	val = DHCP_MSG_DHCPRELEASE;
	optptr = dhcpSetOption(packet->options, DHCP_OPT_DHCPMSGTYPE, 1, &val);
	// set the server ID
	val = htonl(DhcpServerIP);
	optptr = dhcpSetOption(optptr, DHCP_OPT_SERVERID, 4, &val);
	// request the IP previously offered
	optptr = dhcpSetOption(optptr, DHCP_OPT_REQUESTEDIP, 4, &packet->bootp.ciaddr);

	#ifdef DHCP_DEBUG
	cprintf("DHCP: Sending Release to "); netPrintIPAddr(DhcpServerIP); cprintf("\n");
	//dhcpPrintHeader(packet);
	#endif

	// send release
	udpSend(DhcpServerIP, DHCP_UDP_SERVER_PORT, DHCP_HEADER_LEN+3+6+6+1, (uint8_t*)packet);
	
	// deconfigure ip addressing
	ipSetConfig(0,0,0);
	DhcpLeaseTime = 0;
}

void dhcpTimer(void)
{
	// this function to be called once per second

	// decrement lease time
	if(DhcpLeaseTime)
		DhcpLeaseTime--;
}

uint8_t dhcpGetOption(uint8_t* options, uint8_t optcode, uint8_t optlen, void* optvalptr)
{
	uint8_t i;

	// parse for desired option
	for (;;)
	{
		// skip pad characters
		if(*options == DHCP_OPT_PAD)
			options++;
		// break if end reached
		else if(*options == DHCP_OPT_END)
			break;
		// check for desired option
		else if(*options == optcode)
		{
			if(*(options+1) < optlen)
				optlen = *(options+1);
			
			// copy contents of option
			for(i=0; i<optlen; i++)
				*(((uint8_t*)optvalptr)+i) = *(options+i+2);
			// return length of option
			return *(options+1);
		}
		else
		{
			// skip to next option
			options++;
			options+=*options;
			options++;
		}
	}
	// failed to find desired option
	return 0;
}


uint8_t* dhcpSetOption(uint8_t* options, uint8_t optcode, uint8_t optlen, void* optvalptr)
{
	// use current options address as write point

	// set optcode
	*options++ = optcode;
	// set optlen
	*options++ = optlen;
	// copy in argument/data
	while(optlen--)
	{
		*options++ = *((uint8_t*)optvalptr)++;
	}
	// write end marker
	*options = DHCP_OPT_END;

	// return address of end marker, to be used as a future write point
	return options;
}


void dhcpPrintHeader(struct netDhcpHeader* packet)
{
	cprintf("DHCP Packet:\n");
	// print op
	cprintf("Op      : ");
	switch(packet->bootp.op)
	{
	case BOOTP_OP_BOOTREQUEST:	cprintf("BOOTREQUEST"); break;
	case BOOTP_OP_BOOTREPLY:	cprintf("BOOTREPLY"); break;
	default:					cprintf("UNKNOWN"); break;
	}
	cprintf("\n");
	// print transaction ID
	cprintf("XID     : 0x%04lX\n", packet->bootp.xid);
	// print client IP address
	cprintf("ClIpAddr: ");	netPrintIPAddr(htonl(packet->bootp.ciaddr));	cprintf("\n");
	// print 'your' IP address
	cprintf("YrIpAddr: ");	netPrintIPAddr(htonl(packet->bootp.yiaddr));	cprintf("\n");
	// print server IP address
	cprintf("SvIpAddr: ");	netPrintIPAddr(htonl(packet->bootp.siaddr));	cprintf("\n");
	// print gateway IP address
	cprintf("GwIpAddr: ");	netPrintIPAddr(htonl(packet->bootp.giaddr));	cprintf("\n");
	// print client hardware address
	cprintf("ClHwAddr: ");	netPrintEthAddr((struct netEthAddr*)packet->bootp.chaddr);	cprintf("\n");
}
