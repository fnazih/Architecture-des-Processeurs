-------------------------------------------------------------------------------
-- Title      : ALU contants
-- Project    : 
-------------------------------------------------------------------------------
-- File       : alu_constants.vhd
-- Author     : ROUCWL4838  <magoyan@ROUCWL4838>
-- Company    : 
-- Created    : 2019-11-15
-- Last update: 2019-11-15
-- Platform   : 
-- Standard   : VHDL'93/02
-------------------------------------------------------------------------------
-- Description: Define the constants used by the ALU
-------------------------------------------------------------------------------
-- Copyright (c) 2019 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2019-11-15  1.0      magoyan	Created, simplified version derived from RV32I
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

package ALU_constants is

--ALU opcodes
  constant ALU_ADD      : std_logic_vector(3 downto 0) := X"1";
  constant ALU_SUB      : std_logic_vector(3 downto 0) := X"2";
  constant ALU_SLLV     : std_logic_vector(3 downto 0) := X"3";
  constant ALU_SRLV     : std_logic_vector(3 downto 0) := X"4";
  constant ALU_SRAV     : std_logic_vector(3 downto 0) := X"5";
  constant ALU_AND      : std_logic_vector(3 downto 0) := X"6";
  constant ALU_OR       : std_logic_vector(3 downto 0) := X"7";
  constant ALU_XOR      : std_logic_vector(3 downto 0) := X"8";
  constant ALU_SLT      : std_logic_vector(3 downto 0) := X"9";
  constant ALU_SLTU     : std_logic_vector(3 downto 0) := X"A";
  constant ALU_COPY_RS1 : std_logic_vector(3 downto 0) := X"B";
  constant ALU_X        : std_logic_vector(3 downto 0) := X"0";

end package ALU_constants;
