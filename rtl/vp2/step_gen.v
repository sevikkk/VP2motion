`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:35:55 01/16/2012 
// Design Name: 
// Module Name:    step_gen 
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
module step_gen(
    input clk,
    input reset,
    input [31:0] velocity,
    input [31:0] data_in,
    input set_position,
    output reg [31:0] position,
    output reg [31:0] acc,
    output reg step,
    output reg dir
);

wire do_step;
wire next_dir;
reg [9:0] step_cnt;
reg [31:0] next_acc;
reg [31:0] next_position;

assign do_step = next_acc[31];
assign next_dir = velocity[31];

always @(reset or velocity or set_position or acc)
	begin
		if (reset)
			begin
				next_acc <= 32'b0;
			end
		else if (set_position)
			begin
				next_acc <= 0;
			end
		else
			begin
				next_acc <= acc + velocity;
			end
	end
				
always @(reset or data_in or set_position or position or do_step or next_dir)
	begin
		if (reset)
			begin
				next_position <= 0;
			end
		else if (set_position)
			begin
				next_position <= data_in;
			end
		else	if (do_step)
			begin
			   if (!next_dir)
					next_position <= position + 1;
				else
					next_position <= position - 1;
			end
		else
			next_position <= position;
	end
	
always @(posedge clk)
	begin
		position <= next_position;
		acc <= next_acc & 32'h7fffffff;
	end
	
always @(posedge clk)
	begin
		if (reset)
			begin
				step <= 0;
				dir <= 0;
				step_cnt <= 0;
			end
		else if (do_step)
			begin
				dir <= next_dir;
				step_cnt <= 600;
			end
		else if (step_cnt == 500)
			begin
				step <= 1;
				step_cnt <= step_cnt -1;
			end
		else if (step_cnt != 0)
			begin
				step_cnt <= step_cnt -1;
			end
		else
			step <= 0;
	end
	

					
			
				
			
				


endmodule
