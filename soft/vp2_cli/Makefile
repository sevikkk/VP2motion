all:	main.bin

VER != date '+%Y/%m/%d %H:%M:%S'

PROG = main
OBJS = main.o cmdline.o rs485.o steppers.o sdcard.o util.o maxspi.o
OBJS += strtol.o

sd:	main.bin
	sudo dd if=main.bin of=/dev/sdd bs=512 seek=1 conv=sync

.include "../xilinx_ram/Makefile.inc"
CFLAGS += -DMAIN_VERSION='"${VER}"'
