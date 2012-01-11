-------------------------------------------------------------------------------
--
-- $Id$
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
-- 02111-1307, USA.
--
-- Written by Arnim Laeuger <arniml@users.sourceforge.net>, 2008.
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fjmem_max is

  port (
    altera_reserved_tck : in    std_logic;
    altera_reserved_tms : in    std_logic;
    altera_reserved_tdi : in    std_logic;
    altera_reserved_tdo : out   std_logic;
    ext_clk_i     : in    std_logic;
    fl_a_o        : out   std_logic_vector(21 downto 0);
    fl_d_b        : inout std_logic_vector( 15 downto 0);
    fl_we_n_o     : out   std_logic;
    fl_oe_n_o     : out   std_logic;
    fl_cs_n_o     : out   std_logic;
    fl_cs2_n_o    : out   std_logic;
    fl_rdy_i      : in    std_logic;
    ufm_a_o        : out   std_logic_vector(8 downto 0);
    ufm_d_o        : out std_logic_vector( 15 downto 0);
    ufm_d_i        : in std_logic_vector( 15 downto 0);
    ufm_we_n_o     : out   std_logic;
    ufm_oe_n_o     : out   std_logic;
    ufm_rdy_i      : in    std_logic
  );

end fjmem_max;

library ieee;
use ieee.numeric_std.all;

use work.fjmem_config_pack.all;

architecture struct of fjmem_max is

  component fjmem_core
    port (
      clkdr_i  : in  std_logic;
      trst_i   : in  std_logic;
      shift_i  : in  std_logic;
      update_i : in  std_logic;
      tdi_i    : in  std_logic;
      tdo_o    : out std_logic;
      clk_i    : in  std_logic;
      res_i    : in  std_logic;
      strobe_o : out std_logic;
      read_o   : out std_logic;
      write_o  : out std_logic;
      ack_i    : in  std_logic;
      cs_o     : out std_logic_vector(num_blocks_c-1 downto 0);
      addr_o   : out std_logic_vector(max_addr_width_c-1 downto 0);
      din_i    : in  std_logic_vector(max_data_width_c-1 downto 0);
      dout_o   : out std_logic_vector(max_data_width_c-1 downto 0)
    );
  end component;

  component maxii_jtag
    port (
      tms         : in  std_logic;
      tck         : in  std_logic;
      tdi         : in  std_logic;
      tdo         : out std_logic;
      tmsutap     : out std_logic;
      tckutap     : out std_logic;
      tdiutap     : out std_logic;
      tdouser     : in  std_logic;
      shiftuser   : out std_logic;
      clkdruser   : out std_logic;
      updateuser  : out std_logic;
      runidleuser : out std_logic;
      usr1user    : out std_logic
    );
  end component;

  signal tdi_s,
         tdo_s    : std_logic;
  signal clkdr_s,
         trst_s,
         shift_s,
         update_s : std_logic;

  signal addr_s   : std_logic_vector(max_addr_width_c-1 downto 0);
  signal din_s,
         dout_s   : std_logic_vector(max_data_width_c-1 downto 0);

  signal res_s    : std_logic;

  signal read_s,
         write_s,
         strobe_s : std_logic;
  signal cs_s     : std_logic_vector(1 downto 0);
  signal ack_q    : std_logic;

  type   state_t is (IDLE,
                     READ_WAIT,
                     WRITE_DRIVE,
                     WRITE_WAIT,
                     WRITE_FINISH);
  signal state_q : state_t;

  signal cnt_q : unsigned(1 downto 0);

  signal fl_cs_n_q,
         fl_oe_n_q,
         fl_we_n_q,
         fl_d_en_q    : std_logic;

  signal ufm_oe_n_q,
         ufm_we_n_q    : std_logic;

