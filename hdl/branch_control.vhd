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
    BrLt   : out std_logic
		  
    );  

end branch_control;
 
architecture rtl of branch_control is

begin

p_process : process(funct3)

begin

case funct3 is

    --beq
    when "000" => 
	     if (rs1 = rs2) then
            BrEq <= '1';
		  else 
		      BrEq <= '0';
		  end if;
        BrLt <= '-';
    --bneq
    when "001" =>
	 
	     if (rs1 = rs2) then 
        BrEq <= '1';  
		  else 
		  BrEq <= '0';
		  end if;
		  
        BrLt <= '-';
    --blt
    when "100" => 
        BrEq <= '-';
		  
		  if (signed(rs1) < signed(rs2)) then 
            BrLt <= '1'; 
		  else 
		      BrLt <= '0';
		  end if;
    --bge
    when "101" =>
	     if (signed(rs1) = signed(rs2)) then
            BrEq <= '1'; 
		  else 
		      BrEq <= '0';
		  end if;
		  
		  if (signed(rs1) < signed(rs2)) then
            BrLt <= '1'; 
		  else 
		      BrLt <= '0';
		  end if;
    --bltu
    when "110" =>
        BrEq <= '-';
		  
		  if (unsigned(rs1) < unsigned(rs2)) then
		      BrLt <= '1'; 
		  else 
		      BrLt <= '0';
		  end if;
		  
    --bgeu
    when "111" =>
        if (unsigned(rs1) = unsigned(rs2)) then
            BrEq <= '1'; 
		  else 
		      BrEq <= '0';
		  end if;
		  
		  if (unsigned(rs1) < unsigned(rs2)) then
            BrLt <= '1'; 
		  else 
		      BrLt <= '0';
		  end if;
	  
	  when others =>



end case;


end process;

 







end rtl;