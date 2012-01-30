`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:02:18 01/29/2012
// Design Name:   debounce
// Module Name:   /home/seva/src/vp2/rtl/vp2/test_debounce.v
// Project Name:  vp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: debounce
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_debounce;

	// Inputs
	reg clk;
	reg reset;
	reg sig_in;
	reg unlock;
	reg [31:0] pos_in;
	reg [31:0] timeout;

	// Outputs
	wire sig_out;
	wire sig_changed;
	wire [31:0] pos_out;
	wire [31:0] max_bounce;
	wire [7:0] cycles;

	// Instantiate the Unit Under Test (UUT)
	debounce uut (
		.clk(clk), 
		.reset(reset), 
		.sig_in(sig_in), 
		.unlock(unlock), 
		.pos_in(pos_in), 
		.timeout(timeout), 
		.sig_out(sig_out), 
		.sig_changed(sig_changed), 
		.pos_out(pos_out), 
		.max_bounce(max_bounce), 
		.cycles(cycles)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		sig_in = 0;
		unlock = 0;
		pos_in = 0;
		timeout = 20;

		// Wait 100 ns for global reset to finish
		#100;
		
		reset = 1;
		
		#100;
		
		reset = 0;
        
		// Add stimulus here

	end
   
reg [31:0] cycle;
reg [31:0] cycle2;

initial begin
		cycle = 0;
		cycle2 = 0;
		forever
			begin
				clk = 1;
				#3
				if (unlock == 1)
					begin
						unlock = 0;
					end
					
				pos_in = pos_in + 1;
				case (cycle)
					120: begin
						sig_in = 1;
					end
					160: begin
						unlock = 1;
					end
					200: begin
						sig_in = 0;
					end
					240: begin
						unlock = 1;
					end
					300: begin
						sig_in = 1;
					end
					305: begin
						sig_in = 0;
					end
					310: begin
						sig_in = 1;
					end
					345: begin
						unlock = 1;
					end
					350: begin
						sig_in = 1;
					end
					355: begin
						sig_in = 0;
					end
					362: begin
						sig_in = 1;
					end
					365: begin
						sig_in = 0;
					end
					375: begin
						sig_in = 1;
					end
					
				endcase
				#2;
				clk = 0;
				#5;
				cycle = cycle + 1;
			end;
end
      
endmodule

