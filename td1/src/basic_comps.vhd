-------------------------------------------------------------------------------
-- Title      : basic generic components
-- Project    :
-------------------------------------------------------------------------------
-- File       : regModule.vhd
-- Author     : michel agoyan  <michel.agoyan@st.com>
-- Company    :
-- Created    : 2015-11-15
-- Last update: 2019-11-15
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: register with parametrable width and muxed input
--              mux  with parametrable width
--              demux with parametrable width
-------------------------------------------------------------------------------
-- Copyright (c) 2015
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-15  1.0      magoyan Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package basic_comps is
  component reg_comp is
    generic (
      width : positive);
    port (
      data1_i : in  std_logic_vector(width-1 downto 0);
      data0_i  : in  std_logic_vector(width-1 downto 0);
      sel_i : in  std_logic;
      en_i        : in  std_logic;
      clk_i       : in  std_logic;
      resetn_i    : in  std_logic;
      data_o      : out std_logic_vector(width-1 downto 0));
  end component reg_comp;

  component mux_comp is
    generic (
      width : positive;
      n     : positive);
    port (
      data_i : in  std_logic_vector(width*(2**n)-1 downto 0);
      sel_i  : in  std_logic_vector(n-1 downto 0);
      data_o : out std_logic_vector(width-1 downto 0));
  end component mux_comp;

  component demux_comp is
    generic (
      width : positive;
      n     : positive);
    port (
      data_i : in  std_logic_vector(width-1 downto 0);
      sel_i  : in  std_logic_vector(n-1 downto 0);
      data_o : out std_logic_vector(width*(2**n)-1 downto 0));
  end component demux_comp;

end package basic_comps;


package body basic_comps is
end package body basic_comps;

library ieee;
use ieee.std_logic_1164.all;

entity reg_comp is

  generic (
    width : positive := 32);            -- register width

  port (
    data1_i : in  std_logic_vector(width-1 downto 0);
    data0_i  : in  std_logic_vector(width-1 downto 0);
    sel_i : in  std_logic;        -- 1 for data1 ; 0 for data0
    en_i        : in  std_logic;
    clk_i       : in  std_logic;
    resetn_i    : in  std_logic;
    data_o      : out std_logic_vector(width-1 downto 0));

end entity reg_comp;


architecture reg_arch of reg_comp is

begin  -- architecture arch
  -- purpose: core register
  -- type   : sequential
  -- inputs : clk_i, resetn_i
  -- outputs: data_o
  reg_proc : process (clk_i, resetn_i) is
  begin  -- process reg
    if resetn_i = '0' then                  -- asynchronous reset (active low)
      data_o <= (others => '0');
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      if en_i = '1' then
        if sel_i = '1' then
          data_o <= data1_i;
        elsif sel_i = '0' then
          data_o <= data0_i;
        end if;
      end if;
    end if;
  end process reg_proc;

end architecture reg_arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_comp is
  generic (
    width : positive := 32;             -- width of one of the nb ports
    n    : positive := 5);             -- nb of input ports = 2^n

  port (
    data_i : in std_logic_vector(width*(2**n)-1 downto 0);
    sel_i  : in std_logic_vector(n-1 downto 0);
    data_o : out std_logic_vector(width-1 downto 0));

end entity mux_comp;



architecture mux_comp_arch of mux_comp is

begin  -- architecture mux_comp_arch
  data_o <= data_i(width*To_integer(Unsigned(sel_i)+1) - 1 downto width*(To_integer(Unsigned(sel_i)+1)-1));
end architecture mux_comp_arch;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity demux_comp is

  generic (
    width : positive := 1;              -- width of the input port
    n     : positive := 5);             -- nb of output ports = 2

  port (
    data_i     : in  std_logic_vector(width-1 downto 0);
    sel_i      : in  std_logic_vector(n-1 downto 0);
    data_o       : out std_logic_vector(width*(2**n)-1 downto 0));
end entity demux_comp;

architecture demux_comp_arch of demux_comp is

begin  -- architecture demux_comp_arch


  demux_comb_proc:process (sel_i,data_i)
  begin
    data_o <= (others => '0');
    if To_integer(Unsigned(sel_i)) /= 0 then
      data_o(width*To_integer(Unsigned(sel_i)+1) - 1 downto width*(To_integer(Unsigned(sel_i)+1)-1)) <= data_i;
    else
      data_o(0 downto 0) <= data_i;
    end if;
  end process;

end architecture demux_comp_arch;
