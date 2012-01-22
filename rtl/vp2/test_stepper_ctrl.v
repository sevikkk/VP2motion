// Verilog test fixture created from schematic /home/seva/src/vp2/rtl/vp2/stepper_ctrl.sch - Sat Jan 21 21:07:42 2012

`timescale 1ns / 1ps

module stepper_ctrl_stepper_ctrl_sch_tb();

// Inputs
   reg clk;
   reg reset;
   reg relative;
   reg start;
   reg [31:0] target_time;
   reg [31:0] target_position;
   reg [31:0] target_velocity;
   reg set_position;
   reg [31:0] data_in;

// Output
   wire [31:0] end_position;
   wire [31:0] end_velocity;
   wire done;
   wire [31:0] acc;
   wire dir;
   wire step;
   wire [31:0] velocity;
   wire [31:0] position;

// Bidirs

// Instantiate the UUT
   stepper_ctrl UUT (
		.clk(clk), 
		.reset(reset), 
		.relative(relative), 
		.start(start), 
		.target_time(target_time), 
		.target_position(target_position), 
		.target_velocity(target_velocity), 
		.end_position(end_position), 
		.end_velocity(end_velocity), 
		.done(done), 
		.acc(acc), 
		.dir(dir), 
		.step(step), 
		.set_position(set_position), 
		.data_in(data_in), 
		.velocity(velocity), 
		.position(position)
   );
// Initialize Inputs
initial begin
		reset = 1;
		relative = 0;
		start = 0;
		target_time = 0;
		target_position = 0;
		target_velocity = 0;
		set_position = 0;
		data_in = 0;
		
		#105;
		reset = 0;
		#100;
		
end

reg [31:0] cycle;
reg [31:0] cycle2;

initial begin
		cycle = 0;
		cycle2 = 0;
		forever
			begin
				clk = 1;
				#3
				if (start == 1)
					begin
						start = 0;
					end
				case (cycle)
					20: begin
						target_time = 20000;
						target_position = 5;
						start = 1;
					end
				endcase
				if (done)
					begin
						cycle2 = cycle2 + 1;
						case (cycle2)
							1: begin
								target_time = 50000;
								target_position = -15;
								start = 1;
							end
							2: begin
								target_time = 17000;
								target_position = -10;
								start = 1;
							end
							3: begin
								target_time = 50000;
								target_position = 10;
								start = 1;
							end
							4: begin
								target_time = 10000;
								target_position = 10;
								relative = 1;
								start = 1;
							end
							5: begin
								target_time = 15000;
								target_position = -20;
								relative = 1;
								start = 1;
							end
						endcase
					end
				#2;
				clk = 0;
				#5;
				cycle = cycle + 1;
			end;
end
endmodule
