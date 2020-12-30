-------------------------------------------------------------------------------
-- Title      : RV32I testbench
-- Project    : 
-------------------------------------------------------------------------------
-- File       : RV32I_tb.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-25
-- Last update: 2019-12-15
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
-- 2015-11-25  1.0      michel agoyan   Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.RV32I_components.all;

library modelsim_lib;
use modelsim_lib.util.all;

entity RV32I_tb is
end entity RV32I_tb;

architecture RV32I_tb_arch of RV32I_tb is
  constant PERIOD      : time := 20 ns;
  constant HALF_PERIOD : time := 10 ns;

  procedure wait_negedge (
    constant nb  : in positive;         -- number of negative clk edge
    signal clk_i : in std_logic) is
  begin
    for i in 1 to nb loop
      wait until clk_i'event and clk_i = '0';
    end loop;  -- i
  end procedure wait_negedge;

  signal clk_s             : std_logic := '0';
  signal resetn_s          : std_logic := '0';
  signal instruction_spy_s : std_logic_vector(31 downto 0);

begin  -- architecture RV32I_tb_arch

  RV32I_top_1 : entity work.RV32I_pipeline_top
    port map (
      clk_i    => clk_s,
      resetn_i => resetn_s);

  -- clock generation
  clk_s <= not clk_s after HALF_PERIOD;


  tb : process
  begin
    --init_signal_spy(<src_object>, <dest_object>, <verbose>, <control_state>)
    -- verbose = 1 :  Reports a message.
    --control_state = 1: turns on the ability to enable/disable and initially enables mirroring.

    init_signal_spy("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/instruction_mem/d_o", "instruction_spy_s", 1, 1);

    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/pc_counter_s", "16#000", 0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/instruction_mem/d_o", "16#00000000", 0 ns, freeze, open, 1);
    -- reset the design
    resetn_s <= '0';
    wait_negedge(3, clk_s);
    resetn_s <= '1';

    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_add_i", "00001", 0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_data_i", "16#AAAAAAAA", 0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/we_i", "1", 0 ns, freeze, open, 1);
    wait_negedge(1, clk_s);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_add_i", 1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_data_i", 1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/we_i", 1);

    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_add_i", "00010", 0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_data_i", "16#55555555", 0 ns, freeze, open, 1);
    signal_force("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/we_i", "1", 0 ns, freeze, open, 1);
    wait_negedge(1, clk_s);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_add_i", 1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/rd_data_i", 1);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/register_file_1/we_i", 1);


    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/instruction_mem/d_o", 1);
    wait_negedge(1, clk_s);
    signal_release("/rv32i_tb/RV32I_top_1/RV32I_pipeline_datapath_1/pc_counter_s", 1);

    while(instruction_spy_s /= X"00000000") loop
      wait_negedge(1, clk_s);
    end loop;

     wait_negedge(10, clk_s);
    --end of the tb
    assert false report "end of simulation" severity error;
  end process tb;

end architecture RV32I_tb_arch;
