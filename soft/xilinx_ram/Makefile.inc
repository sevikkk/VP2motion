BASE = ../xilinx_ram

.PATH: ${BASE}
.PATH: ../common

CFLAGS=-I${.CURDIR}/../common
CAFLAGS=-I${.CURDIR}/../common
LIBS=runtime.lib

RUNTIMEOBJS = callmain.o copydata.o enter.o leave.o mainargs.o zerobss.o zeropage.o

runtime.lib:	${RUNTIMEOBJS}
	rm -f ${.TARGET}
	ar65 a ${.TARGET} ${.ALLSRC}

${PROG}.bin:	crt0.o ${LIBS} ${OBJS}
	ld65 -C ${BASE}/ld65.cfg -o ${.TARGET} -m ${.TARGET:S/.bin$/.map/} crt0.o ${OBJS} ${LIBS} /usr/lib/cc65/lib/nes.lib

load:	${PROG}.bin
	../tools/send_prg.py ${PROG}.bin

.include "../Makefile.inc"
