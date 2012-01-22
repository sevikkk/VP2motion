`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:47:09 01/19/2012
// Design Name:   div_steps
// Module Name:   /home/seva/src/vp2/rtl/vp2/test_div_steps.v
// Project Name:  vp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: div_steps
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_div_steps;

	// Inputs
	reg [31:0] dividend;
	reg [31:0] divisor;
	reg clk;
	reg clk_en;
	reg divide;
	reg reset;

	// Outputs
	wire [63:0] quot;
	wire done;

	// Instantiate the Unit Under Test (UUT)
	div_steps uut (
		.dividend_i(dividend), 
		.divisor_i(divisor), 
		.quotient_o(quot),
	   .clk_i(clk),
		.clk_en_i(clk_en),
		.rst_i(reset),
		.divide_i(divide),
		.done_o(done)
	);

	initial begin
		// Initialize Inputs
		dividend = 0;
		divisor = 0;
		clk = 0;
		clk_en = 1;
		divide = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		#100;
		reset = 0;
		
		dividend = 2;
		divisor = 1;
		divide = 1;
		#2000;
		
		dividend = 200;
		divisor = 3;
		divide = 1;
		#2000;

		dividend = 32'h60002000;
		divisor = 32'h56000000;
		divide = 1;
		#2000;

		dividend = 32'h40002000;
		divisor = 13;
		divide = 1;
		#2000;

		dividend = 32'hDfff1234;
		divisor = 3;
		divide = 1;
		#2000;

		dividend = 3;
		divisor = 32'hdfff1234;
		divide = 1;
		#2000;
		// Add stimulus here

	end
 
		
	initial begin
		#100;
		forever
			begin
				clk = 1;
				#5;
				clk = 0;
				if (divide == 1)
					divide = 0;
				#5;
			end;
	end
endmodule

