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

use work.basic_comps.all;
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




architecture register_file_arch of register_file is

component reg_comp is
	generic (
		width : positive := 32);
	port (
		data1_i : in std_logic_vector (width - 1 downto 0);	
		data0_i : in std_logic_vector (width - 1 downto 0);
		sel_i : in std_logic;
		clk_i : in std_logic;
		en_i : in std_logic;
		resetn_i : in std_logic;
		data_o : out std_logic_vector (width - 1 downto 0);
		);
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

signal rd_data_s : std_logic_vector(width*(2**n) - 1 downto 0);
signal rs1_data_s : std_logic_vector(width - 1 downto 0);
signal rs2_data_s : std_logic_vector(width - 1 downto 0);
signal rs1_add_s : std_logic_vector(width - 1 downto 0);
signal rs2_add_s : std_logic_vector(width - 1 downto 0);
signal we_s, clk_s : std_logic;
signal en_s : std_logic_vector(width - 1 downto 0);
signal sel_s : std_logic_vector(n - 1 downto 0);
signal entree_mux_s : std_logic_vector(width*width - 1 downto 0);
signal sortie_demux1_s : std_logic_vector(width - 1 downto 0);
signal sortie_demux2_s : std_logic_vector(width*width - 1 downto 0);


begin  -- architecture register_file_arch

we_i <= we_s;
clk_i <= clk_s;
rd_add_i <= sel_s;
rd_data_i <= rd_data_s;
rs1_data_i <= rs1_data_s;
rs2_data_i <= rs2_data_s;
rs1_add_i <= rs1_add_s;
rs2_add_i <= rs2_add_s;

register_file_gen : for i in 0 to (2**n) - 1 generate
	reg_comp_gen : reg_comp 
		generic map (
			width => width)
		port map (
			sel_i => '0',
			data1_i => (others => '0'),
			data0_i => rd_data_i,
			en_i => en_s(s),
			clk_i => clk_s,
			resetn_i => resetn_i,
			data_o => entree_mux_s(width*(i+1) - 1 downto width*i));
end generate;


MUX1 : mux_comp
	generic map (
		width => width,
		n => n)
	port map (
		data_i => entree_mux_s,
		sel_i => rs1_add_s,
		data_o => rs1_data_s
		);

MUX2 : mux_comp
	generic map (
		data_i => entree_mux_s,
		sel_i => rs2_add_s,
		data_o => rs2_data_s
		);


DEMUX1 : demux_comp	--entree : we_i
	generic map (
		width = 1,
		n => n
		);
	port map (
		data_i => we_s,
		sel_i => sel_s,
		data_o => sortie_demux1_s
		);

DEMUX1 : demux_comp	--entree : rd_data_i
	generic map (
		width => width,
		n => n
		);
	port map (
		data_i => rd_data_s,
		sel_i => sel_s,
		data_o => sortie_demux2_s
		);

end architecture register_file_arch;
