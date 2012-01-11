`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:12:40 03/20/2009 
// Design Name: 
// Module Name:    spi_master_ctrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module spi_master_ctrl(
    input clk,
    input reset,
	 input wr,
	 input rd,
	 input [7:0] addr,
	 input [7:0] cpu_di,
	 output reg [7:0] cpu_do,
	 
	 input [7:0] rxData,
	 input rxDataRdySet,
	 
	 output reg [7:0] txData,
	 output reg txDataFull,
	 input txDataFullClr,
	 input txDataEmpty,

	 output reg spiSS0,
	 output reg spiSS1,
	 output reg spiSS2,
	 output reg spiSS3,
	 
	 output reg [7:0] clkDelay
);

reg rxDataRdy;
reg spiSS;
reg [1:0] spiDevNum;

always @(posedge clk)
	begin
		spiSS0 <= 0;
		spiSS1 <= 0;
		spiSS2 <= 0;
		spiSS3 <= 0;
		if (spiSS)
			case (spiDevNum)
				0: spiSS0 <= 1;
				1: spiSS1 <= 1;
				2: spiSS2 <= 1;
				3: spiSS3 <= 1;
			endcase
	end
	
always @(posedge clk)
	begin
		if (reset)
			begin
				cpu_do <= 0;
				rxDataRdy <= 0;
				txDataFull <= 0;
				spiSS <= 0;
				spiDevNum <= 0;
				clkDelay <= 8'h30;
			end
		else
			begin
				cpu_do <= 0;
				
				if (rxDataRdySet)
					rxDataRdy <= 1;
					
				if (txDataFullClr)	
					txDataFull <= 0;
					
				case (addr[1:0])
					0: begin
						if (rd) begin
							cpu_do <= rxData;
							rxDataRdy <= 0;
						end
						if (wr) begin
							txData <= cpu_di;
							txDataFull <= 1;
						end
					end
					1: begin
						if (rd) begin
							cpu_do[0] <= spiSS;
							cpu_do[1] <= rxDataRdy;
							cpu_do[2] <= txDataFull;
							cpu_do[3] <= txDataEmpty;
							cpu_do[5:4] <= spiDevNum;
						end
						if (wr) begin
							spiSS <= cpu_di[0];
							spiDevNum <= cpu_di[5:4];
						end
					end
					2: begin
						if (rd) begin
							cpu_do <= clkDelay;
						end
						if (wr) begin
							clkDelay <= cpu_di;
						end
					end
				endcase
			end
	end
	
endmodule
