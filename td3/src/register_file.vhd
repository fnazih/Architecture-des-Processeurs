-------------------------------------------------------------------------------
-- Title      : register file
-- Project    :
-------------------------------------------------------------------------------
-- File       : file_register.vhd
-- Author     : michel agoyan  <michel.agoyan@st.com>
-- Company    :
-- Created    : 2015-11-15
-- Last update: 2019-12-03
-- Platform   :
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2015
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-15  1.0      magoyan Created
-------------------------------------------------------------------------------

use work.RV32I_components.all;
library ieee;
use ieee.std_logic_1164.all;
entity register_file is

  generic (
    width : positive := 32;             --  width of the registers
    n     : positive := 5);            -- number of registers=2^n

  port (
    clk_i      : in std_logic;
    resetn_i   : in std_logic;
    rs1_add_i  : in std_logic_vector(n-1 downto 0);
    rs2_add_i  : in std_logic_vector(n-1 downto 0);
    rd_add_i   : in std_logic_vector(n-1 downto 0);
    rd_data_i  : in std_logic_vector(width-1 downto 0);
    we_i       : in std_logic;
    rs1_data_o : out std_logic_vector(width-1 downto 0);
    rs2_data_o : out std_logic_vector(width-1 downto 0));

end entity register_file;

architecture register_file_arch of register_file is

 --signal used for registers interconnection
  signal data_s : std_logic_vector(width*(2**n)-1 downto 0);
  --demux output for we_i
  signal sel_s :std_logic_vector(width-1 downto 0);

  signal we_s : std_logic_vector( 0 downto 0);


begin  -- architecture register_file_arch

  --R0 is hard wired to 0
  data_s(31 downto 0) <= (others => '0');

  -- except R0 
  reg_file_gen : for i in 2 to 2**n  generate
  reg_inst : reg_comp
    generic map (
      width => width)
    port map (
      data1_i  => rd_data_i,
      data0_i  => (others => '0'),
      sel_i    => '1',
      en_i     => sel_s(i-1),
      clk_i    => clk_i,
      resetn_i => resetn_i,
      data_o   => data_s(width*i-1 downto width*(i-1) ));

  end generate;

  mux_comp_1 : mux_comp
    generic map (
      width => width,
      n     => n)
    port map (
      data_i => data_s,
      sel_i  => rs1_add_i,
      data_o => rs1_data_o);


  mux_comp_2 : mux_comp
    generic map (
      width => width,
      n     => n)
    port map (
      data_i => data_s,
      sel_i  => rs2_add_i,
      data_o => rs2_data_o);


  we_s(0)  <=  we_i;
  demux_comp_1 : demux_comp
    generic map (
      width => 1,
      n     => n)
    port map (
      data_i => we_s,
      sel_i  => rd_add_i,
      data_o => sel_s);

end architecture register_file_arch;
