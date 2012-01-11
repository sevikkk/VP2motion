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
module spi_flash_ctrl(
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
	 
	 // Flash interface
	 input [15:0] flashDataIn,
	 output reg [15:0] flashDataOut,
	 output reg [21:0] flashAddr,
	 output reg flashCS,
	 output reg flashOE,
	 output reg flashWE,
	 input flashBusy,
	 output reg flashEnableOutput,
	 
	 // Flash access arbitrage
	 output reg flash_access_req,
	 input flash_access_ack
);
	
reg flashBusy_reg;
reg flashBusy_reg1;
reg flashBusy_reg2;
reg [15:0] flashDataIn_reg;
reg [15:0] flashDataIn_reg1;

// flashBusy debounce and resync to local clock
always @(posedge clk)
	begin
		if (reset)
			begin
				flashBusy_reg <= 0;
				flashBusy_reg1 <= 0;
				flashBusy_reg2 <= 0;
				
				flashDataIn_reg <= 0;
				flashDataIn_reg1 <= 0;
			end
		else
			begin
				flashBusy_reg1 <= flashBusy;
				flashBusy_reg2 <= flashBusy_reg1;
				
				if (flashBusy_reg1 == flashBusy_reg2)
					flashBusy_reg <= flashBusy_reg2;
					
				flashDataIn_reg1 <= flashDataIn;
				flashDataIn_reg <= flashDataIn_reg1;
			end
	end


`define STATE_IDLE 0
`define STATE_ADDR0 1
`define STATE_ADDR1 2
`define STATE_ADDR2 3
`define STATE_READ0 4
`define STATE_READ1 5
`define STATE_READ2 6
`define STATE_WRITE0 7
`define STATE_WRITE1 8
`define STATE_WRITE2 9
`define STATE_WRITE3 10
`define STATE_WRITE4 11
`define STATE_CHECK_BUSY 12

`define CMD_NOP 0
`define CMD_ADDR 1
`define CMD_READ 2
`define CMD_WRITE 3
`define CMD_CHECK_BUSY 4
`define CMD_VERSION 5
`define CMD_PING 8'hCD

`define STATUS_NOP 0
`define STATUS_OK 1
`define STATUS_BUSY 2
`define STATUS_VERSION 1
`define STATUS_PONG 8'hAB
`define STATUS_ERROR 254

reg [3:0] state;
reg [3:0] next_state;
reg [7:0] next_txData;
reg next_txDataFull;
reg rxDataRdy;
reg next_rxDataRdy;
reg [21:0] next_flashAddr;
reg [15:0] flashAddrTmp;
reg [15:0] next_flashAddrTmp;
reg next_flashCS;
reg next_flashOE;
reg next_flashWE;
reg next_flashEnableOutput;
reg [7:0] flashDataTmp;
reg [7:0] next_flashDataTmp;
reg [15:0] next_flashDataOut;
reg [3:0] flashDelay;
reg [3:0] next_flashDelay;

