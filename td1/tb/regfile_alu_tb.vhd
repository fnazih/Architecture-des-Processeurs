-------------------------------------------------------------------------------
-- Title      : register file  + alu testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : regfile_alu_tb.vhd
-- Author     : michel agoyan  <michel.agoyan@st.com>
-- Company    : 
-- Created    : 2015-11-15
-- Last update: 2019-11-15
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

library  modelsim_lib;
use modelsim_lib.util.all;

use work.ALU_constants.all;

entity regfile_alu_tb is

end entity regfile_alu_tb;


architecture regfile_alu_tb_arch of regfile_alu_tb is
  component top is
    port (
      clk_i     : in  std_logic;
      resetn_i  : in  std_logic;
      func_i    : in  std_logic_vector(3 downto 0);
      rs1_add_i : in  std_logic_vector(4 downto 0);
      rs2_add_i : in  std_logic_vector(4 downto 0);
      rd_add_i  : in  std_logic_vector(4 downto 0);
      we_i      : in  std_logic;
      zero_o    : out std_logic;
      lt_o      : out std_logic);
  end component top;
  
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


  signal clk_s      : std_logic := '0';
  signal resetn_s   : std_logic := '0';
  signal rs1_add_s  : std_logic_vector(4 downto 0) := "00000";
  signal rs2_add_s  : std_logic_vector(4 downto 0) := "00000";
  signal rd_add_s   : std_logic_vector(4 downto 0) := "00000";
  signal rd_data_s  : std_logic_vector(31 downto 0) :=X"0000_0000";
  signal we_s       : std_logic :='0';
 
  
  signal func_s    : std_logic_vector(3 downto 0);
  signal zero_s    : std_logic;
  signal lt_s      : std_logic;

  signal instruction_s :std_logic_vector(31 downto 0) :=X"0000_0033";
  
begin  -- architecture register_file_tb_arch
  
  -- instanciation of the top

  top_1: entity work.top_regfile_alu
    port map (
      clk_i     => clk_s,
      resetn_i  => resetn_s,
      func_i    => func_s,
      rs1_add_i => rs1_add_s,
      rs2_add_i => rs2_add_s,
      rd_add_i  => rd_add_s,
      we_i      => we_s,
      zero_o    => zero_s,
      lt_o      => lt_s);


  -- clock generation
  clk_s <= not clk_s after HALF_PERIOD;

  --decodage d'une instructioon de type registre-registre  a completer
  rd_add_s <= (others =>'0');
  rs1_add_s <= (others =>'0');
  rs2_add_s <= (others =>'0');
  func_s <= (others =>'0');
  
  tb_proc : process
  begin
    
  -- reset the design
    resetn_s  <= '0';
    instruction_s <= X"00000033";
    wait_negedge(3,clk_s);
    resetn_s <= '1';

    -- write  0x00000002 into reg2
    signal_force("/regfile_alu_tb/top_1/register_file_1/rd_data_i", "16#00000002", 0 ns, freeze, open, 1);
    instruction_s <= X"00000133"; 
    we_s  <= '1';
    wait_negedge(1,clk_s);
    signal_release("/regfile_alu_tb/top_1/register_file_1/rd_data_i",1);
    we_s  <= '0';

    wait_negedge(5,clk_s);

    -- write  0x0000003 into reg3
    signal_force("/regfile_alu_tb/top_1/register_file_1/rd_data_i", "16#00000003", 0 ns, freeze, open, 1);
    instruction_s <= X"000001B3";
    we_s  <= '1';
    wait_negedge(1,clk_s);
    signal_release("/regfile_alu_tb/top_1/register_file_1/rd_data_i",1);
    we_s  <= '0';

    wait_negedge(5,clk_s);

   
    instruction_s <= X"003100B3";
   
    we_s  <= '1';
    wait_negedge(1,clk_s);
    we_s  <= '0';
    wait_negedge(5,clk_s);
   

   
    --end of the tb
    assert false report "end of simulation" severity error;
    
  end process tb_proc;

end architecture regfile_alu_tb_arch;
