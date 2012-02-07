`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:39 11/16/2008 
// Design Name: 
// Module Name:    datamux 
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

module datamux(
	input clk,
	input reset,
	input [15:0] cpu_next_addr,
	input cpu_next_rd,
	input cpu_next_we,
   output reg [7:0] cpu_di,
	output reg cpu_enable,
	
	// ram
	output reg ram_we,
	input [7:0] ram_data,
	
	// rom
	input [7:0] rom_data,
	
	// uart
	input [7:0] uart_data,
	output reg uart_rd,
	output reg uart_wr,
		
	// SDCard spi controller
	input spi_ack,
	input [7:0] spi_data,
	output reg spi_wr,
	output reg spi_stb,
	
	//maxII SPI
	input [7:0] maxspi_data,
	output reg maxspi_wr,
	output reg maxspi_rd,

	//gpio
	input [7:0] gpio_data,
	output reg gpio_wr,
	output reg gpio_rd,

	//dev 4
	input [7:0] dev4_data,
	input dev4_ack,
	output reg dev4_stb,
	output reg dev4_wr,
	output reg dev4_rd,

	//dev 5
	input [7:0] dev5_data,
	input dev5_ack,
	output reg dev5_stb,
	output reg dev5_wr,
	output reg dev5_rd,

	//dev 6
	input [7:0] dev6_data,
	input dev6_ack,
	output reg dev6_stb,
	output reg dev6_wr,
	output reg dev6_rd,

	//dev 7
	input [7:0] dev7_data,
	input dev7_ack,
	output reg dev7_stb,
	output reg dev7_wr,
	output reg dev7_rd
);

reg [3:0] input_select;
reg [3:0] next_input_select;
reg next_cpu_enable;

always @(cpu_next_addr, cpu_next_rd, cpu_next_we, cpu_enable)
	begin
		ram_we <= 0;
		uart_rd <= 0;
		uart_wr <= 0;
		next_input_select <= 0;
		spi_wr <= 0;
		spi_stb <= 0;
		maxspi_wr <= 0;
		maxspi_rd <= 0;
		gpio_wr <= 0;
		gpio_rd <= 0;
		
		dev4_stb <= 0;
		dev4_wr <= 0;
		dev4_rd <= 0;
		
		dev5_stb <= 0;
		dev5_wr <= 0;
		dev5_rd <= 0;
		
		dev6_stb <= 0;
		dev6_wr <= 0;
		dev6_rd <= 0;
		
		dev7_stb <= 0;
		dev7_wr <= 0;
		dev7_rd <= 0;
		
		if (cpu_next_addr[15] == 0) // RAM 0x0000 - 0x7FFF
			begin
				next_input_select <= 1;
				if (cpu_next_we == 1)
					ram_we <= 1;
			end
		else if (cpu_next_addr[15:13] == 7) // ROM 0xE000 - 0xFFFF
			next_input_select <= 2;
		else if (cpu_next_addr[15:8] == 8'hD0) // UART 0xD000 - 0xD0FF
			begin
				next_input_select <= 3;
				if (cpu_next_rd == 1)
					uart_rd <= 1;
				if (cpu_next_we == 1)
					uart_wr <= 1;
			end
		else if (cpu_next_addr[15:8] == 8'hD1) // SPI 0xD100 - 0xD1FF
			begin
				next_input_select <= 5;
				if (cpu_next_rd == 1)
					spi_stb <= 1;
				if (cpu_next_we == 1)
					begin
						spi_stb <= 1;
						spi_wr <= 1;
					end
			end
		else if (cpu_next_addr[15:8] == 8'hD2) // MAXII SPI 0xD200 - 0xD2FF
			begin
				next_input_select <= 6;
				if (cpu_next_we == 1)
					maxspi_wr <= 1;
				if (cpu_next_rd == 1)
					maxspi_rd <= 1;
			end
		else if (cpu_next_addr[15:8] == 8'hD3) // GPIO 0xD300 - 0xD3FF
			begin
				next_input_select <= 7;
				if (cpu_next_we == 1)
					gpio_wr <= 1;
				if (cpu_next_rd == 1)
					gpio_rd <= 1;
			end
		else if (cpu_next_addr[15:8] == 8'hD4) // dev4 0xD400 - 0xD4FF
			begin
				next_input_select <= 8;
				if (cpu_next_we == 1)
					begin
						dev4_stb <= 1;
						dev4_wr <= 1;
					end
				if (cpu_next_rd == 1)
					begin
						dev4_stb <= 1;
						dev4_rd <= 1;
					end
			end
		else if (cpu_next_addr[15:8] == 8'hD5) // dev5 0xD500 - 0xD5FF
			begin
				next_input_select <= 9;
				if (cpu_next_we == 1)
					begin
						dev5_stb <= 1;
						dev5_wr <= 1;
					end
				if (cpu_next_rd == 1)
					begin
						dev5_stb <= 1;
						dev5_rd <= 1;
					end
			end
		else if (cpu_next_addr[15:8] == 8'hD6) // dev6 0xD600 - 0xD6FF
			begin
				next_input_select <= 9;
				if (cpu_next_we == 1)
					begin
						dev6_stb <= 1;
						dev6_wr <= 1;
					end
				if (cpu_next_rd == 1)
					begin
						dev6_stb <= 1;
						dev6_rd <= 1;
					end
			end
		else if (cpu_next_addr[15:8] == 8'hD7) // dev7 0xD700 - 0xD7FF
			begin
				next_input_select <= 10;
				if (cpu_next_we == 1)
					begin
						dev7_stb <= 1;
						dev7_wr <= 1;
					end
				if (cpu_next_rd == 1)
					begin
						dev7_stb <= 1;
						dev7_rd <= 1;
					end
			end
	end
	
always @(posedge clk)
	begin
		input_select <= next_input_select;
	end
	
always @(input_select, ram_data, rom_data, uart_data, spi_data, maxspi_data, gpio_data, dev4_data, dev5_data, dev6_data, dev7_data)
	begin
		if (input_select == 1)
			cpu_di <= ram_data;
		else if (input_select == 2)
			cpu_di <= rom_data;
		else if (input_select == 3)
			cpu_di <= uart_data;
		else if (input_select == 5)
			cpu_di <= spi_data;
		else if (input_select == 6)
			cpu_di <= maxspi_data;
		else if (input_select == 7)
			cpu_di <= gpio_data;
		else if (input_select == 8)
			cpu_di <= dev4_data;
		else if (input_select == 9)
			cpu_di <= dev5_data;
		else if (input_select == 10)
			cpu_di <= dev6_data;
		else if (input_select == 11)
			cpu_di <= dev7_data;
		else
			cpu_di <= 0;
	end

always @(next_input_select, spi_ack, dev4_ack, dev5_ack, dev6_ack, dev7_ack)
	begin
		if (next_input_select == 5)
			cpu_enable <= spi_ack;
		else if (next_input_select == 8)
			cpu_enable <= dev4_ack;
		else if (next_input_select == 9)
			cpu_enable <= dev5_ack;
		else if (next_input_select == 10)
			cpu_enable <= dev6_ack;
		else if (next_input_select == 11)
			cpu_enable <= dev7_ack;
		else
			cpu_enable <= 1;
	end
	
endmodule
