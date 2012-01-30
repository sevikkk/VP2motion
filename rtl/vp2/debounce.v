`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:49:42 01/28/2012 
// Design Name: 
// Module Name:    debounce 
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
module debounce(
    input clk,
    input reset,
    input sig_in,
    input unlock,
    input [31:0] pos_in,
    input [31:0] data_in,
    input set_timeout,
    output reg sig_out,
    output reg sig_changed,
    output reg [31:0] pos_out,
    output reg [31:0] max_bounce,
    output reg [7:0] cycles
);

reg sig_reg1;
reg sig;

// sync to clock
always @(posedge clk)
	begin
		sig_reg1 <= sig_in;
		sig <= sig_reg1;
	end

reg [31:0] timeout;

// sync to clock
always @(posedge clk)
	begin
		if (reset)
			begin
				timeout <= 50000;
			end
		else if (set_timeout)
			begin
				timeout <= data_in;
			end
	end
	
`define DSTATE_STABLE 0
`define DSTATE_BOUNCE1 1
`define DSTATE_BOUNCE2 2

reg [31:0] timer;
reg [2:0] dstate;
reg value;
reg value_changed;
reg [31:0] start_pos;

reg [31:0] next_timer;
reg [31:0] next_max_bounce;
reg [2:0] next_dstate;
reg next_value;
reg next_value_changed;
reg [31:0] next_start_pos;

always @(reset or timeout or sig or timer or dstate or value or max_bounce or unlock or start_pos or pos_in)
	begin
		next_timer <= timer;
		next_dstate <= dstate;
		next_value <= value;
		next_max_bounce <= max_bounce;
		next_start_pos <= start_pos;
		next_value_changed <= 0;
		
		if (reset)
			begin
				next_timer <= 0;
				next_dstate <= `DSTATE_STABLE;
				next_value <= 0;
				next_max_bounce <= 0;
				next_start_pos <= 0;
			end
		else
			begin
				if (unlock)
					begin
						next_max_bounce <= 0;
					end
					
				case (dstate)
				`DSTATE_STABLE:
					begin
						if (sig != value)
							begin
								next_timer <= 0;
								next_start_pos <= pos_in;
								next_dstate <= `DSTATE_BOUNCE1;
							end
					end
				`DSTATE_BOUNCE1:
					begin
						if (sig != value)
							begin
								next_timer <= timer + 1;
								if (timer > timeout)
									begin
										next_value <= sig;
										next_dstate <= `DSTATE_STABLE;
										next_value_changed <= 1;
									end
							end
						else
							begin
								next_dstate <= `DSTATE_BOUNCE2;
								next_timer <= 0;
								if (timer > max_bounce)
									begin
										next_max_bounce <= timer;
									end
							end
					end
				`DSTATE_BOUNCE2:
					begin
						if (sig == value)
							begin
								next_timer <= timer + 1;
								if (timer > timeout)
									begin
										next_dstate <= `DSTATE_STABLE;
									end
							end
						else
							begin
								next_dstate <= `DSTATE_BOUNCE1;
								next_timer <= 0;
								if (timer > max_bounce)
									begin
										next_max_bounce <= timer;
									end
							end
					end
				endcase
			end
	end
	
always @(posedge clk)
	begin
		timer <= next_timer;
		max_bounce <= next_max_bounce;
		dstate <= next_dstate;
		value <= next_value;
		value_changed <= next_value_changed;
		start_pos <= next_start_pos;
	end
	
`define STATE_UNLOCKED 0
`define STATE_LOCKED 1

reg [1:0] state;

reg [1:0] next_state;
reg [31:0] next_pos_out;	
reg [7:0] next_cycles;
reg next_sig_out;
reg next_sig_changed;

always @(reset or unlock or value or value_changed or state or start_pos or pos_out or cycles or sig_out or sig_changed)
	begin
		next_state <= state;
		next_pos_out <= pos_out;	
		next_cycles <= cycles;
		next_sig_out <= sig_out;
		next_sig_changed <= sig_changed;
		
		if (reset)
			begin
				next_state <= `STATE_UNLOCKED;
				next_pos_out <= 0;	
				next_cycles <= 0;
				next_sig_out <= 0;
				next_sig_changed <= 0;
			end
		else
			begin
				case (state)
					`STATE_UNLOCKED:
						begin
							if (value_changed)
								begin
									next_state <= `STATE_LOCKED;
									next_pos_out <= start_pos;	
									next_cycles <= cycles + 1;
									next_sig_out <= value;
									next_sig_changed <= 1;
								end
						end
					`STATE_LOCKED:
						begin
							if (unlock)
								begin
									next_state <= `STATE_UNLOCKED;
									next_sig_changed <= 0;
									next_sig_out <= value;
								end
							else if (value_changed)
								begin
									next_cycles <= cycles + 1;
								end
						end
				endcase
			end
	end

always @(posedge clk)
	begin
		state <= next_state;
		pos_out <= next_pos_out;	
		cycles <= next_cycles;
		sig_out <= next_sig_out;
		sig_changed <= next_sig_changed;
	end

endmodule
