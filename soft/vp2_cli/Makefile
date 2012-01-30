all:	main.bin

VER != date '+%Y/%m/%d %H:%M:%S'

PROG = main
OBJS = main.o cmdline.o
OBJS += strtol.o

sd:	main.bin
	sudo dd if=main.bin of=/dev/sdd bs=512 seek=1 conv=sync

.include "../xilinx_ram/Makefile.inc"
CFLAGS += -DMAIN_VERSION='"${VER}"'
