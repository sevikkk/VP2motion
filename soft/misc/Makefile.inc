MISCBASE = ${.CURDIR}/../misc

.PATH: ${MISCBASE}

CFLAGS+=-I${MISCBASE}
LIBS+= misc.lib

MISCOBJS = fat.o

misc.lib:	${MISCOBJS}
	rm -f ${.TARGET}
	ar65 a ${.TARGET} ${.ALLSRC}

${PROG}.bin:	misc.lib
