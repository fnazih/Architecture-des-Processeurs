-------------------------------------------------------------------------------
-- Title      : top
-- Project    : 
-------------------------------------------------------------------------------
-- File       : top.vhd
-- Author     : ROUCWL4838  <magoyan@ROUCWL4838>
-- Company    : 
-- Created    : 2019-11-15
-- Last update: 2019-11-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-11-15  1.0      magoyan Created
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ALU_constants.all;

entity top_regfile_alu is
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
end entity top_regfile_alu;

architecture top_regfile_alu_arch of top_regfile_alu is
 

begin  -- architecture top_regfile_alu_arch 


  

end architecture top_regfile_alu_arch ;
