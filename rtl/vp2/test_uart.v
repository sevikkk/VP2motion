// Verilog test fixture created from schematic /home/seva/src/vp2/rtl/vp2/uarts_module.sch - Sun Feb  5 21:41:06 2012

`timescale 1ns / 1ps

module uart_sch_tb();

// Inputs
   wire rxd;
   reg tx_we;
   reg rx_read;
   reg [7:0] tx_data;
   reg clk;
   reg reset;
   reg [15:0] bgen_divider;

// Output
   wire tx_full;
   wire rx_empty;
   wire [7:0] rx_data;
   wire tx_empty;
   wire tx_done;
   wire rx_oerr;
   wire rx_ferr;

// Bidirs

// Instantiate the UUT
   uart UUT (
		.rxd(rxd), 
		.tx_full(tx_full), 
		.tx_we(tx_we), 
		.rx_read(rx_read), 
		.rx_empty(rx_empty), 
		.rx_data(rx_data), 
		.txd(rxd), 
		.tx_empty(tx_empty), 
		.tx_done(tx_done), 
		.tx_data(tx_data), 
		.clk(clk), 
		.reset(reset), 
		.bgen_divider(bgen_divider), 
		.rx_oerr(rx_oerr), 
		.rx_ferr(rx_ferr)
   );


initial begin
		tx_we = 0;
		rx_read = 0;
		tx_data = 0;
		clk = 0;
		reset = 0;
		bgen_divider = 10;
		#100;
		reset = 1;
		#100;
		reset = 0;
end

reg [31:0] cycle;
reg [31:0] cycle2;
reg auto_tx;

initial begin
		cycle = 0;
		cycle2 = 0;
		auto_tx = 0;
		forever
			begin
				clk = 1;
				#3
				if (tx_we == 1)
					begin
						tx_we = 0;
					end
				if (rx_read == 1)
					begin
						rx_read = 0;
					end
				case (cycle)
					30: begin
						tx_data = 8'h8A;
						tx_we = 1;
					end
					40: begin
						tx_data = 8'h33;
						tx_we = 1;
					end
					5000: begin
						auto_tx = 1;
					end
					55000: begin
						rx_read = 1;
					end
					55010: begin
						rx_read = 1;
					end
					55020: begin
						rx_read = 1;
					end
					55030: begin
						rx_read = 1;
					end
					55040: begin
						rx_read = 1;
					end
					71000: begin
						rx_read = 1;
					end
					72000: begin
						rx_read = 1;
					end
					73000: begin
						rx_read = 1;
					end
					73010: begin
						rx_read = 1;
					end
					73020: begin
						rx_read = 1;
					end
					73030: begin
						rx_read = 1;
					end
					73040: begin
						rx_read = 1;
					end
					73050: begin
						rx_read = 1;
					end
					73050: begin
						rx_read = 1;
					end
					73060: begin
						rx_read = 1;
					end
					73070: begin
						rx_read = 1;
					end
					73080: begin
						rx_read = 1;
					end
					73090: begin
						rx_read = 1;
					end
					73100: begin
						rx_read = 1;
					end
					73110: begin
						rx_read = 1;
					end
					73120: begin
						rx_read = 1;
					end
					73130: begin
						rx_read = 1;
					end
					73140: begin
						rx_read = 1;
					end
					73150: begin
						rx_read = 1;
					end
					73160: begin
						rx_read = 1;
					end
					73170: begin
						rx_read = 1;
					end
					73180: begin
						rx_read = 1;
					end
					73190: begin
						rx_read = 1;
					end
					73200: begin
						rx_read = 1;
					end
					73210: begin
						rx_read = 1;
					end
					73220: begin
						rx_read = 1;
					end
					73230: begin
						rx_read = 1;
					end
					73240: begin
						rx_read = 1;
					end
					73250: begin
						rx_read = 1;
					end
					73260: begin
						rx_read = 1;
					end
					73270: begin
						rx_read = 1;
					end
					73280: begin
						rx_read = 1;
					end
					73290: begin
						rx_read = 1;
					end
					73300: begin
						rx_read = 1;
					end
					73310: begin
						rx_read = 1;
					end
					73320: begin
						rx_read = 1;
					end
					73330: begin
						rx_read = 1;
					end
					73340: begin
						rx_read = 1;
					end
					73350: begin
						rx_read = 1;
					end
					73360: begin
						rx_read = 1;
					end
					73370: begin
						rx_read = 1;
					end
					73380: begin
						rx_read = 1;
					end
					73390: begin
						rx_read = 1;
					end
					73400: begin
						rx_read = 1;
					end
					73410: begin
						rx_read = 1;
					end
					73420: begin
						rx_read = 1;
					end
					73430: begin
						rx_read = 1;
					end
					73440: begin
						rx_read = 1;
					end
					73450: begin
						rx_read = 1;
					end
					73460: begin
						rx_read = 1;
					end
					73470: begin
						rx_read = 1;
					end
					73480: begin
						rx_read = 1;
					end
					73490: begin
						rx_read = 1;
					end
					73500: begin
						rx_read = 1;
					end
					73510: begin
						rx_read = 1;
					end
					73520: begin
						rx_read = 1;
					end
					73530: begin
						rx_read = 1;
					end
					73540: begin
						rx_read = 1;
					end
					73550: begin
						rx_read = 1;
					end
					73560: begin
						rx_read = 1;
					end
					73570: begin
						rx_read = 1;
					end
					73580: begin
						rx_read = 1;
					end
					73590: begin
						rx_read = 1;
					end
					73600: begin
						rx_read = 1;
					end
					73610: begin
						rx_read = 1;
					end
					73620: begin
						rx_read = 1;
					end
					73630: begin
						rx_read = 1;
					end
					73640: begin
						rx_read = 1;
					end
					73650: begin
						rx_read = 1;
					end
					73660: begin
						rx_read = 1;
					end
					73670: begin
						rx_read = 1;
					end
					73680: begin
						rx_read = 1;
					end
					73690: begin
						rx_read = 1;
					end
					73700: begin
						rx_read = 1;
					end
					73710: begin
						rx_read = 1;
					end
					73720: begin
						rx_read = 1;
					end
					73730: begin
						rx_read = 1;
					end
					73740: begin
						rx_read = 1;
					end
					73750: begin
						rx_read = 1;
					end
					73760: begin
						rx_read = 1;
					end
					73770: begin
						rx_read = 1;
					end
					73780: begin
						rx_read = 1;
					end
					73790: begin
						rx_read = 1;
					end
				endcase
				if (auto_tx && !tx_full)
					begin
						cycle2 = cycle2 + 1;
						if (cycle2 < 40)
							begin
								tx_data = 30+cycle2;
								tx_we = 1;
							end
						else
							auto_tx = 0;
					end
				#2;
				clk = 0;
				#5;
				cycle = cycle + 1;
			end;
end

endmodule
