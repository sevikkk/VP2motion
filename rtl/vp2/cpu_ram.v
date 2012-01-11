//////////////////////////////////////////////////////////////////////
////                                                              ////
//// dpMem_dc.v                                                 ////
////                                                              ////
//// This file is part of the usbhostslave opencores effort.
//// <http://www.opencores.org/cores//>                           ////
////                                                              ////
//// Module Description:                                          ////
//// Synchronous dual port memory with dual clocks
////                                                              ////
//// To Do:                                                       ////
//// 
////                                                              ////
//// Author(s):                                                   ////
//// - Steve Fielding, sfielding@base2designs.com                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2004 Steve Fielding and OPENCORES.ORG          ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE. See the GNU Lesser General Public License for more  ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from <http://www.opencores.org/lgpl.shtml>                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//

module cpu_ram(  addr, Clk, dataIn, writeEn, dataOut);
  //FIFO_DEPTH = ADDR_WIDTH^2
  parameter FIFO_WIDTH = 8;
  parameter FIFO_DEPTH = 32768; 
  parameter ADDR_WIDTH = 15;   
  
input Clk;
input [FIFO_WIDTH-1:0] dataIn;
output [FIFO_WIDTH-1:0] dataOut;
input writeEn;
input [ADDR_WIDTH-1:0] addr;

wire Clk;
wire [FIFO_WIDTH-1:0] dataIn;
wire [FIFO_WIDTH-1:0] dataOut;
wire writeEn;
wire [ADDR_WIDTH-1:0] addr;

reg [FIFO_WIDTH-1:0] buffer [0:FIFO_DEPTH-1];
reg [ADDR_WIDTH-1:0] addrout;

// synchronous read. Introduces one clock cycle delay
always @(posedge Clk) begin
	addrout <= addr;
end                  
assign dataOut = buffer[addrout];

// synchronous write
always @(posedge Clk) begin
  if (writeEn == 1'b1)
    buffer[addr] <= dataIn;
end                  

endmodule
