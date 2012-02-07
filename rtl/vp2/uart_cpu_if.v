`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:07:15 02/06/2012 
// Design Name: 
// Module Name:    uart_cpu_if 
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
module uart_cpu_if(
	input clk,
	input reset,

	input [7:0] cpu_data_in,
	output reg [7:0] cpu_data_out,
	input [7:0] cpu_addr,
	input rd,
	input wr,
	
	output reg [15:0] uart0_divider,
	output reg uart0_tx_wr,
	output reg uart0_rx_rd,
	input [7:0] uart0_rx_data,
	input [5:0] uart0_status,

	output reg [15:0] uart1_divider,
	output reg uart1_tx_wr,
	output reg uart1_rx_rd,
	input [7:0] uart1_rx_data,
	input [5:0] uart1_status,

	output reg [15:0] uart2_divider,
	output reg uart2_tx_wr,
	output reg uart2_rx_rd,
	input [7:0] uart2_rx_data,
	input [5:0] uart2_status,

	output reg [15:0] uart3_divider,
	output reg uart3_tx_wr,
	output reg uart3_rx_rd,
	input [7:0] uart3_rx_data,
	input [5:0] uart3_status,
	
	input [7:0] misc_in,
	output reg [7:0] misc_out
);

reg [7:0] misc_in_reg;
reg [7:0] misc_in_reg1;
reg [7:0] misc_in_reg2;

always @(posedge clk)
	begin
		misc_in_reg2 <= misc_in;
		misc_in_reg1 <= misc_in_reg2;
		misc_in_reg <= misc_in_reg1;
	end

always @(posedge clk)
	begin
		uart0_tx_wr <= 0;
		uart0_rx_rd <= 0;
		uart1_tx_wr <= 0;
		uart1_rx_rd <= 0;
		uart2_tx_wr <= 0;
		uart2_rx_rd <= 0;
		uart3_tx_wr <= 0;
		uart3_rx_rd <= 0;
		if (reset)
			begin
				misc_out <= 0;
				uart0_divider <= 27;
				uart1_divider <= 27;
				uart2_divider <= 27;
				uart3_divider <= 27;
			end
		else if (rd)
			begin
				case (cpu_addr)
					0: begin
						cpu_data_out <= uart0_rx_data;
						uart0_rx_rd <= 1;
					end
					1: cpu_data_out <= uart0_status;
					2: cpu_data_out <= uart0_divider[7:0];
					3: cpu_data_out <= uart0_divider[15:8];
					
					16: begin
						cpu_data_out <= uart1_rx_data;
						uart1_rx_rd <= 1;
					end
					17: cpu_data_out <= uart1_status;
					18: cpu_data_out <= uart1_divider[7:0];
					19: cpu_data_out <= uart1_divider[15:8];
					
					32: begin
						cpu_data_out <= uart2_rx_data;
						uart2_rx_rd <= 1;
					end
					33: cpu_data_out <= uart2_status;
					34: cpu_data_out <= uart2_divider[7:0];
					35: cpu_data_out <= uart2_divider[15:8];
					
					48: begin
						cpu_data_out <= uart3_rx_data;
						uart3_rx_rd <= 1;
					end
					49: cpu_data_out <= uart3_status;
					50: cpu_data_out <= uart3_divider[7:0];
					51: cpu_data_out <= uart3_divider[15:8];
					
					128: cpu_data_out <= misc_out;
					129: cpu_data_out <= misc_in_reg;
				endcase
			end
		else if (wr)
			begin
				case (cpu_addr)
					0: begin
						uart0_tx_wr <= 1;
					end
					2: uart0_divider[7:0] <= cpu_data_in;
					3: uart0_divider[15:8] <= cpu_data_in;
					
					16: begin
						uart1_tx_wr <= 1;
					end
					18: uart1_divider[7:0] <= cpu_data_in;
					19: uart1_divider[15:8] <= cpu_data_in;
					
					32: begin
						uart2_tx_wr <= 1;
					end
					34: uart2_divider[7:0] <= cpu_data_in;
					35: uart2_divider[15:8] <= cpu_data_in;
					
					48: begin
						uart3_tx_wr <= 1;
					end
					50: uart3_divider[7:0] <= cpu_data_in;
					51: uart3_divider[15:8] <= cpu_data_in;
					
					128: misc_out <= cpu_data_out;
				endcase
			end
			
	end

endmodule
