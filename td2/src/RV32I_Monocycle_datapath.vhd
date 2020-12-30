-------------------------------------------------------------------------------
-- Title      : RV32I_datapath
-- Project    : 
-------------------------------------------------------------------------------
-- File       : RV32I_datapath.vhd
-- Author     :   <michel agoyan@ROU13572>
-- Company    : 
-- Created    : 2015-11-25
-- Last update: 2019-12-03
-- Platform   : 
-- Standard   : VHDL'2008
-------------------------------------------------------------------------------
-- Description:  RV32I datapath , also included instruction memory
-------------------------------------------------------------------------------
-- Copyright (c) 2015 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015-11-25  1.0      michel agoyan   Created
-- 2019-08-21  1.1      Olivier potin   Modified to implement RISCV Monocycle
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.RV32I_components.all;
use work.RV32I_constants.all;

entity RV32I_Monocycle_datapath is

  port (
    clk_i         : in  std_logic;
    resetn_i      : in  std_logic;
    alu_control_i : in  std_logic_vector(3 downto 0);  -- select ALU operation
    reg_write_i   : in  std_logic;      -- Register write enable
    alu_src1_i    : in  std_logic_vector(1 downto 0);  -- select ALU operand 2
    alu_src2_i    : in  std_logic_vector(0 downto 0);  -- select ALU operand 2
    imm_gen_sel_i : in  std_logic_vector(1 downto 0);
    instruction_o : out std_logic_vector(31 downto 0);
    alu_zero_o    : out std_logic;  -- ALU "zero" signal flag (ALU result operation = 0x0)
    alu_lt_o      : out std_logic);     -- ALU "less than" signal flag

end entity RV32I_Monocycle_datapath;

architecture RV32I_Monocycle_datapath_architecture of RV32I_Monocycle_datapath is

  signal pc_next_s    : std_logic_vector(31 downto 0);  -- next value of the program counter
  signal pc_plus4_s   : std_logic_vector(31 downto 0);  -- next instruction without jump (i.e. PC+4)
  signal pc_counter_s : std_logic_vector(31 downto 0);  -- output of the program counter

  signal instruction_s  : std_logic_vector(31 downto 0);  -- instruction bus 
  signal wb_data_s      : std_logic_vector(31 downto 0);  -- write back data bus
  signal rs1_data_s     : std_logic_vector(31 downto 0);  -- register source 1 data bus
  signal rs2_data_s     : std_logic_vector(31 downto 0);  -- register source 2 data bus
  signal rs1_add_s      : std_logic_vector(4 downto 0);  -- register source 1 index
  signal rs2_add_s      : std_logic_vector(4 downto 0);  -- register source 2 index 
  signal rd_add_s       : std_logic_vector(4 downto 0);  -- register destination index
  signal imm_s          : std_logic_vector(31 downto 0);  -- sign extended data
  signal alu_s          : std_logic_vector(31 downto 0);  -- ALU output
  signal alu_op1_data_s : std_logic_vector(31 downto 0);  -- ALU operand 1
  signal alu_op2_data_s : std_logic_vector(31 downto 0);  -- ALU operand 2

begin  -- architecture RV32I_Monocycle_datatpath_architecture

  instruction_o <= instruction_s;

  -- decode partially the instruction to retrieve the register indexes
  
  -- recopiez ici le décodage que vous avez effecté dans le TD1 :lignes 100 à 103 de  regfile_alu_tb.vh
  rs1_add_s <= (others =>'0');
  rs2_add_s <= (others =>'0');
  rd_add_s  <= (others =>'0');
 



  -- purpose: program counter
  -- type   : sequential
  -- inputs : clk_i, resetn_i
  -- outputs: 
  pc : process (clk_i, resetn_i) is
  begin
    if resetn_i = '0' then              -- asynchronous reset (active low)
      pc_counter_s <= (others => '0');  -- NB : normally PC starts from 0x00010000 (see Patterson & Waterman page 40) !
    elsif clk_i'event and clk_i = '1' then  -- rising clock edge
      pc_counter_s <= pc_next_s;
    end if;
  end process pc;

  pc_next_s <= pc_plus4_s;
  -- purpose: program counter incrementer
  -- type   : combinational
  -- inputs : pc_counter_s
  -- outputs: 
  pc_incr : process (pc_counter_s) is
  begin
    pc_plus4_s <= std_logic_vector(unsigned(pc_counter_s)+4);
  end process pc_incr;



  -- components instanciation
  alu_1 : alu
    generic map (
      width => 32)
    port map (
      func_i => alu_control_i,
      op1_i  => rs1_data_s,
      op2_i  => rs2_data_s,
      d_o    => wb_data_s,
      zero_o => alu_zero_o,
      lt_o   => alu_lt_o);

  register_file_1 : register_file
    generic map (
      width => 32,
      n     => 5)
    port map (
      clk_i      => clk_i,
      resetn_i   => resetn_i,
      rs1_add_i  => rs1_add_s,
      rs2_add_i  => rs2_add_s,
      rd_add_i   => rd_add_s,
      rd_data_i  => wb_data_s,
      we_i       => reg_write_i,
      rs1_data_o => rs1_data_s,
      rs2_data_o => rs2_data_s);

  -- NB : use only ROM of 8Ko (i.e. 2^12 32-bit words) 
  instruction_mem : sync_mem
    generic map (
      width    => 32,
      n        => 12,
      filename => "rom.hex")
    port map (
      clk_i    => clk_i,
      resetn_i => resetn_i,
      we_i     => '0',
      re_i     => '1',
      d_i      => (others => '0'),
      add_i    => pc_counter_s(13 downto 2),
      d_o      => instruction_s);


end architecture RV32I_Monocycle_datapath_architecture;
