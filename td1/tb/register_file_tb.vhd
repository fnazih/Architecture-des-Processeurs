-------------------------------------------------------------------------------
-- Title      : register file testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : register_file_tb.vhd
-- Author     : michel agoyan  <michel.agoyan@st.com>
-- Company    : 
-- Created    : 2015-11-15
-- Last update: 2015-11-15
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

use work.basic_comps.all;
library ieee;
use ieee.std_logic_1164.all;

entity register_file_tb is

end entity register_file_tb;


architecture register_file_tb_arch of register_file_tb is

  procedure wait_negedge (
  constant nb  : in positive;           -- number of negative clk edge
  signal clk_i : in std_logic) is
  begin
    for i in 1 to nb loop
      wait until clk_i'event and clk_i='0';
    end loop;  -- i
  end procedure wait_negedge;


  constant PERIOD : time := 20 ns;
  constant HALF_PERIOD : time := 10 ns;

  constant WIDTH : positive := 32;
  constant N : positive := 5;

  signal clk_s      : std_logic := '0';
  signal resetn_s   : std_logic := '0';
  signal rs1_add_s  : std_logic_vector(N-1 downto 0) := "00000";
  signal rs2_add_s  : std_logic_vector(N-1 downto 0) := "00000";
  signal rd_add_s   : std_logic_vector(N-1 downto 0) := "00000";
  signal rd_data_s  : std_logic_vector(WIDTH-1 downto 0) :=X"0000_0000";
  signal we_s       : std_logic :='0';
  signal rs1_data_s : std_logic_vector(WIDTH-1 downto 0);
  signal rs2_data_s : std_logic_vector(WIDTH-1 downto 0);
  

begin  -- architecture register_file_tb_arch
  
  -- instanciation of the file register
  register_file_1: entity work.register_file
    generic map (
      width => WIDTH,
      n     => N)
    port map (
      clk_i      => clk_s,
      resetn_i   => resetn_s,
      rs1_add_i  => rs1_add_s,
      rs2_add_i  => rs2_add_s,
      rd_add_i   => rd_add_s,
      rd_data_i  => rd_data_s,
      we_i       => we_s,
      rs1_data_o => rs1_data_s,
      rs2_data_o => rs2_data_s);
  
 

  -- clock generation
  clk_s <= not clk_s after HALF_PERIOD;

  tb : process
  begin
    
  -- reset the design
    resetn_s  <= '0';
    wait_negedge(3,clk_s);
    resetn_s <= '1';

    -- write  0x55555555 into reg1
    rd_data_s  <=  X"5555_5555";
    rd_add_s <= "00001"; 
    we_s  <= '1';
    wait_negedge(1,clk_s);
    we_s  <= '0';

    wait_negedge(5,clk_s);

    -- write  0xAAAAAAAA into reg2
    rd_data_s  <=  X"AAAA_AAAA";
    rd_add_s <= "00010" ;
    we_s  <= '1';
    wait_negedge(1,clk_s);
    we_s  <= '0';

    wait_negedge(5,clk_s);

   

    rs1_add_s <= "00001" ;
    rs2_add_s <= "00010" ;
    wait_negedge(5,clk_s);
   

    assert rs2_data_s = X"AAAA_AAAA" report "error unexpected result" severity error;
    assert rs1_data_s = X"5555_5555" report "error unexpected result" severity error;
    
    --end of the tb
    assert false report "end of simulation" severity error;
    
  end process tb;

end architecture register_file_tb_arch;
