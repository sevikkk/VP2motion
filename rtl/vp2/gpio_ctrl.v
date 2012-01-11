`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:55:49 04/27/2009 
// Design Name: 
// Module Name:    gpio_ctrl 
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
module gpio_ctrl(
    input clk,
    input reset,
    input [7:0] cpu_do,
    input [7:0] cpu_addr,
    output reg [7:0] cpu_di,
    input rd,
    input wr,
    input [31:0] gpin,
    output reg [31:0] gpout,
    output reg [31:0] gpio_in,
    input [31:0] gpio_out,
    output reg gpio_oe
    );

always @(posedge clk)
	begin
		if (reset)
			begin
				gpio_oe <= 0;
				gpout <= 0;
				gpio_in <= 0;
			end
		else
			begin
				if (wr) begin
					case (cpu_addr[7:6])
						0:	case (cpu_addr[1:0])
								0: gpout[7:0] <= cpu_do;
								1: gpout[15:8] <= cpu_do;
								2: gpout[23:16] <= cpu_do;
								3: gpout[31:24] <= cpu_do;
							endcase
						1:	case (cpu_addr[1:0])
								0: gpio_in[7:0] <= cpu_do;
								1: gpio_in[15:8] <= cpu_do;
								2: gpio_in[23:16] <= cpu_do;
								3: gpio_in[31:24] <= cpu_do;
							endcase
						3: begin
							gpio_oe <= cpu_do[0];
						end
					endcase
				end
				case (cpu_addr[7:6])
					0:	case (cpu_addr[1:0])
							0: cpu_di <= gpin[7:0];
							1: cpu_di <= gpin[15:8];
							2: cpu_di <= gpin[23:16];
							3: cpu_di <= gpin[31:24];
						endcase
					1:	case (cpu_addr[1:0])
							0: cpu_di <= gpio_out[7:0];
							1: cpu_di <= gpio_out[15:8];
							2: cpu_di <= gpio_out[23:16];
							3: cpu_di <= gpio_out[31:24];
						endcase
					default:	cpu_di <= 0;
				endcase
			end
	end

endmodule
