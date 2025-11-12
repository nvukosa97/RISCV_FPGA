library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity branch_control is
    port (
    --INPUTS
	rs1    : in std_logic_vector(31 downto 0);
    rs2    : in std_logic_vector(31 downto 0);
    funct3 : in std_logic_vector(2 downto 0);

    --OUTPUTS
    BrEq   : out std_logic;
    BrLt   : out std_logic;
		  
    );  

end branch_control;
 
architecture rtl of branch_control is

p_process : process(funct3)

begin

case funct3 is

    --beq
    when "000" => 
        BrEq <= '1' when (rs1 = rs2) else '0';
        BrLt <= '-';
    --bneq
    when "001" => 
        BrEq <= '0' when (rs1 != rs2) else '1';
        BrLt <= '-';
    --blt
    when "100" => 
        BrEq <= '-';
        BrLt <= '1' when (signed(rs1) < signed(rs2)) else '0';
    --bge
    when "101" =>
        BrEq <= '1' when (signed(rs1) = signed(rs2)) else '0';
        BrLt <= '1' when (signed(rs1) < signed(rs2)) else '0';
    --bltu
    when "110" =>
        BrEq <= '-';
        BrLt <= '1' when (unsigned(rs1) < unsigned(rs2)) else '0';
    --bgeu
    when "111" =>
        BrEq <= '1' when (unsigned(rs1) = unsigned(rs2)) else '0';
        BrLt <= '1' when (unsigned(rs1) < unsigned(rs2)) else '0';



end case;


end process;

 
begin






end rtl;