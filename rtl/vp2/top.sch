VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "virtex2p"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL clk
        SIGNAL ram_we
        SIGNAL ram_data(7:0)
        SIGNAL clk_cpu
        SIGNAL cpu_do(7:0)
        SIGNAL rom_data(7:0)
        SIGNAL reset
        SIGNAL uart_data(7:0)
        SIGNAL uart_rd
        SIGNAL uart_wr
        SIGNAL spi_data(7:0)
        SIGNAL spi_ack
        SIGNAL spi_we
        SIGNAL spi_stb
        SIGNAL locked
        SIGNAL XLXN_2
        SIGNAL cnt(7:0)
        SIGNAL XLXN_4
        SIGNAL XLXN_5
        SIGNAL XLXN_6
        SIGNAL cnt1(15:0)
        SIGNAL nreset
        SIGNAL SYSRESET
        SIGNAL XLXN_1188
        SIGNAL XLXN_1251
        SIGNAL led1
        SIGNAL cnt(7)
        SIGNAL led2
        SIGNAL led3
        SIGNAL led4
        SIGNAL led5
        SIGNAL beep
        SIGNAL cnt1(15)
        SIGNAL flashspi_do
        SIGNAL flashspi_ss
        SIGNAL cpu_addr(15:0)
        SIGNAL XLXN_433
        SIGNAL XLXN_222
        SIGNAL cpu_addr_reg(15:0)
        SIGNAL cpu_do_reg(7:0)
        SIGNAL cpu_di(7:0)
        SIGNAL cpu_enable
        SIGNAL cpu_addr(7:0)
        SIGNAL maxspi_data(7:0)
        SIGNAL maxspi_wr
        SIGNAL maxspi_rd
        SIGNAL gpin0
        SIGNAL gpin10
        SIGNAL gpin9
        SIGNAL gpin8
        SIGNAL gpin7
        SIGNAL gpin6
        SIGNAL gpin1
        SIGNAL gpin11
        SIGNAL gpin12
        SIGNAL gpin13
        SIGNAL gpin14
        SIGNAL gpin15
        SIGNAL gpin16
        SIGNAL gpin17
        SIGNAL gpin18
        SIGNAL gpin19
        SIGNAL gpin20
        SIGNAL gpin21
        SIGNAL gpin22
        SIGNAL gpin23
        SIGNAL gpin24
        SIGNAL gpin25
        SIGNAL gpin26
        SIGNAL gpin27
        SIGNAL gpin28
        SIGNAL gpin29
        SIGNAL gpin30
        SIGNAL gpin31
        SIGNAL gpin2
        SIGNAL gpin3
        SIGNAL gpin4
        SIGNAL gpin5
        SIGNAL gpout1
        SIGNAL gpout2
        SIGNAL gpout3
        SIGNAL gpout4
        SIGNAL gpout5
        SIGNAL gpout6
        SIGNAL gpout7
        SIGNAL gpout9
        SIGNAL gpout10
        SIGNAL gpout11
        SIGNAL gpout12
        SIGNAL gpout13
        SIGNAL gpout14
        SIGNAL gpout15
        SIGNAL gpout16
        SIGNAL gpout17
        SIGNAL gpout18
        SIGNAL gpout19
        SIGNAL gpout20
        SIGNAL gpout21
        SIGNAL gpout22
        SIGNAL gpout23
        SIGNAL gpout24
        SIGNAL gpout25
        SIGNAL gpout26
        SIGNAL gpout27
        SIGNAL gpout28
        SIGNAL gpout29
        SIGNAL gpout30
        SIGNAL gpout31
        SIGNAL gpout8
        SIGNAL gpout0
        SIGNAL gpio0
        SIGNAL gpio1
        SIGNAL gpio2
        SIGNAL gpio3
        SIGNAL gpio4
        SIGNAL gpio5
        SIGNAL gpio6
        SIGNAL gpio7
        SIGNAL gpio8
        SIGNAL gpio9
        SIGNAL gpio10
        SIGNAL gpio11
        SIGNAL gpio12
        SIGNAL gpio13
        SIGNAL gpio14
        SIGNAL gpio15
        SIGNAL gpio16
        SIGNAL gpio17
        SIGNAL gpio18
        SIGNAL gpio19
        SIGNAL gpio20
        SIGNAL gpio21
        SIGNAL gpio22
        SIGNAL gpio23
        SIGNAL gpio24
        SIGNAL gpio25
        SIGNAL gpio26
        SIGNAL gpio27
        SIGNAL gpio28
        SIGNAL gpio29
        SIGNAL gpio30
        SIGNAL gpio31
        SIGNAL U38_OE
        SIGNAL U38_DIR
        SIGNAL XLXN_1933(31:0)
        SIGNAL XLXN_1934(31:0)
        SIGNAL XLXN_1935(31:0)
        SIGNAL XLXN_1936(31:0)
        SIGNAL XLXN_1946
        SIGNAL gpio_data(7:0)
        SIGNAL gpio_wr
        SIGNAL gpio_rd
        SIGNAL XLXN_434
        SIGNAL steppers_wr
        SIGNAL steppers_rd
        SIGNAL steppers_data(7:0)
        SIGNAL cpu_addr(14:0)
        SIGNAL cpu_addr(12:0)
        SIGNAL SD_DI
        SIGNAL SD_CLK
        SIGNAL SD_DO
        SIGNAL SD_CS
        SIGNAL XLXN_1299(7:0)
        SIGNAL flashspi_clk
        SIGNAL flashspi_di
        SIGNAL XLXN_1511
        SIGNAL XLXN_1513(7:0)
        SIGNAL XLXN_1514
        SIGNAL XLXN_1512
        SIGNAL XLXN_1516
        SIGNAL XLXN_1517(7:0)
        SIGNAL osram_load
        SIGNAL osram_clk
        SIGNAL osram_data
        SIGNAL dir_y
        SIGNAL step_y
        SIGNAL dir_z
        SIGNAL step_z
        SIGNAL dir_a
        SIGNAL step_a
        SIGNAL step_x
        SIGNAL dir_x
        SIGNAL enable_a
        SIGNAL enable_xyz
        SIGNAL XLXN_2035
        SIGNAL XLXN_2036
        SIGNAL XLXN_2037
        SIGNAL XLXN_2038
        SIGNAL XLXN_2039
        SIGNAL XLXN_2040
        SIGNAL XLXN_2041
        SIGNAL XLXN_2042
        SIGNAL XLXN_2043
        SIGNAL XLXN_2044
        SIGNAL z_endstop
        SIGNAL y_endstop
        SIGNAL x_endstop
        SIGNAL XLXN_2184
        SIGNAL UART_TX
        SIGNAL UART_RX
        SIGNAL RS485_RX
        SIGNAL XLXN_2186
        SIGNAL XLXN_2188
        SIGNAL XLXN_2189
        SIGNAL RS485_TX
        SIGNAL XLXN_2191
        SIGNAL RS485_DE
        SIGNAL XLXN_2194
        PORT Input clk
        PORT Input SYSRESET
        PORT Output led1
        PORT Output led2
        PORT Output led3
        PORT Output led4
        PORT Output led5
        PORT Output beep
        PORT Input flashspi_do
        PORT Output flashspi_ss
        PORT Input gpin0
        PORT Input gpin10
        PORT Input gpin9
        PORT Input gpin8
        PORT Input gpin7
        PORT Input gpin6
        PORT Input gpin1
        PORT Input gpin11
        PORT Input gpin12
        PORT Input gpin13
        PORT Input gpin14
        PORT Input gpin15
        PORT Input gpin16
        PORT Input gpin17
        PORT Input gpin18
        PORT Input gpin19
        PORT Input gpin20
        PORT Input gpin21
        PORT Input gpin22
        PORT Input gpin23
        PORT Input gpin24
        PORT Input gpin25
        PORT Input gpin26
        PORT Input gpin27
        PORT Input gpin28
        PORT Input gpin29
        PORT Input gpin30
        PORT Input gpin31
        PORT Input gpin2
        PORT Input gpin3
        PORT Input gpin4
        PORT Input gpin5
        PORT Output gpout1
        PORT Output gpout2
        PORT Output gpout3
        PORT Output gpout4
        PORT Output gpout5
        PORT Output gpout6
        PORT Output gpout7
        PORT Output gpout9
        PORT Output gpout10
        PORT Output gpout11
        PORT Output gpout12
        PORT Output gpout13
        PORT Output gpout14
        PORT Output gpout15
        PORT Output gpout16
        PORT Output gpout17
        PORT Output gpout18
        PORT Output gpout19
        PORT Output gpout20
        PORT Output gpout21
        PORT Output gpout22
        PORT Output gpout23
        PORT Output gpout24
        PORT Output gpout25
        PORT Output gpout26
        PORT Output gpout27
        PORT Output gpout28
        PORT Output gpout29
        PORT Output gpout30
        PORT Output gpout31
        PORT Output gpout8
        PORT Output gpout0
        PORT BiDirectional gpio0
        PORT BiDirectional gpio1
        PORT BiDirectional gpio2
        PORT BiDirectional gpio3
        PORT BiDirectional gpio4
        PORT BiDirectional gpio5
        PORT BiDirectional gpio6
        PORT BiDirectional gpio7
        PORT BiDirectional gpio8
        PORT BiDirectional gpio9
        PORT BiDirectional gpio10
        PORT BiDirectional gpio11
        PORT BiDirectional gpio12
        PORT BiDirectional gpio13
        PORT BiDirectional gpio14
        PORT BiDirectional gpio15
        PORT BiDirectional gpio16
        PORT BiDirectional gpio17
        PORT BiDirectional gpio18
        PORT BiDirectional gpio19
        PORT BiDirectional gpio20
        PORT BiDirectional gpio21
        PORT BiDirectional gpio22
        PORT BiDirectional gpio23
        PORT BiDirectional gpio24
        PORT BiDirectional gpio25
        PORT BiDirectional gpio26
        PORT BiDirectional gpio27
        PORT BiDirectional gpio28
        PORT BiDirectional gpio29
        PORT BiDirectional gpio30
        PORT BiDirectional gpio31
        PORT Output U38_OE
        PORT Output U38_DIR
        PORT Input SD_DI
        PORT Output SD_CLK
        PORT Output SD_DO
        PORT Output SD_CS
        PORT Output flashspi_clk
        PORT Output flashspi_di
        PORT Output osram_load
        PORT Output osram_clk
        PORT Output osram_data
        PORT Output dir_y
        PORT Output step_y
        PORT Output dir_z
        PORT Output step_z
        PORT Output dir_a
        PORT Output step_a
        PORT Output step_x
        PORT Output dir_x
        PORT Output enable_a
        PORT Output enable_xyz
        PORT Input z_endstop
        PORT Input y_endstop
        PORT Input x_endstop
        PORT Output UART_TX
        PORT Input UART_RX
        PORT Input RS485_RX
        PORT Output RS485_TX
        PORT Output RS485_DE
        BEGIN BLOCKDEF cb16ce
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 384 -192 320 -192 
            RECTANGLE N 320 -268 384 -244 
            LINE N 384 -256 320 -256 
            LINE N 0 -192 64 -192 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 384 -128 320 -128 
            RECTANGLE N 64 -320 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF cb8ce
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 384 -128 320 -128 
            RECTANGLE N 320 -268 384 -244 
            LINE N 384 -256 320 -256 
            LINE N 0 -192 64 -192 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 0 -128 64 -128 
            LINE N 0 -32 64 -32 
            LINE N 384 -192 320 -192 
            RECTANGLE N 64 -320 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF vcc
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 64 -32 64 -64 
            LINE N 64 0 64 -32 
            LINE N 96 -64 32 -64 
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
        BEGIN BLOCKDEF buf
            TIMESTAMP 2000 1 1 10 10 10
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
            LINE N 64 0 128 -32 
            LINE N 128 -32 64 -64 
            LINE N 64 -64 64 0 
        END BLOCKDEF
        BEGIN BLOCKDEF cpu_rom
            TIMESTAMP 2008 11 17 12 23 46
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 320 -108 384 -84 
            LINE N 320 -96 384 -96 
        END BLOCKDEF
        BEGIN BLOCKDEF cpu_ram
            TIMESTAMP 2008 11 17 12 23 32
            RECTANGLE N 64 -256 320 0 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 320 -236 384 -212 
            LINE N 320 -224 384 -224 
        END BLOCKDEF
        BEGIN BLOCKDEF cpu6502_sync
            TIMESTAMP 2008 11 17 12 23 40
            RECTANGLE N 64 -896 320 0 
            LINE N 64 -864 0 -864 
            LINE N 64 -736 0 -736 
            LINE N 64 -608 0 -608 
            LINE N 64 -480 0 -480 
            LINE N 64 -352 0 -352 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            LINE N 320 -864 384 -864 
            LINE N 320 -800 384 -800 
            LINE N 320 -736 384 -736 
            LINE N 320 -672 384 -672 
            RECTANGLE N 320 -620 384 -596 
            LINE N 320 -608 384 -608 
            RECTANGLE N 320 -556 384 -532 
            LINE N 320 -544 384 -544 
            RECTANGLE N 320 -492 384 -468 
            LINE N 320 -480 384 -480 
            RECTANGLE N 320 -428 384 -404 
            LINE N 320 -416 384 -416 
            RECTANGLE N 320 -364 384 -340 
            LINE N 320 -352 384 -352 
            RECTANGLE N 320 -300 384 -276 
            LINE N 320 -288 384 -288 
            RECTANGLE N 320 -236 384 -212 
            LINE N 320 -224 384 -224 
            RECTANGLE N 320 -172 384 -148 
            LINE N 320 -160 384 -160 
            RECTANGLE N 320 -108 384 -84 
            LINE N 320 -96 384 -96 
            RECTANGLE N 320 -44 384 -20 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF spiMaster
            TIMESTAMP 2008 12 7 20 53 36
            RECTANGLE N 64 -512 384 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 384 -480 448 -480 
            LINE N 384 -368 448 -368 
            LINE N 384 -256 448 -256 
            LINE N 384 -144 448 -144 
            RECTANGLE N 384 -44 448 -20 
            LINE N 384 -32 448 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF cb4ce
            TIMESTAMP 2000 1 1 10 10 10
            RECTANGLE N 64 -512 320 -64 
            LINE N 0 -32 64 -32 
            LINE N 0 -128 64 -128 
            LINE N 384 -256 320 -256 
            LINE N 384 -320 320 -320 
            LINE N 384 -384 320 -384 
            LINE N 384 -448 320 -448 
            LINE N 80 -128 64 -144 
            LINE N 64 -112 80 -128 
            LINE N 384 -128 320 -128 
            LINE N 192 -32 64 -32 
            LINE N 192 -64 192 -32 
            LINE N 0 -192 64 -192 
            LINE N 384 -192 320 -192 
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
        BEGIN BLOCKDEF clockgen
            TIMESTAMP 2009 2 27 21 58 30
            LINE N 64 160 0 160 
            LINE N 64 -32 0 -32 
            LINE N 416 -224 480 -224 
            LINE N 416 -160 480 -160 
            LINE N 416 -96 480 -96 
            LINE N 416 -32 480 -32 
            RECTANGLE N 64 -256 416 192 
        END BLOCKDEF
        BEGIN BLOCKDEF readWriteSPIWireData
            TIMESTAMP 2009 3 17 22 18 53
            RECTANGLE N 64 -512 400 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 400 -480 464 -480 
            RECTANGLE N 400 -428 464 -404 
            LINE N 400 -416 464 -416 
            LINE N 400 -288 464 -288 
            LINE N 400 -224 464 -224 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            LINE N 64 -96 0 -96 
            LINE N 400 -96 464 -96 
            LINE N 400 -32 464 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 400 -160 64 -160 
            LINE N 64 -352 400 -352 
        END BLOCKDEF
        BEGIN BLOCKDEF spi_master_ctrl
            TIMESTAMP 2009 3 22 14 55 40
            LINE N 64 -608 0 -608 
            LINE N 64 -544 0 -544 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            RECTANGLE N 0 -364 64 -340 
            LINE N 64 -352 0 -352 
            RECTANGLE N 0 -300 64 -276 
            LINE N 64 -288 0 -288 
            LINE N 384 -32 448 -32 
            RECTANGLE N 384 -108 448 -84 
            LINE N 384 -96 448 -96 
            RECTANGLE N 384 -620 448 -596 
            LINE N 384 -608 448 -608 
            LINE N 64 -256 384 -256 
            LINE N 64 -128 384 -128 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            LINE N 64 -224 0 -224 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 384 -544 448 -544 
            LINE N 384 -480 448 -480 
            LINE N 384 -416 448 -416 
            LINE N 384 -352 448 -352 
            RECTANGLE N 64 -640 384 0 
            RECTANGLE N 384 -300 448 -276 
            LINE N 384 -288 448 -288 
        END BLOCKDEF
        BEGIN BLOCKDEF gpin_buf
            TIMESTAMP 2009 4 26 20 5 31
            RECTANGLE N 64 -1024 320 24 
            RECTANGLE N 320 -1004 384 -980 
            LINE N 320 -992 384 -992 
            LINE N 64 -864 0 -864 
            LINE N 64 -832 0 -832 
            LINE N 64 -800 0 -800 
            LINE N 64 -768 0 -768 
            LINE N 64 -736 0 -736 
            LINE N 64 -704 0 -704 
            LINE N 64 -672 0 -672 
            LINE N 64 -640 0 -640 
            LINE N 64 -608 0 -608 
            LINE N 64 -576 0 -576 
            LINE N 64 -544 0 -544 
            LINE N 64 -512 0 -512 
            LINE N 64 -480 0 -480 
            LINE N 64 -448 0 -448 
            LINE N 64 -416 0 -416 
            LINE N 64 -992 0 -992 
            LINE N 64 -960 0 -960 
            LINE N 64 -928 0 -928 
            LINE N 64 -896 0 -896 
            LINE N 64 -352 0 -352 
            LINE N 64 -320 0 -320 
            LINE N 64 -288 0 -288 
            LINE N 64 -256 0 -256 
            LINE N 64 -224 0 -224 
            LINE N 64 -192 0 -192 
            LINE N 64 -160 0 -160 
            LINE N 64 -128 0 -128 
            LINE N 64 -96 0 -96 
            LINE N 64 -64 0 -64 
            LINE N 64 -32 0 -32 
            LINE N 64 0 0 0 
            LINE N 64 -384 0 -384 
        END BLOCKDEF
        BEGIN BLOCKDEF gpout_buf
            TIMESTAMP 2009 4 26 20 22 48
            RECTANGLE N 64 -1056 320 0 
            LINE N 320 -288 384 -288 
            LINE N 320 -256 384 -256 
            LINE N 320 -224 384 -224 
            LINE N 320 -192 384 -192 
            LINE N 320 -160 384 -160 
            LINE N 320 -128 384 -128 
            LINE N 320 -96 384 -96 
            LINE N 320 -64 384 -64 
            LINE N 320 -32 384 -32 
            LINE N 320 -672 384 -672 
            LINE N 320 -640 384 -640 
            LINE N 320 -608 384 -608 
            LINE N 320 -576 384 -576 
            LINE N 320 -544 384 -544 
            LINE N 320 -512 384 -512 
            LINE N 320 -480 384 -480 
            LINE N 320 -448 384 -448 
            LINE N 320 -416 384 -416 
            LINE N 320 -384 384 -384 
            LINE N 320 -352 384 -352 
            LINE N 320 -320 384 -320 
            RECTANGLE N 0 -1036 64 -1012 
            LINE N 64 -1024 0 -1024 
            LINE N 320 -1024 384 -1024 
            LINE N 320 -992 384 -992 
            LINE N 320 -960 384 -960 
            LINE N 320 -928 384 -928 
            LINE N 320 -896 384 -896 
            LINE N 320 -864 384 -864 
            LINE N 320 -832 384 -832 
            LINE N 320 -800 384 -800 
            LINE N 320 -768 384 -768 
            LINE N 320 -736 384 -736 
            LINE N 320 -704 384 -704 
        END BLOCKDEF
        BEGIN BLOCKDEF gpio_buf
            TIMESTAMP 2009 4 26 21 2 45
            LINE N 400 -272 464 -272 
            RECTANGLE N 64 -496 400 740 
            LINE N 400 -240 464 -240 
            LINE N 400 -208 464 -208 
            LINE N 400 -176 464 -176 
            LINE N 400 -144 464 -144 
            LINE N 400 -112 464 -112 
            LINE N 400 -80 464 -80 
            LINE N 400 -48 464 -48 
            LINE N 400 -16 464 -16 
            LINE N 400 16 464 16 
            LINE N 400 48 464 48 
            LINE N 400 80 464 80 
            LINE N 400 112 464 112 
            LINE N 400 144 464 144 
            LINE N 400 176 464 176 
            LINE N 400 208 464 208 
            LINE N 400 240 464 240 
            LINE N 400 272 464 272 
            LINE N 400 304 464 304 
            LINE N 400 336 464 336 
            LINE N 400 368 464 368 
            LINE N 400 400 464 400 
            LINE N 400 432 464 432 
            LINE N 400 464 464 464 
            LINE N 400 496 464 496 
            LINE N 400 528 464 528 
            LINE N 400 560 464 560 
            LINE N 400 592 464 592 
            LINE N 400 624 464 624 
            LINE N 400 656 464 656 
            LINE N 400 688 464 688 
            LINE N 400 720 464 720 
            LINE N 64 -464 0 -464 
            LINE N 64 -400 0 -400 
            RECTANGLE N 0 -348 64 -324 
            LINE N 64 -336 0 -336 
            LINE N 64 -272 0 -272 
            RECTANGLE N 400 -476 464 -452 
            LINE N 400 -464 464 -464 
            LINE N 400 -400 464 -400 
            LINE N 400 -336 464 -336 
        END BLOCKDEF
        BEGIN BLOCKDEF gpio_ctrl
            TIMESTAMP 2009 4 27 20 25 48
            RECTANGLE N 64 -512 400 0 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            LINE N 400 -480 464 -480 
            RECTANGLE N 400 -348 464 -324 
            LINE N 400 -336 464 -336 
            RECTANGLE N 400 -204 464 -180 
            LINE N 400 -192 464 -192 
            RECTANGLE N 400 -60 464 -36 
            LINE N 400 -48 464 -48 
        END BLOCKDEF
        BEGIN BLOCKDEF steppers_module
            TIMESTAMP 2012 1 29 0 20 4
            LINE N 64 -352 0 -352 
            LINE N 64 -288 0 -288 
            LINE N 64 -224 0 -224 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -44 64 -20 
            LINE N 64 -32 0 -32 
            RECTANGLE N 464 -364 528 -340 
            LINE N 464 -352 528 -352 
            RECTANGLE N 64 -384 464 380 
            LINE N 64 96 0 96 
            LINE N 64 160 0 160 
            LINE N 64 224 0 224 
            LINE N 464 -224 528 -224 
            LINE N 464 -96 528 -96 
            LINE N 464 -32 528 -32 
            LINE N 464 32 528 32 
            LINE N 464 96 528 96 
            LINE N 464 160 528 160 
            LINE N 464 224 528 224 
            LINE N 464 -160 528 -160 
            LINE N 464 288 528 288 
            LINE N 464 352 528 352 
        END BLOCKDEF
        BEGIN BLOCKDEF datamux
            TIMESTAMP 2012 2 7 9 17 20
            RECTANGLE N 64 -1728 432 0 
            LINE N 64 -1696 0 -1696 
            LINE N 64 -1632 0 -1632 
            LINE N 64 -1568 0 -1568 
            LINE N 64 -1504 0 -1504 
            RECTANGLE N 0 -1452 64 -1428 
            LINE N 64 -1440 0 -1440 
            RECTANGLE N 0 -1388 64 -1364 
            LINE N 64 -1376 0 -1376 
            RECTANGLE N 0 -1324 64 -1300 
            LINE N 64 -1312 0 -1312 
            RECTANGLE N 0 -1260 64 -1236 
            LINE N 64 -1248 0 -1248 
            LINE N 64 -1120 0 -1120 
            RECTANGLE N 0 -1068 64 -1044 
            LINE N 64 -1056 0 -1056 
            RECTANGLE N 0 -1004 64 -980 
            LINE N 64 -992 0 -992 
            RECTANGLE N 0 -876 64 -852 
            LINE N 64 -864 0 -864 
            LINE N 64 -672 0 -672 
            RECTANGLE N 0 -748 64 -724 
            LINE N 64 -736 0 -736 
            LINE N 432 -1376 496 -1376 
            LINE N 432 -1632 496 -1632 
            RECTANGLE N 432 -1708 496 -1684 
            LINE N 432 -1696 496 -1696 
            LINE N 64 -96 0 -96 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -364 64 -340 
            LINE N 64 -352 0 -352 
            LINE N 64 -480 0 -480 
            RECTANGLE N 0 -556 64 -532 
            LINE N 64 -544 0 -544 
            LINE N 432 -864 496 -864 
            LINE N 432 -800 496 -800 
            LINE N 432 -992 496 -992 
            LINE N 432 -928 496 -928 
            LINE N 432 -1120 496 -1120 
            LINE N 432 -1056 496 -1056 
            LINE N 432 -1248 496 -1248 
            LINE N 432 -1184 496 -1184 
            LINE N 64 -1408 432 -1408 
            LINE N 64 -1344 432 -1344 
            LINE N 64 -1152 432 -1152 
            LINE N 64 -1280 432 -1280 
            LINE N 64 -1024 432 -1024 
            LINE N 64 -896 432 -896 
            LINE N 64 -768 432 -768 
            LINE N 64 -576 432 -576 
            LINE N 64 -384 432 -384 
            LINE N 64 -192 432 -192 
            LINE N 432 -736 496 -736 
            LINE N 432 -672 496 -672 
            LINE N 432 -608 496 -608 
            LINE N 432 -544 496 -544 
            LINE N 432 -480 496 -480 
            LINE N 432 -352 496 -352 
            LINE N 432 -288 496 -288 
            LINE N 432 -160 496 -160 
            LINE N 432 -96 496 -96 
            LINE N 432 -224 496 -224 
            LINE N 432 -416 496 -416 
            LINE N 432 -32 496 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF uarts_module
            TIMESTAMP 2012 2 7 8 59 7
            LINE N 464 -96 528 -96 
            LINE N 464 -32 528 -32 
            LINE N 464 -224 528 -224 
            LINE N 464 -160 528 -160 
            LINE N 464 -352 528 -352 
            LINE N 464 -288 528 -288 
            LINE N 464 -480 528 -480 
            LINE N 464 -416 528 -416 
            RECTANGLE N 464 -556 528 -532 
            LINE N 464 -544 528 -544 
            LINE N 64 -96 0 -96 
            LINE N 64 -224 0 -224 
            LINE N 64 -352 0 -352 
            LINE N 64 -480 0 -480 
            LINE N 64 -928 0 -928 
            LINE N 64 -864 0 -864 
            LINE N 64 -800 0 -800 
            LINE N 64 -736 0 -736 
            RECTANGLE N 0 -684 64 -660 
            LINE N 64 -672 0 -672 
            RECTANGLE N 0 -620 64 -596 
            LINE N 64 -608 0 -608 
            RECTANGLE N 0 -556 64 -532 
            LINE N 64 -544 0 -544 
            RECTANGLE N 464 -940 528 -916 
            LINE N 464 -928 528 -928 
            LINE N 64 -576 464 -576 
            RECTANGLE N 64 -964 464 -4 
            LINE N 64 -512 464 -512 
            LINE N 64 -384 464 -384 
            LINE N 64 -256 464 -256 
            LINE N 64 -128 464 -128 
        END BLOCKDEF
        BEGIN BLOCK XLXI_6 cb16ce
            PIN C clk_cpu
            PIN CE XLXN_4
            PIN CLR XLXN_5
            PIN CEO XLXN_2
            PIN Q(15:0) cnt1(15:0)
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_7 cb8ce
            PIN C clk_cpu
            PIN CE XLXN_2
            PIN CLR XLXN_6
            PIN CEO
            PIN Q(7:0) cnt(7:0)
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_8 vcc
            PIN P XLXN_4
        END BLOCK
        BEGIN BLOCK XLXI_9 gnd
            PIN G XLXN_5
        END BLOCK
        BEGIN BLOCK XLXI_10 gnd
            PIN G XLXN_6
        END BLOCK
        BEGIN BLOCK XLXI_402 clockgen
            PIN CLKIN_IN clk
            PIN LOCKED_OUT locked
            PIN CLKDV_OUT clk_cpu
            PIN CLKIN_IBUFG_OUT
            PIN CLK0_OUT
            PIN USER_RST_IN XLXN_1251
        END BLOCK
        BEGIN BLOCK XLXI_377 inv
            PIN I SYSRESET
            PIN O XLXN_1251
        END BLOCK
        BEGIN BLOCK XLXI_362 cb4ce
            PIN C clk_cpu
            PIN CE XLXN_1188
            PIN CLR XLXN_1251
            PIN CEO
            PIN Q0
            PIN Q1
            PIN Q2
            PIN Q3 nreset
            PIN TC
        END BLOCK
        BEGIN BLOCK XLXI_363 and2
            PIN I0 locked
            PIN I1 reset
            PIN O XLXN_1188
        END BLOCK
        BEGIN BLOCK XLXI_365 inv
            PIN I nreset
            PIN O reset
        END BLOCK
        BEGIN BLOCK XLXI_11 buf
            PIN I cnt(7)
            PIN O led1
        END BLOCK
        BEGIN BLOCK XLXI_384 buf
            PIN I locked
            PIN O led2
        END BLOCK
        BEGIN BLOCK XLXI_382 buf
            PIN I reset
            PIN O led3
        END BLOCK
        BEGIN BLOCK XLXI_383 buf
            PIN I flashspi_ss
            PIN O led4
        END BLOCK
        BEGIN BLOCK XLXI_378 buf
            PIN I flashspi_do
            PIN O led5
        END BLOCK
        BEGIN BLOCK XLXI_12 buf
            PIN I cnt1(15)
            PIN O beep
        END BLOCK
        BEGIN BLOCK XLXI_100 cpu6502_sync
            PIN clk clk_cpu
            PIN enable cpu_enable
            PIN reset reset
            PIN nmi_n XLXN_222
            PIN irq_n XLXN_222
            PIN so_n XLXN_222
            PIN di(7:0) cpu_di(7:0)
            PIN we
            PIN rd
            PIN next_we XLXN_434
            PIN next_rd XLXN_433
            PIN do(7:0) cpu_do_reg(7:0)
            PIN addr(15:0) cpu_addr_reg(15:0)
            PIN next_do(7:0) cpu_do(7:0)
            PIN next_addr(15:0) cpu_addr(15:0)
            PIN debugOpcode(7:0)
            PIN debugPc(15:0)
            PIN debugA(7:0)
            PIN debugX(7:0)
            PIN debugY(7:0)
            PIN debugS(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_102 vcc
            PIN P XLXN_222
        END BLOCK
        BEGIN BLOCK XLXI_634 gpin_buf
            PIN gpin(31:0) XLXN_1936(31:0)
            PIN gpin4 gpin4
            PIN gpin5 gpin5
            PIN gpin6 gpin6
            PIN gpin7 gpin7
            PIN gpin8 gpin8
            PIN gpin9 gpin9
            PIN gpin10 gpin10
            PIN gpin11 gpin11
            PIN gpin12 gpin12
            PIN gpin13 gpin13
            PIN gpin14 gpin14
            PIN gpin15 gpin15
            PIN gpin16 gpin16
            PIN gpin17 gpin17
            PIN gpin18 gpin18
            PIN gpin0 gpin0
            PIN gpin1 gpin1
            PIN gpin2 gpin2
            PIN gpin3 gpin3
            PIN gpin20 gpin20
            PIN gpin21 gpin21
            PIN gpin22 gpin22
            PIN gpin23 gpin23
            PIN gpin24 gpin24
            PIN gpin25 gpin25
            PIN gpin26 gpin26
            PIN gpin27 gpin27
            PIN gpin28 gpin28
            PIN gpin29 gpin29
            PIN gpin30 gpin30
            PIN gpin31 gpin31
            PIN gpin19 gpin19
        END BLOCK
        BEGIN BLOCK XLXI_642 gpio_ctrl
            PIN clk clk_cpu
            PIN reset reset
            PIN rd gpio_rd
            PIN wr gpio_wr
            PIN cpu_do(7:0) cpu_do(7:0)
            PIN cpu_addr(7:0) cpu_addr(7:0)
            PIN gpin(31:0) XLXN_1936(31:0)
            PIN gpio_out(31:0) XLXN_1934(31:0)
            PIN gpio_oe XLXN_1946
            PIN cpu_di(7:0) gpio_data(7:0)
            PIN gpout(31:0) XLXN_1935(31:0)
            PIN gpio_in(31:0) XLXN_1933(31:0)
        END BLOCK
        BEGIN BLOCK XLXI_636 gpout_buf
            PIN gpout23 gpout23
            PIN gpout24 gpout24
            PIN gpout25 gpout25
            PIN gpout26 gpout26
            PIN gpout27 gpout27
            PIN gpout28 gpout28
            PIN gpout29 gpout29
            PIN gpout30 gpout30
            PIN gpout31 gpout31
            PIN gpout11 gpout11
            PIN gpout12 gpout12
            PIN gpout13 gpout13
            PIN gpout14 gpout14
            PIN gpout15 gpout15
            PIN gpout16 gpout16
            PIN gpout17 gpout17
            PIN gpout19 gpout18
            PIN gpout18 gpout19
            PIN gpout20 gpout20
            PIN gpout21 gpout21
            PIN gpout22 gpout22
            PIN gpout(31:0) XLXN_1935(31:0)
            PIN gpout0 gpout0
            PIN gpout1 gpout1
            PIN gpout2 gpout2
            PIN gpout4 gpout3
            PIN gpout3 gpout4
            PIN gpout5 gpout5
            PIN gpout6 gpout6
            PIN gpout7 gpout7
            PIN gpout8 gpout8
            PIN gpout9 gpout9
            PIN gpout10 gpout10
        END BLOCK
        BEGIN BLOCK XLXI_641 gpio_buf
            PIN gpio0 gpio0
            PIN gpio1 gpio1
            PIN gpio2 gpio2
            PIN gpio3 gpio3
            PIN gpio4 gpio4
            PIN gpio5 gpio5
            PIN gpio6 gpio6
            PIN gpio7 gpio7
            PIN gpio8 gpio8
            PIN gpio9 gpio9
            PIN gpio10 gpio10
            PIN gpio11 gpio11
            PIN gpio12 gpio12
            PIN gpio13 gpio13
            PIN gpio14 gpio14
            PIN gpio15 gpio15
            PIN gpio16 gpio16
            PIN gpio17 gpio17
            PIN gpio18 gpio18
            PIN gpio19 gpio19
            PIN gpio20 gpio20
            PIN gpio21 gpio21
            PIN gpio22 gpio22
            PIN gpio23 gpio23
            PIN gpio24 gpio24
            PIN gpio25 gpio25
            PIN gpio26 gpio26
            PIN gpio27 gpio27
            PIN gpio28 gpio28
            PIN gpio29 gpio29
            PIN gpio30 gpio30
            PIN gpio31 gpio31
            PIN clk clk_cpu
            PIN reset reset
            PIN gpio_in(31:0) XLXN_1933(31:0)
            PIN gpio_oe XLXN_1946
            PIN gpio_out(31:0) XLXN_1934(31:0)
            PIN gpio_ext_oe U38_OE
            PIN gpio_ext_dir U38_DIR
        END BLOCK
        BEGIN BLOCK XLXI_658 datamux
            PIN clk clk_cpu
            PIN reset reset
            PIN cpu_next_rd XLXN_433
            PIN cpu_next_we XLXN_434
            PIN cpu_next_addr(15:0) cpu_addr(15:0)
            PIN ram_data(7:0) ram_data(7:0)
            PIN rom_data(7:0) rom_data(7:0)
            PIN uart_data(7:0) uart_data(7:0)
            PIN spi_ack spi_ack
            PIN spi_data(7:0) spi_data(7:0)
            PIN maxspi_data(7:0) maxspi_data(7:0)
            PIN gpio_data(7:0) gpio_data(7:0)
            PIN dev4_ack XLXN_2184
            PIN dev4_data(7:0) steppers_data(7:0)
            PIN ram_we ram_we
            PIN cpu_enable cpu_enable
            PIN cpu_di(7:0) cpu_di(7:0)
            PIN dev7_ack XLXN_2184
            PIN dev7_data(7:0)
            PIN dev6_ack XLXN_2184
            PIN dev6_data(7:0)
            PIN dev5_ack XLXN_2184
            PIN dev5_data(7:0)
            PIN gpio_wr gpio_wr
            PIN gpio_rd gpio_rd
            PIN maxspi_wr maxspi_wr
            PIN maxspi_rd maxspi_rd
            PIN spi_wr spi_we
            PIN spi_stb spi_stb
            PIN uart_rd uart_rd
            PIN uart_wr uart_wr
            PIN dev4_wr steppers_wr
            PIN dev4_rd steppers_rd
            PIN dev4_stb
            PIN dev5_wr
            PIN dev5_rd
            PIN dev6_wr
            PIN dev6_rd
            PIN dev7_wr
            PIN dev7_rd
            PIN dev5_stb
            PIN dev6_stb
            PIN dev7_stb
        END BLOCK
        BEGIN BLOCK XLXI_101 cpu_ram
            PIN Clk clk_cpu
            PIN writeEn ram_we
            PIN addr(14:0) cpu_addr(14:0)
            PIN dataIn(7:0) cpu_do(7:0)
            PIN dataOut(7:0) ram_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_104 cpu_rom
            PIN clk clk_cpu
            PIN addr(12:0) cpu_addr(12:0)
            PIN dataOut(7:0) rom_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_367 spiMaster
            PIN clk_i clk_cpu
            PIN rst_i reset
            PIN strobe_i spi_stb
            PIN we_i spi_we
            PIN spiSysClk clk_cpu
            PIN spiDataIn SD_DI
            PIN address_i(7:0) cpu_addr(7:0)
            PIN data_i(7:0) cpu_do(7:0)
            PIN ack_o spi_ack
            PIN spiClkOut SD_CLK
            PIN spiDataOut SD_DO
            PIN spiCS_n SD_CS
            PIN data_o(7:0) spi_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_507 readWriteSPIWireData
            PIN clk clk_cpu
            PIN rst reset
            PIN rxDataRdySet XLXN_1514
            PIN rxDataOut(7:0) XLXN_1513(7:0)
            PIN txDataEmpty XLXN_1512
            PIN txDataFullClr XLXN_1511
            PIN txDataFull XLXN_1516
            PIN txDataIn(7:0) XLXN_1517(7:0)
            PIN spiDataIn flashspi_do
            PIN spiClkOut flashspi_clk
            PIN spiDataOut flashspi_di
            PIN clkDelay(7:0) XLXN_1299(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_592 spi_master_ctrl
            PIN clk clk_cpu
            PIN reset reset
            PIN wr maxspi_wr
            PIN rd maxspi_rd
            PIN rxDataRdySet XLXN_1514
            PIN txDataFullClr XLXN_1511
            PIN txDataEmpty XLXN_1512
            PIN addr(7:0) cpu_addr(7:0)
            PIN cpu_di(7:0) cpu_do(7:0)
            PIN rxData(7:0) XLXN_1513(7:0)
            PIN txDataFull XLXN_1516
            PIN spiSS0 flashspi_ss
            PIN spiSS1 osram_load
            PIN spiSS2
            PIN spiSS3
            PIN cpu_do(7:0) maxspi_data(7:0)
            PIN txData(7:0) XLXN_1517(7:0)
            PIN clkDelay(7:0) XLXN_1299(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_596 inv
            PIN I flashspi_clk
            PIN O osram_clk
        END BLOCK
        BEGIN BLOCK XLXI_597 inv
            PIN I flashspi_di
            PIN O osram_data
        END BLOCK
        BEGIN BLOCK XLXI_649 inv
            PIN I XLXN_2037
            PIN O dir_y
        END BLOCK
        BEGIN BLOCK XLXI_650 inv
            PIN I XLXN_2038
            PIN O step_y
        END BLOCK
        BEGIN BLOCK XLXI_651 inv
            PIN I XLXN_2039
            PIN O dir_z
        END BLOCK
        BEGIN BLOCK XLXI_652 inv
            PIN I XLXN_2040
            PIN O step_z
        END BLOCK
        BEGIN BLOCK XLXI_653 inv
            PIN I XLXN_2041
            PIN O dir_a
        END BLOCK
        BEGIN BLOCK XLXI_654 inv
            PIN I XLXN_2042
            PIN O step_a
        END BLOCK
        BEGIN BLOCK XLXI_648 inv
            PIN I XLXN_2036
            PIN O step_x
        END BLOCK
        BEGIN BLOCK XLXI_647 inv
            PIN I XLXN_2035
            PIN O dir_x
        END BLOCK
        BEGIN BLOCK XLXI_655 inv
            PIN I XLXN_2043
            PIN O enable_xyz
        END BLOCK
        BEGIN BLOCK XLXI_656 inv
            PIN I XLXN_2044
            PIN O enable_a
        END BLOCK
        BEGIN BLOCK XLXI_644 steppers_module
            PIN clk clk_cpu
            PIN reset reset
            PIN rd steppers_rd
            PIN wr steppers_wr
            PIN cpu_addr(7:0) cpu_addr(7:0)
            PIN cpu_data_in(7:0) cpu_do(7:0)
            PIN cpu_data_out(7:0) steppers_data(7:0)
            PIN y_endstop y_endstop
            PIN z_endstop z_endstop
            PIN dir_x XLXN_2035
            PIN step_x XLXN_2036
            PIN dir_y XLXN_2037
            PIN step_y XLXN_2038
            PIN dir_z XLXN_2039
            PIN step_z XLXN_2040
            PIN dir_a XLXN_2041
            PIN step_a XLXN_2042
            PIN enable_xyz XLXN_2043
            PIN enable_a XLXN_2044
            PIN x_endstop x_endstop
        END BLOCK
        BEGIN BLOCK XLXI_685 vcc
            PIN P XLXN_2184
        END BLOCK
        BEGIN BLOCK XLXI_686 uarts_module
            PIN txd3
            PIN tx_idle3
            PIN txd2
            PIN tx_idle2
            PIN txd1 RS485_TX
            PIN tx_idle1 XLXN_2191
            PIN txd0 UART_TX
            PIN tx_idle0
            PIN misc_out(7:0)
            PIN rxd3
            PIN rxd2
            PIN rxd1 RS485_RX
            PIN rxd0 UART_RX
            PIN clk clk_cpu
            PIN reset reset
            PIN rd uart_rd
            PIN wr uart_wr
            PIN cpu_data_in(7:0) cpu_do(7:0)
            PIN cpu_addr(7:0) cpu_addr(7:0)
            PIN misc_in(7:0)
            PIN cpu_data_out(7:0) uart_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_688 inv
            PIN I XLXN_2191
            PIN O RS485_DE
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 7609 5382
        ATTR LengthUnitName "CM"
        ATTR GridsPerUnit "4"
        BEGIN BRANCH clk
            WIRE 288 800 432 800
        END BRANCH
        IOMARKER 288 800 clk R180 28
        INSTANCE XLXI_6 1024 416 R0
        INSTANCE XLXI_7 1520 768 R0
        BEGIN BRANCH XLXN_2
            WIRE 1408 224 1456 224
            WIRE 1456 224 1456 576
            WIRE 1456 576 1520 576
        END BRANCH
        BEGIN BRANCH cnt(7:0)
            WIRE 1904 512 1984 512
            WIRE 1984 512 2016 512
            BEGIN DISPLAY 1984 512 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_8 864 192 R0
        INSTANCE XLXI_9 960 592 R0
        INSTANCE XLXI_10 1456 912 R0
        BEGIN BRANCH XLXN_4
            WIRE 928 192 928 224
            WIRE 928 224 1024 224
        END BRANCH
        BEGIN BRANCH XLXN_5
            WIRE 1024 384 1024 464
        END BRANCH
        BEGIN BRANCH XLXN_6
            WIRE 1520 736 1520 784
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 816 640 832 640
            WIRE 832 640 928 640
            WIRE 928 640 1520 640
            WIRE 928 288 1024 288
            WIRE 928 288 928 640
            BEGIN DISPLAY 832 640 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cnt1(15:0)
            WIRE 1408 160 1520 160
            WIRE 1520 160 1536 160
            BEGIN DISPLAY 1520 160 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH nreset
            WIRE 2624 1280 2704 1280
            WIRE 2704 1280 2736 1280
            WIRE 2704 1200 2704 1280
            WIRE 2704 1200 2992 1200
            BEGIN DISPLAY 2992 1200 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH locked
            WIRE 1424 1040 1552 1040
            WIRE 1552 1040 1680 1040
            WIRE 1680 1040 1680 1376
            WIRE 1680 1376 1856 1376
            BEGIN DISPLAY 1552 1040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_402 944 1264 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 1424 1104 1552 1104
            WIRE 1552 1104 1616 1104
            BEGIN DISPLAY 1552 1104 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk
            WIRE 784 1232 816 1232
            WIRE 816 1232 944 1232
            BEGIN DISPLAY 816 1232 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH SYSRESET
            WIRE 544 1424 608 1424
        END BRANCH
        INSTANCE XLXI_377 608 1456 R0
        BEGIN BRANCH clk_cpu
            WIRE 2144 1408 2240 1408
            BEGIN DISPLAY 2144 1408 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1188
            WIRE 2112 1344 2240 1344
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1792 1312 1808 1312
            WIRE 1808 1312 1856 1312
            BEGIN DISPLAY 1808 1312 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_362 2240 1536 R0
        BEGIN BRANCH XLXN_1251
            WIRE 832 1424 880 1424
            WIRE 880 1424 944 1424
            WIRE 880 1424 880 1504
            WIRE 880 1504 2240 1504
        END BRANCH
        INSTANCE XLXI_363 1856 1440 R0
        INSTANCE XLXI_365 2736 1312 R0
        BEGIN BRANCH reset
            WIRE 2960 1280 2992 1280
            BEGIN DISPLAY 2992 1280 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        IOMARKER 544 1424 SYSRESET R180 28
        BEGIN BRANCH led1
            WIRE 2560 208 2640 208
        END BRANCH
        INSTANCE XLXI_11 2336 240 R0
        BEGIN BRANCH cnt(7)
            WIRE 2256 208 2336 208
            BEGIN DISPLAY 2256 208 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        INSTANCE XLXI_384 2336 352 R0
        BEGIN BRANCH led2
            WIRE 2560 320 2640 320
        END BRANCH
        INSTANCE XLXI_382 2336 464 R0
        BEGIN BRANCH led3
            WIRE 2560 432 2640 432
        END BRANCH
        INSTANCE XLXI_383 2336 576 R0
        BEGIN BRANCH led4
            WIRE 2560 544 2640 544
        END BRANCH
        INSTANCE XLXI_378 2336 688 R0
        BEGIN BRANCH led5
            WIRE 2560 656 2640 656
        END BRANCH
        BEGIN BRANCH locked
            WIRE 2256 320 2336 320
            BEGIN DISPLAY 2256 320 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2256 432 2336 432
            BEGIN DISPLAY 2256 432 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH beep
            WIRE 2560 112 2640 112
        END BRANCH
        BEGIN BRANCH cnt1(15)
            WIRE 2256 112 2336 112
            BEGIN DISPLAY 2256 112 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        IOMARKER 2640 320 led2 R0 28
        IOMARKER 2640 432 led3 R0 28
        IOMARKER 2640 544 led4 R0 28
        IOMARKER 2640 656 led5 R0 28
        IOMARKER 2640 208 led1 R0 28
        IOMARKER 2640 112 beep R0 28
        INSTANCE XLXI_12 2336 144 R0
        BEGIN BRANCH flashspi_ss
            WIRE 2240 544 2256 544
            WIRE 2256 544 2336 544
            BEGIN DISPLAY 2256 544 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH flashspi_do
            WIRE 2240 656 2272 656
            WIRE 2272 656 2336 656
            BEGIN DISPLAY 2272 656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 528 1984 544 1984
            WIRE 544 1984 656 1984
            BEGIN DISPLAY 544 1984 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 560 1728 576 1728
            WIRE 576 1728 656 1728
            BEGIN DISPLAY 576 1728 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_100 656 2592 R0
        END INSTANCE
        BEGIN BRANCH cpu_addr(15:0)
            WIRE 1040 2176 1104 2176
            WIRE 1104 2176 1168 2176
            BEGIN DISPLAY 1104 2176 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 1040 2112 1088 2112
            WIRE 1088 2112 1168 2112
            BEGIN DISPLAY 1088 2112 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(15:0)
            WIRE 1520 2128 1648 2128
            BEGIN DISPLAY 1520 2128 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1520 1936 1648 1936
            BEGIN DISPLAY 1520 1936 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 1520 1872 1648 1872
            BEGIN DISPLAY 1520 1872 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_data(7:0)
            WIRE 1440 2192 1648 2192
            BEGIN DISPLAY 1440 2192 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rom_data(7:0)
            WIRE 1472 2256 1648 2256
            BEGIN DISPLAY 1472 2256 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_434
            WIRE 1040 1856 1344 1856
            WIRE 1344 1856 1344 2064
            WIRE 1344 2064 1648 2064
        END BRANCH
        BEGIN BRANCH uart_data(7:0)
            WIRE 1488 2320 1648 2320
            BEGIN DISPLAY 1488 2320 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_222
            WIRE 432 2080 432 2112
            WIRE 432 2112 624 2112
            WIRE 624 2112 624 2240
            WIRE 624 2240 656 2240
            WIRE 624 2240 624 2368
            WIRE 624 2368 656 2368
            WIRE 624 2112 656 2112
        END BRANCH
        INSTANCE XLXI_102 368 2080 R0
        BEGIN BRANCH cpu_addr_reg(15:0)
            WIRE 1040 2048 1088 2048
            WIRE 1088 2048 1184 2048
            BEGIN DISPLAY 1088 2048 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do_reg(7:0)
            WIRE 1040 1984 1088 1984
            WIRE 1088 1984 1184 1984
            BEGIN DISPLAY 1088 1984 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_ack
            WIRE 1552 2448 1648 2448
            BEGIN DISPLAY 1552 2448 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_di(7:0)
            WIRE 512 2496 560 2496
            WIRE 560 2496 656 2496
            BEGIN DISPLAY 560 2496 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_enable
            WIRE 576 1856 608 1856
            WIRE 608 1856 656 1856
            BEGIN DISPLAY 608 1856 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_634 3536 1120 R0
        END INSTANCE
        BEGIN BRANCH gpin0
            WIRE 3408 128 3536 128
        END BRANCH
        BEGIN BRANCH gpin10
            WIRE 3408 448 3536 448
        END BRANCH
        BEGIN BRANCH gpin9
            WIRE 3408 416 3536 416
        END BRANCH
        BEGIN BRANCH gpin8
            WIRE 3408 384 3536 384
        END BRANCH
        BEGIN BRANCH gpin7
            WIRE 3408 352 3536 352
        END BRANCH
        BEGIN BRANCH gpin6
            WIRE 3408 320 3536 320
        END BRANCH
        BEGIN BRANCH gpin1
            WIRE 3408 160 3536 160
        END BRANCH
        BEGIN BRANCH gpin11
            WIRE 3408 480 3536 480
        END BRANCH
        BEGIN BRANCH gpin12
            WIRE 3408 512 3536 512
        END BRANCH
        BEGIN BRANCH gpin13
            WIRE 3408 544 3536 544
        END BRANCH
        BEGIN BRANCH gpin14
            WIRE 3408 576 3536 576
        END BRANCH
        BEGIN BRANCH gpin15
            WIRE 3408 608 3536 608
        END BRANCH
        BEGIN BRANCH gpin16
            WIRE 3408 640 3536 640
        END BRANCH
        BEGIN BRANCH gpin17
            WIRE 3408 672 3536 672
        END BRANCH
        BEGIN BRANCH gpin18
            WIRE 3408 704 3536 704
        END BRANCH
        BEGIN BRANCH gpin19
            WIRE 3408 736 3536 736
        END BRANCH
        BEGIN BRANCH gpin20
            WIRE 3408 768 3536 768
        END BRANCH
        BEGIN BRANCH gpin21
            WIRE 3408 800 3536 800
        END BRANCH
        BEGIN BRANCH gpin22
            WIRE 3408 832 3536 832
        END BRANCH
        BEGIN BRANCH gpin23
            WIRE 3408 864 3536 864
        END BRANCH
        BEGIN BRANCH gpin24
            WIRE 3408 896 3536 896
        END BRANCH
        BEGIN BRANCH gpin25
            WIRE 3408 928 3536 928
        END BRANCH
        BEGIN BRANCH gpin26
            WIRE 3408 960 3536 960
        END BRANCH
        BEGIN BRANCH gpin27
            WIRE 3408 992 3536 992
        END BRANCH
        BEGIN BRANCH gpin28
            WIRE 3408 1024 3536 1024
        END BRANCH
        BEGIN BRANCH gpin29
            WIRE 3408 1056 3536 1056
        END BRANCH
        BEGIN BRANCH gpin30
            WIRE 3408 1088 3536 1088
        END BRANCH
        BEGIN BRANCH gpin31
            WIRE 3408 1120 3536 1120
        END BRANCH
        BEGIN BRANCH gpin2
            WIRE 3408 192 3536 192
        END BRANCH
        BEGIN BRANCH gpin3
            WIRE 3408 224 3536 224
        END BRANCH
        BEGIN BRANCH gpin4
            WIRE 3408 256 3536 256
        END BRANCH
        BEGIN BRANCH gpin5
            WIRE 3408 288 3536 288
        END BRANCH
        IOMARKER 3408 128 gpin0 R180 28
        IOMARKER 3408 160 gpin1 R180 28
        IOMARKER 3408 480 gpin11 R180 28
        IOMARKER 3408 448 gpin10 R180 28
        IOMARKER 3408 416 gpin9 R180 28
        IOMARKER 3408 384 gpin8 R180 28
        IOMARKER 3408 352 gpin7 R180 28
        IOMARKER 3408 320 gpin6 R180 28
        IOMARKER 3408 512 gpin12 R180 28
        IOMARKER 3408 544 gpin13 R180 28
        IOMARKER 3408 576 gpin14 R180 28
        IOMARKER 3408 608 gpin15 R180 28
        IOMARKER 3408 640 gpin16 R180 28
        IOMARKER 3408 672 gpin17 R180 28
        IOMARKER 3408 704 gpin18 R180 28
        IOMARKER 3408 736 gpin19 R180 28
        IOMARKER 3408 768 gpin20 R180 28
        IOMARKER 3408 800 gpin21 R180 28
        IOMARKER 3408 832 gpin22 R180 28
        IOMARKER 3408 864 gpin23 R180 28
        IOMARKER 3408 896 gpin24 R180 28
        IOMARKER 3408 928 gpin25 R180 28
        IOMARKER 3408 960 gpin26 R180 28
        IOMARKER 3408 992 gpin27 R180 28
        IOMARKER 3408 1024 gpin28 R180 28
        IOMARKER 3408 1056 gpin29 R180 28
        IOMARKER 3408 1088 gpin30 R180 28
        IOMARKER 3408 1120 gpin31 R180 28
        IOMARKER 3408 192 gpin2 R180 28
        IOMARKER 3408 224 gpin3 R180 28
        IOMARKER 3408 256 gpin4 R180 28
        IOMARKER 3408 288 gpin5 R180 28
        BEGIN BRANCH gpout1
            WIRE 5216 144 5376 144
        END BRANCH
        BEGIN BRANCH gpout2
            WIRE 5216 176 5376 176
        END BRANCH
        BEGIN BRANCH gpout3
            WIRE 5216 208 5376 208
        END BRANCH
        BEGIN BRANCH gpout4
            WIRE 5216 240 5376 240
        END BRANCH
        BEGIN BRANCH gpout5
            WIRE 5216 272 5376 272
        END BRANCH
        BEGIN BRANCH gpout6
            WIRE 5216 304 5376 304
        END BRANCH
        BEGIN BRANCH gpout7
            WIRE 5216 336 5376 336
        END BRANCH
        BEGIN BRANCH gpout9
            WIRE 5216 400 5376 400
        END BRANCH
        BEGIN BRANCH gpout10
            WIRE 5216 432 5376 432
        END BRANCH
        BEGIN BRANCH gpout11
            WIRE 5216 464 5376 464
        END BRANCH
        BEGIN BRANCH gpout12
            WIRE 5216 496 5376 496
        END BRANCH
        BEGIN BRANCH gpout13
            WIRE 5216 528 5376 528
        END BRANCH
        BEGIN BRANCH gpout14
            WIRE 5216 560 5376 560
        END BRANCH
        BEGIN BRANCH gpout15
            WIRE 5216 592 5376 592
        END BRANCH
        BEGIN BRANCH gpout16
            WIRE 5216 624 5376 624
        END BRANCH
        BEGIN BRANCH gpout17
            WIRE 5216 656 5376 656
        END BRANCH
        BEGIN BRANCH gpout18
            WIRE 5216 688 5376 688
        END BRANCH
        BEGIN BRANCH gpout19
            WIRE 5216 720 5376 720
        END BRANCH
        BEGIN BRANCH gpout20
            WIRE 5216 752 5376 752
        END BRANCH
        BEGIN BRANCH gpout21
            WIRE 5216 784 5376 784
        END BRANCH
        BEGIN BRANCH gpout22
            WIRE 5216 816 5376 816
        END BRANCH
        BEGIN BRANCH gpout23
            WIRE 5216 848 5376 848
        END BRANCH
        BEGIN BRANCH gpout24
            WIRE 5216 880 5376 880
        END BRANCH
        BEGIN BRANCH gpout25
            WIRE 5216 912 5376 912
        END BRANCH
        BEGIN BRANCH gpout26
            WIRE 5216 944 5376 944
        END BRANCH
        BEGIN BRANCH gpout27
            WIRE 5216 976 5376 976
        END BRANCH
        BEGIN BRANCH gpout28
            WIRE 5216 1008 5376 1008
        END BRANCH
        BEGIN BRANCH gpout29
            WIRE 5216 1040 5376 1040
        END BRANCH
        BEGIN BRANCH gpout30
            WIRE 5216 1072 5376 1072
        END BRANCH
        BEGIN BRANCH gpout31
            WIRE 5216 1104 5376 1104
        END BRANCH
        BEGIN BRANCH gpout8
            WIRE 5216 368 5376 368
        END BRANCH
        BEGIN BRANCH gpout0
            WIRE 5216 112 5376 112
        END BRANCH
        BEGIN INSTANCE XLXI_636 4832 1136 R0
        END INSTANCE
        IOMARKER 5376 112 gpout0 R0 28
        IOMARKER 5376 144 gpout1 R0 28
        IOMARKER 5376 176 gpout2 R0 28
        IOMARKER 5376 208 gpout3 R0 28
        IOMARKER 5376 240 gpout4 R0 28
        IOMARKER 5376 272 gpout5 R0 28
        IOMARKER 5376 304 gpout6 R0 28
        IOMARKER 5376 336 gpout7 R0 28
        IOMARKER 5376 368 gpout8 R0 28
        IOMARKER 5376 400 gpout9 R0 28
        IOMARKER 5376 432 gpout10 R0 28
        IOMARKER 5376 464 gpout11 R0 28
        IOMARKER 5376 496 gpout12 R0 28
        IOMARKER 5376 528 gpout13 R0 28
        IOMARKER 5376 560 gpout14 R0 28
        IOMARKER 5376 592 gpout15 R0 28
        IOMARKER 5376 624 gpout16 R0 28
        IOMARKER 5376 656 gpout17 R0 28
        IOMARKER 5376 688 gpout18 R0 28
        IOMARKER 5376 720 gpout19 R0 28
        IOMARKER 5376 752 gpout20 R0 28
        IOMARKER 5376 784 gpout21 R0 28
        IOMARKER 5376 816 gpout22 R0 28
        IOMARKER 5376 848 gpout23 R0 28
        IOMARKER 5376 880 gpout24 R0 28
        IOMARKER 5376 912 gpout25 R0 28
        IOMARKER 5376 944 gpout26 R0 28
        IOMARKER 5376 976 gpout27 R0 28
        IOMARKER 5376 1008 gpout28 R0 28
        IOMARKER 5376 1040 gpout29 R0 28
        IOMARKER 5376 1072 gpout30 R0 28
        IOMARKER 5376 1104 gpout31 R0 28
        BEGIN BRANCH gpio0
            WIRE 5344 1520 5440 1520
        END BRANCH
        BEGIN BRANCH gpio1
            WIRE 5344 1552 5440 1552
        END BRANCH
        BEGIN BRANCH gpio2
            WIRE 5344 1584 5440 1584
        END BRANCH
        BEGIN BRANCH gpio3
            WIRE 5344 1616 5440 1616
        END BRANCH
        BEGIN BRANCH gpio4
            WIRE 5344 1648 5440 1648
        END BRANCH
        BEGIN BRANCH gpio5
            WIRE 5344 1680 5440 1680
        END BRANCH
        BEGIN BRANCH gpio6
            WIRE 5344 1712 5440 1712
        END BRANCH
        BEGIN BRANCH gpio7
            WIRE 5344 1744 5440 1744
        END BRANCH
        BEGIN BRANCH gpio8
            WIRE 5344 1776 5440 1776
        END BRANCH
        BEGIN BRANCH gpio9
            WIRE 5344 1808 5440 1808
        END BRANCH
        BEGIN BRANCH gpio10
            WIRE 5344 1840 5440 1840
        END BRANCH
        BEGIN BRANCH gpio11
            WIRE 5344 1872 5440 1872
        END BRANCH
        BEGIN BRANCH gpio12
            WIRE 5344 1904 5440 1904
        END BRANCH
        BEGIN BRANCH gpio13
            WIRE 5344 1936 5440 1936
        END BRANCH
        BEGIN BRANCH gpio14
            WIRE 5344 1968 5440 1968
        END BRANCH
        BEGIN BRANCH gpio15
            WIRE 5344 2000 5440 2000
        END BRANCH
        BEGIN BRANCH gpio16
            WIRE 5344 2032 5440 2032
        END BRANCH
        BEGIN BRANCH gpio17
            WIRE 5344 2064 5440 2064
        END BRANCH
        BEGIN BRANCH gpio18
            WIRE 5344 2096 5440 2096
        END BRANCH
        BEGIN BRANCH gpio19
            WIRE 5344 2128 5440 2128
        END BRANCH
        BEGIN BRANCH gpio20
            WIRE 5344 2160 5440 2160
        END BRANCH
        BEGIN BRANCH gpio21
            WIRE 5344 2192 5440 2192
        END BRANCH
        BEGIN BRANCH gpio22
            WIRE 5344 2224 5440 2224
        END BRANCH
        BEGIN BRANCH gpio23
            WIRE 5344 2256 5440 2256
        END BRANCH
        BEGIN BRANCH gpio24
            WIRE 5344 2288 5440 2288
        END BRANCH
        BEGIN BRANCH gpio25
            WIRE 5344 2320 5440 2320
        END BRANCH
        BEGIN BRANCH gpio26
            WIRE 5344 2352 5440 2352
        END BRANCH
        BEGIN BRANCH gpio27
            WIRE 5344 2384 5440 2384
        END BRANCH
        BEGIN BRANCH gpio28
            WIRE 5344 2416 5440 2416
        END BRANCH
        BEGIN BRANCH gpio29
            WIRE 5344 2448 5440 2448
        END BRANCH
        BEGIN BRANCH gpio30
            WIRE 5344 2480 5440 2480
        END BRANCH
        BEGIN BRANCH gpio31
            WIRE 5344 2512 5440 2512
        END BRANCH
        BEGIN BRANCH U38_OE
            WIRE 5344 1392 5440 1392
        END BRANCH
        BEGIN BRANCH U38_DIR
            WIRE 5344 1456 5440 1456
        END BRANCH
        BEGIN INSTANCE XLXI_641 4880 1792 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 4800 1328 4816 1328
            WIRE 4816 1328 4880 1328
            BEGIN DISPLAY 4816 1328 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 4800 1392 4816 1392
            WIRE 4816 1392 4880 1392
            BEGIN DISPLAY 4816 1392 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 5440 1520 gpio0 R0 28
        IOMARKER 5440 1552 gpio1 R0 28
        IOMARKER 5440 1584 gpio2 R0 28
        IOMARKER 5440 1616 gpio3 R0 28
        IOMARKER 5440 1648 gpio4 R0 28
        IOMARKER 5440 1680 gpio5 R0 28
        IOMARKER 5440 1712 gpio6 R0 28
        IOMARKER 5440 1744 gpio7 R0 28
        IOMARKER 5440 1776 gpio8 R0 28
        IOMARKER 5440 1808 gpio9 R0 28
        IOMARKER 5440 1840 gpio10 R0 28
        IOMARKER 5440 1872 gpio11 R0 28
        IOMARKER 5440 1904 gpio12 R0 28
        IOMARKER 5440 1936 gpio13 R0 28
        IOMARKER 5440 1968 gpio14 R0 28
        IOMARKER 5440 2000 gpio15 R0 28
        IOMARKER 5440 2032 gpio16 R0 28
        IOMARKER 5440 2064 gpio17 R0 28
        IOMARKER 5440 2096 gpio18 R0 28
        IOMARKER 5440 2128 gpio19 R0 28
        IOMARKER 5440 2160 gpio20 R0 28
        IOMARKER 5440 2192 gpio21 R0 28
        IOMARKER 5440 2224 gpio22 R0 28
        IOMARKER 5440 2256 gpio23 R0 28
        IOMARKER 5440 2288 gpio24 R0 28
        IOMARKER 5440 2320 gpio25 R0 28
        IOMARKER 5440 2352 gpio26 R0 28
        IOMARKER 5440 2384 gpio27 R0 28
        IOMARKER 5440 2416 gpio28 R0 28
        IOMARKER 5440 2448 gpio29 R0 28
        IOMARKER 5440 2480 gpio30 R0 28
        IOMARKER 5440 2512 gpio31 R0 28
        IOMARKER 5440 1456 U38_DIR R0 28
        IOMARKER 5440 1392 U38_OE R0 28
        BEGIN BRANCH XLXN_1933(31:0)
            WIRE 4608 704 4672 704
            WIRE 4672 704 4672 1456
            WIRE 4672 1456 4880 1456
        END BRANCH
        BEGIN BRANCH XLXN_1934(31:0)
            WIRE 4064 720 4144 720
            WIRE 4064 720 4064 1200
            WIRE 4064 1200 5360 1200
            WIRE 5360 1200 5360 1328
            WIRE 5344 1328 5360 1328
        END BRANCH
        BEGIN BRANCH XLXN_1935(31:0)
            WIRE 4608 560 4768 560
            WIRE 4768 112 4768 560
            WIRE 4768 112 4832 112
        END BRANCH
        BEGIN BRANCH XLXN_1936(31:0)
            WIRE 3920 128 3936 128
            WIRE 3936 128 3936 656
            WIRE 3936 656 4144 656
        END BRANCH
        BEGIN INSTANCE XLXI_642 4144 752 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 4048 272 4080 272
            WIRE 4080 272 4144 272
            BEGIN DISPLAY 4080 272 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 4048 336 4080 336
            WIRE 4080 336 4144 336
            BEGIN DISPLAY 4080 336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_rd
            WIRE 4048 400 4064 400
            WIRE 4064 400 4144 400
            BEGIN DISPLAY 4064 400 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_wr
            WIRE 4048 464 4064 464
            WIRE 4064 464 4144 464
            BEGIN DISPLAY 4064 464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 4048 528 4064 528
            WIRE 4064 528 4144 528
            BEGIN DISPLAY 4064 528 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 4048 592 4064 592
            WIRE 4064 592 4144 592
            BEGIN DISPLAY 4064 592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1946
            WIRE 4608 272 4736 272
            WIRE 4736 272 4736 1520
            WIRE 4736 1520 4880 1520
        END BRANCH
        BEGIN BRANCH gpio_data(7:0)
            WIRE 4608 416 4640 416
            WIRE 4640 416 4704 416
            BEGIN DISPLAY 4640 416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_433
            WIRE 1040 1920 1056 1920
            WIRE 1056 1920 1056 2000
            WIRE 1056 2000 1648 2000
        END BRANCH
        BEGIN BRANCH spi_data(7:0)
            WIRE 1552 2512 1648 2512
            BEGIN DISPLAY 1552 2512 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_data(7:0)
            WIRE 1552 2576 1648 2576
            BEGIN DISPLAY 1552 2576 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_data(7:0)
            WIRE 1552 2704 1648 2704
            BEGIN DISPLAY 1552 2704 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH steppers_data(7:0)
            WIRE 1552 2832 1600 2832
            WIRE 1600 2832 1648 2832
            BEGIN DISPLAY 1600 2832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_658 1648 3568 R0
        END INSTANCE
        BEGIN BRANCH cpu_di(7:0)
            WIRE 2144 1872 2272 1872
            BEGIN DISPLAY 2272 1872 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_enable
            WIRE 2144 1936 2224 1936
            BEGIN DISPLAY 2224 1936 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_we
            WIRE 2144 2192 2208 2192
            BEGIN DISPLAY 2208 2192 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_we
            WIRE 2144 2448 2272 2448
            BEGIN DISPLAY 2272 2448 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_stb
            WIRE 2144 2512 2272 2512
            BEGIN DISPLAY 2272 2512 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_wr
            WIRE 2144 2576 2272 2576
            BEGIN DISPLAY 2272 2576 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_rd
            WIRE 2144 2640 2256 2640
            BEGIN DISPLAY 2256 2640 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_wr
            WIRE 2144 2704 2272 2704
            BEGIN DISPLAY 2272 2704 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_rd
            WIRE 2144 2768 2272 2768
            BEGIN DISPLAY 2272 2768 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH steppers_wr
            WIRE 2144 2832 2256 2832
            BEGIN DISPLAY 2256 2832 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH steppers_rd
            WIRE 2144 2896 2240 2896
            BEGIN DISPLAY 2240 2896 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_we
            WIRE 560 2832 592 2832
            WIRE 592 2832 656 2832
            BEGIN DISPLAY 592 2832 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_data(7:0)
            WIRE 1040 2768 1072 2768
            WIRE 1072 2768 1120 2768
            BEGIN DISPLAY 1072 2768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_101 656 2992 R0
        END INSTANCE
        BEGIN BRANCH cpu_addr(14:0)
            WIRE 560 2896 592 2896
            WIRE 592 2896 656 2896
            BEGIN DISPLAY 592 2896 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 608 2768 624 2768
            WIRE 624 2768 656 2768
            BEGIN DISPLAY 624 2768 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 512 2960 576 2960
            WIRE 576 2960 656 2960
            BEGIN DISPLAY 576 2960 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(12:0)
            WIRE 592 3248 640 3248
            WIRE 640 3248 688 3248
            BEGIN DISPLAY 640 3248 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_104 688 3280 R0
        END INSTANCE
        BEGIN BRANCH rom_data(7:0)
            WIRE 1072 3184 1152 3184
            WIRE 1152 3184 1168 3184
            BEGIN DISPLAY 1152 3184 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 592 3184 624 3184
            WIRE 624 3184 688 3184
            BEGIN DISPLAY 624 3184 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_367 656 3936 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 544 3456 560 3456
            WIRE 560 3456 656 3456
            BEGIN DISPLAY 560 3456 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 544 3520 560 3520
            WIRE 560 3520 656 3520
            BEGIN DISPLAY 560 3520 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_stb
            WIRE 544 3584 560 3584
            WIRE 560 3584 656 3584
            BEGIN DISPLAY 560 3584 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_we
            WIRE 544 3648 560 3648
            WIRE 560 3648 656 3648
            BEGIN DISPLAY 560 3648 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 544 3712 560 3712
            WIRE 560 3712 656 3712
            BEGIN DISPLAY 560 3712 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH SD_DI
            WIRE 560 3776 656 3776
        END BRANCH
        BEGIN BRANCH SD_CLK
            WIRE 1104 3568 1232 3568
        END BRANCH
        BEGIN BRANCH SD_DO
            WIRE 1104 3680 1232 3680
        END BRANCH
        BEGIN BRANCH SD_CS
            WIRE 1104 3792 1232 3792
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 544 3840 560 3840
            WIRE 560 3840 656 3840
            BEGIN DISPLAY 560 3840 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 544 3904 560 3904
            WIRE 560 3904 656 3904
            BEGIN DISPLAY 560 3904 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_data(7:0)
            WIRE 1104 3904 1216 3904
            WIRE 1216 3904 1248 3904
            BEGIN DISPLAY 1216 3904 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_ack
            WIRE 1104 3456 1200 3456
            WIRE 1200 3456 1216 3456
            BEGIN DISPLAY 1200 3456 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 560 3776 SD_DI R180 28
        IOMARKER 1232 3568 SD_CLK R0 28
        IOMARKER 1232 3680 SD_DO R0 28
        IOMARKER 1232 3792 SD_CS R0 28
        BEGIN INSTANCE XLXI_507 2016 4848 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1299(7:0)
            WIRE 1968 4816 2016 4816
            WIRE 1968 4816 1968 4864
            WIRE 1968 4864 3312 4864
            WIRE 3248 4304 3312 4304
            WIRE 3312 4304 3312 4864
        END BRANCH
        BEGIN BRANCH flashspi_do
            WIRE 1936 4720 2000 4720
            WIRE 2000 4720 2000 4752
            WIRE 2000 4752 2016 4752
        END BRANCH
        BEGIN BRANCH flashspi_clk
            WIRE 2480 4752 2528 4752
            WIRE 2528 4752 2528 5024
            WIRE 2528 5024 2544 5024
            WIRE 2528 4752 2576 4752
        END BRANCH
        BEGIN BRANCH flashspi_di
            WIRE 2480 4816 2512 4816
            WIRE 2512 4816 2576 4816
            WIRE 2512 4816 2512 5120
            WIRE 2512 5120 2544 5120
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 1920 4368 1936 4368
            WIRE 1936 4368 2016 4368
            BEGIN DISPLAY 1936 4368 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1920 4432 1936 4432
            WIRE 1936 4432 2016 4432
            BEGIN DISPLAY 1936 4432 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1511
            WIRE 2480 4624 2640 4624
            WIRE 2640 4560 2640 4624
            WIRE 2640 4560 2800 4560
        END BRANCH
        BEGIN BRANCH XLXN_1513(7:0)
            WIRE 2480 4432 2800 4432
        END BRANCH
        BEGIN BRANCH XLXN_1514
            WIRE 2480 4368 2800 4368
        END BRANCH
        BEGIN INSTANCE XLXI_592 2800 4592 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1512
            WIRE 2480 4560 2496 4560
            WIRE 2496 4496 2800 4496
            WIRE 2496 4496 2496 4560
        END BRANCH
        BEGIN BRANCH XLXN_1516
            WIRE 1712 4560 1712 4896
            WIRE 1712 4896 3328 4896
            WIRE 1712 4560 2016 4560
            WIRE 3248 4560 3328 4560
            WIRE 3328 4560 3328 4896
        END BRANCH
        BEGIN BRANCH XLXN_1517(7:0)
            WIRE 1744 4624 2016 4624
            WIRE 1744 4624 1744 4928
            WIRE 1744 4928 3360 4928
            WIRE 3248 4496 3360 4496
            WIRE 3360 4496 3360 4928
        END BRANCH
        BEGIN BRANCH flashspi_ss
            WIRE 3248 4048 3616 4048
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 2704 3984 2800 3984
            BEGIN DISPLAY 2704 3984 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 2704 4048 2800 4048
            BEGIN DISPLAY 2704 4048 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_wr
            WIRE 2704 4112 2800 4112
            BEGIN DISPLAY 2704 4112 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_rd
            WIRE 2704 4176 2800 4176
            BEGIN DISPLAY 2704 4176 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 2704 4240 2800 4240
            BEGIN DISPLAY 2704 4240 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 2704 4304 2800 4304
            BEGIN DISPLAY 2704 4304 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_data(7:0)
            WIRE 3248 3984 3344 3984
            BEGIN DISPLAY 3344 3984 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH osram_load
            WIRE 3248 4112 3600 4112
        END BRANCH
        INSTANCE XLXI_596 2544 5056 R0
        BEGIN BRANCH osram_clk
            WIRE 2768 5024 2816 5024
        END BRANCH
        BEGIN BRANCH osram_data
            WIRE 2768 5120 2816 5120
        END BRANCH
        INSTANCE XLXI_597 2544 5152 R0
        IOMARKER 1936 4720 flashspi_do R180 28
        IOMARKER 2576 4752 flashspi_clk R0 28
        IOMARKER 2576 4816 flashspi_di R0 28
        IOMARKER 3600 4112 osram_load R0 28
        IOMARKER 3616 4048 flashspi_ss R0 28
        IOMARKER 2816 5120 osram_data R0 28
        IOMARKER 2816 5024 osram_clk R0 28
        BEGIN BRANCH steppers_data(7:0)
            WIRE 3936 1824 4000 1824
            WIRE 4000 1824 4032 1824
            BEGIN DISPLAY 4000 1824 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH dir_y
            WIRE 4256 2080 4352 2080
        END BRANCH
        BEGIN BRANCH step_y
            WIRE 4256 2144 4352 2144
        END BRANCH
        BEGIN BRANCH dir_z
            WIRE 4256 2208 4352 2208
        END BRANCH
        BEGIN BRANCH step_z
            WIRE 4256 2272 4352 2272
        END BRANCH
        BEGIN BRANCH dir_a
            WIRE 4256 2336 4352 2336
        END BRANCH
        BEGIN BRANCH step_a
            WIRE 4256 2400 4352 2400
        END BRANCH
        INSTANCE XLXI_649 4032 2112 R0
        INSTANCE XLXI_650 4032 2176 R0
        INSTANCE XLXI_651 4032 2240 R0
        INSTANCE XLXI_652 4032 2304 R0
        INSTANCE XLXI_653 4032 2368 R0
        INSTANCE XLXI_654 4032 2432 R0
        INSTANCE XLXI_648 4032 2048 R0
        BEGIN BRANCH step_x
            WIRE 4256 2016 4352 2016
        END BRANCH
        INSTANCE XLXI_647 4032 1984 R0
        BEGIN BRANCH dir_x
            WIRE 4256 1952 4352 1952
        END BRANCH
        BEGIN BRANCH enable_a
            WIRE 4256 2528 4352 2528
        END BRANCH
        BEGIN BRANCH enable_xyz
            WIRE 4256 2464 4352 2464
        END BRANCH
        INSTANCE XLXI_655 4032 2496 R0
        INSTANCE XLXI_656 4032 2560 R0
        BEGIN BRANCH XLXN_2035
            WIRE 3936 1952 4032 1952
        END BRANCH
        BEGIN BRANCH XLXN_2036
            WIRE 3936 2016 4032 2016
        END BRANCH
        BEGIN BRANCH XLXN_2037
            WIRE 3936 2080 4032 2080
        END BRANCH
        BEGIN BRANCH XLXN_2038
            WIRE 3936 2144 4032 2144
        END BRANCH
        BEGIN BRANCH XLXN_2039
            WIRE 3936 2208 4032 2208
        END BRANCH
        BEGIN BRANCH XLXN_2040
            WIRE 3936 2272 4032 2272
        END BRANCH
        BEGIN BRANCH XLXN_2041
            WIRE 3936 2336 4032 2336
        END BRANCH
        BEGIN BRANCH XLXN_2042
            WIRE 3936 2400 4032 2400
        END BRANCH
        BEGIN BRANCH XLXN_2043
            WIRE 3936 2464 4032 2464
        END BRANCH
        BEGIN BRANCH XLXN_2044
            WIRE 3936 2528 4032 2528
        END BRANCH
        BEGIN BRANCH z_endstop
            WIRE 3312 2400 3408 2400
        END BRANCH
        BEGIN BRANCH y_endstop
            WIRE 3312 2336 3408 2336
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 3312 2144 3328 2144
            WIRE 3328 2144 3408 2144
            BEGIN DISPLAY 3328 2144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 3312 2080 3344 2080
            WIRE 3344 2080 3408 2080
            BEGIN DISPLAY 3344 2080 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH steppers_wr
            WIRE 3312 2016 3360 2016
            WIRE 3360 2016 3408 2016
            BEGIN DISPLAY 3360 2016 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH steppers_rd
            WIRE 3312 1952 3344 1952
            WIRE 3344 1952 3408 1952
            BEGIN DISPLAY 3344 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3312 1888 3328 1888
            WIRE 3328 1888 3408 1888
            BEGIN DISPLAY 3328 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 3312 1824 3344 1824
            WIRE 3344 1824 3408 1824
            BEGIN DISPLAY 3344 1824 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_644 3408 2176 R0
        END INSTANCE
        BEGIN BRANCH x_endstop
            WIRE 3312 2272 3408 2272
        END BRANCH
        IOMARKER 4352 2144 step_y R0 28
        IOMARKER 4352 2080 dir_y R0 28
        IOMARKER 4352 2208 dir_z R0 28
        IOMARKER 4352 2272 step_z R0 28
        IOMARKER 4352 2336 dir_a R0 28
        IOMARKER 4352 2400 step_a R0 28
        IOMARKER 4352 2016 step_x R0 28
        IOMARKER 4352 1952 dir_x R0 28
        IOMARKER 4352 2528 enable_a R0 28
        IOMARKER 4352 2464 enable_xyz R0 28
        IOMARKER 3312 2336 y_endstop R180 28
        IOMARKER 3312 2400 z_endstop R180 28
        IOMARKER 3312 2272 x_endstop R180 28
        BEGIN BRANCH XLXN_2184
            WIRE 1408 2976 1408 3088
            WIRE 1408 3088 1632 3088
            WIRE 1632 3088 1648 3088
            WIRE 1632 3088 1632 3280
            WIRE 1632 3280 1648 3280
            WIRE 1632 3280 1632 3472
            WIRE 1632 3472 1648 3472
            WIRE 1632 2896 1648 2896
            WIRE 1632 2896 1632 3088
        END BRANCH
        INSTANCE XLXI_685 1344 2976 R0
        BEGIN BRANCH uart_rd
            WIRE 2144 2320 2208 2320
            BEGIN DISPLAY 2208 2320 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_wr
            WIRE 2144 2384 2208 2384
            BEGIN DISPLAY 2208 2384 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_686 672 5024 R0
        END INSTANCE
        BEGIN BRANCH UART_TX
            WIRE 1200 4544 1344 4544
        END BRANCH
        BEGIN BRANCH UART_RX
            WIRE 592 4544 672 4544
        END BRANCH
        IOMARKER 1344 4544 UART_TX R0 28
        IOMARKER 592 4544 UART_RX R180 28
        BEGIN BRANCH clk_cpu
            WIRE 576 4096 608 4096
            WIRE 608 4096 672 4096
            BEGIN DISPLAY 608 4096 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 576 4160 624 4160
            WIRE 624 4160 672 4160
            BEGIN DISPLAY 624 4160 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_rd
            WIRE 576 4224 608 4224
            WIRE 608 4224 672 4224
            BEGIN DISPLAY 608 4224 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_wr
            WIRE 576 4288 624 4288
            WIRE 624 4288 672 4288
            BEGIN DISPLAY 624 4288 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 576 4352 624 4352
            WIRE 624 4352 672 4352
            BEGIN DISPLAY 624 4352 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 576 4416 624 4416
            WIRE 624 4416 672 4416
            BEGIN DISPLAY 624 4416 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_data(7:0)
            WIRE 1200 4096 1280 4096
            WIRE 1280 4096 1312 4096
            BEGIN DISPLAY 1280 4096 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH RS485_RX
            WIRE 592 4672 656 4672
            WIRE 656 4672 672 4672
        END BRANCH
        BEGIN BRANCH RS485_TX
            WIRE 1200 4672 1216 4672
            WIRE 1216 4672 1344 4672
        END BRANCH
        BEGIN BRANCH XLXN_2191
            WIRE 1200 4736 1248 4736
        END BRANCH
        INSTANCE XLXI_688 1248 4768 R0
        BEGIN BRANCH RS485_DE
            WIRE 1472 4736 1488 4736
            WIRE 1488 4736 1504 4736
        END BRANCH
        IOMARKER 592 4672 RS485_RX R180 28
        IOMARKER 1344 4672 RS485_TX R0 28
        IOMARKER 1504 4736 RS485_DE R0 28
    END SHEET
END SCHEMATIC
