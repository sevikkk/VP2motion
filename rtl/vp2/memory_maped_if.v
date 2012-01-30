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
module memory_maped_if(
	    input clk,
	    input reset,

            input [7:0] cpu_data_in,
            output reg [7:0] cpu_data_out,
            input [7:0] cpu_addr,
            input rd,
            input wr,

            output [31:0] data_out1,
            output [31:0] data_out2,

            output reg set0,
            output reg set1,
            output reg set2,
            output reg set3,
            output reg set4,
            output reg set5,
            output reg set6,
            output reg set7,
            output reg set8,
            output reg set9,
            output reg set10,
            output reg set11,
            output reg set12,
            output reg set13,
            output reg set14,
            output reg set15,
            output reg set16,
            output reg set17,
            output reg set18,
            output reg set19,
            output reg set20,
            output reg set21,
            output reg set22,
            output reg set23,
            output reg set24,
            output reg set25,
            output reg set26,
            output reg set27,
            output reg set28,
            output reg set29,
            output reg set30,
            output reg set31,

            input [31:0] input0,
            input [31:0] input1,
            input [31:0] input2,
            input [31:0] input3,
            input [31:0] input4,
            input [31:0] input5,
            input [31:0] input6,
            input [31:0] input7,
            input [31:0] input8,
            input [31:0] input9,
            input [31:0] input10,
            input [31:0] input11,
            input [31:0] input12,
            input [31:0] input13,
            input [31:0] input14,
            input [31:0] input15,
            input [31:0] input16,
            input [31:0] input17,
            input [31:0] input18,
            input [31:0] input19,
            input [31:0] input20,
            input [31:0] input21,
            input [31:0] input22,
            input [31:0] input23,
            input [31:0] input24,
            input [31:0] input25,
            input [31:0] input26,
            input [31:0] input27,
            input [31:0] input28,
            input [31:0] input29,
            input [31:0] input30,
            input [31:0] input31,

            input [7:0] misc_in0,
            input [7:0] misc_in1,
            input [7:0] misc_in2,
            input [7:0] misc_in3,

            output reg [7:0] misc_out0,
            output reg [7:0] misc_out1,
            output reg [7:0] misc_out2,
            output reg [7:0] misc_out3
    );

reg [31:0] regfile[0:31];
reg [4:0] out1_select;
reg [4:0] out2_select;
reg [4:0] in_select;
reg [31:0] in_reg;

assign data_out1 = regfile[out1_select];
assign data_out2 = regfile[out2_select];

always @(in_select 
    or input0 or input1 or input2 or input3 or input4 or input5 or input6 or input7 or input8 or input9
    or input10 or input11 or input12 or input13 or input14 or input15 or input16 or input17 or input18 or input19
    or input20 or input21 or input22 or input23 or input24 or input25 or input26 or input27 or input28 or input29
    or input30 or input31)
    begin
        case (in_select)
            0: in_reg <= input0;
            1: in_reg <= input1;
            2: in_reg <= input2;
            3: in_reg <= input3;
            4: in_reg <= input4;
            5: in_reg <= input5;
            6: in_reg <= input6;
            7: in_reg <= input7;
            8: in_reg <= input8;
            9: in_reg <= input9;
            10: in_reg <= input10;
            11: in_reg <= input11;
            12: in_reg <= input12;
            13: in_reg <= input13;
            14: in_reg <= input14;
            15: in_reg <= input15;
            16: in_reg <= input16;
            17: in_reg <= input17;
            18: in_reg <= input18;
            19: in_reg <= input19;
            20: in_reg <= input20;
            21: in_reg <= input21;
            22: in_reg <= input22;
            23: in_reg <= input23;
            24: in_reg <= input24;
            25: in_reg <= input25;
            26: in_reg <= input26;
            27: in_reg <= input27;
            28: in_reg <= input28;
            29: in_reg <= input29;
            30: in_reg <= input30;
            31: in_reg <= input31;
        endcase
    end

