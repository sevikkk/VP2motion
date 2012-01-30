// Verilog test fixture created from schematic /home/seva/src/vp2/rtl/vp2/steppers_module.sch - Sat Jan 28 19:14:52 2012

`timescale 1ns / 1ps

module steppers_module_steppers_module_sch_tb();

// Inputs
   reg clk;
   reg reset;
   reg rd;
   reg wr;
   reg [7:0] cpu_addr;
   reg [7:0] cpu_data_in;

// Output
   wire [7:0] cpu_data_out;
   wire dir_x;
   wire step_x;

// Bidirs

// Instantiate the UUT
   steppers_module UUT (
		.clk(clk), 
		.reset(reset), 
		.rd(rd), 
		.wr(wr), 
		.cpu_data_out(cpu_data_out), 
		.cpu_addr(cpu_addr), 
		.cpu_data_in(cpu_data_in), 
		.dir_x(dir_x), 
		.step_x(step_x)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		clk = 0;
		reset = 0;
		rd = 0;
		wr = 0;
		cpu_addr = 0;
		cpu_data_in = 0;
   `endif
endmodule
