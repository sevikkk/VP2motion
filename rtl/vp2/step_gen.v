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
    input signed [31:0] velocity,
    input signed [31:0] data_in,
    input set_position,
    output reg signed [31:0] position,
    output reg signed [31:0] acc,
    output reg step,
    output reg dir
);

reg do_step;
reg next_dir;
reg step_done;
reg [9:0] step_cnt;
reg signed [31:0] next_acc;
reg signed [31:0] next_position;

reg signed [31:0] cur_velocity;
reg signed [31:0] next_cur_velocity;

always @(reset or velocity or set_position or acc)
	begin
		if (reset)
			begin
				next_acc <= 0;
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

always @(acc or next_acc or velocity)
	begin
		next_dir <= velocity[31];
		do_step <= next_acc[31] ^ acc[31];
	end
				
always @(reset or data_in or set_position or position or step_done or next_dir)
	begin
		if (reset)
			begin
				next_position <= 0;
			end
		else if (set_position)
			begin
				next_position <= data_in;
			end
		else	if (step_done)
			begin
			   if (!dir)
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
		acc <= next_acc;
	end
	
always @(posedge clk)
	begin
		step_done <= 0;
		if (reset)
			begin
				step <= 0;
				dir <= 0;
				step_cnt <= 0;
			end
		else if (step_cnt == 0)
			begin
			 if (do_step)
				begin
					dir <= next_dir;
					step_cnt <= 500;
				end
			end
		else
			begin
				if (step_cnt == 400)
					begin
						step <= 1;
					end
				else if (step_cnt == 100)
					begin
						step <= 0;
					end
				else if (step_cnt == 1)
					begin
						step_done <= 1;
					end
				step_cnt <= step_cnt -1;
			end
	end

endmodule
