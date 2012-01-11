`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:40:57 03/15/2009
// Design Name:   readWriteSPIWireData
// Module Name:   C:/Xilinx/proj/vp2/test_spi_wire.v
// Project Name:  vp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: readWriteSPIWireData
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_spi_wire;

	// Inputs
	reg clk;
	reg [7:0] clkDelay;
	reg rst;
	wire spiDataIn;
	reg txDataFull;
	reg [7:0] txDataIn;

	// Outputs
	wire [7:0] rxDataOut;
	wire rxDataRdySet;
	wire spiClkOut;
	wire spiDataOut;
	wire txDataEmpty;
	wire txDataFullClr;

	// Inputs
	reg spiSelectIn2;
	wire txDataFull2;
	wire [7:0] txDataIn2;

	// Outputs
	wire [7:0] rxDataOut2;
	wire rxDataRdySet2;
	wire txDataEmpty2;
	wire txDataFullClr2;
	wire rxPacketStart2;

	// Flash Interface
	reg [15:0] flashDataIn;
	reg flashBusy; 
	reg flash_access_ack;
	wire [15:0] flashDataOut; 
	wire [21:0] flashAddr;
	wire flashCS;
	wire flashOE; 
	wire flashWE; 
	wire flashEnableOutput; 
	wire flash_access_req;

	// Instantiate the Unit Under Test (UUT)
	readWriteSPIWireData uut (
		.clk(clk), 
		.clkDelay(clkDelay), 
		.rst(rst), 
		.rxDataOut(rxDataOut), 
		.rxDataRdySet(rxDataRdySet), 
		.spiClkOut(spiClkOut), 
		.spiDataIn(spiDataIn), 
		.spiDataOut(spiDataOut), 
		.txDataEmpty(txDataEmpty), 
		.txDataFull(txDataFull), 
		.txDataFullClr(txDataFullClr), 
		.txDataIn(txDataIn)
	);

	spi_slave uut2 (
		.clk(clk), 
		.reset(rst), 
		.rxDataOut(rxDataOut2), 
		.rxDataRdySet(rxDataRdySet2), 
		.rxPacketStart(rxPacketStart2), 
		.spiClkIn(spiClkOut), 
		.spiDataOut(spiDataIn), 
		.spiDataIn(spiDataOut), 
		.spiSelectIn(spiSelectIn2), 
		.txDataEmpty(txDataEmpty2), 
		.txDataFull(txDataFull2), 
		.txDataFullClr(txDataFullClr2), 
		.txDataIn(txDataIn2)
	);

	spi_flash_ctrl instance_name (
		.clk(clk), 
		.reset(rst), 
		.rxPacketStart(rxPacketStart2), 
		.rxData(rxDataOut2), 
		.rxDataRdySet(rxDataRdySet2), 
		.txDataFull(txDataFull2), 
		.txData(txDataIn2), 
		.txDataEmpty(txDataEmpty2), 
		.txDataFullClr(txDataFullClr2), 
		.flashDataIn(flashDataIn), 
		.flashDataOut(flashDataOut), 
		.flashAddr(flashAddr), 
		.flashCS(flashCS), 
		.flashOE(flashOE), 
		.flashWE(flashWE), 
		.flashBusy(flashBusy), 
		.flashEnableOutput(flashEnableOutput), 
		.flash_access_req(flash_access_req), 
		.flash_access_ack(flash_access_ack)
	 );

	initial begin
		// Initialize Inputs
		clk = 0;
		clkDelay = 10;
		rst = 1;
		//spiDataIn = 0;
		txDataFull = 0;
		txDataIn = 0;
		spiSelectIn2 = 0;
		flashDataIn = 0;
		flashBusy = 0; 
		flash_access_ack = 1;

		// Wait 100 ns for global reset to finish
		#300;
		rst = 0;

		// PING
		#30;
		spiSelectIn2 = 1;
		#300;
		txDataIn = 8'hCD;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#4000;
		spiSelectIn2 = 0;
		#1000;
		
		// ADDR
		spiSelectIn2 = 1;
		#300;
		txDataIn = 8'h01;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h12;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h34;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h56;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#4000;
		spiSelectIn2 = 0;
		#1000;

		// READ
		flashDataIn = 16'h1234;
		spiSelectIn2 = 1;
		#300;
		txDataIn = 8'h02;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		flashDataIn = 16'h5678;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		flashDataIn = 16'h9ABC;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		flashDataIn = 16'hDEF0;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		#4000;
		spiSelectIn2 = 0;
		#1000;

		// WRITE
		spiSelectIn2 = 1;
		#300;
		txDataIn = 8'h03;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h01;
		txDataFull = 1;
		flashBusy = 1; 
		#2000;
		txDataIn = 8'h02;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h03;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h04;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h05;
		txDataFull = 1;
		#2000;
		flashBusy = 0; 
		txDataIn = 8'h06;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h07;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h08;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h09;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h0A;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h0B;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h0C;
		txDataFull = 1;
		#2000;
		flashBusy = 1; 
		txDataIn = 8'h0D;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h0E;
		txDataFull = 1;
		#2000;
		flashBusy = 0; 
		txDataIn = 8'h0F;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h10;
		txDataFull = 1;
		#4000;
		spiSelectIn2 = 0;
		#1000;

		// BUSY
		spiSelectIn2 = 1;
		#300;
		txDataIn = 8'h04;
		txDataFull = 1;
		#2000;
		txDataIn = 8'h00;
		txDataFull = 1;
		flashBusy = 1; 
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		flashBusy = 0; 
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		flashBusy = 1; 
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#2000;
		flashBusy = 0; 
		txDataFull = 1;
		#2000;
		txDataFull = 1;
		#4000;
		spiSelectIn2 = 0;
		#1000;

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
		
always @(posedge clk)
	begin
		if (txDataFullClr) 
			begin
				txDataFull <= 0;
			end;
	end
      
endmodule