begin

  res_s <= '0';

  maxii_jtag_b : maxii_jtag
    port map (
      tms         => altera_reserved_tms,
      tck         => altera_reserved_tck,
      tdi         => altera_reserved_tdi,
      tdo         => altera_reserved_tdo,
      tmsutap     => open,
      tckutap     => open,
      tdiutap     => tdi_s,
      tdouser     => tdo_s,
      shiftuser   => shift_s,
      clkdruser   => clkdr_s,
      updateuser  => update_s,
      runidleuser => open, --trst_s,
      usr1user    => open
    );
  trst_s <= '0';

  fjmem_core_b : fjmem_core
    port map (
      clkdr_i  => clkdr_s,
      trst_i   => trst_s,
      shift_i  => shift_s,
      update_i => update_s,
      tdi_i    => tdi_s,
      tdo_o    => tdo_s,
      clk_i    => ext_clk_i,
      res_i    => res_s,
      strobe_o => strobe_s,
      read_o   => read_s,
      write_o  => write_s,
      ack_i    => ack_q,
      cs_o     => cs_s,
      addr_o   => addr_s,
      din_i    => din_s,
      dout_o   => dout_s
    );

  -----------------------------------------------------------------------------
  -- Process mem_ctrl
  --
  -- Purpose:
  --   Handles access to external memory.
  --
  mem_ctrl: process (res_s, ext_clk_i)
  begin
    if res_s = '1' then
      -- Flash
      fl_cs_n_q   <= '1';
      fl_oe_n_q   <= '1';
      fl_we_n_q   <= '1';
      fl_d_en_q   <= '0';
      -- UFM
      ufm_oe_n_q   <= '1';
      ufm_we_n_q   <= '1';

      ack_q <= '0';

      state_q     <= IDLE;
      cnt_q       <= (others => '0');

    elsif rising_edge(ext_clk_i) then
      case state_q is
        when IDLE =>
          if strobe_s = '1' then
            if write_s = '1' then
              state_q <= WRITE_DRIVE;
            else
              state_q <= READ_WAIT;
              ack_q   <= '1';
            end if;

            case cs_s is
              -- Flash
              when "01" =>
                fl_cs_n_q   <= '0';
                if read_s = '1' then
                  fl_oe_n_q <= '0';
                  -- start counter on read
                  cnt_q     <= (others => '1');
                end if;
                if write_s = '1' then
                  fl_d_en_q <= '1';
                end if;

              -- UFM
              when "10" =>
                if read_s = '1' then
                  ufm_oe_n_q <= '0';
                end if;

              -- unimlemented / invalid
              when others =>
                null;

            end case;
          end if;

        when READ_WAIT =>
          if cnt_q = 0 then
            state_q <= IDLE;
            ack_q   <= '0';

            -- disable all memories
            fl_cs_n_q   <= '1';
            fl_oe_n_q   <= '1';
            ufm_oe_n_q   <= '1';
            ufm_we_n_q   <= '1';
          end if;

        when WRITE_DRIVE =>
          state_q <= WRITE_WAIT;

          -- output drivers are active during this state
          -- thus we can activate the write impulse at the end
          case cs_s is
            when "01" =>
              fl_we_n_q <= '0';
              -- start counter
              cnt_q     <= (others => '1');
            when "10" =>
              ufm_we_n_q <= '0';
              -- start counter
              cnt_q     <= (others => '1');
            when others =>
              null;
          end case;

        when WRITE_WAIT =>
          if cnt_q = 0 then
            state_q <= WRITE_FINISH;
            ack_q   <= '0';

            -- disable write signals
            fl_we_n_q   <= '1';
            ufm_we_n_q   <= '1';
          end if;

        when WRITE_FINISH =>
          state_q <= IDLE;

          -- disable output enables
          fl_d_en_q   <= '0';
          -- disable all memories
          fl_cs_n_q   <= '1';
          fl_oe_n_q   <= '1';
          ufm_oe_n_q   <= '1';
          ufm_we_n_q   <= '1';

        when others =>
          state_q <= IDLE;

      end case;

      if cnt_q /= 0 then
        cnt_q <= cnt_q - 1;
      end if;

    end if;
  end process mem_ctrl;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- Process read_mux
  --
  -- Purpose:
  --   Read multiplexer from memory to jop_core.
  --
  read_mux: process (cs_s,
                     fl_d_b,
                     ufm_d_i)
    variable din_v : std_logic_vector(din_s'range);
  begin
    din_v := (others => '0');

    if cs_s(0) = '1' then
      din_v := din_v or fl_d_b;
    end if;
    if cs_s(1) = '1' then
      din_v := din_v or ufm_d_i;
    end if;

    din_s <= din_v;
  end process read_mux;
  --
  -----------------------------------------------------------------------------


  -----------------------------------------------------------------------------
  -- JOP pin defaults
  -----------------------------------------------------------------------------
  -- Flash
  fl_a_o      <= addr_s(21 downto 0);
  fl_d_b      <=   dout_s(15 downto 0)
                 when fl_d_en_q = '1' else
                   (others => 'Z');
  fl_we_n_o   <= fl_we_n_q;
  fl_oe_n_o   <= fl_oe_n_q;
  fl_cs_n_o   <= fl_cs_n_q;
  fl_cs2_n_o  <= '1';
  
  -- UFM
  ufm_we_n_o   <= ufm_we_n_q;
  ufm_oe_n_o   <= ufm_oe_n_q;
  ufm_a_o      <= addr_s(8 downto 0);
  ufm_d_o      <=   dout_s;
  
end struct;
