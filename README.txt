Main areas of interest:

rtl/vp2 - verilog sources for FPGA part of controller. It has embedded
          6502 cpu for control tasks and hardware DDA and acceleration 
	  blocks. SD-card interface and end-stops present too.

soft/vp2_cli - software running on embedded processor. It has commandline 
          interface on serial port and can print .s3g files from SD.

emu/parse.py - host-based g-code interpreter, path planning, synchronized
          acceleration profiles and output to makerbot compatible .s3g files.
