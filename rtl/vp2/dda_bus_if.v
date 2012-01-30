`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:25 01/22/2012 
// Design Name: 
// Module Name:    dda_bus_if 
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
module dda_bus_if(
	    input clk,
	    input reset,
       input [31:0] data_in,
		 input set_target_time,
		 input set_target_position,
		 input set_target_velocity,
		 
		 output reg [31:0] target_time,
		 output reg [31:0] target_position,
		 output reg [31:0] target_velocity
    );

always @(posedge clk)
	begin
		if (reset)
			begin
				target_time <= 0;
				target_position <= 0;
				target_velocity <= 0;
			end
		else
			begin
				if (set_target_time)
					target_time <= data_in;
				if (set_target_position)
					target_position <= data_in;
				if (set_target_velocity)
					target_velocity <= data_in;
			end
	end

endmodule
