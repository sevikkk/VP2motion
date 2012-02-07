VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_3(7:0)
        SIGNAL XLXN_4(7:0)
        SIGNAL XLXN_7
        SIGNAL XLXN_2
        SIGNAL XLXN_29
        SIGNAL XLXN_30
        SIGNAL rxd
        SIGNAL XLXN_6
        SIGNAL XLXN_31
        SIGNAL tx_full
        SIGNAL tx_we
        SIGNAL rx_read
        SIGNAL rx_empty
        SIGNAL rx_data(7:0)
        SIGNAL txd
        SIGNAL tx_empty
        SIGNAL tx_data(7:0)
        SIGNAL XLXN_79
        SIGNAL XLXN_80
        SIGNAL clk
        SIGNAL reset
        SIGNAL bgen_divider(15:0)
        SIGNAL XLXN_88
        SIGNAL rx_oerr
        SIGNAL rx_ferr
        SIGNAL XLXN_107
        SIGNAL XLXN_108
        SIGNAL XLXN_109
        SIGNAL tx_done
        PORT Input rxd
        PORT Output tx_full
        PORT Input tx_we
        PORT Input rx_read
        PORT Output rx_empty
        PORT Output rx_data(7:0)
        PORT Output txd
        PORT Output tx_empty
        PORT Input tx_data(7:0)
        PORT Input clk
        PORT Input reset
        PORT Input bgen_divider(15:0)
        PORT Output rx_oerr
        PORT Output rx_ferr
        PORT Output tx_done
        BEGIN BLOCKDEF RxUnit
            TIMESTAMP 2012 2 5 14 2 10
            RECTANGLE N 64 -320 320 0 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -288 384 -288 
            LINE N 320 -208 384 -208 
            LINE N 320 -128 384 -128 
            RECTANGLE N 320 -60 384 -36 
            LINE N 320 -48 384 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF TxUnit
            TIMESTAMP 2012 2 5 14 2 10
            RECTANGLE N 64 -320 320 0 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 320 -288 384 -288 
            LINE N 320 -160 384 -160 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF fifo32
            TIMESTAMP 2012 2 5 16 43 13
            RECTANGLE N 64 -384 320 0 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 320 -352 384 -352 
            LINE N 320 -192 384 -192 
            RECTANGLE N 320 -44 384 -20 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ClkUnit38400
            TIMESTAMP 2012 2 5 17 59 10
            RECTANGLE N 64 -192 320 0 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 320 -160 384 -160 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF and2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 64 -128 
            LINE N 256 -96 192 -96 
            ARC N 96 -144 192 -48 144 -48 144 -144 
            LINE N 144 -48 64 -48 
            LINE N 64 -144 144 -144 
            LINE N 64 -48 64 -144 
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
        BEGIN BLOCKDEF gnd
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -64 64 -96 
            LINE N 76 -48 52 -48 
            LINE N 68 -32 60 -32 
            LINE N 88 -64 40 -64 
            LINE N 64 -64 64 -80 
            LINE N 64 -128 64 -96 
        END BLOCKDEF
        BEGIN BLOCK XLXI_8 fifo32
            PIN clk clk
            PIN rst reset
            PIN clr XLXN_79
            PIN we tx_we
            PIN re XLXN_7
            PIN din(7:0) tx_data(7:0)
            PIN full tx_full
            PIN empty tx_empty
            PIN dout(7:0) XLXN_3(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 TxUnit
            PIN Clk clk
            PIN Reset reset
            PIN Enable XLXN_2
            PIN Load XLXN_7
            PIN DataO(7:0) XLXN_3(7:0)
            PIN TxD txd
            PIN TRegE XLXN_108
            PIN TBufE XLXN_109
        END BLOCK
        BEGIN BLOCK XLXI_14 and2
            PIN I0 XLXN_109
            PIN I1 XLXN_107
            PIN O XLXN_7
        END BLOCK
        BEGIN BLOCK XLXI_15 inv
            PIN I tx_empty
            PIN O XLXN_107
        END BLOCK
        BEGIN BLOCK XLXI_9 fifo32
            PIN clk clk
            PIN rst reset
            PIN clr XLXN_80
            PIN we XLXN_6
            PIN re rx_read
            PIN din(7:0) XLXN_4(7:0)
            PIN full XLXN_29
            PIN empty rx_empty
            PIN dout(7:0) rx_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_16 inv
            PIN I XLXN_29
            PIN O XLXN_30
        END BLOCK
        BEGIN BLOCK XLXI_17 and2
            PIN I0 XLXN_31
            PIN I1 XLXN_30
            PIN O XLXN_6
        END BLOCK
        BEGIN BLOCK XLXI_27 gnd
            PIN G XLXN_79
        END BLOCK
        BEGIN BLOCK XLXI_28 gnd
            PIN G XLXN_80
        END BLOCK
        BEGIN BLOCK XLXI_12 ClkUnit38400
            PIN SysClk clk
            PIN Reset reset
            PIN Divider(15:0) bgen_divider(15:0)
            PIN EnableRx XLXN_88
            PIN EnableTx XLXN_2
        END BLOCK
        BEGIN BLOCK XLXI_4 RxUnit
            PIN Clk clk
            PIN Reset reset
            PIN Enable XLXN_88
            PIN RxD rxd
            PIN RD XLXN_6
            PIN FErr rx_ferr
            PIN OErr rx_oerr
            PIN DRdy XLXN_31
            PIN DataIn(7:0) XLXN_4(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_31 and2
            PIN I0 XLXN_109
            PIN I1 XLXN_108
            PIN O tx_done
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_8 1296 1312 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_6 2000 1312 R0
        END INSTANCE
        BEGIN BRANCH XLXN_3(7:0)
            WIRE 1680 1280 2000 1280
        END BRANCH
        BEGIN BRANCH XLXN_4(7:0)
            WIRE 1504 752 2000 752
            WIRE 2000 736 2016 736
            WIRE 2000 736 2000 752
        END BRANCH
        BEGIN BRANCH XLXN_7
            WIRE 1216 1216 1296 1216
            WIRE 1216 1216 1216 1392
            WIRE 1216 1392 1888 1392
            WIRE 1888 1392 2960 1392
            WIRE 1888 1216 2000 1216
            WIRE 1888 1216 1888 1392
            WIRE 2880 1248 2960 1248
            WIRE 2960 1248 2960 1392
        END BRANCH
        INSTANCE XLXI_15 2080 896 R0
        BEGIN BRANCH XLXN_2
            WIRE 848 832 1984 832
            WIRE 1984 832 1984 1152
            WIRE 1984 1152 2000 1152
        END BRANCH
        BEGIN INSTANCE XLXI_9 2016 768 R0
        END INSTANCE
        INSTANCE XLXI_16 2448 448 R0
        INSTANCE XLXI_17 2688 544 R0
        BEGIN BRANCH XLXN_29
            WIRE 2400 416 2448 416
        END BRANCH
        BEGIN BRANCH XLXN_30
            WIRE 2672 416 2688 416
        END BRANCH
        BEGIN BRANCH XLXN_31
            WIRE 1504 672 1584 672
            WIRE 1584 672 1584 816
            WIRE 1584 816 2688 816
            WIRE 2688 480 2688 816
        END BRANCH
        BEGIN BRANCH tx_full
            WIRE 1680 960 1712 960
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1248 960 1264 960
            WIRE 1264 960 1296 960
            BEGIN DISPLAY 1264 960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1248 1024 1264 1024
            WIRE 1264 1024 1296 1024
            BEGIN DISPLAY 1264 1024 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH tx_we
            WIRE 1168 1152 1296 1152
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1952 1088 2000 1088
            BEGIN DISPLAY 1952 1088 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1952 1024 1968 1024
            WIRE 1968 1024 2000 1024
            BEGIN DISPLAY 1968 1024 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rx_read
            WIRE 1968 672 2016 672
        END BRANCH
        BEGIN BRANCH clk
            WIRE 1968 416 1984 416
            WIRE 1984 416 2016 416
            BEGIN DISPLAY 1984 416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1968 480 1984 480
            WIRE 1984 480 2016 480
            BEGIN DISPLAY 1984 480 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rx_empty
            WIRE 2400 576 2448 576
        END BRANCH
        BEGIN BRANCH rx_data(7:0)
            WIRE 2400 736 2448 736
        END BRANCH
        BEGIN BRANCH txd
            WIRE 2384 1024 2432 1024
        END BRANCH
        BEGIN BRANCH tx_data(7:0)
            WIRE 1184 1280 1296 1280
        END BRANCH
        IOMARKER 2432 1024 txd R0 28
        IOMARKER 2448 736 rx_data(7:0) R0 28
        IOMARKER 2448 576 rx_empty R0 28
        IOMARKER 1968 672 rx_read R180 28
        BEGIN BRANCH rxd
            WIRE 1056 704 1120 704
        END BRANCH
        BEGIN BRANCH XLXN_79
            WIRE 944 1088 944 1104
            WIRE 944 1088 1296 1088
        END BRANCH
        INSTANCE XLXI_27 880 1232 R0
        IOMARKER 1184 1280 tx_data(7:0) R180 28
        IOMARKER 1168 1152 tx_we R180 28
        IOMARKER 1712 960 tx_full R0 28
        INSTANCE XLXI_14 2624 1344 R0
        BEGIN BRANCH XLXN_80
            WIRE 1760 544 1760 608
            WIRE 1760 544 2016 544
        END BRANCH
        BEGIN INSTANCE XLXI_12 464 864 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 416 704 464 704
        END BRANCH
        BEGIN BRANCH reset
            WIRE 400 768 464 768
        END BRANCH
        BEGIN BRANCH bgen_divider(15:0)
            WIRE 416 832 464 832
        END BRANCH
        IOMARKER 416 704 clk R180 28
        IOMARKER 416 832 bgen_divider(15:0) R180 28
        BEGIN INSTANCE XLXI_4 1120 800 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 1072 512 1104 512
            WIRE 1104 512 1120 512
            BEGIN DISPLAY 1104 512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1072 576 1104 576
            WIRE 1104 576 1120 576
            BEGIN DISPLAY 1104 576 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rx_oerr
            WIRE 1504 592 1552 592
        END BRANCH
        BEGIN BRANCH rx_ferr
            WIRE 1504 512 1552 512
        END BRANCH
        IOMARKER 1552 592 rx_oerr R0 28
        IOMARKER 1552 512 rx_ferr R0 28
        BEGIN BRANCH XLXN_88
            WIRE 848 704 864 704
            WIRE 864 640 1120 640
            WIRE 864 640 864 704
        END BRANCH
        BEGIN BRANCH XLXN_6
            WIRE 1088 272 1088 768
            WIRE 1088 768 1120 768
            WIRE 1088 272 1888 272
            WIRE 1888 272 2976 272
            WIRE 2976 272 2976 448
            WIRE 1888 272 1888 608
            WIRE 1888 608 2016 608
            WIRE 2944 448 2976 448
        END BRANCH
        IOMARKER 1056 704 rxd R180 28
        INSTANCE XLXI_28 1696 736 R0
        IOMARKER 400 768 reset R180 28
        BEGIN BRANCH tx_empty
            WIRE 1680 1120 1712 1120
            WIRE 1712 1120 1888 1120
            WIRE 1712 1120 1712 1184
            WIRE 1712 1184 1760 1184
            WIRE 1888 864 2080 864
            WIRE 1888 864 1888 1120
        END BRANCH
        IOMARKER 1760 1184 tx_empty R0 28
        BEGIN BRANCH XLXN_107
            WIRE 2304 864 2512 864
            WIRE 2512 864 2512 1216
            WIRE 2512 1216 2624 1216
        END BRANCH
        INSTANCE XLXI_31 2592 1200 R0
        BEGIN BRANCH XLXN_108
            WIRE 2384 1152 2480 1152
            WIRE 2480 1072 2480 1152
            WIRE 2480 1072 2592 1072
        END BRANCH
        BEGIN BRANCH XLXN_109
            WIRE 2384 1280 2528 1280
            WIRE 2528 1280 2624 1280
            WIRE 2528 1136 2592 1136
            WIRE 2528 1136 2528 1280
        END BRANCH
        BEGIN BRANCH tx_done
            WIRE 2848 1104 2944 1104
        END BRANCH
        IOMARKER 2944 1104 tx_done R0 28
    END SHEET
END SCHEMATIC
