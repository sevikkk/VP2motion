BASE = ../xilinx_rom

.PATH: ${BASE}
.PATH: ../common

CFLAGS=-I${.CURDIR}/../common
CAFLAGS=-I${.CURDIR}/../common

RUNTIMEOBJS = callmain.o copydata.o enter.o leave.o mainargs.o zerobss.o zeropage.o

runtime.lib:	${RUNTIMEOBJS}
	rm -f ${.TARGET}
	ar65 a ${.TARGET} ${.ALLSRC}

${PROG}.bin:	crt0.o runtime.lib ${OBJS}
	ld65 -C ${BASE}/ld65.cfg -o ${.TARGET} -m ${.TARGET:S/.bin$/.map/} crt0.o ${OBJS} runtime.lib /usr/lib/cc65/lib/nes.lib

.include "../Makefile.inc"
