VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1
        SIGNAL XLXN_24
        SIGNAL XLXN_30
        SIGNAL XLXN_31
        SIGNAL XLXN_32
        SIGNAL XLXN_33
        SIGNAL clk
        SIGNAL reset
        SIGNAL XLXN_6
        SIGNAL XLXN_9
        SIGNAL XLXN_10(31:0)
        SIGNAL XLXN_11(31:0)
        SIGNAL XLXN_12(63:0)
        SIGNAL XLXN_53(63:0)
        SIGNAL XLXN_54
        SIGNAL XLXN_13
        SIGNAL relative
        SIGNAL start
        SIGNAL target_time(31:0)
        SIGNAL target_position(31:0)
        SIGNAL target_velocity(31:0)
        SIGNAL end_position(31:0)
        SIGNAL end_velocity(31:0)
        SIGNAL done
        SIGNAL acc(31:0)
        SIGNAL dir
        SIGNAL step
        SIGNAL set_position
        SIGNAL data_in(31:0)
        SIGNAL velocity(31:0)
        SIGNAL XLXN_72(31:0)
        SIGNAL position(31:0)
        SIGNAL XLXN_74(31:0)
        PORT Input clk
        PORT Input reset
        PORT Input relative
        PORT Input start
        PORT Input target_time(31:0)
        PORT Input target_position(31:0)
        PORT Input target_velocity(31:0)
        PORT Output end_position(31:0)
        PORT Output end_velocity(31:0)
        PORT Output done
        PORT Output acc(31:0)
        PORT Output dir
        PORT Output step
        PORT Input set_position
        PORT Input data_in(31:0)
        PORT Output velocity(31:0)
        PORT Output position(31:0)
        BEGIN BLOCKDEF step_gen
            TIMESTAMP 2012 1 21 15 27 16
            RECTANGLE N 64 -320 400 0 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 400 -288 464 -288 
            LINE N 400 -208 464 -208 
            RECTANGLE N 400 -140 464 -116 
            LINE N 400 -128 464 -128 
            RECTANGLE N 400 -60 464 -36 
            LINE N 400 -48 464 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF dda
            TIMESTAMP 2012 1 21 16 1 11
            RECTANGLE N 64 -640 528 0 
            LINE N 64 -608 0 -608 
            LINE N 64 -544 0 -544 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            RECTANGLE N 0 -300 64 -276 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 528 -608 592 -608 
            LINE N 528 -512 592 -512 
            RECTANGLE N 528 -428 592 -404 
            LINE N 528 -416 592 -416 
            RECTANGLE N 528 -332 592 -308 
            LINE N 528 -320 592 -320 
            RECTANGLE N 528 -236 592 -212 
            LINE N 528 -224 592 -224 
            RECTANGLE N 528 -140 592 -116 
            LINE N 528 -128 592 -128 
            RECTANGLE N 528 -44 592 -20 
            LINE N 528 -32 592 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF div_steps
            TIMESTAMP 2012 1 21 16 10 2
            RECTANGLE N 64 -384 432 0 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 432 -352 496 -352 
            RECTANGLE N 432 -44 496 -20 
            LINE N 432 -32 496 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
        END BLOCKDEF
        BEGIN BLOCK XLXI_4 dda
            PIN clk clk
            PIN reset reset
            PIN relative relative
            PIN start start
            PIN divide_done XLXN_13
            PIN target_time(31:0) target_time(31:0)
            PIN target_position(31:0) target_position(31:0)
            PIN target_velocity(31:0) target_velocity(31:0)
            PIN position(31:0) position(31:0)
            PIN quotinent(63:0) XLXN_12(63:0)
            PIN done done
            PIN start_divide XLXN_9
            PIN velocity(31:0) velocity(31:0)
            PIN end_position(31:0) end_position(31:0)
            PIN end_velocity(31:0) end_velocity(31:0)
            PIN divident(31:0) XLXN_10(31:0)
            PIN divisor(31:0) XLXN_11(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_5 div_steps
            PIN clk_i clk
            PIN clk_en_i XLXN_6
            PIN rst_i reset
            PIN divide_i XLXN_9
            PIN dividend_i(31:0) XLXN_10(31:0)
            PIN divisor_i(31:0) XLXN_11(31:0)
            PIN done_o XLXN_13
            PIN quotient_o(63:0) XLXN_12(63:0)
        END BLOCK
        BEGIN BLOCK XLXI_6 vcc
            PIN P XLXN_6
        END BLOCK
        BEGIN BLOCK XLXI_3 step_gen
            PIN clk clk
            PIN reset reset
            PIN set_position set_position
            PIN velocity(31:0) velocity(31:0)
            PIN data_in(31:0) data_in(31:0)
            PIN step step
            PIN dir dir
            PIN position(31:0) position(31:0)
            PIN acc(31:0) acc(31:0)
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_4 816 1600 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 672 992 816 992
        END BRANCH
        BEGIN BRANCH reset
            WIRE 672 1056 816 1056
        END BRANCH
        BEGIN INSTANCE XLXI_5 1712 1920 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 1648 1568 1712 1568
            BEGIN DISPLAY 1648 1568 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_6 1488 1632 R0
        BEGIN BRANCH XLXN_6
            WIRE 1552 1632 1712 1632
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1632 1696 1712 1696
            BEGIN DISPLAY 1632 1696 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_9
            WIRE 1408 1088 1504 1088
            WIRE 1504 1088 1504 1760
            WIRE 1504 1760 1712 1760
        END BRANCH
        BEGIN BRANCH XLXN_10(31:0)
            WIRE 1408 1472 1488 1472
            WIRE 1488 1472 1488 1824
            WIRE 1488 1824 1712 1824
        END BRANCH
        BEGIN BRANCH XLXN_11(31:0)
            WIRE 1408 1568 1472 1568
            WIRE 1472 1568 1472 1888
            WIRE 1472 1888 1712 1888
        END BRANCH
        BEGIN BRANCH XLXN_12(63:0)
            WIRE 752 1568 816 1568
            WIRE 752 1568 752 1952
            WIRE 752 1952 2256 1952
            WIRE 2208 1888 2256 1888
            WIRE 2256 1888 2256 1952
        END BRANCH
        BEGIN BRANCH XLXN_13
            WIRE 736 1248 816 1248
            WIRE 736 1248 736 1968
            WIRE 736 1968 2272 1968
            WIRE 2208 1568 2272 1568
            WIRE 2272 1568 2272 1968
        END BRANCH
        BEGIN BRANCH relative
            WIRE 672 1120 816 1120
        END BRANCH
        BEGIN BRANCH start
            WIRE 672 1184 816 1184
        END BRANCH
        BEGIN BRANCH target_time(31:0)
            WIRE 672 1312 816 1312
        END BRANCH
        BEGIN BRANCH target_position(31:0)
            WIRE 672 1376 816 1376
        END BRANCH
        BEGIN BRANCH target_velocity(31:0)
            WIRE 672 1440 816 1440
        END BRANCH
        BEGIN BRANCH end_position(31:0)
            WIRE 1408 1280 1552 1280
        END BRANCH
        BEGIN BRANCH end_velocity(31:0)
            WIRE 1408 1376 1552 1376
        END BRANCH
        BEGIN BRANCH done
            WIRE 1408 992 1568 992
        END BRANCH
        BEGIN BRANCH clk
            WIRE 2112 1024 2144 1024
            WIRE 2144 1024 2224 1024
            BEGIN DISPLAY 2144 1024 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2112 1088 2144 1088
            WIRE 2144 1088 2224 1088
            BEGIN DISPLAY 2138 1088 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH acc(31:0)
            WIRE 2688 1264 2880 1264
        END BRANCH
        BEGIN BRANCH dir
            WIRE 2688 1104 2880 1104
        END BRANCH
        BEGIN BRANCH step
            WIRE 2688 1024 2880 1024
        END BRANCH
        BEGIN BRANCH set_position
            WIRE 2112 1152 2224 1152
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2112 1280 2224 1280
        END BRANCH
        BEGIN INSTANCE XLXI_3 2224 1312 R0
        END INSTANCE
        BEGIN BRANCH velocity(31:0)
            WIRE 1408 1184 1536 1184
            WIRE 1536 1184 1536 1216
            WIRE 1536 1216 2224 1216
            WIRE 1536 1152 1552 1152
            WIRE 1536 1152 1536 1184
        END BRANCH
        BEGIN BRANCH position(31:0)
            WIRE 720 1504 816 1504
            WIRE 720 1504 720 1984
            WIRE 720 1984 2752 1984
            WIRE 2688 1184 2752 1184
            WIRE 2752 1184 2880 1184
            WIRE 2752 1184 2752 1984
        END BRANCH
        IOMARKER 1568 992 done R0 28
        IOMARKER 1552 1280 end_position(31:0) R0 28
        IOMARKER 1552 1376 end_velocity(31:0) R0 28
        IOMARKER 672 1440 target_velocity(31:0) R180 28
        IOMARKER 672 1376 target_position(31:0) R180 28
        IOMARKER 672 1312 target_time(31:0) R180 28
        IOMARKER 672 1184 start R180 28
        IOMARKER 672 1120 relative R180 28
        IOMARKER 672 1056 reset R180 28
        IOMARKER 672 992 clk R180 28
        IOMARKER 1552 1152 velocity(31:0) R0 28
        IOMARKER 2880 1104 dir R0 28
        IOMARKER 2880 1024 step R0 28
        IOMARKER 2880 1184 position(31:0) R0 28
        IOMARKER 2880 1264 acc(31:0) R0 28
        IOMARKER 2112 1152 set_position R180 28
        IOMARKER 2112 1280 data_in(31:0) R180 28
    END SHEET
END SCHEMATIC
