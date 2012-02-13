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

reg signed [31:0] target_velocity;
reg signed [31:0] next_target_velocity;

reg [9:0] cycle;
reg [9:0] next_cycle;

wire [31:0] max_accel;
wire [31:0] max_velocity;

assign max_accel = 200;
assign max_velocity = 2100000;

always @(reset or cur_velocity or cycle or set_position or target_velocity)
	begin
		if (reset)
			begin
				next_cur_velocity <= 0;
				next_cycle <= 0;
			end
		else if (set_position)
			begin
				next_cur_velocity <= 0;
				next_cycle <= 0;
			end
		else
			begin
				next_cycle <= cycle + 1;
				next_cur_velocity <= cur_velocity;
				if (cycle == 999)
					begin
						next_cycle <= 0;
						if (cur_velocity > target_velocity)
							begin
								if (cur_velocity - target_velocity < max_accel)
									begin
										next_cur_velocity <= target_velocity;
									end
								else
									begin
										next_cur_velocity <= cur_velocity - max_accel;
									end
							end
						else if (cur_velocity < target_velocity)
							begin
								if (target_velocity - cur_velocity < max_accel)
									begin
										next_cur_velocity <= target_velocity;
									end
								else
									begin
										next_cur_velocity <= cur_velocity + max_accel;
									end
							end
							
					end
			end
	end
	
always @(velocity or max_velocity)
	begin
		if (velocity > 0)
			begin
				if (velocity > max_velocity)
					next_target_velocity <= max_velocity;
				else
					next_target_velocity <= velocity;
			end
		else
			begin
				if (-velocity > max_velocity)
					next_target_velocity <= -max_velocity;
				else
					next_target_velocity <= velocity;
			end
	end

always @(posedge clk)
	begin
		cycle <= next_cycle;
		cur_velocity <= next_cur_velocity;
		target_velocity <= next_target_velocity;
	end


always @(reset or cur_velocity or set_position or acc)
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
				next_acc <= acc + cur_velocity;
			end
	end

always @(acc or next_acc or cur_velocity)
	begin
		next_dir <= cur_velocity[31];
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
