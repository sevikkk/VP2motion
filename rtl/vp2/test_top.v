// Verilog test fixture created from schematic C:\Xilinx\proj\vp2\top.sch - Fri Feb 27 12:12:49 2009

`timescale 1ns / 1ps

module top_top_sch_tb();

// Inputs
   reg clk;
   reg SD_DI;
   reg UART_RX;
   reg SYSRESET;

// Output
   wire SD_CLK;
   wire SD_DO;
   wire SD_CS;
   wire UART_TX;
   wire led1;
   wire led2;
   wire led3;
   wire led4;
   wire led5;
   wire beep;

// Bidirs

// Instantiate the UUT
   top UUT (
		.clk(clk), 
		.SD_DI(SD_DI), 
		.SD_CLK(SD_CLK), 
		.SD_DO(SD_DO), 
		.SD_CS(SD_CS), 
		.UART_RX(UART_RX), 
		.UART_TX(UART_TX), 
		.led1(led1), 
		.led2(led2), 
		.led3(led3), 
		.led4(led4), 
		.led5(led5), 
		.beep(beep), 
		.SYSRESET(SYSRESET)
   );


// Initialize Inputs
initial begin
		clk = 0;
		SD_DI = 0;
		UART_RX = 0;
		SYSRESET = 0;
		#500;
		SYSRESET = 1;
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
