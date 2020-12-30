-------------------------------------------------------------------------------
-- Title      : register file
-- Project    :
-------------------------------------------------------------------------------
-- File       : file_register.vhd
-- Author     : michel agoyan  <michel.agoyan@st.com>
-- Company    :
-- Created    : 2015-11-15
-- Last update: 2015-11-19
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
    n     : positive := 5);             -- number of registers=2^n

  port (
    clk_i      : in  std_logic;
    resetn_i   : in  std_logic;
    rs1_add_i  : in  std_logic_vector(n-1 downto 0);
    rs2_add_i  : in  std_logic_vector(n-1 downto 0);
    rd_add_i   : in  std_logic_vector(n-1 downto 0);
    rd_data_i  : in  std_logic_vector(width-1 downto 0);
    we_i       : in  std_logic;
    rs1_data_o : out std_logic_vector(width-1 downto 0);
    rs2_data_o : out std_logic_vector(width-1 downto 0));

end entity register_file;

-- recopiez votre travail du TD1 ici


architecture register_file_arch of register_file is



begin  -- architecture register_file_arch



end architecture register_file_arch;
