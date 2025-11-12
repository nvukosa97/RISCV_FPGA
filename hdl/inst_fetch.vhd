library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity inst_fetch is
  port (
          --INPUTS
	      clk          : in std_logic;
		  reset        : in std_logic;
          current_pc   : in std_logic_vector(31 downto 0);
		  
		  --OUTPUTS
		  new_pc       : out std_logic_vector(31 downto 0);
		  instruct     : out std_logic_vector(31 downto 0)
		  
    );  
end inst_fetch;
 
architecture rtl of inst_fetch is



 
begin






end rtl;