`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:18 03/15/2009 
// Design Name: 
// Module Name:    spi_slave 
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
module spi_slave(
    input clk,
    input reset,
	 
	 // SPI
    input spiDataIn,
    input spiClkIn,
    input spiSelectIn,
    output reg spiDataOut,
	 
	 // TX interface
	 input txDataFull,
	 input [7:0] txDataIn,
	 output reg txDataEmpty,
	 output reg txDataFullClr,
	 
	 // RX Interface
	 output reg [7:0] rxDataOut,
	 output reg rxDataRdySet,
	 output reg rxPacketStart
);

reg reg1_spiDataIn;
reg reg1_spiClkIn;
reg reg1_spiSelectIn;
reg reg2_spiDataIn;
reg reg2_spiClkIn;
reg reg2_spiSelectIn;
reg reg_spiDataIn;
reg reg_spiClkIn;
reg reg_spiSelectIn;

always @(posedge clk)
	begin
		if (reset)
			begin
				reg_spiDataIn <= 0;
				reg_spiClkIn <= 0;
				reg_spiSelectIn <= 0;
				reg1_spiDataIn <= 0;
				reg1_spiClkIn <= 0;
				reg1_spiSelectIn <= 0;
				reg2_spiDataIn <= 0;
				reg2_spiClkIn <= 0;
				reg2_spiSelectIn <= 0;
			end
		else
			begin
				reg1_spiDataIn <= spiDataIn;
				reg1_spiClkIn <= spiClkIn;
				reg1_spiSelectIn <= spiSelectIn;
				reg2_spiDataIn <= reg1_spiDataIn;
				reg2_spiClkIn <= reg1_spiClkIn;
				reg2_spiSelectIn <= reg1_spiSelectIn;
				
				if (reg1_spiDataIn == reg2_spiDataIn)
					reg_spiDataIn <= reg1_spiDataIn;
					
				if (reg1_spiClkIn == reg2_spiClkIn)
					reg_spiClkIn <= reg1_spiClkIn;

				if (reg1_spiSelectIn == reg2_spiSelectIn)
					reg_spiSelectIn <= reg1_spiSelectIn;
			end
	end


reg [2:0] state;
reg [2:0] next_state;
reg next_spiDataOut;
reg next_txDataEmpty;
reg next_txDataFullClr;
reg [7:0] next_rxDataOut;
reg next_rxDataRdySet;
reg next_rxPacketStart;
reg rxPacketStartTmp;
reg next_rxPacketStartTmp;
reg [7:0] rxDataReg;
reg [7:0] next_rxDataReg;
reg [7:0] txDataReg;
reg [7:0] next_txDataReg;
reg [3:0] bitcnt;
reg [2:0] next_bitcnt;


`define STATE_WAIT_HI_0 0
`define STATE_WAIT_HI_1 1
`define STATE_WAIT_LO_0 2
`define STATE_WAIT_LO_1 3

always @(state or reset or spiDataOut or reg_spiDataIn or reg_spiClkIn or reg_spiSelectIn or txDataFull or txDataEmpty or txDataIn or txDataReg or rxDataOut or rxDataReg or bitcnt or rxPacketStart or rxPacketStartTmp)
	begin
		next_state <= state;
		next_spiDataOut <= spiDataOut;
		next_txDataEmpty <= txDataEmpty;
		next_txDataFullClr <= 0;
		next_rxDataOut <= rxDataOut;
		next_rxDataRdySet <= 0;
		next_rxPacketStart <= rxPacketStart;
		next_rxPacketStartTmp <= rxPacketStartTmp;
		next_rxDataReg <= rxDataReg;
		next_txDataReg <= txDataReg;
		next_bitcnt <= bitcnt;
		if (reset || !reg_spiSelectIn)
			begin
				next_state <= `STATE_WAIT_HI_0;
				next_spiDataOut <= 0;
				next_txDataEmpty <= 1;
				next_rxDataOut <= 0;
				next_rxPacketStart <= 0;
				next_rxPacketStartTmp <= 1;
				next_rxDataReg <= 0;
				next_txDataReg <= 0;
				next_bitcnt <= 0;
				if (txDataFull)
					next_txDataFullClr <= 1;
			end
		else
			case (state)
				`STATE_WAIT_HI_0: begin
					if (bitcnt == 0)
						begin
							if (txDataFull)
								begin
									next_txDataReg <= txDataIn;
									next_txDataFullClr <= 1;
									next_spiDataOut <= txDataIn[7];
								end
							else
								begin
									next_txDataReg <= 255;
									next_spiDataOut <= 1;
								end
						end
					else
						begin
							next_spiDataOut <= txDataReg[6];
							next_txDataReg <= txDataReg[6:0] << 1;
						end
						
					next_bitcnt <= bitcnt + 1;			
					next_state <= `STATE_WAIT_HI_1;
				end
				`STATE_WAIT_HI_1: begin
					if (reg_spiClkIn)
						begin
							next_state <= `STATE_WAIT_LO_0;
							next_rxDataReg <= rxDataReg[6:0] << 1 | reg_spiDataIn;
						end
				end
				`STATE_WAIT_LO_0: begin
					if (bitcnt == 0)
						begin
							next_rxDataOut <= rxDataReg;
							next_rxDataReg <= 0;
							next_rxDataRdySet <= 1;
							next_rxPacketStart <= rxPacketStartTmp;
							next_rxPacketStartTmp <= 0;
						end
					next_state <= `STATE_WAIT_LO_1;
				end
				`STATE_WAIT_LO_1: begin
					if (!reg_spiClkIn)
						begin
							next_state <= `STATE_WAIT_HI_0;
						end
				end
			endcase
	end

always @(posedge clk)
	begin
		state <= next_state;
		spiDataOut <= next_spiDataOut;
		txDataEmpty <= next_txDataEmpty;
		txDataFullClr <= next_txDataFullClr;
		rxDataOut <= next_rxDataOut;
		rxDataRdySet <= next_rxDataRdySet;
		rxPacketStart <= next_rxPacketStart;
		rxPacketStartTmp <= next_rxPacketStartTmp;
		rxDataReg <= next_rxDataReg;
		txDataReg <= next_txDataReg;
		bitcnt <= next_bitcnt;
	end
	

endmodule
