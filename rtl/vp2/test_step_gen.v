`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:23:21 01/16/2012
// Design Name:   step_gen
// Module Name:   /home/seva/src/vp2/rtl/vp2/test_step_gen.v
// Project Name:  vp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: step_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_step_gen;

	// Inputs
	reg clk;
	reg reset;
	reg [31:0] velocity;
	wire step;
	wire dir;
	wire [31:0] position;

	// Instantiate the Unit Under Test (UUT)
	step_gen uut (
		.clk(clk), 
		.reset(reset), 
		.velocity(velocity),
		.step(step),
		.dir(dir),
		.position(position)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		velocity = 0;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 1;
		
		#17;
		
		reset = 0;
		velocity = 32'h400000;
		#1000000;
		velocity = 32'hFFC00000;
		
        
		// Add stimulus here

	end
  
	initial begin
		#100;
		forever
			begin
				clk = 1;
				#5;
				clk = 0;
				#5;
			end;
	end
		  
endmodule

