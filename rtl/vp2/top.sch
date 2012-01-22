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
        SIGNAL uart_load
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
        SIGNAL XLXN_434
        SIGNAL uart_status(7:0)
        SIGNAL XLXN_222
        SIGNAL cpu_addr_reg(15:0)
        SIGNAL cpu_do_reg(7:0)
        SIGNAL cpu_di(7:0)
        SIGNAL cpu_enable
        SIGNAL XLXN_114
        SIGNAL XLXN_113
        SIGNAL uart_status(1)
        SIGNAL uart_status(0)
        SIGNAL UART_TX
        SIGNAL uart_status(4)
        SIGNAL uart_status(3)
        SIGNAL uart_status(2)
        SIGNAL UART_RX
        SIGNAL cpu_addr(12:0)
        SIGNAL cpu_addr(14:0)
        SIGNAL SD_DI
        SIGNAL SD_CLK
        SIGNAL SD_DO
        SIGNAL SD_CS
        SIGNAL cpu_addr(7:0)
        SIGNAL maxspi_data(7:0)
        SIGNAL maxspi_wr
        SIGNAL maxspi_rd
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
        SIGNAL wheel1
        SIGNAL wheel2
        SIGNAL bump1
        SIGNAL bump2
        SIGNAL front_wheel
        SIGNAL IR
        SIGNAL cnt(5)
        SIGNAL XLXN_1294
        SIGNAL XLXN_1298
        SIGNAL snd
        SIGNAL leds_power
        SIGNAL m2b
        SIGNAL m2a
        SIGNAL m1b
        SIGNAL m1a
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
        PORT Output UART_TX
        PORT Input UART_RX
        PORT Input SD_DI
        PORT Output SD_CLK
        PORT Output SD_DO
        PORT Output SD_CS
        PORT Output flashspi_clk
        PORT Output flashspi_di
        PORT Output osram_load
        PORT Output osram_clk
        PORT Output osram_data
        PORT Input wheel1
        PORT Input wheel2
        PORT Input bump1
        PORT Input bump2
        PORT Input front_wheel
        PORT Input IR
        PORT Output snd
        PORT Output leds_power
        PORT Output m2b
        PORT Output m2a
        PORT Output m1b
        PORT Output m1a
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
        BEGIN BLOCKDEF datamux
            TIMESTAMP 2009 4 27 19 52 37
            LINE N 432 160 496 160 
            LINE N 432 224 496 224 
            LINE N 432 288 496 288 
            RECTANGLE N 0 84 64 108 
            LINE N 64 96 0 96 
            LINE N 432 96 496 96 
            LINE N 64 -608 0 -608 
            LINE N 64 -544 0 -544 
            LINE N 64 -480 0 -480 
            LINE N 64 -416 0 -416 
            RECTANGLE N 0 -364 64 -340 
            LINE N 64 -352 0 -352 
            RECTANGLE N 0 -300 64 -276 
            LINE N 64 -288 0 -288 
            RECTANGLE N 0 -236 64 -212 
            LINE N 64 -224 0 -224 
            RECTANGLE N 0 -172 64 -148 
            LINE N 64 -160 0 -160 
            RECTANGLE N 0 -108 64 -84 
            LINE N 64 -96 0 -96 
            LINE N 432 -288 496 -288 
            LINE N 432 -96 496 -96 
            RECTANGLE N 432 -620 496 -596 
            LINE N 432 -608 496 -608 
            LINE N 432 -544 496 -544 
            LINE N 432 -160 496 -160 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 20 64 44 
            LINE N 64 32 0 32 
            LINE N 432 -32 496 -32 
            LINE N 432 32 496 32 
            LINE N 64 -64 432 -64 
            LINE N 432 -192 64 -192 
            LINE N 64 -320 432 -320 
            LINE N 64 64 432 64 
            RECTANGLE N 64 -640 432 388 
            LINE N 64 192 432 192 
            RECTANGLE N 0 212 64 236 
            LINE N 64 224 0 224 
        END BLOCKDEF
        BEGIN BLOCKDEF TxUnit
            TIMESTAMP 2008 11 17 12 23 22
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
        BEGIN BLOCKDEF ClkUnit
            TIMESTAMP 2008 11 17 12 23 6
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF RxUnit
            TIMESTAMP 2008 11 17 12 23 16
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
        BEGIN BLOCK XLXI_109 datamux
            PIN clk clk_cpu
            PIN reset reset
            PIN cpu_next_rd XLXN_433
            PIN cpu_next_we XLXN_434
            PIN spi_ack spi_ack
            PIN cpu_next_addr(15:0) cpu_addr(15:0)
            PIN ram_data(7:0) ram_data(7:0)
            PIN rom_data(7:0) rom_data(7:0)
            PIN uart_data(7:0) uart_data(7:0)
            PIN uart_status(7:0) uart_status(7:0)
            PIN spi_data(7:0) spi_data(7:0)
            PIN maxspi_data(7:0) maxspi_data(7:0)
            PIN cpu_enable cpu_enable
            PIN ram_we ram_we
            PIN uart_rd uart_rd
            PIN uart_load uart_load
            PIN spi_wr spi_we
            PIN spi_stb spi_stb
            PIN maxspi_wr maxspi_wr
            PIN cpu_di(7:0) cpu_di(7:0)
            PIN maxspi_rd maxspi_rd
            PIN gpio_wr gpio_wr
            PIN gpio_rd gpio_rd
            PIN gpio_data(7:0) gpio_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_102 vcc
            PIN P XLXN_222
        END BLOCK
        BEGIN BLOCK XLXI_55 ClkUnit
            PIN SysClk clk_cpu
            PIN Reset reset
            PIN EnableRx XLXN_113
            PIN EnableTx XLXN_114
        END BLOCK
        BEGIN BLOCK XLXI_57 TxUnit
            PIN Clk clk_cpu
            PIN Reset reset
            PIN Enable XLXN_114
            PIN Load uart_load
            PIN DataO(7:0) cpu_do(7:0)
            PIN TxD UART_TX
            PIN TRegE uart_status(0)
            PIN TBufE uart_status(1)
        END BLOCK
        BEGIN BLOCK XLXI_56 RxUnit
            PIN Clk clk_cpu
            PIN Reset reset
            PIN Enable XLXN_113
            PIN RxD UART_RX
            PIN RD uart_rd
            PIN FErr uart_status(2)
            PIN OErr uart_status(3)
            PIN DRdy uart_status(4)
            PIN DataIn(7:0) uart_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_104 cpu_rom
            PIN clk clk_cpu
            PIN addr(12:0) cpu_addr(12:0)
            PIN dataOut(7:0) rom_data(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_101 cpu_ram
            PIN Clk clk_cpu
            PIN writeEn ram_we
            PIN addr(14:0) cpu_addr(14:0)
            PIN dataIn(7:0) cpu_do(7:0)
            PIN dataOut(7:0) ram_data(7:0)
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
        BEGIN BLOCK XLXI_487 buf
            PIN I wheel1
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_488 buf
            PIN I wheel2
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_489 buf
            PIN I bump1
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_490 buf
            PIN I bump2
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_491 buf
            PIN I front_wheel
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_492 buf
            PIN I IR
            PIN O
        END BLOCK
        BEGIN BLOCK XLXI_506 vcc
            PIN P XLXN_1298
        END BLOCK
        BEGIN BLOCK XLXI_505 gnd
            PIN G XLXN_1294
        END BLOCK
        BEGIN BLOCK XLXI_480 buf
            PIN I cnt(5)
            PIN O snd
        END BLOCK
        BEGIN BLOCK XLXI_479 buf
            PIN I XLXN_1298
            PIN O leds_power
        END BLOCK
        BEGIN BLOCK XLXI_478 buf
            PIN I XLXN_1294
            PIN O m2b
        END BLOCK
        BEGIN BLOCK XLXI_477 buf
            PIN I XLXN_1294
            PIN O m2a
        END BLOCK
        BEGIN BLOCK XLXI_476 buf
            PIN I XLXN_1294
            PIN O m1b
        END BLOCK
        BEGIN BLOCK XLXI_475 buf
            PIN I XLXN_1294
            PIN O m1a
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
        BEGIN BLOCK XLXI_643 stepper_ctrl
            PIN clk
            PIN reset
            PIN relative
            PIN start
            PIN target_time(31:0)
            PIN target_position(31:0)
            PIN target_velocity(31:0)
            PIN set_position
            PIN data_in(31:0)
            PIN end_position(31:0)
            PIN end_velocity(31:0)
            PIN done
            PIN acc(31:0)
            PIN dir
            PIN step
            PIN velocity(31:0)
            PIN position(31:0)
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
            WIRE 1520 2144 1536 2144
            WIRE 1536 2144 1648 2144
            BEGIN DISPLAY 1536 2144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1520 1952 1536 1952
            WIRE 1536 1952 1648 1952
            BEGIN DISPLAY 1536 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 1520 1888 1536 1888
            WIRE 1536 1888 1648 1888
            BEGIN DISPLAY 1536 1888 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_data(7:0)
            WIRE 1440 2208 1520 2208
            WIRE 1520 2208 1648 2208
            BEGIN DISPLAY 1520 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH rom_data(7:0)
            WIRE 1472 2272 1520 2272
            WIRE 1520 2272 1648 2272
            BEGIN DISPLAY 1520 2272 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_433
            WIRE 1040 1920 1344 1920
            WIRE 1344 1920 1344 2016
            WIRE 1344 2016 1648 2016
        END BRANCH
        BEGIN BRANCH XLXN_434
            WIRE 1040 1856 1328 1856
            WIRE 1328 1856 1328 2080
            WIRE 1328 2080 1648 2080
        END BRANCH
        BEGIN BRANCH uart_status(7:0)
            WIRE 1488 2400 1504 2400
            WIRE 1504 2400 1648 2400
            BEGIN DISPLAY 1504 2400 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_data(7:0)
            WIRE 1488 2336 1504 2336
            WIRE 1504 2336 1648 2336
            BEGIN DISPLAY 1504 2336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_109 1648 2496 R0
        END INSTANCE
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
        BEGIN BRANCH spi_data(7:0)
            WIRE 1552 2528 1568 2528
            WIRE 1568 2528 1648 2528
            BEGIN DISPLAY 1568 2528 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_ack
            WIRE 1552 2464 1584 2464
            WIRE 1584 2464 1648 2464
            BEGIN DISPLAY 1584 2464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_we
            WIRE 2144 2464 2192 2464
            WIRE 2192 2464 2240 2464
            BEGIN DISPLAY 2192 2464 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_stb
            WIRE 2144 2528 2192 2528
            WIRE 2192 2528 2240 2528
            BEGIN DISPLAY 2192 2528 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_load
            WIRE 2144 2336 2176 2336
            WIRE 2176 2336 2224 2336
            BEGIN DISPLAY 2176 2336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_rd
            WIRE 2144 2400 2176 2400
            WIRE 2176 2400 2224 2400
            BEGIN DISPLAY 2176 2400 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_we
            WIRE 2144 2208 2176 2208
            WIRE 2176 2208 2224 2208
            BEGIN DISPLAY 2176 2208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_di(7:0)
            WIRE 512 2496 560 2496
            WIRE 560 2496 656 2496
            BEGIN DISPLAY 560 2496 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_di(7:0)
            WIRE 2144 1888 2224 1888
            WIRE 2224 1888 2240 1888
            BEGIN DISPLAY 2224 1888 ATTR Name
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
        BEGIN BRANCH cpu_enable
            WIRE 2144 1952 2176 1952
            WIRE 2176 1952 2240 1952
            BEGIN DISPLAY 2176 1952 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_114
            WIRE 1104 3728 1360 3728
        END BRANCH
        BEGIN INSTANCE XLXI_55 720 3760 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 672 3664 720 3664
            BEGIN DISPLAY 672 3664 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 672 3728 720 3728
            BEGIN DISPLAY 672 3728 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_113
            WIRE 1104 3664 1152 3664
            WIRE 1152 3312 1152 3664
            WIRE 1152 3312 1360 3312
        END BRANCH
        BEGIN INSTANCE XLXI_57 1360 3888 R0
        END INSTANCE
        BEGIN BRANCH uart_status(1)
            WIRE 1744 3856 1840 3856
            BEGIN DISPLAY 1840 3856 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_status(0)
            WIRE 1744 3728 1840 3728
            BEGIN DISPLAY 1840 3728 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_load
            WIRE 1328 3792 1360 3792
            BEGIN DISPLAY 1328 3792 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 1328 3856 1360 3856
            BEGIN DISPLAY 1328 3856 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1328 3664 1360 3664
            BEGIN DISPLAY 1328 3664 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 1328 3600 1360 3600
            BEGIN DISPLAY 1328 3600 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UART_TX
            WIRE 1744 3600 1872 3600
        END BRANCH
        IOMARKER 1872 3600 UART_TX R0 28
        BEGIN BRANCH uart_rd
            WIRE 1328 3440 1360 3440
            BEGIN DISPLAY 1328 3440 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_data(7:0)
            WIRE 1744 3424 1840 3424
            BEGIN DISPLAY 1840 3424 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_status(4)
            WIRE 1744 3344 1840 3344
            BEGIN DISPLAY 1840 3344 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_status(3)
            WIRE 1744 3264 1840 3264
            BEGIN DISPLAY 1840 3264 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH uart_status(2)
            WIRE 1744 3184 1840 3184
            BEGIN DISPLAY 1840 3184 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_56 1360 3472 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 1328 3184 1360 3184
            BEGIN DISPLAY 1328 3184 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 1328 3248 1360 3248
            BEGIN DISPLAY 1328 3248 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH UART_RX
            WIRE 1056 3376 1360 3376
        END BRANCH
        IOMARKER 1056 3376 UART_RX R180 28
        BEGIN BRANCH cpu_addr(12:0)
            WIRE 640 4304 688 4304
            WIRE 688 4304 736 4304
            BEGIN DISPLAY 688 4304 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_104 736 4336 R0
        END INSTANCE
        BEGIN BRANCH rom_data(7:0)
            WIRE 1120 4240 1200 4240
            WIRE 1200 4240 1216 4240
            BEGIN DISPLAY 1200 4240 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 640 4240 672 4240
            WIRE 672 4240 736 4240
            BEGIN DISPLAY 672 4240 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_we
            WIRE 1504 4208 1536 4208
            WIRE 1536 4208 1600 4208
            BEGIN DISPLAY 1536 4208 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH ram_data(7:0)
            WIRE 1984 4144 2016 4144
            WIRE 2016 4144 2064 4144
            BEGIN DISPLAY 2016 4144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_101 1600 4368 R0
        END INSTANCE
        BEGIN BRANCH cpu_addr(14:0)
            WIRE 1504 4272 1536 4272
            WIRE 1536 4272 1600 4272
            BEGIN DISPLAY 1536 4272 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 1552 4144 1568 4144
            WIRE 1568 4144 1600 4144
            BEGIN DISPLAY 1568 4144 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 1456 4336 1520 4336
            WIRE 1520 4336 1600 4336
            BEGIN DISPLAY 1520 4336 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_367 784 5072 R0
        END INSTANCE
        BEGIN BRANCH clk_cpu
            WIRE 672 4592 688 4592
            WIRE 688 4592 784 4592
            BEGIN DISPLAY 688 4592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 672 4656 688 4656
            WIRE 688 4656 784 4656
            BEGIN DISPLAY 688 4656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_stb
            WIRE 672 4720 688 4720
            WIRE 688 4720 784 4720
            BEGIN DISPLAY 688 4720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_we
            WIRE 672 4784 688 4784
            WIRE 688 4784 784 4784
            BEGIN DISPLAY 688 4784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 672 4848 688 4848
            WIRE 688 4848 784 4848
            BEGIN DISPLAY 688 4848 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH SD_DI
            WIRE 688 4912 784 4912
        END BRANCH
        BEGIN BRANCH SD_CLK
            WIRE 1232 4704 1360 4704
        END BRANCH
        BEGIN BRANCH SD_DO
            WIRE 1232 4816 1360 4816
        END BRANCH
        BEGIN BRANCH SD_CS
            WIRE 1232 4928 1360 4928
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 672 4976 688 4976
            WIRE 688 4976 784 4976
            BEGIN DISPLAY 688 4976 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 672 5040 688 5040
            WIRE 688 5040 784 5040
            BEGIN DISPLAY 688 5040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_data(7:0)
            WIRE 1232 5040 1344 5040
            WIRE 1344 5040 1376 5040
            BEGIN DISPLAY 1344 5040 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH spi_ack
            WIRE 1232 4592 1328 4592
            WIRE 1328 4592 1344 4592
            BEGIN DISPLAY 1328 4592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        IOMARKER 688 4912 SD_DI R180 28
        IOMARKER 1360 4704 SD_CLK R0 28
        IOMARKER 1360 4816 SD_DO R0 28
        IOMARKER 1360 4928 SD_CS R0 28
        BEGIN BRANCH maxspi_data(7:0)
            WIRE 1552 2592 1648 2592
            BEGIN DISPLAY 1552 2592 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_wr
            WIRE 2144 2592 2176 2592
            WIRE 2176 2592 2240 2592
            BEGIN DISPLAY 2176 2592 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_rd
            WIRE 2144 2656 2160 2656
            WIRE 2160 2656 2240 2656
            BEGIN DISPLAY 2160 2656 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_507 3264 4800 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1299(7:0)
            WIRE 3216 4768 3264 4768
            WIRE 3216 4768 3216 4816
            WIRE 3216 4816 4560 4816
            WIRE 4496 4256 4560 4256
            WIRE 4560 4256 4560 4816
        END BRANCH
        BEGIN BRANCH flashspi_do
            WIRE 3184 4672 3248 4672
            WIRE 3248 4672 3248 4704
            WIRE 3248 4704 3264 4704
        END BRANCH
        BEGIN BRANCH flashspi_clk
            WIRE 3728 4704 3776 4704
            WIRE 3776 4704 3776 4976
            WIRE 3776 4976 3792 4976
            WIRE 3776 4704 3824 4704
        END BRANCH
        BEGIN BRANCH flashspi_di
            WIRE 3728 4768 3760 4768
            WIRE 3760 4768 3760 5104
            WIRE 3760 5104 3792 5104
            WIRE 3760 4768 3824 4768
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 3168 4320 3184 4320
            WIRE 3184 4320 3264 4320
            BEGIN DISPLAY 3184 4320 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3168 4384 3184 4384
            WIRE 3184 4384 3264 4384
            BEGIN DISPLAY 3184 4384 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1511
            WIRE 3728 4576 3888 4576
            WIRE 3888 4512 3888 4576
            WIRE 3888 4512 4048 4512
        END BRANCH
        BEGIN BRANCH XLXN_1513(7:0)
            WIRE 3728 4384 4048 4384
        END BRANCH
        BEGIN BRANCH XLXN_1514
            WIRE 3728 4320 4048 4320
        END BRANCH
        BEGIN INSTANCE XLXI_592 4048 4544 R0
        END INSTANCE
        BEGIN BRANCH XLXN_1512
            WIRE 3728 4512 3744 4512
            WIRE 3744 4448 4048 4448
            WIRE 3744 4448 3744 4512
        END BRANCH
        BEGIN BRANCH XLXN_1516
            WIRE 2960 4512 2960 4848
            WIRE 2960 4848 4576 4848
            WIRE 2960 4512 3264 4512
            WIRE 4496 4512 4576 4512
            WIRE 4576 4512 4576 4848
        END BRANCH
        BEGIN BRANCH XLXN_1517(7:0)
            WIRE 2992 4576 3264 4576
            WIRE 2992 4576 2992 4880
            WIRE 2992 4880 4608 4880
            WIRE 4496 4448 4608 4448
            WIRE 4608 4448 4608 4880
        END BRANCH
        BEGIN BRANCH flashspi_ss
            WIRE 4496 4000 4864 4000
        END BRANCH
        BEGIN BRANCH clk_cpu
            WIRE 3952 3936 4048 3936
            BEGIN DISPLAY 3952 3936 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH reset
            WIRE 3952 4000 4048 4000
            BEGIN DISPLAY 3952 4000 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_wr
            WIRE 3952 4064 4048 4064
            BEGIN DISPLAY 3952 4064 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_rd
            WIRE 3952 4128 4048 4128
            BEGIN DISPLAY 3952 4128 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_addr(7:0)
            WIRE 3952 4192 4048 4192
            BEGIN DISPLAY 3952 4192 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH cpu_do(7:0)
            WIRE 3952 4256 4048 4256
            BEGIN DISPLAY 3952 4256 ATTR Name
                ALIGNMENT SOFT-RIGHT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH maxspi_data(7:0)
            WIRE 4496 3936 4592 3936
            BEGIN DISPLAY 4592 3936 ATTR Name
                ALIGNMENT SOFT-LEFT
            END DISPLAY
        END BRANCH
        BEGIN BRANCH osram_load
            WIRE 4496 4064 4848 4064
        END BRANCH
        INSTANCE XLXI_596 3792 5008 R0
        INSTANCE XLXI_597 3792 5136 R0
        BEGIN BRANCH osram_clk
            WIRE 4016 4976 4096 4976
        END BRANCH
        BEGIN BRANCH osram_data
            WIRE 4016 5104 4096 5104
        END BRANCH
        IOMARKER 3184 4672 flashspi_do R180 28
        IOMARKER 4096 4976 osram_clk R0 28
        IOMARKER 4096 5104 osram_data R0 28
        IOMARKER 3824 4704 flashspi_clk R0 28
        IOMARKER 3824 4768 flashspi_di R0 28
        IOMARKER 4848 4064 osram_load R0 28
        IOMARKER 4864 4000 flashspi_ss R0 28
        INSTANCE XLXI_487 3392 3200 R0
        BEGIN BRANCH wheel1
            WIRE 3248 3168 3392 3168
        END BRANCH
        INSTANCE XLXI_488 3392 3296 R0
        BEGIN BRANCH wheel2
            WIRE 3248 3264 3392 3264
        END BRANCH
        BEGIN BRANCH bump1
            WIRE 3248 3360 3392 3360
        END BRANCH
        INSTANCE XLXI_489 3392 3392 R0
        INSTANCE XLXI_490 3392 3488 R0
        BEGIN BRANCH bump2
            WIRE 3248 3456 3392 3456
        END BRANCH
        INSTANCE XLXI_491 3392 3584 R0
        BEGIN BRANCH front_wheel
            WIRE 3248 3552 3392 3552
        END BRANCH
        INSTANCE XLXI_492 3392 3680 R0
        BEGIN BRANCH IR
            WIRE 3248 3648 3392 3648
        END BRANCH
        BEGIN BRANCH cnt(5)
            WIRE 4256 3744 4288 3744
            WIRE 4288 3744 4384 3744
            BEGIN DISPLAY 4288 3744 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH XLXN_1294
            WIRE 3936 3216 4272 3216
            WIRE 4272 3216 4272 3312
            WIRE 4272 3312 4272 3408
            WIRE 4272 3408 4272 3520
            WIRE 4272 3520 4384 3520
            WIRE 4272 3408 4384 3408
            WIRE 4272 3312 4384 3312
            WIRE 4272 3216 4384 3216
            WIRE 3936 3216 3936 3360
        END BRANCH
        INSTANCE XLXI_506 4016 3616 R0
        INSTANCE XLXI_505 3872 3488 R0
        BEGIN BRANCH XLXN_1298
            WIRE 4080 3616 4080 3632
            WIRE 4080 3632 4384 3632
        END BRANCH
        INSTANCE XLXI_480 4384 3776 R0
        BEGIN BRANCH snd
            WIRE 4608 3744 4752 3744
        END BRANCH
        INSTANCE XLXI_479 4384 3664 R0
        BEGIN BRANCH leds_power
            WIRE 4608 3632 4752 3632
        END BRANCH
        INSTANCE XLXI_478 4384 3552 R0
        BEGIN BRANCH m2b
            WIRE 4608 3520 4752 3520
        END BRANCH
        INSTANCE XLXI_477 4384 3440 R0
        BEGIN BRANCH m2a
            WIRE 4608 3408 4752 3408
        END BRANCH
        INSTANCE XLXI_476 4384 3344 R0
        BEGIN BRANCH m1b
            WIRE 4608 3312 4752 3312
        END BRANCH
        INSTANCE XLXI_475 4384 3248 R0
        BEGIN BRANCH m1a
            WIRE 4608 3216 4752 3216
        END BRANCH
        IOMARKER 3248 3168 wheel1 R180 28
        IOMARKER 3248 3264 wheel2 R180 28
        IOMARKER 3248 3360 bump1 R180 28
        IOMARKER 3248 3456 bump2 R180 28
        IOMARKER 3248 3552 front_wheel R180 28
        IOMARKER 3248 3648 IR R180 28
        IOMARKER 4752 3744 snd R0 28
        IOMARKER 4752 3632 leds_power R0 28
        IOMARKER 4752 3520 m2b R0 28
        IOMARKER 4752 3408 m2a R0 28
        IOMARKER 4752 3312 m1b R0 28
        IOMARKER 4752 3216 m1a R0 28
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
        BEGIN BRANCH gpio_data(7:0)
            WIRE 1552 2720 1568 2720
            WIRE 1568 2720 1648 2720
            BEGIN DISPLAY 1568 2720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_wr
            WIRE 2144 2720 2176 2720
            WIRE 2176 2720 2240 2720
            BEGIN DISPLAY 2176 2720 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN BRANCH gpio_rd
            WIRE 2144 2784 2176 2784
            WIRE 2176 2784 2240 2784
            BEGIN DISPLAY 2176 2784 ATTR Name
                ALIGNMENT SOFT-BCENTER
            END DISPLAY
        END BRANCH
        BEGIN INSTANCE XLXI_643 5904 3552 R0
        END INSTANCE
    END SHEET
END SCHEMATIC
