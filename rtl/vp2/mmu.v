`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:09:19 11/24/2008 
// Design Name: 
// Module Name:    mmu 
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
module mmu(
    input clk,
    input reset,
    input [7:0] cpu_do,
    input sdc_cmd_wr,
    input [11:0] cpu_addr,
    output [24:0] sdc_addr,
    output [31:0] sdc_data_in,
	 input sdc_cs,
	 input sdc_rd,
	 input sdc_wr,
	 output sdc_cs_reg,
	 output sdc_rd_reg,
	 output sdc_wr_reg,
	 input sdc_busy
);

reg [12:0] top;

always @(posedge clk)
	begin

		if (reset == 1)
				top <= 0;
		else
			if (sdc_cmd_wr)
				begin
					if (cpu_addr[0] == 0)
						top[7:0] <= cpu_do[7:0];
					else
						top[12:8] <= cpu_do[4:0];
				end
	end

assign sdc_cs_reg = sdc_cs;
assign sdc_rd_reg = sdc_rd;
assign sdc_wr_reg = sdc_wr;
assign sdc_addr[11:0] = cpu_addr[11:0];
assign sdc_addr[24:12] = top[12:0];
assign sdc_data_in[7:0] = cpu_do[7:0];
assign sdc_data_in[31:8] = 0;

endmodule
