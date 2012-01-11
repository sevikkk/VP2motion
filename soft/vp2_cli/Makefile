all:	main.bin

PROG = main
OBJS = main.o cmdline.o
OBJS += strtol.o

sd:	main.bin
	sudo dd if=main.bin of=/dev/da0 bs=512 oseek=1 conv=sync

.include "../xilinx_ram/Makefile.inc"
