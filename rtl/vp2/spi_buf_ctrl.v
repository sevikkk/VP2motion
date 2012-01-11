`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:33:26 03/18/2009 
// Design Name: 
// Module Name:    spi_flash_ctrl 
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
module spi_buf_ctrl(
    input clk,
	 input reset,
	 
	 // RX Interface
	 input rxPacketStart,
	 input [7:0] rxData,
	 input rxDataRdySet,

	 // TX interface
	 output reg txDataFull,
	 output reg [7:0] txData,
	 input txDataEmpty,
	 input txDataFullClr,
	 
	 // CPU interface
	 input [7:0] cpu_di,
	 output [7:0] cpu_do,
	 output reg [7:0] cpu_addr,
	 input cpu_rd,
	 input cpu_wr
);

reg [7:0] buffer[31:0];
reg [4:0] cpu_addr_reg;
wire [7:0] spi_do;
reg [4:0] spi_addr;

always @(posedge clk)
	begin
		cpu_addr_reg <= cpu_addr[4:0];
		if (cpu_wr)
			buffer[cpu_addr[4:0]] <= cpu_di;				
	end
	
assign cpu_do = buffer[cpu_addr_reg];
assign spi_do = buffer[spi_addr];

`define STATE_IDLE 0
`define STATE_SEND 1
`define STATE_WAIT 2

reg [3:0] state;
reg [3:0] next_state;
reg [7:0] next_txData;
reg next_txDataFull;
reg rxDataRdy;
reg next_rxDataRdy;
reg [4:0] next_spi_addr;

always @(posedge clk)
	begin
		if (reset)
			begin
				state <= `STATE_IDLE;
				txData <= 0;
				txDataFull <= 0;
				rxDataRdy <= 0;
				spi_addr <= 0;
			end
		else
			begin
				state <= next_state;
				txData <= next_txData;
				txDataFull <= next_txDataFull;
				rxDataRdy <= next_rxDataRdy;
				spi_addr <= next_spi_addr;
			end
	end

always @(state or rxDataRdy or rxDataRdySet or rxPacketStart or txDataFull or txDataEmpty or rxData or txData or txDataFull or txDataFullClr
				or spi_addr or buffer or spi_do)
	begin
		next_txDataFull <= txDataFull;
		next_rxDataRdy <= rxDataRdy;
		next_txData <= txData;
		next_state <= state;
		
		if (rxDataRdySet)
			next_rxDataRdy <= 1;
				
		if (txDataFullClr)
			next_txDataFull <= 0;
					
		case (state)
			`STATE_IDLE: begin
				if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						if (rxPacketStart)
							begin
								next_txDataFull <= 0;
								next_spi_addr <= 0;
								next_state <= `STATE_SEND;
							end
					end
			end
			`STATE_SEND: begin
				next_txData <= spi_do;
				next_txDataFull <= 1;
				next_spi_addr <= spi_addr + 1;
				next_state <= `STATE_WAIT;
			end
			`STATE_WAIT: begin
				if (rxPacketStart)
					next_state <= `STATE_IDLE;
				else
					if (rxDataRdy)
						begin
							next_rxDataRdy <= 0;
							if (spi_addr == 0)
								next_state <= `STATE_IDLE;
							else
								next_state <= `STATE_SEND;
						end
			end
		endcase
	end
	
endmodule
