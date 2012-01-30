VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_1947(31:0)
        SIGNAL XLXN_1948(31:0)
        SIGNAL XLXN_1949(31:0)
        SIGNAL clk
        SIGNAL reset
        SIGNAL rd
        SIGNAL wr
        SIGNAL cpu_data_out(7:0)
        SIGNAL cpu_addr(7:0)
        SIGNAL cpu_data_in(7:0)
        SIGNAL dir_x
        SIGNAL step_x
        SIGNAL data_in(31:0)
        SIGNAL x_set_pos
        SIGNAL x_start
        SIGNAL misc_in0(0)
        SIGNAL x_cur_pos(31:0)
        SIGNAL x_set_target_pos
        SIGNAL x_set_target_vel
        SIGNAL x_set_target_time
        SIGNAL data_loop(31:0)
        SIGNAL x_cur_vel(31:0)
        SIGNAL misc_out0(7:0)
        SIGNAL misc_out0(0)
        SIGNAL XLXN_1981(31:0)
        SIGNAL XLXN_1982(31:0)
        SIGNAL XLXN_1983(31:0)
        SIGNAL step_y
        SIGNAL y_set_pos
        SIGNAL y_start
        SIGNAL misc_out0(1)
        SIGNAL misc_in0(1)
        SIGNAL y_cur_pos(31:0)
        SIGNAL y_set_target_time
        SIGNAL y_set_target_pos
        SIGNAL y_set_target_vel
        SIGNAL y_cur_vel(31:0)
        SIGNAL XLXN_2001(31:0)
        SIGNAL XLXN_2002(31:0)
        SIGNAL XLXN_2003(31:0)
        SIGNAL z_set_pos
        SIGNAL z_start
        SIGNAL misc_out0(2)
        SIGNAL z_cur_pos(31:0)
        SIGNAL z_set_target_time
        SIGNAL z_set_target_pos
        SIGNAL z_set_target_vel
        SIGNAL z_cur_vel(31:0)
        SIGNAL XLXN_2021(31:0)
        SIGNAL XLXN_2022(31:0)
        SIGNAL XLXN_2023(31:0)
        SIGNAL a_set_pos
        SIGNAL a_start
        SIGNAL misc_out0(3)
        SIGNAL a_cur_pos(31:0)
        SIGNAL a_set_target_time
        SIGNAL a_set_target_pos
        SIGNAL a_set_target_vel
        SIGNAL a_cur_vel(31:0)
        SIGNAL x_end_pos(31:0)
        SIGNAL x_end_vel(31:0)
        SIGNAL y_end_pos(31:0)
        SIGNAL y_end_vel(31:0)
        SIGNAL a_end_vel(31:0)
        SIGNAL a_end_pos(31:0)
        SIGNAL z_end_pos(31:0)
        SIGNAL z_end_vel(31:0)
        SIGNAL debounce_unlock
        SIGNAL debounce_set_timeout
        SIGNAL x_endstop_pos(31:0)
        SIGNAL x_endstop_bounce(31:0)
        SIGNAL y_endstop_pos(31:0)
        SIGNAL y_endstop_bounce(31:0)
        SIGNAL z_endstop_pos(31:0)
        SIGNAL z_endstop_bounce(31:0)
        SIGNAL endstop_cycles(31:0)
        SIGNAL misc_in1(7:0)
        SIGNAL misc_in0(7:0)
        SIGNAL misc_out1(7:0)
        SIGNAL enable_xyz
        SIGNAL enable_a
        SIGNAL misc_out1(0)
        SIGNAL misc_out1(1)
        SIGNAL XLXN_2109
        SIGNAL XLXN_2110
        SIGNAL endstop_cycles(23:16)
        SIGNAL misc_in1(5)
        SIGNAL misc_in1(4)
        SIGNAL endstop_cycles(15:8)
        SIGNAL misc_in1(3)
        SIGNAL misc_in1(2)
        SIGNAL endstop_cycles(7:0)
        SIGNAL misc_in1(1)
        SIGNAL misc_in1(0)
        SIGNAL misc_in0(3)
        SIGNAL step_a
        SIGNAL dir_a
        SIGNAL misc_in0(2)
        SIGNAL step_z
        SIGNAL dir_z
        SIGNAL XLXN_2128
        SIGNAL XLXN_2129
        SIGNAL x_endstop
        SIGNAL XLXN_2134
        SIGNAL XLXN_2135
        SIGNAL XLXN_2136
        SIGNAL y_endstop
        SIGNAL XLXN_2138
        SIGNAL XLXN_2140
        SIGNAL z_endstop
        SIGNAL XLXN_2143
        SIGNAL XLXN_2145
        SIGNAL XLXN_2146
        SIGNAL XLXN_2147
        SIGNAL XLXN_2148
        SIGNAL XLXN_2149
        SIGNAL XLXN_2150
        SIGNAL XLXN_2151
        SIGNAL dir_y
        SIGNAL XLXN_2154
        SIGNAL XLXN_2155
        SIGNAL misc_out2(0)
        SIGNAL misc_out2(2)
        SIGNAL misc_out2(3)
        SIGNAL misc_out2(6)
        SIGNAL misc_out2(5)
        SIGNAL misc_out2(4)
        SIGNAL misc_out2(7:0)
        SIGNAL misc_out2(1)
        PORT Input clk
        PORT Input reset
        PORT Input rd
        PORT Input wr
        PORT Output cpu_data_out(7:0)
        PORT Input cpu_addr(7:0)
        PORT Input cpu_data_in(7:0)
        PORT Output dir_x
        PORT Output step_x
        PORT Output step_y
        PORT Output enable_xyz
        PORT Output enable_a
        PORT Output step_a
        PORT Output dir_a
        PORT Output step_z
        PORT Output dir_z
        PORT Input x_endstop
        PORT Input y_endstop
        PORT Input z_endstop
        PORT Output dir_y
        BEGIN BLOCKDEF stepper_ctrl
            TIMESTAMP 2012 1 22 10 55 58
            RECTANGLE N 64 -576 528 0 
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
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 528 -556 592 -532 
            LINE N 528 -544 592 -544 
            RECTANGLE N 528 -492 592 -468 
            LINE N 528 -480 592 -480 
            LINE N 528 -416 592 -416 
            RECTANGLE N 528 -364 592 -340 
            LINE N 528 -352 592 -352 
            LINE N 528 -288 592 -288 
            LINE N 528 -224 592 -224 
            RECTANGLE N 528 -172 592 -148 
            LINE N 528 -160 592 -160 
            RECTANGLE N 528 -108 592 -84 
            LINE N 528 -96 592 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF dda_bus_if
            TIMESTAMP 2012 1 22 13 51 54
            RECTANGLE N 64 -384 528 0 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 528 -364 592 -340 
            LINE N 528 -352 592 -352 
            RECTANGLE N 528 -204 592 -180 
            LINE N 528 -192 592 -192 
            RECTANGLE N 528 -44 592 -20 
            LINE N 528 -32 592 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF memory_maped_if
            TIMESTAMP 2012 1 27 18 40 46
            RECTANGLE N 64 -2816 464 0 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -236 528 -212 
            LINE N 464 -224 528 -224 
            RECTANGLE N 464 -172 528 -148 
            LINE N 464 -160 528 -160 
            RECTANGLE N 464 -108 528 -84 
            LINE N 464 -96 528 -96 
            RECTANGLE N 464 -44 528 -20 
            LINE N 464 -32 528 -32 
            LINE N 464 -2272 528 -2272 
            LINE N 464 -2208 528 -2208 
            LINE N 464 -2144 528 -2144 
            LINE N 464 -2080 528 -2080 
            LINE N 464 -2016 528 -2016 
            LINE N 464 -1952 528 -1952 
            LINE N 464 -1888 528 -1888 
            LINE N 464 -1824 528 -1824 
            LINE N 464 -1760 528 -1760 
            LINE N 464 -1696 528 -1696 
            LINE N 464 -1632 528 -1632 
            LINE N 464 -1568 528 -1568 
            LINE N 464 -1504 528 -1504 
            LINE N 464 -1440 528 -1440 
            LINE N 464 -1376 528 -1376 
            LINE N 464 -1312 528 -1312 
            LINE N 464 -1248 528 -1248 
            LINE N 464 -1184 528 -1184 
            LINE N 464 -1120 528 -1120 
            LINE N 464 -1056 528 -1056 
            LINE N 464 -992 528 -992 
            LINE N 464 -928 528 -928 
            LINE N 464 -864 528 -864 
            LINE N 464 -800 528 -800 
            LINE N 464 -736 528 -736 
            LINE N 464 -672 528 -672 
            LINE N 464 -608 528 -608 
            LINE N 464 -544 528 -544 
            LINE N 464 -480 528 -480 
            LINE N 464 -416 528 -416 
            LINE N 464 -352 528 -352 
            LINE N 464 -288 528 -288 
            RECTANGLE N 464 -2412 528 -2388 
            LINE N 464 -2400 528 -2400 
            RECTANGLE N 464 -2348 528 -2324 
            LINE N 464 -2336 528 -2336 
            LINE N 64 -256 464 -256 
            LINE N 64 -2784 0 -2784 
            LINE N 64 -2720 0 -2720 
            RECTANGLE N 0 -2668 64 -2644 
            LINE N 64 -2656 0 -2656 
            RECTANGLE N 0 -2604 64 -2580 
            LINE N 64 -2592 0 -2592 
            LINE N 64 -2528 0 -2528 
            LINE N 64 -2464 0 -2464 
            RECTANGLE N 464 -2796 528 -2772 
            LINE N 464 -2784 528 -2784 
            RECTANGLE N 0 -2412 64 -2388 
            LINE N 64 -2400 0 -2400 
            RECTANGLE N 0 -2348 64 -2324 
            LINE N 64 -2336 0 -2336 
            RECTANGLE N 0 -2284 64 -2260 
            LINE N 64 -2272 0 -2272 
            RECTANGLE N 0 -2220 64 -2196 
            LINE N 64 -2208 0 -2208 
            RECTANGLE N 0 -2156 64 -2132 
            LINE N 64 -2144 0 -2144 
            RECTANGLE N 0 -2092 64 -2068 
            LINE N 64 -2080 0 -2080 
            RECTANGLE N 0 -2028 64 -2004 
            LINE N 64 -2016 0 -2016 
            RECTANGLE N 0 -1964 64 -1940 
            LINE N 64 -1952 0 -1952 
            RECTANGLE N 0 -1900 64 -1876 
            LINE N 64 -1888 0 -1888 
            RECTANGLE N 0 -1836 64 -1812 
            LINE N 64 -1824 0 -1824 
            RECTANGLE N 0 -1772 64 -1748 
            LINE N 64 -1760 0 -1760 
            RECTANGLE N 0 -1708 64 -1684 
            LINE N 64 -1696 0 -1696 
            RECTANGLE N 0 -1644 64 -1620 
            LINE N 64 -1632 0 -1632 
            RECTANGLE N 0 -1580 64 -1556 
            LINE N 64 -1568 0 -1568 
            RECTANGLE N 0 -1516 64 -1492 
            LINE N 64 -1504 0 -1504 
            RECTANGLE N 0 -1452 64 -1428 
            LINE N 64 -1440 0 -1440 
            RECTANGLE N 0 -1388 64 -1364 
            LINE N 64 -1376 0 -1376 
            RECTANGLE N 0 -1324 64 -1300 
            LINE N 64 -1312 0 -1312 
            RECTANGLE N 0 -1260 64 -1236 
            LINE N 64 -1248 0 -1248 
            RECTANGLE N 0 -1196 64 -1172 
            LINE N 64 -1184 0 -1184 
            RECTANGLE N 0 -1132 64 -1108 
            LINE N 64 -1120 0 -1120 
            RECTANGLE N 0 -1068 64 -1044 
            LINE N 64 -1056 0 -1056 
            RECTANGLE N 0 -1004 64 -980 
            LINE N 64 -992 0 -992 
            RECTANGLE N 0 -940 64 -916 
            LINE N 64 -928 0 -928 
            RECTANGLE N 0 -876 64 -852 
            LINE N 64 -864 0 -864 
            RECTANGLE N 0 -812 64 -788 
            LINE N 64 -800 0 -800 
            RECTANGLE N 0 -748 64 -724 
            LINE N 64 -736 0 -736 
            RECTANGLE N 0 -684 64 -660 
            LINE N 64 -672 0 -672 
            RECTANGLE N 0 -620 64 -596 
            LINE N 64 -608 0 -608 
            RECTANGLE N 0 -556 64 -532 
            LINE N 64 -544 0 -544 
            RECTANGLE N 0 -492 64 -468 
            LINE N 64 -480 0 -480 
            RECTANGLE N 0 -428 64 -404 
            LINE N 64 -416 0 -416 
            LINE N 64 -2432 464 -2432 
        END BLOCKDEF
        BEGIN BLOCKDEF debounce
            TIMESTAMP 2012 1 28 22 57 31
            RECTANGLE N 64 -448 432 0 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 432 -416 496 -416 
            LINE N 432 -320 496 -320 
            RECTANGLE N 432 -236 496 -212 
            LINE N 432 -224 496 -224 
            RECTANGLE N 432 -140 496 -116 
            LINE N 432 -128 496 -128 
            RECTANGLE N 432 -44 496 -20 
            LINE N 432 -32 496 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF buf
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
            LINE N 64 0 128 -32 
            LINE N 128 -32 64 -64 
            LINE N 64 -64 64 0 
        END BLOCKDEF
        BEGIN BLOCKDEF xor2
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -64 64 -64 
            LINE N 0 -128 60 -128 
            LINE N 256 -96 208 -96 
            ARC N -40 -152 72 -40 48 -48 44 -144 
            ARC N -24 -152 88 -40 64 -48 64 -144 
            LINE N 128 -144 64 -144 
            LINE N 128 -48 64 -48 
            ARC N 44 -144 220 32 208 -96 128 -144 
            ARC N 44 -224 220 -48 128 -48 208 -96 
        END BLOCKDEF
        BEGIN BLOCK XLXI_643 stepper_ctrl
            PIN clk clk
            PIN reset reset
            PIN relative misc_out0(0)
            PIN start x_start
            PIN target_time(31:0) XLXN_1947(31:0)
            PIN target_position(31:0) XLXN_1948(31:0)
            PIN target_velocity(31:0) XLXN_1949(31:0)
            PIN set_position x_set_pos
            PIN data_in(31:0) data_in(31:0)
            PIN end_position(31:0) x_end_pos(31:0)
            PIN end_velocity(31:0) x_end_vel(31:0)
            PIN done misc_in0(0)
            PIN acc(31:0)
            PIN dir XLXN_2149
            PIN step step_x
            PIN velocity(31:0) x_cur_vel(31:0)
            PIN position(31:0) x_cur_pos(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_644 dda_bus_if
            PIN clk clk
            PIN reset reset
            PIN set_target_time x_set_target_time
            PIN set_target_position x_set_target_pos
            PIN set_target_velocity x_set_target_vel
            PIN data_in(31:0) data_in(31:0)
            PIN target_time(31:0) XLXN_1947(31:0)
            PIN target_position(31:0) XLXN_1948(31:0)
            PIN target_velocity(31:0) XLXN_1949(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_645 memory_maped_if
            PIN misc_in0(7:0) misc_in0(7:0)
            PIN misc_in1(7:0) misc_in1(7:0)
            PIN misc_in2(7:0)
            PIN misc_in3(7:0)
            PIN misc_out0(7:0) misc_out0(7:0)
            PIN misc_out1(7:0) misc_out1(7:0)
            PIN misc_out2(7:0) misc_out2(7:0)
            PIN misc_out3(7:0)
            PIN set0 x_start
            PIN set1 x_set_pos
            PIN set2 x_set_target_time
            PIN set3 x_set_target_pos
            PIN set4 x_set_target_vel
            PIN set5 y_start
            PIN set6 y_set_pos
            PIN set7 y_set_target_time
            PIN set8 y_set_target_pos
            PIN set9 y_set_target_vel
            PIN set10 z_start
            PIN set11 z_set_pos
            PIN set12 z_set_target_time
            PIN set13 z_set_target_pos
            PIN set14 z_set_target_vel
            PIN set15 a_start
            PIN set16 a_set_pos
            PIN set17 a_set_target_time
            PIN set18 a_set_target_pos
            PIN set19 a_set_target_vel
            PIN set20 debounce_unlock
            PIN set21 debounce_set_timeout
            PIN set22
            PIN set23
            PIN set24
            PIN set25
            PIN set26
            PIN set27
            PIN set28
            PIN set29
            PIN set30
            PIN set31
            PIN data_out1(31:0) data_in(31:0)
            PIN data_out2(31:0) data_loop(31:0)
            PIN clk clk
            PIN reset reset
            PIN cpu_addr(7:0) cpu_addr(7:0)
            PIN cpu_data_in(7:0) cpu_data_in(7:0)
            PIN rd rd
            PIN wr wr
            PIN cpu_data_out(7:0) cpu_data_out(7:0)
            PIN input0(31:0) data_loop(31:0)
            PIN input1(31:0) x_cur_pos(31:0)
            PIN input2(31:0) x_cur_vel(31:0)
            PIN input3(31:0) x_end_pos(31:0)
            PIN input4(31:0) x_end_vel(31:0)
            PIN input5(31:0) y_cur_pos(31:0)
            PIN input6(31:0) y_cur_vel(31:0)
            PIN input7(31:0) y_end_pos(31:0)
            PIN input8(31:0) y_end_vel(31:0)
            PIN input9(31:0) z_cur_pos(31:0)
            PIN input10(31:0) z_cur_vel(31:0)
            PIN input11(31:0) z_end_pos(31:0)
            PIN input12(31:0) z_end_vel(31:0)
            PIN input13(31:0) a_cur_pos(31:0)
            PIN input14(31:0) a_cur_vel(31:0)
            PIN input15(31:0) a_end_pos(31:0)
            PIN input16(31:0) a_end_vel(31:0)
            PIN input17(31:0) x_endstop_pos(31:0)
            PIN input18(31:0) x_endstop_bounce(31:0)
            PIN input19(31:0) y_endstop_pos(31:0)
            PIN input20(31:0) y_endstop_bounce(31:0)
            PIN input21(31:0) z_endstop_pos(31:0)
            PIN input22(31:0) z_endstop_bounce(31:0)
            PIN input23(31:0) endstop_cycles(31:0)
            PIN input24(31:0)
            PIN input25(31:0)
            PIN input26(31:0)
            PIN input27(31:0)
            PIN input28(31:0)
            PIN input29(31:0)
            PIN input30(31:0)
            PIN input31(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_646 stepper_ctrl
            PIN clk clk
            PIN reset reset
            PIN relative misc_out0(1)
            PIN start y_start
            PIN target_time(31:0) XLXN_1981(31:0)
            PIN target_position(31:0) XLXN_1982(31:0)
            PIN target_velocity(31:0) XLXN_1983(31:0)
            PIN set_position y_set_pos
            PIN data_in(31:0) data_in(31:0)
            PIN end_position(31:0) y_end_pos(31:0)
            PIN end_velocity(31:0) y_end_vel(31:0)
            PIN done misc_in0(1)
            PIN acc(31:0)
            PIN dir XLXN_2150
            PIN step step_y
            PIN velocity(31:0) y_cur_vel(31:0)
            PIN position(31:0) y_cur_pos(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_647 dda_bus_if
            PIN clk clk
            PIN reset reset
            PIN set_target_time y_set_target_time
            PIN set_target_position y_set_target_pos
            PIN set_target_velocity y_set_target_vel
            PIN data_in(31:0) data_in(31:0)
            PIN target_time(31:0) XLXN_1981(31:0)
            PIN target_position(31:0) XLXN_1982(31:0)
            PIN target_velocity(31:0) XLXN_1983(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_648 stepper_ctrl
            PIN clk clk
            PIN reset reset
            PIN relative misc_out0(2)
            PIN start z_start
            PIN target_time(31:0) XLXN_2001(31:0)
            PIN target_position(31:0) XLXN_2002(31:0)
            PIN target_velocity(31:0) XLXN_2003(31:0)
            PIN set_position z_set_pos
            PIN data_in(31:0) data_in(31:0)
            PIN end_position(31:0) z_end_pos(31:0)
            PIN end_velocity(31:0) z_end_vel(31:0)
            PIN done misc_in0(2)
            PIN acc(31:0)
            PIN dir XLXN_2154
            PIN step step_z
            PIN velocity(31:0) z_cur_vel(31:0)
            PIN position(31:0) z_cur_pos(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_649 dda_bus_if
            PIN clk clk
            PIN reset reset
            PIN set_target_time z_set_target_time
            PIN set_target_position z_set_target_pos
            PIN set_target_velocity z_set_target_vel
            PIN data_in(31:0) data_in(31:0)
            PIN target_time(31:0) XLXN_2001(31:0)
            PIN target_position(31:0) XLXN_2002(31:0)
            PIN target_velocity(31:0) XLXN_2003(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_650 stepper_ctrl
            PIN clk clk
            PIN reset reset
            PIN relative misc_out0(3)
            PIN start a_start
            PIN target_time(31:0) XLXN_2021(31:0)
            PIN target_position(31:0) XLXN_2022(31:0)
            PIN target_velocity(31:0) XLXN_2023(31:0)
            PIN set_position a_set_pos
            PIN data_in(31:0) data_in(31:0)
            PIN end_position(31:0) a_end_pos(31:0)
            PIN end_velocity(31:0) a_end_vel(31:0)
            PIN done misc_in0(3)
            PIN acc(31:0)
            PIN dir XLXN_2155
            PIN step step_a
            PIN velocity(31:0) a_cur_vel(31:0)
            PIN position(31:0) a_cur_pos(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_651 dda_bus_if
            PIN clk clk
            PIN reset reset
            PIN set_target_time a_set_target_time
            PIN set_target_position a_set_target_pos
            PIN set_target_velocity a_set_target_vel
            PIN data_in(31:0) data_in(31:0)
            PIN target_time(31:0) XLXN_2021(31:0)
            PIN target_position(31:0) XLXN_2022(31:0)
            PIN target_velocity(31:0) XLXN_2023(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_657 buf
            PIN I misc_out1(0)
            PIN O enable_xyz
        END BLOCK
        BEGIN BLOCK XLXI_658 buf
            PIN I misc_out1(1)
            PIN O enable_a
        END BLOCK
        BEGIN BLOCK XLXI_661 xor2
            PIN I0 misc_out2(4)
            PIN I1 x_endstop
            PIN O XLXN_2135
        END BLOCK
        BEGIN BLOCK XLXI_660 xor2
            PIN I0 misc_out2(5)
            PIN I1 y_endstop
            PIN O XLXN_2138
        END BLOCK
        BEGIN BLOCK XLXI_659 xor2
            PIN I0 misc_out2(6)
            PIN I1 z_endstop
            PIN O XLXN_2140
        END BLOCK
        BEGIN BLOCK XLXI_656 debounce
            PIN clk clk
            PIN reset reset
            PIN sig_in XLXN_2140
            PIN unlock debounce_unlock
            PIN set_timeout debounce_set_timeout
            PIN pos_in(31:0) z_cur_pos(31:0)
            PIN data_in(31:0) data_in(31:0)
            PIN sig_out misc_in1(4)
            PIN sig_changed misc_in1(5)
            PIN pos_out(31:0) z_endstop_pos(31:0)
            PIN max_bounce(31:0) z_endstop_bounce(31:0)
            PIN cycles(7:0) endstop_cycles(23:16)
        END BLOCK
        BEGIN BLOCK XLXI_655 debounce
            PIN clk clk
            PIN reset reset
            PIN sig_in XLXN_2138
            PIN unlock debounce_unlock
            PIN set_timeout debounce_set_timeout
            PIN pos_in(31:0) y_cur_pos(31:0)
            PIN data_in(31:0) data_in(31:0)
            PIN sig_out misc_in1(2)
            PIN sig_changed misc_in1(3)
            PIN pos_out(31:0) y_endstop_pos(31:0)
            PIN max_bounce(31:0) y_endstop_bounce(31:0)
            PIN cycles(7:0) endstop_cycles(15:8)
        END BLOCK
        BEGIN BLOCK XLXI_652 debounce
            PIN clk clk
            PIN reset reset
            PIN sig_in XLXN_2135
            PIN unlock debounce_unlock
            PIN set_timeout debounce_set_timeout
            PIN pos_in(31:0) x_cur_pos(31:0)
            PIN data_in(31:0) data_in(31:0)
            PIN sig_out misc_in1(0)
            PIN sig_changed misc_in1(1)
            PIN pos_out(31:0) x_endstop_pos(31:0)
            PIN max_bounce(31:0) x_endstop_bounce(31:0)
            PIN cycles(7:0) endstop_cycles(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_665 xor2
            PIN I0 XLXN_2155
            PIN I1 misc_out2(3)
            PIN O dir_a
        END BLOCK
        BEGIN BLOCK XLXI_664 xor2
            PIN I0 XLXN_2154
            PIN I1 misc_out2(2)
            PIN O dir_z
        END BLOCK
        BEGIN BLOCK XLXI_663 xor2
            PIN I0 XLXN_2150
            PIN I1 misc_out2(1)
            PIN O dir_y
        END BLOCK
        BEGIN BLOCK XLXI_662 xor2
            PIN I0 XLXN_2149
            PIN I1 misc_out2(0)
            PIN O dir_x
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 7040 5440
        BEGIN BRANCH XLXN_1947(31:0)
            WIRE 2784 352 2800 352
            WIRE 2800 352 2800 448
            WIRE 2800 448 3088 448
        END BRANCH
        BEGIN BRANCH XLXN_1948(31:0)
            WIRE 2784 512 3088 512
        END BRANCH
        BEGIN BRANCH XLXN_1949(31:0)
            WIRE 2784 672 2800 672
            WIRE 2800 576 2800 672
            WIRE 2800 576 3088 576
        END BRANCH
        BEGIN INSTANCE XLXI_643 3088 736 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_644 2192 704 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 2032 352 2192 352
            BEGIN DISPLAY 2032 352 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2032 416 2192 416
            BEGIN DISPLAY 2032 416 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_645 672 2992 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 512 208 672 208
        END BRANCH
        BEGIN BRANCH reset
            WIRE 512 272 672 272
        END BRANCH
        BEGIN BRANCH rd
            WIRE 512 464 672 464
        END BRANCH
        BEGIN BRANCH wr
            WIRE 512 528 672 528
        END BRANCH
        BEGIN BRANCH cpu_data_out(7:0)
            WIRE 1200 208 1360 208
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 512 336 672 336
        END BRANCH
        BEGIN BRANCH cpu_data_in(7:0)
            WIRE 512 400 672 400
        END BRANCH
        IOMARKER 512 208 clk R180 28
        IOMARKER 512 272 reset R180 28
        IOMARKER 512 336 cpu_addr(7:0) R180 28
        IOMARKER 512 400 cpu_data_in(7:0) R180 28
        IOMARKER 512 464 rd R180 28
        IOMARKER 512 528 wr R180 28
        IOMARKER 1360 208 cpu_data_out(7:0) R0 28
        BEGIN BRANCH step_x
            WIRE 3680 512 3808 512
        END BRANCH
        BEGIN BRANCH clk
            WIRE 2992 192 3088 192
            BEGIN DISPLAY 2992 192 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2992 256 3088 256
            BEGIN DISPLAY 2992 256 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 1200 592 1328 592
            BEGIN DISPLAY 1328 592 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2096 672 2192 672
            BEGIN DISPLAY 2096 672 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2992 704 3088 704
            BEGIN DISPLAY 2992 704 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_pos
            WIRE 2992 640 3088 640
            BEGIN DISPLAY 2992 640 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_start
            WIRE 2992 384 3088 384
            BEGIN DISPLAY 2992 384 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out0(0)
            WIRE 2992 320 3088 320
            BEGIN DISPLAY 2992 320 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in0(0)
            WIRE 3680 320 3744 320
            WIRE 3744 320 3808 320
            BEGIN DISPLAY 3744 320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_cur_pos(31:0)
            WIRE 3680 640 3792 640
            WIRE 3792 640 3808 640
            BEGIN DISPLAY 3792 640 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_time
            WIRE 2096 480 2192 480
            BEGIN DISPLAY 2096 480 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_pos
            WIRE 2096 544 2192 544
            BEGIN DISPLAY 2096 544 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_vel
            WIRE 2096 608 2192 608
            BEGIN DISPLAY 2096 608 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_cur_vel(31:0)
            WIRE 3680 576 3792 576
            WIRE 3792 576 3808 576
            BEGIN DISPLAY 3792 576 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_pos
            WIRE 1200 784 1360 784
            BEGIN DISPLAY 1360 784 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_time
            WIRE 1200 848 1360 848
            BEGIN DISPLAY 1360 848 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_pos
            WIRE 1200 912 1360 912
            BEGIN DISPLAY 1360 912 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_set_target_vel
            WIRE 1200 976 1360 976
            BEGIN DISPLAY 1360 976 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_start
            WIRE 1200 1040 1408 1040
            BEGIN DISPLAY 1408 1040 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_pos
            WIRE 1200 1104 1360 1104
            BEGIN DISPLAY 1360 1104 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_time
            WIRE 1200 1168 1360 1168
            BEGIN DISPLAY 1360 1168 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_loop(31:0)
            WIRE 496 592 672 592
            BEGIN DISPLAY 496 592 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_cur_pos(31:0)
            WIRE 496 656 672 656
            BEGIN DISPLAY 496 656 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_cur_vel(31:0)
            WIRE 544 720 672 720
            BEGIN DISPLAY 544 720 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_loop(31:0)
            WIRE 1200 656 1328 656
            BEGIN DISPLAY 1328 656 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out0(7:0)
            WIRE 1200 2768 1296 2768
            WIRE 1296 2768 1344 2768
            BEGIN DISPLAY 1296 2768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in0(7:0)
            WIRE 576 2768 624 2768
            WIRE 624 2768 672 2768
            BEGIN DISPLAY 624 2768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1981(31:0)
            WIRE 2800 1024 2960 1024
            WIRE 2960 1024 2960 1120
            WIRE 2960 1120 3104 1120
        END BRANCH
        BEGIN BRANCH XLXN_1982(31:0)
            WIRE 2800 1184 3104 1184
        END BRANCH
        BEGIN BRANCH XLXN_1983(31:0)
            WIRE 2800 1344 2960 1344
            WIRE 2960 1248 2960 1344
            WIRE 2960 1248 3104 1248
        END BRANCH
        BEGIN INSTANCE XLXI_646 3104 1408 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_647 2208 1376 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 2048 1024 2208 1024
            BEGIN DISPLAY 2048 1024 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2048 1088 2208 1088
            BEGIN DISPLAY 2048 1088 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH step_y
            WIRE 3696 1184 3824 1184
        END BRANCH
        BEGIN BRANCH clk
            WIRE 3008 864 3024 864
            WIRE 3024 864 3104 864
            BEGIN DISPLAY 3024 864 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3008 928 3024 928
            WIRE 3024 928 3104 928
            BEGIN DISPLAY 3024 928 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2112 1344 2144 1344
            WIRE 2144 1344 2208 1344
            BEGIN DISPLAY 2144 1344 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2992 1376 3008 1376
            WIRE 3008 1376 3104 1376
            BEGIN DISPLAY 3008 1376 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_pos
            WIRE 2992 1312 3024 1312
            WIRE 3024 1312 3104 1312
            BEGIN DISPLAY 3024 1312 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_start
            WIRE 2992 1056 3008 1056
            WIRE 3008 1056 3104 1056
            BEGIN DISPLAY 3008 1056 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out0(1)
            WIRE 2992 992 3024 992
            WIRE 3024 992 3104 992
            BEGIN DISPLAY 3024 992 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in0(1)
            WIRE 3696 992 3760 992
            WIRE 3760 992 3824 992
            BEGIN DISPLAY 3760 992 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_cur_pos(31:0)
            WIRE 3696 1312 3808 1312
            WIRE 3808 1312 3824 1312
            BEGIN DISPLAY 3808 1312 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_time
            WIRE 2112 1152 2144 1152
            WIRE 2144 1152 2208 1152
            BEGIN DISPLAY 2144 1152 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_pos
            WIRE 2112 1216 2128 1216
            WIRE 2128 1216 2208 1216
            BEGIN DISPLAY 2128 1216 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_vel
            WIRE 2112 1280 2144 1280
            WIRE 2144 1280 2208 1280
            BEGIN DISPLAY 2144 1280 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_cur_vel(31:0)
            WIRE 3696 1248 3808 1248
            WIRE 3808 1248 3824 1248
            BEGIN DISPLAY 3808 1248 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_2001(31:0)
            WIRE 2816 1696 2976 1696
            WIRE 2976 1696 2976 1792
            WIRE 2976 1792 3120 1792
        END BRANCH
        BEGIN BRANCH XLXN_2002(31:0)
            WIRE 2816 1856 3120 1856
        END BRANCH
        BEGIN BRANCH XLXN_2003(31:0)
            WIRE 2816 2016 2976 2016
            WIRE 2976 1920 2976 2016
            WIRE 2976 1920 3120 1920
        END BRANCH
        BEGIN INSTANCE XLXI_648 3120 2080 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_649 2224 2048 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 2064 1696 2224 1696
            BEGIN DISPLAY 2064 1696 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2064 1760 2224 1760
            BEGIN DISPLAY 2064 1760 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 3024 1536 3040 1536
            WIRE 3040 1536 3120 1536
            BEGIN DISPLAY 3040 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3024 1600 3040 1600
            WIRE 3040 1600 3120 1600
            BEGIN DISPLAY 3040 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2128 2016 2160 2016
            WIRE 2160 2016 2224 2016
            BEGIN DISPLAY 2160 2016 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 3008 2048 3024 2048
            WIRE 3024 2048 3120 2048
            BEGIN DISPLAY 3024 2048 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_pos
            WIRE 3008 1984 3040 1984
            WIRE 3040 1984 3120 1984
            BEGIN DISPLAY 3040 1984 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_start
            WIRE 3008 1728 3024 1728
            WIRE 3024 1728 3120 1728
            BEGIN DISPLAY 3024 1728 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out0(2)
            WIRE 3008 1664 3040 1664
            WIRE 3040 1664 3120 1664
            BEGIN DISPLAY 3040 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_time
            WIRE 2128 1824 2160 1824
            WIRE 2160 1824 2224 1824
            BEGIN DISPLAY 2160 1824 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_pos
            WIRE 2128 1888 2144 1888
            WIRE 2144 1888 2224 1888
            BEGIN DISPLAY 2144 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_vel
            WIRE 2128 1952 2160 1952
            WIRE 2160 1952 2224 1952
            BEGIN DISPLAY 2160 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_2021(31:0)
            WIRE 2832 2384 2992 2384
            WIRE 2992 2384 2992 2480
            WIRE 2992 2480 3136 2480
        END BRANCH
        BEGIN BRANCH XLXN_2022(31:0)
            WIRE 2832 2544 3136 2544
        END BRANCH
        BEGIN BRANCH XLXN_2023(31:0)
            WIRE 2832 2704 2992 2704
            WIRE 2992 2608 2992 2704
            WIRE 2992 2608 3136 2608
        END BRANCH
        BEGIN INSTANCE XLXI_650 3136 2768 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_651 2240 2736 R0
        END INSTANCE
        BEGIN BRANCH clk
            WIRE 2080 2384 2240 2384
            BEGIN DISPLAY 2080 2384 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2080 2448 2240 2448
            BEGIN DISPLAY 2080 2448 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 3040 2224 3056 2224
            WIRE 3056 2224 3136 2224
            BEGIN DISPLAY 3056 2224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3040 2288 3056 2288
            WIRE 3056 2288 3136 2288
            BEGIN DISPLAY 3056 2288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 2144 2704 2176 2704
            WIRE 2176 2704 2240 2704
            BEGIN DISPLAY 2176 2704 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 3024 2736 3040 2736
            WIRE 3040 2736 3136 2736
            BEGIN DISPLAY 3040 2736 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_pos
            WIRE 3024 2672 3056 2672
            WIRE 3056 2672 3136 2672
            BEGIN DISPLAY 3056 2672 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_start
            WIRE 3024 2416 3040 2416
            WIRE 3040 2416 3136 2416
            BEGIN DISPLAY 3040 2416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out0(3)
            WIRE 3024 2352 3056 2352
            WIRE 3056 2352 3136 2352
            BEGIN DISPLAY 3056 2352 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_time
            WIRE 2144 2512 2176 2512
            WIRE 2176 2512 2240 2512
            BEGIN DISPLAY 2176 2512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_pos
            WIRE 2144 2576 2160 2576
            WIRE 2160 2576 2240 2576
            BEGIN DISPLAY 2160 2576 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_vel
            WIRE 2144 2640 2176 2640
            WIRE 2176 2640 2240 2640
            BEGIN DISPLAY 2176 2640 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_pos
            WIRE 1200 1232 1360 1232
            BEGIN DISPLAY 1360 1232 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_set_target_vel
            WIRE 1200 1296 1360 1296
            BEGIN DISPLAY 1360 1296 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_start
            WIRE 1200 1360 1424 1360
            BEGIN DISPLAY 1424 1360 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_time
            WIRE 1200 1488 1360 1488
            BEGIN DISPLAY 1360 1488 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_pos
            WIRE 1200 1552 1360 1552
            BEGIN DISPLAY 1360 1552 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_target_vel
            WIRE 1200 1616 1360 1616
            BEGIN DISPLAY 1360 1616 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_start
            WIRE 1200 1680 1424 1680
            BEGIN DISPLAY 1424 1680 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_pos
            WIRE 1200 1744 1360 1744
            BEGIN DISPLAY 1360 1744 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_time
            WIRE 1200 1808 1360 1808
            BEGIN DISPLAY 1360 1808 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_pos
            WIRE 1200 1872 1360 1872
            BEGIN DISPLAY 1360 1872 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_set_target_vel
            WIRE 1200 1936 1360 1936
            BEGIN DISPLAY 1360 1936 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_set_pos
            WIRE 1200 1424 1360 1424
            BEGIN DISPLAY 1360 1424 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_start
            WIRE 1200 720 1408 720
            BEGIN DISPLAY 1408 720 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_end_pos(31:0)
            WIRE 3680 192 3792 192
            WIRE 3792 192 3808 192
            BEGIN DISPLAY 3792 192 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_end_vel(31:0)
            WIRE 3680 256 3792 256
            WIRE 3792 256 3808 256
            BEGIN DISPLAY 3792 256 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_end_pos(31:0)
            WIRE 3696 864 3808 864
            WIRE 3808 864 3824 864
            BEGIN DISPLAY 3808 864 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_end_vel(31:0)
            WIRE 3696 928 3808 928
            WIRE 3808 928 3824 928
            BEGIN DISPLAY 3808 928 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_end_pos(31:0)
            WIRE 544 784 672 784
            BEGIN DISPLAY 544 784 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_end_vel(31:0)
            WIRE 544 848 672 848
            BEGIN DISPLAY 544 848 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_cur_vel(31:0)
            WIRE 544 976 672 976
            BEGIN DISPLAY 544 976 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_end_pos(31:0)
            WIRE 544 1040 672 1040
            BEGIN DISPLAY 544 1040 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_end_vel(31:0)
            WIRE 544 1104 672 1104
            BEGIN DISPLAY 544 1104 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_cur_pos(31:0)
            WIRE 496 912 672 912
            BEGIN DISPLAY 496 912 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_cur_vel(31:0)
            WIRE 544 1232 672 1232
            BEGIN DISPLAY 544 1232 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_end_pos(31:0)
            WIRE 544 1296 672 1296
            BEGIN DISPLAY 544 1296 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_end_vel(31:0)
            WIRE 544 1360 672 1360
            BEGIN DISPLAY 544 1360 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_cur_pos(31:0)
            WIRE 496 1168 672 1168
            BEGIN DISPLAY 496 1168 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_cur_vel(31:0)
            WIRE 544 1488 672 1488
            BEGIN DISPLAY 544 1488 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_end_pos(31:0)
            WIRE 544 1552 672 1552
            BEGIN DISPLAY 544 1552 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_end_vel(31:0)
            WIRE 544 1616 672 1616
            BEGIN DISPLAY 544 1616 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_cur_pos(31:0)
            WIRE 496 1424 672 1424
            BEGIN DISPLAY 496 1424 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_unlock
            WIRE 1200 2000 1360 2000
            BEGIN DISPLAY 1360 2000 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_set_timeout
            WIRE 1200 2064 1360 2064
            BEGIN DISPLAY 1360 2064 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_endstop_pos(31:0)
            WIRE 544 1680 672 1680
            BEGIN DISPLAY 544 1680 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_endstop_bounce(31:0)
            WIRE 544 1744 672 1744
            BEGIN DISPLAY 544 1744 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_endstop_pos(31:0)
            WIRE 544 1808 672 1808
            BEGIN DISPLAY 544 1808 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_endstop_bounce(31:0)
            WIRE 544 1872 672 1872
            BEGIN DISPLAY 544 1872 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_endstop_pos(31:0)
            WIRE 544 1936 672 1936
            BEGIN DISPLAY 544 1936 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_endstop_bounce(31:0)
            WIRE 544 2000 672 2000
            BEGIN DISPLAY 544 2000 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH endstop_cycles(31:0)
            WIRE 544 2064 672 2064
            BEGIN DISPLAY 544 2064 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(7:0)
            WIRE 576 2832 624 2832
            WIRE 624 2832 672 2832
            BEGIN DISPLAY 624 2832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out1(7:0)
            WIRE 1200 2832 1296 2832
            WIRE 1296 2832 1344 2832
            BEGIN DISPLAY 1296 2832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_657 1872 2976 R0
        INSTANCE XLXI_658 1872 3120 R0
        BEGIN BRANCH enable_xyz
            WIRE 2096 2944 2240 2944
        END BRANCH
        BEGIN BRANCH enable_a
            WIRE 2096 3088 2240 3088
        END BRANCH
        BEGIN BRANCH misc_out1(0)
            WIRE 1808 2944 1872 2944
            BEGIN DISPLAY 1808 2944 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out1(1)
            WIRE 1808 3088 1872 3088
            BEGIN DISPLAY 1808 3088 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        IOMARKER 2240 2944 enable_xyz R0 28
        IOMARKER 2240 3088 enable_a R0 28
        BEGIN INSTANCE XLXI_656 5424 2352 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_655 5392 1696 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_652 5392 992 R0
        END INSTANCE
        IOMARKER 3856 2544 step_a R0 28
        IOMARKER 3840 1856 step_z R0 28
        IOMARKER 3824 1184 step_y R0 28
        IOMARKER 3808 512 step_x R0 28
        BEGIN BRANCH endstop_cycles(23:16)
            WIRE 5920 2320 6032 2320
            BEGIN DISPLAY 6032 2320 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_endstop_bounce(31:0)
            WIRE 5920 2224 6032 2224
            BEGIN DISPLAY 6032 2224 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_endstop_pos(31:0)
            WIRE 5920 2128 6032 2128
            BEGIN DISPLAY 6032 2128 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(5)
            WIRE 5920 2032 6032 2032
            BEGIN DISPLAY 6032 2032 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(4)
            WIRE 5920 1936 6032 1936
            BEGIN DISPLAY 6032 1936 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 5312 2320 5424 2320
            BEGIN DISPLAY 5312 2320 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_cur_pos(31:0)
            WIRE 5312 2256 5424 2256
            BEGIN DISPLAY 5312 2256 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_set_timeout
            WIRE 5312 2192 5424 2192
            BEGIN DISPLAY 5312 2192 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_unlock
            WIRE 5312 2128 5424 2128
            BEGIN DISPLAY 5312 2128 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 5312 2000 5424 2000
            BEGIN DISPLAY 5312 2000 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 5312 1936 5424 1936
            BEGIN DISPLAY 5312 1936 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH endstop_cycles(15:8)
            WIRE 5888 1664 6000 1664
            BEGIN DISPLAY 6000 1664 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_endstop_bounce(31:0)
            WIRE 5888 1568 6000 1568
            BEGIN DISPLAY 6000 1568 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_endstop_pos(31:0)
            WIRE 5888 1472 6000 1472
            BEGIN DISPLAY 6000 1472 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(3)
            WIRE 5888 1376 6000 1376
            BEGIN DISPLAY 6000 1376 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(2)
            WIRE 5888 1280 6000 1280
            BEGIN DISPLAY 6000 1280 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 5280 1664 5392 1664
            BEGIN DISPLAY 5280 1664 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH y_cur_pos(31:0)
            WIRE 5280 1600 5392 1600
            BEGIN DISPLAY 5280 1600 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_unlock
            WIRE 5280 1472 5392 1472
            BEGIN DISPLAY 5280 1472 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 5280 1344 5392 1344
            BEGIN DISPLAY 5280 1344 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 5280 1280 5392 1280
            BEGIN DISPLAY 5280 1280 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH endstop_cycles(7:0)
            WIRE 5888 960 6000 960
            BEGIN DISPLAY 6000 960 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_endstop_bounce(31:0)
            WIRE 5888 864 6000 864
            BEGIN DISPLAY 6000 864 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_endstop_pos(31:0)
            WIRE 5888 768 6000 768
            BEGIN DISPLAY 6000 768 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(1)
            WIRE 5888 672 6000 672
            BEGIN DISPLAY 6000 672 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in1(0)
            WIRE 5888 576 6000 576
            BEGIN DISPLAY 6000 576 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH data_in(31:0)
            WIRE 5280 960 5392 960
            BEGIN DISPLAY 5280 960 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_cur_pos(31:0)
            WIRE 5280 896 5392 896
            BEGIN DISPLAY 5280 896 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_unlock
            WIRE 5280 768 5392 768
            BEGIN DISPLAY 5280 768 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 5280 640 5392 640
            BEGIN DISPLAY 5280 640 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 5280 576 5392 576
            BEGIN DISPLAY 5280 576 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH debounce_set_timeout
            WIRE 5280 1536 5392 1536
            BEGIN DISPLAY 5280 1536 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_end_vel(31:0)
            WIRE 3712 1600 3824 1600
            WIRE 3824 1600 3840 1600
            BEGIN DISPLAY 3824 1600 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_end_pos(31:0)
            WIRE 3712 1536 3824 1536
            WIRE 3824 1536 3840 1536
            BEGIN DISPLAY 3824 1536 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_end_pos(31:0)
            WIRE 3728 2224 3840 2224
            WIRE 3840 2224 3856 2224
            BEGIN DISPLAY 3840 2224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_end_vel(31:0)
            WIRE 3728 2288 3840 2288
            WIRE 3840 2288 3856 2288
            BEGIN DISPLAY 3840 2288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_cur_vel(31:0)
            WIRE 3728 2608 3840 2608
            WIRE 3840 2608 3856 2608
            BEGIN DISPLAY 3840 2608 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH a_cur_pos(31:0)
            WIRE 3728 2672 3840 2672
            WIRE 3840 2672 3856 2672
            BEGIN DISPLAY 3840 2672 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in0(3)
            WIRE 3728 2352 3792 2352
            WIRE 3792 2352 3856 2352
            BEGIN DISPLAY 3792 2352 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH step_a
            WIRE 3728 2544 3856 2544
        END BRANCH
        BEGIN BRANCH z_cur_vel(31:0)
            WIRE 3712 1920 3824 1920
            WIRE 3824 1920 3840 1920
            BEGIN DISPLAY 3824 1920 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH z_cur_pos(31:0)
            WIRE 3712 1984 3824 1984
            WIRE 3824 1984 3840 1984
            BEGIN DISPLAY 3824 1984 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_in0(2)
            WIRE 3712 1664 3776 1664
            WIRE 3776 1664 3840 1664
            BEGIN DISPLAY 3776 1664 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH step_z
            WIRE 3712 1856 3840 1856
        END BRANCH
        BEGIN BRANCH debounce_set_timeout
            WIRE 5280 832 5392 832
            BEGIN DISPLAY 5280 832 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH x_endstop
            WIRE 4800 672 4864 672
        END BRANCH
        BEGIN BRANCH XLXN_2135
            WIRE 5120 704 5392 704
        END BRANCH
        INSTANCE XLXI_661 4864 800 R0
        BEGIN BRANCH y_endstop
            WIRE 4816 1376 4880 1376
        END BRANCH
        INSTANCE XLXI_660 4880 1504 R0
        BEGIN BRANCH XLXN_2138
            WIRE 5136 1408 5392 1408
        END BRANCH
        BEGIN BRANCH XLXN_2140
            WIRE 5152 2064 5424 2064
        END BRANCH
        BEGIN BRANCH z_endstop
            WIRE 4800 2032 4896 2032
        END BRANCH
        INSTANCE XLXI_659 4896 2160 R0
        IOMARKER 4800 2032 z_endstop R180 28
        IOMARKER 4816 1376 y_endstop R180 28
        IOMARKER 4800 672 x_endstop R180 28
        BEGIN BRANCH dir_a
            WIRE 4320 2448 4336 2448
            WIRE 4336 2448 4480 2448
        END BRANCH
        BEGIN BRANCH dir_z
            WIRE 4352 1760 4432 1760
        END BRANCH
        BEGIN BRANCH dir_x
            WIRE 4304 416 4400 416
        END BRANCH
        BEGIN BRANCH XLXN_2149
            WIRE 3680 448 4048 448
        END BRANCH
        BEGIN BRANCH dir_y
            WIRE 4320 1088 4368 1088
        END BRANCH
        BEGIN BRANCH XLXN_2154
            WIRE 3712 1792 4096 1792
        END BRANCH
        BEGIN BRANCH XLXN_2155
            WIRE 3728 2480 4064 2480
        END BRANCH
        INSTANCE XLXI_665 4064 2544 R0
        IOMARKER 4480 2448 dir_a R0 28
        IOMARKER 4368 1088 dir_y R0 28
        IOMARKER 4400 416 dir_x R0 28
        IOMARKER 4432 1760 dir_z R0 28
        INSTANCE XLXI_664 4096 1856 R0
        BEGIN BRANCH XLXN_2150
            WIRE 3696 1120 4064 1120
        END BRANCH
        INSTANCE XLXI_663 4064 1184 R0
        INSTANCE XLXI_662 4048 512 R0
        BEGIN BRANCH misc_out2(0)
            WIRE 3952 384 4048 384
            BEGIN DISPLAY 3952 384 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(1)
            WIRE 3968 1056 4064 1056
            BEGIN DISPLAY 3968 1056 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(2)
            WIRE 4000 1728 4096 1728
            BEGIN DISPLAY 4000 1728 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(3)
            WIRE 3952 2416 4064 2416
            BEGIN DISPLAY 3952 2416 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(6)
            WIRE 4784 2096 4896 2096
            BEGIN DISPLAY 4784 2096 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(5)
            WIRE 4784 1440 4880 1440
            BEGIN DISPLAY 4784 1440 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(4)
            WIRE 4768 736 4864 736
            BEGIN DISPLAY 4768 736 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH misc_out2(7:0)
            WIRE 1200 2896 1248 2896
            WIRE 1248 2896 1344 2896
            BEGIN DISPLAY 1248 2896 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
    END SHEET
END SCHEMATIC