always @(posedge clk)
	begin
            set0 <= 0;
            set1 <= 0;
            set2 <= 0;
            set3 <= 0;
            set4 <= 0;
            set5 <= 0;
            set6 <= 0;
            set7 <= 0;
            set8 <= 0;
            set9 <= 0;
            set10 <= 0;
            set11 <= 0;
            set12 <= 0;
            set13 <= 0;
            set14 <= 0;
            set15 <= 0;
            set16 <= 0;
            set17 <= 0;
            set18 <= 0;
            set19 <= 0;
            set20 <= 0;
            set21 <= 0;
            set22 <= 0;
            set23 <= 0;
            set24 <= 0;
            set25 <= 0;
            set26 <= 0;
            set27 <= 0;
            set28 <= 0;
            set29 <= 0;
            set30 <= 0;
            set31 <= 0;

				if (reset)
					begin
						misc_out0 <= 0;
						misc_out1 <= 0;
						misc_out2 <= 0;
						misc_out3 <= 0;
						out1_select <= 0;
						out2_select <= 0;
						in_select <= 0;
					end
            else if (cpu_addr[7] == 1)
                begin
                    if (rd)
                        begin
                            case (cpu_addr[1:0])
                                0: cpu_data_out <= regfile[cpu_addr[6:2]][7:0];
                                1: cpu_data_out <= regfile[cpu_addr[6:2]][15:8];
                                2: cpu_data_out <= regfile[cpu_addr[6:2]][23:16];
                                3: cpu_data_out <= regfile[cpu_addr[6:2]][31:24];
                            endcase
                        end
                    if (wr)
                        begin
                            case (cpu_addr[1:0])
                                0: regfile[cpu_addr[6:2]][7:0] <= cpu_data_in;
                                1: regfile[cpu_addr[6:2]][15:8] <= cpu_data_in;
                                2: regfile[cpu_addr[6:2]][23:16] <= cpu_data_in;
                                3: regfile[cpu_addr[6:2]][31:24] <= cpu_data_in;
                            endcase
                        end
                end
            else
                begin
                    if (rd)
                        case (cpu_addr[6:0])
                            0: cpu_data_out <= {3'b0, out1_select};
                            1: cpu_data_out <= {3'b0, out2_select};
                            2: cpu_data_out <= {3'b0, in_select};
									 3: cpu_data_out <= 0;
									 4: cpu_data_out <= 0;
									 5: cpu_data_out <= 0;
									 6: cpu_data_out <= 0;
									 7: cpu_data_out <= 0;
									 8: cpu_data_out <= misc_in0;
                            9: cpu_data_out <= misc_in1;
                           10: cpu_data_out <= misc_in2;
                           11: cpu_data_out <= misc_in3;
                           12: cpu_data_out <= misc_out0;
                           13: cpu_data_out <= misc_out1;
                           14: cpu_data_out <= misc_out2;
                           15: cpu_data_out <= misc_out3;
                        endcase
                    if (wr)
                        case (cpu_addr[6:0])
                            0: out1_select <= cpu_data_in[4:0];
                            1: out2_select <= cpu_data_in[4:0];
                            2: in_select <= cpu_data_in[4:0];
                            3: begin
                                case (cpu_data_in[4:0])
                                    0: set0 <= 1;
                                    1: set1 <= 1;
                                    2: set2 <= 1;
                                    3: set3 <= 1;
                                    4: set4 <= 1;
                                    5: set5 <= 1;
                                    6: set6 <= 1;
                                    7: set7 <= 1;
                                    8: set8 <= 1;
                                    9: set9 <= 1;
                                    10: set10 <= 1;
                                    11: set11 <= 1;
                                    12: set12 <= 1;
                                    13: set13 <= 1;
                                    14: set14 <= 1;
                                    15: set15 <= 1;
                                    16: set16 <= 1;
                                    17: set17 <= 1;
                                    18: set18 <= 1;
                                    19: set19 <= 1;
                                    20: set20 <= 1;
                                    21: set21 <= 1;
                                    22: set22 <= 1;
                                    23: set23 <= 1;
                                    24: set24 <= 1;
                                    25: set25 <= 1;
                                    26: set26 <= 1;
                                    27: set27 <= 1;
                                    28: set28 <= 1;
                                    29: set29 <= 1;
                                    30: set30 <= 1;
                                    31: set31 <= 1;
                                endcase
                            end
									 4: regfile[cpu_data_in[4:0]] <= in_reg;
                           12: misc_out0 <= cpu_data_in;
                           13: misc_out1 <= cpu_data_in;
                           14: misc_out2 <= cpu_data_in;
                           15: misc_out3 <= cpu_data_in;
                        endcase
                end
	end

endmodule
