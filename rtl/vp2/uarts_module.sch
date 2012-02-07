VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_2
        SIGNAL uart1_status(1)
        SIGNAL uart1_status(3)
        SIGNAL uart1_status(2)
        SIGNAL txd1
        SIGNAL tx_idle1
        SIGNAL rxd1
        SIGNAL XLXN_20
        SIGNAL uart1_status(0)
        SIGNAL uart1_status(5)
        SIGNAL XLXN_23
        SIGNAL XLXN_24
        SIGNAL uart0_status(1)
        SIGNAL uart0_status(4)
        SIGNAL uart0_status(3)
        SIGNAL uart0_status(2)
        SIGNAL txd0
        SIGNAL tx_idle0
        SIGNAL rxd0
        SIGNAL uart0_status(0)
        SIGNAL uart0_status(5)
        SIGNAL XLXN_41
        SIGNAL XLXN_42
        SIGNAL uart2_rx_data(7:0)
        SIGNAL uart2_status(1)
        SIGNAL uart2_status(4)
        SIGNAL uart2_status(3)
        SIGNAL uart2_status(2)
        SIGNAL txd2
        SIGNAL tx_idle2
        SIGNAL rxd2
        SIGNAL uart2_status(0)
        SIGNAL uart2_status(5)
        SIGNAL XLXN_59
        SIGNAL XLXN_60
        SIGNAL uart3_status(1)
        SIGNAL uart3_status(4)
        SIGNAL uart3_status(3)
        SIGNAL uart3_status(2)
        SIGNAL txd3
        SIGNAL tx_idle3
        SIGNAL rxd3
        SIGNAL uart3_status(0)
        SIGNAL uart3_status(5)
        SIGNAL uart0_wr
        SIGNAL uart0_rx_data(7:0)
        SIGNAL uart0_status(5:0)
        SIGNAL uart1_rx_data(7:0)
        SIGNAL uart1_status(5:0)
        SIGNAL uart1_wr
        SIGNAL uart2_status(5:0)
        SIGNAL uart3_rx_data(7:0)
        SIGNAL uart3_status(5:0)
        SIGNAL misc_out(7:0)
        SIGNAL cpu_data_out(7:0)
        SIGNAL uart0_rd
        SIGNAL uart0_divider(15:0)
        SIGNAL uart1_rd
        SIGNAL uart1_divider(15:0)
        SIGNAL uart2_wr
        SIGNAL uart2_rd
        SIGNAL uart2_divider(15:0)
        SIGNAL uart3_rd
        SIGNAL uart3_divider(15:0)
        SIGNAL uart3_wr
        SIGNAL clk
        SIGNAL reset
        SIGNAL rd
        SIGNAL wr
        SIGNAL cpu_data_in(7:0)
        SIGNAL cpu_addr(7:0)
        SIGNAL misc_in(7:0)
        SIGNAL uart1_status(4)
        PORT Output txd1
        PORT Output tx_idle1
        PORT Input rxd1
        PORT Output txd0
        PORT Output tx_idle0
        PORT Input rxd0
        PORT Output txd2
        PORT Output tx_idle2
        PORT Input rxd2
        PORT Output txd3
        PORT Output tx_idle3
        PORT Input rxd3
        PORT Output misc_out(7:0)
        PORT Output cpu_data_out(7:0)
        PORT Input clk
        PORT Input reset
        PORT Input rd
        PORT Input wr
        PORT Input cpu_data_in(7:0)
        PORT Input cpu_addr(7:0)
        PORT Input misc_in(7:0)
        BEGIN BLOCKDEF uart
            TIMESTAMP 2012 2 5 22 1 30
            RECTANGLE N 64 -712 432 0 
            LINE N 432 -96 496 -96 
            LINE N 64 -96 0 -96 
            LINE N 432 -32 496 -32 
            LINE N 64 -672 0 -672 
            LINE N 64 -608 0 -608 
            RECTANGLE N 0 -556 64 -532 
            LINE N 64 -544 0 -544 
            LINE N 64 -416 0 -416 
            RECTANGLE N 0 -492 64 -468 
            LINE N 64 -480 0 -480 
            LINE N 432 -416 496 -416 
            LINE N 432 -480 496 -480 
            LINE N 64 -352 0 -352 
            LINE N 432 -288 496 -288 
            RECTANGLE N 432 -364 496 -340 
            LINE N 432 -352 496 -352 
            LINE N 432 -224 496 -224 
            LINE N 432 -160 496 -160 
            LINE N 64 -512 432 -512 
            LINE N 64 -384 432 -384 
            LINE N 64 -128 432 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF uart_cpu_if
            TIMESTAMP 2012 2 6 21 27 4
            RECTANGLE N 64 -1280 512 0 
            RECTANGLE N 512 -108 576 -84 
            LINE N 512 -96 576 -96 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            LINE N 512 -864 576 -864 
            LINE N 512 -800 576 -800 
            RECTANGLE N 0 -876 64 -852 
            LINE N 64 -864 0 -864 
            RECTANGLE N 0 -812 64 -788 
            LINE N 64 -800 0 -800 
            RECTANGLE N 0 -684 64 -660 
            LINE N 64 -672 0 -672 
            RECTANGLE N 0 -620 64 -596 
            LINE N 64 -608 0 -608 
            RECTANGLE N 0 -492 64 -468 
            LINE N 64 -480 0 -480 
            RECTANGLE N 0 -428 64 -404 
            LINE N 64 -416 0 -416 
            RECTANGLE N 0 -300 64 -276 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            LINE N 512 -672 576 -672 
            LINE N 512 -608 576 -608 
            RECTANGLE N 512 -748 576 -724 
            LINE N 512 -736 576 -736 
            LINE N 512 -480 576 -480 
            LINE N 512 -416 576 -416 
            RECTANGLE N 512 -556 576 -532 
            LINE N 512 -544 576 -544 
            LINE N 512 -288 576 -288 
            LINE N 512 -224 576 -224 
            RECTANGLE N 512 -364 576 -340 
            LINE N 512 -352 576 -352 
            RECTANGLE N 512 -172 576 -148 
            LINE N 512 -160 576 -160 
            LINE N 64 -1248 0 -1248 
            LINE N 64 -1184 0 -1184 
            LINE N 64 -1120 0 -1120 
            LINE N 64 -1056 0 -1056 
            RECTANGLE N 0 -1004 64 -980 
            LINE N 64 -992 0 -992 
            RECTANGLE N 0 -940 64 -916 
            LINE N 64 -928 0 -928 
            RECTANGLE N 512 -1260 576 -1236 
            LINE N 512 -1248 576 -1248 
            LINE N 64 -896 512 -896 
            LINE N 64 -704 512 -704 
            LINE N 64 -512 512 -512 
            LINE N 64 -320 512 -320 
            LINE N 64 -128 512 -128 
        END BLOCKDEF
        BEGIN BLOCKDEF inv
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 160 -32 
            LINE N 64 -64 128 -32 
            LINE N 128 -32 64 0 
            LINE N 64 0 64 -64 
            CIRCLE N 128 -48 160 -16 
        END BLOCKDEF
        BEGIN BLOCKDEF buf
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
            LINE N 64 0 128 -32 
            LINE N 128 -32 64 -64 
            LINE N 64 -64 64 0 
        END BLOCKDEF
        BEGIN BLOCK XLXI_3 uart
            PIN txd txd1
            PIN rxd rxd1
            PIN tx_done tx_idle1
            PIN clk clk
            PIN reset reset
            PIN bgen_divider(15:0) uart1_divider(15:0)
            PIN tx_we uart1_wr
            PIN tx_data(7:0) cpu_data_in(7:0)
            PIN tx_empty uart1_status(5)
            PIN tx_full XLXN_1
            PIN rx_read uart1_rd
            PIN rx_empty XLXN_2
            PIN rx_data(7:0) uart1_rx_data(7:0)
            PIN rx_oerr uart1_status(3)
            PIN rx_ferr uart1_status(2)
        END BLOCK
        BEGIN BLOCK XLXI_11 inv
            PIN I XLXN_2
            PIN O uart1_status(4)
        END BLOCK
        BEGIN BLOCK XLXI_10 inv
            PIN I XLXN_1
            PIN O uart1_status(1)
        END BLOCK
        BEGIN BLOCK XLXI_15 buf
            PIN I tx_idle1
            PIN O uart1_status(0)
        END BLOCK
        BEGIN BLOCK XLXI_16 uart
            PIN txd txd0
            PIN rxd rxd0
            PIN tx_done tx_idle0
            PIN clk clk
            PIN reset reset
            PIN bgen_divider(15:0) uart0_divider(15:0)
            PIN tx_we uart0_wr
            PIN tx_data(7:0) cpu_data_in(7:0)
            PIN tx_empty uart0_status(5)
            PIN tx_full XLXN_23
            PIN rx_read uart0_rd
            PIN rx_empty XLXN_24
            PIN rx_data(7:0) uart0_rx_data(7:0)
            PIN rx_oerr uart0_status(3)
            PIN rx_ferr uart0_status(2)
        END BLOCK
        BEGIN BLOCK XLXI_17 inv
            PIN I XLXN_24
            PIN O uart0_status(4)
        END BLOCK
        BEGIN BLOCK XLXI_18 inv
            PIN I XLXN_23
            PIN O uart0_status(1)
        END BLOCK
        BEGIN BLOCK XLXI_19 buf
            PIN I tx_idle0
            PIN O uart0_status(0)
        END BLOCK
        BEGIN BLOCK XLXI_20 uart
            PIN txd txd2
            PIN rxd rxd2
            PIN tx_done tx_idle2
            PIN clk clk
            PIN reset reset
            PIN bgen_divider(15:0) uart2_divider(15:0)
            PIN tx_we uart2_wr
            PIN tx_data(7:0) cpu_data_in(7:0)
            PIN tx_empty uart2_status(5)
            PIN tx_full XLXN_41
            PIN rx_read uart2_rd
            PIN rx_empty XLXN_42
            PIN rx_data(7:0) uart2_rx_data(7:0)
            PIN rx_oerr uart2_status(3)
            PIN rx_ferr uart2_status(2)
        END BLOCK
        BEGIN BLOCK XLXI_21 inv
            PIN I XLXN_42
            PIN O uart2_status(4)
        END BLOCK
        BEGIN BLOCK XLXI_22 inv
            PIN I XLXN_41
            PIN O uart2_status(1)
        END BLOCK
        BEGIN BLOCK XLXI_23 buf
            PIN I tx_idle2
            PIN O uart2_status(0)
        END BLOCK
        BEGIN BLOCK XLXI_24 uart
            PIN txd txd3
            PIN rxd rxd3
            PIN tx_done tx_idle3
            PIN clk clk
            PIN reset reset
            PIN bgen_divider(15:0) uart3_divider(15:0)
            PIN tx_we uart3_wr
            PIN tx_data(7:0) cpu_data_in(7:0)
            PIN tx_empty uart3_status(5)
            PIN tx_full XLXN_59
            PIN rx_read uart3_rd
            PIN rx_empty XLXN_60
            PIN rx_data(7:0) uart3_rx_data(7:0)
            PIN rx_oerr uart3_status(3)
            PIN rx_ferr uart3_status(2)
        END BLOCK
        BEGIN BLOCK XLXI_25 inv
            PIN I XLXN_60
            PIN O uart3_status(4)
        END BLOCK
        BEGIN BLOCK XLXI_26 inv
            PIN I XLXN_59
            PIN O uart3_status(1)
        END BLOCK
        BEGIN BLOCK XLXI_27 buf
            PIN I tx_idle3
            PIN O uart3_status(0)
        END BLOCK
        BEGIN BLOCK XLXI_5 uart_cpu_if
            PIN misc_out(7:0) misc_out(7:0)
            PIN misc_in(7:0) misc_in(7:0)
            PIN uart0_tx_wr uart0_wr
            PIN uart0_rx_rd uart0_rd
            PIN uart0_rx_data(7:0) uart0_rx_data(7:0)
            PIN uart0_status(5:0) uart0_status(5:0)
            PIN uart1_rx_data(7:0) uart1_rx_data(7:0)
            PIN uart1_status(5:0) uart1_status(5:0)
            PIN uart2_rx_data(7:0) uart2_rx_data(7:0)
            PIN uart2_status(5:0) uart2_status(5:0)
            PIN uart3_rx_data(7:0) uart3_rx_data(7:0)
            PIN uart3_status(5:0) uart3_status(5:0)
            PIN uart1_tx_wr uart1_wr
            PIN uart1_rx_rd uart1_rd
            PIN uart0_divider(15:0) uart0_divider(15:0)
            PIN uart2_tx_wr uart2_wr
            PIN uart2_rx_rd uart2_rd
            PIN uart1_divider(15:0) uart1_divider(15:0)
            PIN uart3_tx_wr uart3_wr
            PIN uart3_rx_rd uart3_rd
            PIN uart2_divider(15:0) uart2_divider(15:0)
            PIN uart3_divider(15:0) uart3_divider(15:0)
            PIN clk clk
            PIN reset reset
            PIN rd rd
            PIN wr wr
            PIN cpu_data_in(7:0) cpu_data_in(7:0)
            PIN cpu_addr(7:0) cpu_addr(7:0)
            PIN cpu_data_out(7:0) cpu_data_out(7:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_3 1472 2208 R0
        END INSTANCE
        INSTANCE XLXI_11 1984 1952 R0
        INSTANCE XLXI_10 1984 1760 R0
        BEGIN BRANCH XLXN_1
            WIRE 1968 1728 1984 1728
        END BRANCH
        BEGIN BRANCH XLXN_2
            WIRE 1968 1920 1984 1920
        END BRANCH
        BEGIN BRANCH uart1_rx_data(7:0)
            WIRE 1968 1856 2208 1856
            WIRE 2208 1856 2288 1856
            BEGIN DISPLAY 2208 1856 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(1)
            WIRE 2208 1728 2224 1728
            WIRE 2224 1728 2288 1728
            BEGIN DISPLAY 2224 1728 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(4)
            WIRE 2208 1920 2240 1920
            WIRE 2240 1920 2288 1920
            BEGIN DISPLAY 2240 1920 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(3)
            WIRE 1968 1984 2240 1984
            WIRE 2240 1984 2288 1984
            BEGIN DISPLAY 2240 1984 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(2)
            WIRE 1968 2048 2240 2048
            WIRE 2240 2048 2288 2048
            BEGIN DISPLAY 2240 2048 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH txd1
            WIRE 1968 2112 2032 2112
        END BRANCH
        BEGIN BRANCH tx_idle1
            WIRE 1968 2176 1984 2176
            WIRE 1984 2176 1984 2288
            WIRE 1984 2288 2000 2288
            WIRE 1984 2176 2032 2176
        END BRANCH
        BEGIN BRANCH rxd1
            WIRE 1424 2112 1472 2112
        END BRANCH
        IOMARKER 1424 2112 rxd1 R180 28
        IOMARKER 2032 2112 txd1 R0 28
        IOMARKER 2032 2176 tx_idle1 R0 28
        BEGIN BRANCH clk
            WIRE 1344 1536 1376 1536
            WIRE 1376 1536 1472 1536
            BEGIN DISPLAY 1376 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1344 1600 1376 1600
            WIRE 1376 1600 1472 1600
            BEGIN DISPLAY 1376 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 1344 1728 1392 1728
            WIRE 1392 1728 1472 1728
            BEGIN DISPLAY 1392 1728 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_wr
            WIRE 1344 1792 1360 1792
            WIRE 1360 1792 1472 1792
            BEGIN DISPLAY 1360 1792 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_rd
            WIRE 1344 1856 1392 1856
            WIRE 1392 1856 1472 1856
            BEGIN DISPLAY 1392 1856 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_divider(15:0)
            WIRE 1344 1664 1360 1664
            WIRE 1360 1664 1472 1664
            BEGIN DISPLAY 1360 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_15 2000 2320 R0
        BEGIN BRANCH uart1_status(0)
            WIRE 2224 2288 2240 2288
            WIRE 2240 2288 2288 2288
            BEGIN DISPLAY 2240 2288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(5)
            WIRE 1968 1792 2224 1792
            WIRE 2224 1792 2288 1792
            BEGIN DISPLAY 2224 1792 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_16 1488 1328 R0
        END INSTANCE
        INSTANCE XLXI_17 2000 1072 R0
        BEGIN BRANCH XLXN_23
            WIRE 1984 848 2016 848
        END BRANCH
        BEGIN BRANCH XLXN_24
            WIRE 1984 1040 2000 1040
        END BRANCH
        BEGIN BRANCH uart0_rx_data(7:0)
            WIRE 1984 976 2208 976
            WIRE 2208 976 2304 976
            BEGIN DISPLAY 2208 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(1)
            WIRE 2240 848 2272 848
            WIRE 2272 848 2304 848
            BEGIN DISPLAY 2272 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(4)
            WIRE 2224 1040 2256 1040
            WIRE 2256 1040 2304 1040
            BEGIN DISPLAY 2256 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(3)
            WIRE 1984 1104 2240 1104
            WIRE 2240 1104 2304 1104
            BEGIN DISPLAY 2240 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(2)
            WIRE 1984 1168 2256 1168
            WIRE 2256 1168 2304 1168
            BEGIN DISPLAY 2256 1168 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH txd0
            WIRE 1984 1232 2048 1232
        END BRANCH
        BEGIN BRANCH tx_idle0
            WIRE 1984 1296 2000 1296
            WIRE 2000 1296 2000 1408
            WIRE 2000 1408 2016 1408
            WIRE 2000 1296 2048 1296
        END BRANCH
        BEGIN BRANCH rxd0
            WIRE 1440 1232 1488 1232
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1360 656 1392 656
            WIRE 1392 656 1488 656
            BEGIN DISPLAY 1392 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1360 720 1392 720
            WIRE 1392 720 1488 720
            BEGIN DISPLAY 1392 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 1360 848 1408 848
            WIRE 1408 848 1488 848
            BEGIN DISPLAY 1408 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_wr
            WIRE 1360 912 1392 912
            WIRE 1392 912 1488 912
            BEGIN DISPLAY 1392 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_rd
            WIRE 1360 976 1392 976
            WIRE 1392 976 1488 976
            BEGIN DISPLAY 1392 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_divider(15:0)
            WIRE 1360 784 1376 784
            WIRE 1376 784 1488 784
            BEGIN DISPLAY 1376 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_19 2016 1440 R0
        BEGIN BRANCH uart0_status(0)
            WIRE 2240 1408 2272 1408
            WIRE 2272 1408 2304 1408
            BEGIN DISPLAY 2272 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(5)
            WIRE 1984 912 2240 912
            WIRE 2240 912 2304 912
            BEGIN DISPLAY 2240 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 1440 1232 rxd0 R180 28
        IOMARKER 2048 1232 txd0 R0 28
        IOMARKER 2048 1296 tx_idle0 R0 28
        BEGIN INSTANCE XLXI_20 2528 1328 R0
        END INSTANCE
        INSTANCE XLXI_21 3040 1072 R0
        INSTANCE XLXI_22 3040 880 R0
        BEGIN BRANCH XLXN_41
            WIRE 3024 848 3040 848
        END BRANCH
        BEGIN BRANCH XLXN_42
            WIRE 3024 1040 3040 1040
        END BRANCH
        BEGIN BRANCH uart2_rx_data(7:0)
            WIRE 3024 976 3264 976
            WIRE 3264 976 3344 976
            BEGIN DISPLAY 3264 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(1)
            WIRE 3264 848 3296 848
            WIRE 3296 848 3344 848
            BEGIN DISPLAY 3296 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(4)
            WIRE 3264 1040 3312 1040
            WIRE 3312 1040 3344 1040
            BEGIN DISPLAY 3312 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(3)
            WIRE 3024 1104 3296 1104
            WIRE 3296 1104 3344 1104
            BEGIN DISPLAY 3296 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(2)
            WIRE 3024 1168 3280 1168
            WIRE 3280 1168 3344 1168
            BEGIN DISPLAY 3280 1168 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH txd2
            WIRE 3024 1232 3088 1232
        END BRANCH
        BEGIN BRANCH tx_idle2
            WIRE 3024 1296 3040 1296
            WIRE 3040 1296 3040 1408
            WIRE 3040 1408 3056 1408
            WIRE 3040 1296 3088 1296
        END BRANCH
        BEGIN BRANCH rxd2
            WIRE 2480 1232 2528 1232
        END BRANCH
        BEGIN BRANCH clk
            WIRE 2400 656 2416 656
            WIRE 2416 656 2528 656
            BEGIN DISPLAY 2416 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2400 720 2432 720
            WIRE 2432 720 2528 720
            BEGIN DISPLAY 2432 720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 2400 848 2432 848
            WIRE 2432 848 2528 848
            BEGIN DISPLAY 2432 848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_wr
            WIRE 2400 912 2432 912
            WIRE 2432 912 2528 912
            BEGIN DISPLAY 2432 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_rd
            WIRE 2400 976 2432 976
            WIRE 2432 976 2528 976
            BEGIN DISPLAY 2432 976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_divider(15:0)
            WIRE 2400 784 2432 784
            WIRE 2432 784 2528 784
            BEGIN DISPLAY 2432 784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_23 3056 1440 R0
        BEGIN BRANCH uart2_status(0)
            WIRE 3280 1408 3312 1408
            WIRE 3312 1408 3344 1408
            BEGIN DISPLAY 3312 1408 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(5)
            WIRE 3024 912 3280 912
            WIRE 3280 912 3344 912
            BEGIN DISPLAY 3280 912 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2480 1232 rxd2 R180 28
        IOMARKER 3088 1232 txd2 R0 28
        IOMARKER 3088 1296 tx_idle2 R0 28
        BEGIN INSTANCE XLXI_24 2544 2368 R0
        END INSTANCE
        INSTANCE XLXI_25 3056 2112 R0
        INSTANCE XLXI_26 3056 1920 R0
        BEGIN BRANCH XLXN_59
            WIRE 3040 1888 3056 1888
        END BRANCH
        BEGIN BRANCH XLXN_60
            WIRE 3040 2080 3056 2080
        END BRANCH
        BEGIN BRANCH uart3_rx_data(7:0)
            WIRE 3040 2016 3296 2016
            WIRE 3296 2016 3360 2016
            BEGIN DISPLAY 3296 2016 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(1)
            WIRE 3280 1888 3328 1888
            WIRE 3328 1888 3360 1888
            BEGIN DISPLAY 3328 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(4)
            WIRE 3280 2080 3328 2080
            WIRE 3328 2080 3360 2080
            BEGIN DISPLAY 3328 2080 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(3)
            WIRE 3040 2144 3328 2144
            WIRE 3328 2144 3360 2144
            BEGIN DISPLAY 3328 2144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(2)
            WIRE 3040 2208 3328 2208
            WIRE 3328 2208 3360 2208
            BEGIN DISPLAY 3328 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH txd3
            WIRE 3040 2272 3056 2272
            WIRE 3056 2272 3104 2272
        END BRANCH
        BEGIN BRANCH tx_idle3
            WIRE 3040 2336 3056 2336
            WIRE 3056 2336 3056 2448
            WIRE 3056 2448 3072 2448
            WIRE 3056 2336 3104 2336
        END BRANCH
        BEGIN BRANCH rxd3
            WIRE 2496 2272 2544 2272
        END BRANCH
        BEGIN BRANCH clk
            WIRE 2416 1696 2448 1696
            WIRE 2448 1696 2544 1696
            BEGIN DISPLAY 2448 1696 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2416 1760 2464 1760
            WIRE 2464 1760 2544 1760
            BEGIN DISPLAY 2464 1760 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 2416 1888 2464 1888
            WIRE 2464 1888 2544 1888
            BEGIN DISPLAY 2464 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_wr
            WIRE 2416 1952 2448 1952
            WIRE 2448 1952 2544 1952
            BEGIN DISPLAY 2448 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_rd
            WIRE 2416 2016 2448 2016
            WIRE 2448 2016 2544 2016
            BEGIN DISPLAY 2448 2016 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_divider(15:0)
            WIRE 2416 1824 2480 1824
            WIRE 2480 1824 2544 1824
            BEGIN DISPLAY 2480 1824 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_27 3072 2480 R0
        BEGIN BRANCH uart3_status(0)
            WIRE 3296 2448 3344 2448
            WIRE 3344 2448 3360 2448
            BEGIN DISPLAY 3344 2448 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(5)
            WIRE 3040 1952 3312 1952
            WIRE 3312 1952 3360 1952
            BEGIN DISPLAY 3312 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 2496 2272 rxd3 R180 28
        IOMARKER 3104 2272 txd3 R0 28
        IOMARKER 3104 2336 tx_idle3 R0 28
        BEGIN INSTANCE XLXI_5 368 1904 R0
        END INSTANCE
        BEGIN BRANCH uart0_wr
            WIRE 944 1040 1040 1040
            WIRE 1040 1040 1072 1040
            BEGIN DISPLAY 1040 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_rx_data(7:0)
            WIRE 240 1040 256 1040
            WIRE 256 1040 368 1040
            BEGIN DISPLAY 256 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_status(5:0)
            WIRE 240 1104 256 1104
            WIRE 256 1104 368 1104
            BEGIN DISPLAY 256 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_rx_data(7:0)
            WIRE 240 1232 272 1232
            WIRE 272 1232 368 1232
            BEGIN DISPLAY 272 1232 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_status(5:0)
            WIRE 240 1296 256 1296
            WIRE 256 1296 368 1296
            BEGIN DISPLAY 256 1296 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_wr
            WIRE 944 1232 1024 1232
            WIRE 1024 1232 1072 1232
            BEGIN DISPLAY 1024 1232 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_rx_data(7:0)
            WIRE 240 1424 272 1424
            WIRE 272 1424 368 1424
            BEGIN DISPLAY 272 1424 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_status(5:0)
            WIRE 240 1488 272 1488
            WIRE 272 1488 368 1488
            BEGIN DISPLAY 272 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_rx_data(7:0)
            WIRE 240 1616 272 1616
            WIRE 272 1616 368 1616
            BEGIN DISPLAY 272 1616 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_status(5:0)
            WIRE 240 1680 256 1680
            WIRE 256 1680 368 1680
            BEGIN DISPLAY 256 1680 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out(7:0)
            WIRE 944 1808 1072 1808
        END BRANCH
        BEGIN BRANCH cpu_data_out(7:0)
            WIRE 944 656 960 656
            WIRE 960 656 976 656
        END BRANCH
        BEGIN BRANCH uart0_rd
            WIRE 944 1104 1040 1104
            WIRE 1040 1104 1072 1104
            BEGIN DISPLAY 1040 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart0_divider(15:0)
            WIRE 944 1168 1040 1168
            WIRE 1040 1168 1072 1168
            BEGIN DISPLAY 1040 1168 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_rd
            WIRE 944 1296 1008 1296
            WIRE 1008 1296 1072 1296
            BEGIN DISPLAY 1008 1296 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart1_divider(15:0)
            WIRE 944 1360 1008 1360
            WIRE 1008 1360 1072 1360
            BEGIN DISPLAY 1008 1360 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_wr
            WIRE 944 1424 1056 1424
            WIRE 1056 1424 1072 1424
            BEGIN DISPLAY 1056 1424 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_rd
            WIRE 944 1488 960 1488
            WIRE 960 1488 1024 1488
            WIRE 1024 1488 1072 1488
            BEGIN DISPLAY 1024 1488 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart2_divider(15:0)
            WIRE 944 1552 960 1552
            WIRE 960 1552 1040 1552
            WIRE 1040 1552 1072 1552
            BEGIN DISPLAY 1040 1552 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_rd
            WIRE 944 1680 960 1680
            WIRE 960 1680 1024 1680
            WIRE 1024 1680 1072 1680
            BEGIN DISPLAY 1024 1680 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_divider(15:0)
            WIRE 944 1744 1024 1744
            WIRE 1024 1744 1072 1744
            BEGIN DISPLAY 1024 1744 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart3_wr
            WIRE 944 1616 1024 1616
            WIRE 1024 1616 1072 1616
            BEGIN DISPLAY 1024 1616 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 976 656 cpu_data_out(7:0) R0 28
        BEGIN BRANCH clk
            WIRE 336 656 352 656
            WIRE 352 656 368 656
        END BRANCH
        BEGIN BRANCH reset
            WIRE 336 720 352 720
            WIRE 352 720 368 720
        END BRANCH
        BEGIN BRANCH rd
            WIRE 336 784 352 784
            WIRE 352 784 368 784
        END BRANCH
        BEGIN BRANCH wr
            WIRE 336 848 352 848
            WIRE 352 848 368 848
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 336 912 352 912
            WIRE 352 912 368 912
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 336 976 352 976
            WIRE 352 976 368 976
        END BRANCH
        BEGIN BRANCH misc_in(7:0)
            WIRE 336 1808 352 1808
            WIRE 352 1808 368 1808
        END BRANCH
        IOMARKER 336 656 clk R180 28
        IOMARKER 336 720 reset R180 28
        IOMARKER 336 784 rd R180 28
        IOMARKER 336 848 wr R180 28
        IOMARKER 336 912 cpu_data_in(7:0) R180 28
        IOMARKER 336 976 cpu_addr(7:0) R180 28
        IOMARKER 336 1808 misc_in(7:0) R180 28
        IOMARKER 1072 1808 misc_out(7:0) R0 28
        INSTANCE XLXI_18 2016 880 R0
    END SHEET
END SCHEMATIC