always @(posedge clk)
	begin
		if (reset)
			begin
				state <= `STATE_IDLE;
				txData <= 0;
				txDataFull <= 0;
				rxDataRdy <= 0;
				flashAddr <= 0;
				flashAddrTmp <= 0;
				flashCS <= 0;
				flashOE <= 0;
				flashWE <= 0;
				flashEnableOutput <= 0;
				flashDataTmp <= 0;
				flashDataOut <= 0;
				flashDelay <= 0;
			end
		else
			begin
				state <= next_state;
				txData <= next_txData;
				txDataFull <= next_txDataFull;
				rxDataRdy <= next_rxDataRdy;
				flashAddr <= next_flashAddr;
				flashAddrTmp <= next_flashAddrTmp;
				flashCS <= next_flashCS;
				flashOE <= next_flashOE;
				flashWE <= next_flashWE;
				flashDataTmp <= next_flashDataTmp;
				flashDataOut <= next_flashDataOut;
				flashEnableOutput <= next_flashEnableOutput;
				flashDelay <= next_flashDelay;
			end
	end

always @(state or rxDataRdy or rxDataRdySet or rxPacketStart or txDataFull or txDataEmpty or rxData or txData or txDataFull or txDataFullClr
				or flashDataIn_reg or flashAddr or flashAddrTmp or flashBusy_reg or flashDataOut or flashDataTmp or flashDelay)
	begin
		next_txDataFull <= txDataFull;
		next_rxDataRdy <= rxDataRdy;
		next_txData <= txData;
		next_state <= state;
		next_flashAddr <= flashAddr;
		next_flashAddrTmp <= flashAddrTmp;
		next_flashCS <= 0;
		next_flashOE <= 0;
		next_flashWE <= 0;
		next_flashEnableOutput <= 0;
		next_flashDataOut <= flashDataOut;
		next_flashDataTmp <= flashDataTmp;
		next_flashDelay <= flashDelay;
		
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
								case (rxData)
									`CMD_NOP: begin
										next_txData <= `STATUS_NOP;
										next_txDataFull <= 1;
									end
									`CMD_PING: begin
										next_txData <= `STATUS_PONG;
										next_txDataFull <= 1;
									end
									`CMD_VERSION: begin
										next_txData <= `STATUS_VERSION;
										next_txDataFull <= 1;
									end
									`CMD_ADDR: begin
										next_flashAddrTmp <= 0;
										next_state <= `STATE_ADDR0;
									end
									`CMD_READ: begin
										next_rxDataRdy <= 1;
										next_state <= `STATE_READ2;
										next_txData <= `STATUS_OK;
										next_txDataFull <= 1;
									end
									`CMD_WRITE: begin
										next_state <= `STATE_WRITE0;
										next_txData <= `STATUS_OK;
										next_txDataFull <= 1;
									end
									`CMD_CHECK_BUSY: begin
										if (flashBusy_reg)
											next_txData <= `STATUS_BUSY;
										else
											next_txData <= `STATUS_OK;
										next_txDataFull <= 1;
										next_state <= `STATE_CHECK_BUSY;
									end
									default: begin
										next_txData <= `STATUS_ERROR;
										next_txDataFull <= 1;
									end
								endcase
							end
					end
			end
			`STATE_ADDR0: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						next_flashAddrTmp[7:0] <= rxData;
						next_state <= `STATE_ADDR1;
					end
			end
			`STATE_ADDR1: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						next_flashAddrTmp[15:8] <= rxData;
						next_state <= `STATE_ADDR2;
					end
			end
			`STATE_ADDR2: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						next_flashAddr[21:16] <= rxData[5:0];
						next_flashAddr[15:0] <= flashAddrTmp;
						next_state <= `STATE_IDLE;
						next_txData <= `STATUS_OK;
						next_txDataFull <= 1;
					end
			end
			`STATE_READ0: begin
					if (flashDelay == 0)
						begin
							next_txData <= flashDataIn_reg[7:0];
							next_txDataFull <= 1;
							next_flashDataTmp <= flashDataIn_reg[15:8];
							next_flashAddr <= flashAddr + 1;

							next_state <= `STATE_READ1;
						end
					else
						begin
							next_flashCS <= 1;
							next_flashOE <= 1;
							next_flashDelay <= flashDelay - 1;
						end
			end
			`STATE_READ1: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (!txDataFull)
					begin
						next_txData <= flashDataTmp;
						next_txDataFull <= 1;
						next_state <= `STATE_READ2;
					end
			end
			`STATE_READ2: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (!txDataFull && rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						next_flashCS <= 1;
						next_flashOE <= 1;
						next_flashDelay <= 5;
						next_state <= `STATE_READ0;
					end
			end
			`STATE_WRITE0: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_flashDataTmp <= rxData;
						next_rxDataRdy <= 0;
						next_state <= `STATE_WRITE1;
					end
			end
			`STATE_WRITE1: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						next_flashDataOut[15:8] <= rxData;
						next_flashDataOut[7:0] <= flashDataTmp;
						next_flashEnableOutput <= 1;
						next_state <= `STATE_WRITE2;
					end
			end
			`STATE_WRITE2: begin
				next_flashCS <= 1;
				next_flashWE <= 1;
				next_flashEnableOutput <= 1;
				next_flashDelay <= 5;
				next_state <= `STATE_WRITE3;
			end
			`STATE_WRITE3: begin
					if (flashDelay == 0)
						begin
							if (flashBusy_reg)
								next_txData <= `STATUS_BUSY;
							else
								next_txData <= `STATUS_OK;
							next_txDataFull <= 1;
							next_flashEnableOutput <= 1;
							next_state <= `STATE_WRITE4;
						end
					else
						begin
							next_flashCS <= 1;
							next_flashWE <= 1;
							next_flashEnableOutput <= 1;
							next_flashDelay <= flashDelay - 1;
						end
			end
			`STATE_WRITE4: begin
				next_state <= `STATE_WRITE0;
				next_flashAddr <= flashAddr + 1;
			end
			`STATE_CHECK_BUSY: begin
				if (rxDataRdy && rxPacketStart)
					next_state <= `STATE_IDLE;
				else if (rxDataRdy)
					begin
						next_rxDataRdy <= 0;
						if (flashBusy_reg)
							next_txData <= `STATUS_BUSY;
						else
							next_txData <= `STATUS_OK;
						next_txDataFull <= 1;
					end
			end
		endcase
	end
	
endmodule
