AVRNETBASE = ${.CURDIR}/../avrnet

.PATH: ${AVRNETBASE}

CFLAGS+=-I${AVRNETBASE}
LIBS+= avrnet.lib

AVRNETOBJS = arp.o dhcp.o icmp.o ip.o net.o netstack.o nic.o

avrnet.lib:	${AVRNETOBJS}
	rm -f ${.TARGET}
	ar65 a ${.TARGET} ${.ALLSRC}

${PROG}.bin:	avrnet.lib
