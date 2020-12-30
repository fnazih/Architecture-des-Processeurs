-------------------------------------------------------------------------------
-- Title      : RV32I testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : RV32I_tb.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-25
-- Last update: 2019-12-09
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description:
-- 
-------------------------------------------------------------------------------
-- Copyright (c) 2015 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-25  1.0      michel agoyan	Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.RV32I_components.all;

library  modelsim_lib;
use modelsim_lib.util.all;

entity RV32I_tb is
end entity RV32I_tb;

architecture RV32I_tb_arch of RV32I_tb is
  constant PERIOD : time := 20 ns;
  constant HALF_PERIOD : time := 10 ns;
  
  procedure wait_negedge (
    constant nb  : in positive;         -- number of negative clk edge
    signal clk_i : in std_logic) is
  begin
    for i in 1 to nb loop
      wait until clk_i'event and clk_i = '0';
    end loop;  -- i
  end procedure wait_negedge;
  
  signal clk_s    : std_logic := '0';
  signal resetn_s : std_logic := '0';

  type regs_file_t is array (0 to 31) of std_logic_vector(31 downto 0 );
  
  -- alias regs_file_a is << signal RV32I_tb.RV32I_top_1.RV32I_datapath_1.register_file_1.regs_file_s  : regs_file_t >> ;
  
begin  -- architecture RV32I_tb_arch

  RV32I_top_1: entity work.RV32I_Monocycle_top
    port map (
      clk_i    => clk_s,
      resetn_i => resetn_s);
  
  -- clock generation
  clk_s <= not clk_s after HALF_PERIOD;

 
 tb : process
  begin
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/pc_counter_s","16#000",0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/instruction_mem/d_o" ,"16#00000000",0 ns, freeze, open, 1);
    -- reset the design
    resetn_s <= '0';  
    wait_negedge(3, clk_s);
    resetn_s <= '1';

    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_add_i","00010",0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_data_i","16#00000002",0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/we_i","1" ,0 ns, freeze, open, 1);
    wait_negedge(1,clk_s);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_add_i",1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_data_i",1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/we_i",1);
    
     signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_add_i","00011",0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_data_i","16#00000003",0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/we_i","1" ,0 ns, freeze, open, 1);
    wait_negedge(1,clk_s);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_add_i",1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/rd_data_i",1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/register_file_1/we_i",1);

    
    
	wait_negedge(2,clk_s);
	
	signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/instruction_mem/d_o",1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_Monocycle_datapath_1/pc_counter_s",1);
	
    --regs_file_a(1) <=X"0000_0001";
    wait_negedge(12,clk_s);
    --end of the tb
    assert false report "end of simulation" severity error;
  end process tb;
    
end architecture RV32I_tb_arch;
