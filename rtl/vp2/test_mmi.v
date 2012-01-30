`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:39:42 01/28/2012
// Design Name:   memory_maped_if
// Module Name:   /home/seva/src/vp2/rtl/vp2/test_mmi.v
// Project Name:  vp2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memory_maped_if
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_mmi;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] cpu_data_in;
	reg [7:0] cpu_addr;
	reg rd;
	reg wr;
	reg [31:0] input0;
	reg [31:0] input1;
	reg [31:0] input2;
	reg [31:0] input3;
	reg [31:0] input4;
	reg [31:0] input5;
	reg [31:0] input6;
	reg [31:0] input7;
	reg [31:0] input8;
	reg [31:0] input9;
	reg [31:0] input10;
	reg [31:0] input11;
	reg [31:0] input12;
	reg [31:0] input13;
	reg [31:0] input14;
	reg [31:0] input15;
	reg [31:0] input16;
	reg [31:0] input17;
	reg [31:0] input18;
	reg [31:0] input19;
	reg [31:0] input20;
	reg [31:0] input21;
	reg [31:0] input22;
	reg [31:0] input23;
	reg [31:0] input24;
	reg [31:0] input25;
	reg [31:0] input26;
	reg [31:0] input27;
	reg [31:0] input28;
	reg [31:0] input29;
	reg [31:0] input30;
	reg [31:0] input31;
	reg [7:0] misc_in0;
	reg [7:0] misc_in1;
	reg [7:0] misc_in2;
	reg [7:0] misc_in3;

	// Outputs
	wire [7:0] cpu_data_out;
	wire [31:0] data_out1;
	wire [31:0] data_out2;
	wire set0;
	wire set1;
	wire set2;
	wire set3;
	wire set4;
	wire set5;
	wire set6;
	wire set7;
	wire set8;
	wire set9;
	wire set10;
	wire set11;
	wire set12;
	wire set13;
	wire set14;
	wire set15;
	wire set16;
	wire set17;
	wire set18;
	wire set19;
	wire set20;
	wire set21;
	wire set22;
	wire set23;
	wire set24;
	wire set25;
	wire set26;
	wire set27;
	wire set28;
	wire set29;
	wire set30;
	wire set31;
	wire [7:0] misc_out0;
	wire [7:0] misc_out1;
	wire [7:0] misc_out2;
	wire [7:0] misc_out3;

	// Instantiate the Unit Under Test (UUT)
	memory_maped_if uut (
		.clk(clk), 
		.reset(reset), 
		.cpu_data_in(cpu_data_in), 
		.cpu_data_out(cpu_data_out), 
		.cpu_addr(cpu_addr), 
		.rd(rd), 
		.wr(wr), 
		.data_out1(data_out1), 
		.data_out2(data_out2), 
		.set0(set0), 
		.set1(set1), 
		.set2(set2), 
		.set3(set3), 
		.set4(set4), 
		.set5(set5), 
		.set6(set6), 
		.set7(set7), 
		.set8(set8), 
		.set9(set9), 
		.set10(set10), 
		.set11(set11), 
		.set12(set12), 
		.set13(set13), 
		.set14(set14), 
		.set15(set15), 
		.set16(set16), 
		.set17(set17), 
		.set18(set18), 
		.set19(set19), 
		.set20(set20), 
		.set21(set21), 
		.set22(set22), 
		.set23(set23), 
		.set24(set24), 
		.set25(set25), 
		.set26(set26), 
		.set27(set27), 
		.set28(set28), 
		.set29(set29), 
		.set30(set30), 
		.set31(set31), 
		.input0(input0), 
		.input1(input1), 
		.input2(input2), 
		.input3(input3), 
		.input4(input4), 
		.input5(input5), 
		.input6(input6), 
		.input7(input7), 
		.input8(input8), 
		.input9(input9), 
		.input10(input10), 
		.input11(input11), 
		.input12(input12), 
		.input13(input13), 
		.input14(input14), 
		.input15(input15), 
		.input16(input16), 
		.input17(input17), 
		.input18(input18), 
		.input19(input19), 
		.input20(input20), 
		.input21(input21), 
		.input22(input22), 
		.input23(input23), 
		.input24(input24), 
		.input25(input25), 
		.input26(input26), 
		.input27(input27), 
		.input28(input28), 
		.input29(input29), 
		.input30(input30), 
		.input31(input31), 
		.misc_in0(misc_in0), 
		.misc_in1(misc_in1), 
		.misc_in2(misc_in2), 
		.misc_in3(misc_in3), 
		.misc_out0(misc_out0), 
		.misc_out1(misc_out1), 
		.misc_out2(misc_out2), 
		.misc_out3(misc_out3)
	);

	initial begin
		// Initialize Inputs
		reset = 1;
		cpu_data_in = 0;
		cpu_addr = 0;
		rd = 0;
		wr = 0;
		input0 = 100;
		input1 = 101;
		input2 = 102;
		input3 = 103;
		input4 = 104;
		input5 = 105;
		input6 = 106;
		input7 = 107;
		input8 = 108;
		input9 = 109;
		input10 = 110;
		input11 = 111;
		input12 = 112;
		input13 = 113;
		input14 = 114;
		input15 = 115;
		input16 = 116;
		input17 = 117;
		input18 = 118;
		input19 = 119;
		input20 = 120;
		input21 = 121;
		input22 = 122;
		input23 = 123;
		input24 = 124;
		input25 = 125;
		input26 = 126;
		input27 = 127;
		input28 = 128;
		input29 = 129;
		input30 = 130;
		input31 = 131;
		misc_in0 = 200;
		misc_in1 = 201;
		misc_in2 = 202;
		misc_in3 = 203;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0;
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
				if (wr == 1)
					begin
						wr = 0;
					end
				if (rd == 1)
					begin
						rd = 0;
					end
				case (cycle)
					20: begin
						wr = 1;
						cpu_addr = 8'h82;
						cpu_data_in = 8'h34;
					end
					22: begin
						wr = 1;
						cpu_addr = 8'h83;
						cpu_data_in = 8'h12;
					end
					24: begin
						wr = 1;
						cpu_addr = 8'h80;
						cpu_data_in = 8'h78;
					end
					26: begin
						wr = 1;
						cpu_addr = 8'h81;
						cpu_data_in = 8'h56;
					end
					28: begin
						wr = 1;
						cpu_addr = 8'h00;
						cpu_data_in = 8'h00;
					end
					30: begin
						wr = 1;
						cpu_addr = 8'h01;
						cpu_data_in = 8'h01;
					end
					32: begin
						cpu_addr = 8'h82;
						rd = 1;
					end
					34: begin
						wr = 1;
						cpu_addr = 8'h86;
						cpu_data_in = 8'hab;
					end
					36: begin
						wr = 1;
						cpu_addr = 8'h87;
						cpu_data_in = 8'h89;
					end
					38: begin
						wr = 1;
						cpu_addr = 8'h84;
						cpu_data_in = 8'hef;
					end
					40: begin
						wr = 1;
						cpu_addr = 8'h85;
						cpu_data_in = 8'hcd;
					end
					42: begin
						wr = 1;
						cpu_addr = 8'h8;
						cpu_data_in = 8'h12;
					end
					44: begin
						wr = 1;
						cpu_addr = 8'h9;
						cpu_data_in = 8'h34;
					end
					46: begin
						wr = 1;
						cpu_addr = 8'ha;
						cpu_data_in = 8'h56;
					end
					48: begin
						wr = 1;
						cpu_addr = 8'hb;
						cpu_data_in = 8'h78;
					end
					50: begin
						rd = 1;
						cpu_addr = 8'h0d;
					end
					52: begin
						wr = 1;
						cpu_addr = 8'h2;
						cpu_data_in = 8'h8;
					end
					54: begin
						rd = 1;
						cpu_addr = 8'h03;
					end
					56: begin
						wr = 1;
						cpu_addr = 8'h3;
						cpu_data_in = 8'ha;
					end
				endcase
				#2;
				clk = 0;
				#5;
				cycle = cycle + 1;
			end;
end
      
endmodule

