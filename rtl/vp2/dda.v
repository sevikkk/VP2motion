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
module dda(
    input clk,
    input reset,
    input [31:0] target_time,
    input signed [31:0] target_position,
    input signed [31:0] target_velocity,
    input relative,
    input start,

    input signed [31:0] position,

    output reg signed [31:0] velocity,

    output reg done,
    output reg signed [31:0] end_position,
    output reg signed [31:0] end_velocity,

    // divider interface
    output reg [31:0] divident,
    output reg [31:0] divisor,
    output reg start_divide,
    input [63:0] quotinent,
    input divide_done

);

reg [5:0] state;
`define STATE_IDLE 0
`define STATE_CALC1 1
`define STATE_CALC2 2
`define STATE_MOVING 3


reg direction;
reg signed [32:0] remaining_time;
reg [16:0] timer;
reg signed [31:0] orig_target;
reg restart;

reg [5:0] next_state;
reg next_direction;
reg signed [32:0] next_remaining_time;
reg [16:0] next_timer;
reg signed [31:0] next_orig_target;
reg next_restart;

reg next_done;
reg [31:0] next_divisor;
reg [31:0] next_divident;
reg [31:0] next_start_divide;

reg recalc;
reg next_recalc;

reg signed [31:0] next_velocity;

always @(reset or target_position or target_time or start or position or quotinent or divide_done or state or remaining_time or direction or velocity or timer or relative or restart or recalc)
	begin
            next_state <= state;
            next_direction <= 0;
            next_divisor <= 0;
            next_divident <= 0;
            next_start_divide <= 0;
            next_velocity <= velocity;
            next_remaining_time <= remaining_time - 1;
            next_timer <= timer;
            next_direction <= direction;
            next_done <= done;
				next_restart <= restart;
				next_recalc <= 0;

            if (reset)
                begin
                    next_state <= `STATE_IDLE;
                    next_remaining_time <= 0;
                    next_velocity <= 0;
                    next_direction <= 0;
						  next_timer <= 0;
						  next_orig_target <= 0;
						  next_restart <= 0;
						  next_done <= 0;
                end
            else
						case (state)
							`STATE_IDLE: 
								begin
									if (start || restart || recalc) 
										begin
											if (relative && (start || restart))
												begin
													next_orig_target <= position + target_position;
													next_divisor <= target_time;
													next_remaining_time <= {1'b0, target_time};

													if (target_position > 0) 
														begin
															next_direction <= 0;
															next_divident <= target_position;
														end
													else
														begin
															next_direction <= 1;
															next_divident <= -target_position;
														end
												end
											else if (start || restart)
												begin
													next_orig_target <= target_position;
													next_divisor <= target_time;
													next_remaining_time <= {1'b0, target_time};

													if (target_position > position) 
														begin
															next_direction <= 0;
															next_divident <= target_position - position;
														end
													else
														begin
															next_direction <= 1;
															next_divident <= position - target_position;
														end
												end
											else
												begin
													next_divisor <= remaining_time[31:0];

													if (orig_target > position) 
														begin
															next_direction <= 0;
															next_divident <= orig_target - position;
														end
													else
														begin
															next_direction <= 1;
															next_divident <= position - orig_target;
														end
												end
											next_start_divide <= 1;
											next_state <= `STATE_CALC1;
											next_restart <= 0;
											next_done <= 0;
										end
									else
										begin
											next_remaining_time <= 0;
											if (timer == 1)
												begin
													next_velocity <= 0;
												end
											if (timer != 0)
												begin
													next_timer <= timer - 1;
												end
										end
								end
                    `STATE_CALC1:
								begin
									if (start)
										begin
											next_restart <= 1;
											next_state <= `STATE_IDLE;
											next_done <= 1;
										end
									else
										next_state <= `STATE_CALC2;
								end
                    `STATE_CALC2:
								begin
									if (start)
										begin
											next_restart <= 1;
											next_state <= `STATE_IDLE;
											next_done <= 1;
										end
									else
										if (divide_done)
											begin
												if (~direction)
													begin
														next_velocity <= {1'b0 , quotinent[31:1]};
													end
												else
													begin
														next_velocity <= -{1'b0 , quotinent[31:1]};
													end
												next_state <= `STATE_MOVING;
												next_timer <= 5000;
											end
								end
                    `STATE_MOVING:
								begin
									if (start)
										begin
											next_restart <= 1;
											next_state <= `STATE_IDLE;
											next_done <= 1;
										end
									else
										if (remaining_time[32] == 1)
											begin
												next_state <= `STATE_IDLE;
												next_done <= 1;
												next_timer <= 1000; // 100000; // 1ms
											end
										else
											begin
												next_timer <= timer - 1;
												if (timer == 0)
													begin
														next_recalc <= 1;
														next_state <= `STATE_IDLE;
													end
											end
								end
						endcase
	end
				
always @(posedge clk)
	begin
            state <= next_state;
            done <= next_done;
            velocity <= next_velocity;
            direction <= next_direction;
            remaining_time <= next_remaining_time;
            divisor <= next_divisor;
            divident <= next_divident;
            start_divide <= next_start_divide;
            timer <= next_timer;
            orig_target <= next_orig_target;
				restart <= next_restart;
				recalc <= next_recalc;
				
            end_position <= next_orig_target;
            end_velocity <= next_velocity;
	end

endmodule
