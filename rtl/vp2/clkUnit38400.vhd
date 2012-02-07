--===========================================================================--
--
--  S Y N T H E Z I A B L E    miniUART   C O R E
--
--  www.OpenCores.Org - January 2000
--  This core adheres to the GNU public license  

-- Design units   : miniUART core for the OCRP-1
--
-- File name      : clkUnit.vhd
--
-- Purpose        : Implements an miniUART device for communication purposes 
--                  between the OR1K processor and the Host computer through
--                  an RS-232 communication protocol.
--                  
-- Library        : uart_lib.vhd
--
-- Dependencies   : IEEE.Std_Logic_1164
--
--===========================================================================--
-------------------------------------------------------------------------------
-- Revision list
-- Version   Author              Date                Changes
--
-- 1.0     Ovidiu Lupas      15 January 2000         New model
-- 1.1     Ovidiu Lupas      28 May 2000     EnableRx/EnableTx ratio corrected
--      olupas@opencores.org
-------------------------------------------------------------------------------
-- Description    : Generates the Baud clock and enable signals for RX & TX
--                  units. 
-------------------------------------------------------------------------------
-- Entity for Baud rate generator Unit - 9600 baudrate                       --
-------------------------------------------------------------------------------
library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library work;
   use work.UART_Def.all;
-------------------------------------------------------------------------------
-- Baud rate generator
-------------------------------------------------------------------------------
entity ClkUnit38400 is
	port (
		SysClk   : in  Std_Logic;  -- System Clock
		EnableRx : out Std_Logic;  -- Control signal
		EnableTx : out Std_Logic;  -- Control signal
		Reset    : in  Std_Logic; -- Reset input
		Divider  : in Std_Logic_Vector(15 downto 0)
	);  -- Control signal

end entity; --================== End of entity ==============================--
-------------------------------------------------------------------------------
-- Architecture for Baud rate generator Unit
-------------------------------------------------------------------------------
architecture Behaviour of ClkUnit38400 is
  -----------------------------------------------------------------------------
  -- Signals
  -----------------------------------------------------------------------------
  signal tmpEnRX   : Std_Logic;
  signal tmpEnTX   : Std_Logic;
  
begin
  -----------------------------------------------------------------------------
  -- Provides the EnableRX signal, at ~ 155 KHz
  -----------------------------------------------------------------------------
  DivClk166 : process(SysClk,Reset,Divider)
     constant CntOne : unsigned(15 downto 0) := "0000000000000001";
     variable Cnt166  : unsigned(15 downto 0);
  begin
		if Rising_Edge(SysClk) then
			if Reset = '1' then
				Cnt166 := "0000000000000000";
				tmpEnRX <= '0';
			else
				Cnt166 := Cnt166 + CntOne;
			end if;
			if Cnt166 >= unsigned(Divider) then
				tmpEnRX <= '1';
				Cnt166 := "0000000000000000";
			else
				tmpEnRX <= '0';
			end if;
		end if;
  end process;
  -----------------------------------------------------------------------------
  -- Provides the EnableTX signal, at 9.6 KHz
  -----------------------------------------------------------------------------
  DivClk16 : process(SysClk,Reset,tmpEnRX)
     constant CntOne : unsigned(4 downto 0) := "00001";
     variable Cnt16  : unsigned(4 downto 0);
  begin
     if Rising_Edge(SysClk) then
        if Reset = '1' then
           Cnt16 := "00000";
           tmpEnTX <= '0';
        elsif tmpEnRX = '1' then
           Cnt16 := Cnt16 + CntOne;
        end if;
        case Cnt16 is
           when "01111" =>
                tmpEnTX <= '1';
                Cnt16 := Cnt16 + CntOne;
           when "10001" =>
                Cnt16 := "00000";
                tmpEnTX <= '0';
           when others =>
                tmpEnTX <= '0';
        end case;
     end if;
  end process;

  EnableRX <= tmpEnRX;
  EnableTX <= tmpEnTX;
end Behaviour; --==================== End of architecture ===================--
