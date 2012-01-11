`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:26:00 04/26/2009 
// Design Name: 
// Module Name:    gpio_buf 
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
module gpio_buf(
    input [31:0] gpio_in,
    output [31:0] gpio_out,
    input gpio_oe,
    input clk,
    input reset,
	 output reg gpio_ext_oe,
    output reg gpio_ext_dir,
    inout gpio0,
    inout gpio1,
    inout gpio2,
    inout gpio3,
    inout gpio4,
    inout gpio5,
    inout gpio6,
    inout gpio7,
    inout gpio8,
    inout gpio9,
    inout gpio10,
    inout gpio11,
    inout gpio12,
    inout gpio13,
    inout gpio14,
    inout gpio15,
    inout gpio16,
    inout gpio17,
    inout gpio18,
    inout gpio19,
    inout gpio20,
    inout gpio21,
    inout gpio22,
    inout gpio23,
    inout gpio24,
    inout gpio25,
    inout gpio26,
    inout gpio27,
    inout gpio28,
    inout gpio29,
    inout gpio30,
    inout gpio31
    );
	 
reg gpio_oe1;
reg int_oe;

always @(posedge clk)
	begin
		gpio_oe1 <= gpio_oe;
		case ({gpio_oe1, gpio_oe})
			2'b00: begin
				gpio_ext_oe <= 0;
				gpio_ext_dir <= 0;
				int_oe <= 0;
			end
			2'b01: begin
				gpio_ext_oe <= 1;
				gpio_ext_dir <= 1;
				int_oe <= 0;
			end
			2'b11: begin
				gpio_ext_oe <= 0;
				gpio_ext_dir <= 1;
				int_oe <= 1;
			end
			2'b10: begin
				gpio_ext_oe <= 1;
				gpio_ext_dir <= 0;
				int_oe <= 0;
			end
		endcase
	end

assign gpio0 = int_oe ? gpio_in[0] : 1'bZ;
assign gpio1 = int_oe ? gpio_in[1] : 1'bZ;
assign gpio2 = int_oe ? gpio_in[2] : 1'bZ;
assign gpio3 = int_oe ? gpio_in[3] : 1'bZ;
assign gpio4 = int_oe ? gpio_in[4] : 1'bZ;
assign gpio5 = int_oe ? gpio_in[5] : 1'bZ;
assign gpio6 = int_oe ? gpio_in[6] : 1'bZ;
assign gpio7 = int_oe ? gpio_in[7] : 1'bZ;
assign gpio8 = int_oe ? gpio_in[8] : 1'bZ;
assign gpio9 = int_oe ? gpio_in[9] : 1'bZ;
assign gpio10 = int_oe ? gpio_in[10] : 1'bZ;
assign gpio11 = int_oe ? gpio_in[11] : 1'bZ;
assign gpio12 = int_oe ? gpio_in[12] : 1'bZ;
assign gpio13 = int_oe ? gpio_in[13] : 1'bZ;
assign gpio14 = int_oe ? gpio_in[14] : 1'bZ;
assign gpio15 = int_oe ? gpio_in[15] : 1'bZ;
assign gpio16 = int_oe ? gpio_in[16] : 1'bZ;
assign gpio17 = int_oe ? gpio_in[17] : 1'bZ;
assign gpio18 = int_oe ? gpio_in[18] : 1'bZ;
assign gpio19 = int_oe ? gpio_in[19] : 1'bZ;
assign gpio20 = int_oe ? gpio_in[20] : 1'bZ;
assign gpio21 = int_oe ? gpio_in[21] : 1'bZ;
assign gpio22 = int_oe ? gpio_in[22] : 1'bZ;
assign gpio23 = int_oe ? gpio_in[23] : 1'bZ;
assign gpio24 = int_oe ? gpio_in[24] : 1'bZ;
assign gpio25 = int_oe ? gpio_in[25] : 1'bZ;
assign gpio26 = int_oe ? gpio_in[26] : 1'bZ;
assign gpio27 = int_oe ? gpio_in[27] : 1'bZ;
assign gpio28 = int_oe ? gpio_in[28] : 1'bZ;
assign gpio29 = int_oe ? gpio_in[29] : 1'bZ;
assign gpio30 = int_oe ? gpio_in[30] : 1'bZ;
assign gpio31 = int_oe ? gpio_in[31] : 1'bZ;

assign gpio_out[0] = gpio0;
assign gpio_out[1] = gpio1;
assign gpio_out[2] = gpio2;
assign gpio_out[3] = gpio3;
assign gpio_out[4] = gpio4;
assign gpio_out[5] = gpio5;
assign gpio_out[6] = gpio6;
assign gpio_out[7] = gpio7;
assign gpio_out[8] = gpio8;
assign gpio_out[9] = gpio9;
assign gpio_out[10] = gpio10;
assign gpio_out[11] = gpio11;
assign gpio_out[12] = gpio12;
assign gpio_out[13] = gpio13;
assign gpio_out[14] = gpio14;
assign gpio_out[15] = gpio15;
assign gpio_out[16] = gpio16;
assign gpio_out[17] = gpio17;
assign gpio_out[18] = gpio18;
assign gpio_out[19] = gpio19;
assign gpio_out[20] = gpio20;
assign gpio_out[21] = gpio21;
assign gpio_out[22] = gpio22;
assign gpio_out[23] = gpio23;
assign gpio_out[24] = gpio24;
assign gpio_out[25] = gpio25;
assign gpio_out[26] = gpio26;
assign gpio_out[27] = gpio27;
assign gpio_out[28] = gpio28;
assign gpio_out[29] = gpio29;
assign gpio_out[30] = gpio30;
assign gpio_out[31] = gpio31;


endmodule
