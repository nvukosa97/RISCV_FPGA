library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
package riscv_pkg is
   
  

  type inst_type is
      (R_TYPE, I_TYPE, S_TYPE, B_TYPE, U_TYPE, J_TYPE, ERR);
   
  function get_type(opcode: std_logic_vector(4 downto 0)) return inst_type;

 
   
   
end package riscv_pkg;

package body riscv_pkg is

  -- Get type of instruction using opcode, can ignore first 2 bits since they are the same across all opcodes (11)
  function get_type(opcode: std_logic_vector(4 downto 0)) return inst_type is

  --variable opcode: std_logic_vector(4 downto 0) := instruction(6 downto 2);
  
  begin

  case opcode is
        when "01100" => return R_TYPE; when "00100" => return I_TYPE;
        when "00000" => return I_TYPE; when "11001" => return I_TYPE;
        when "11100" => return I_TYPE; when "11000" => return B_TYPE;
        when "01101" => return U_TYPE; when "01000" => return S_TYPE;
        when "11011" => return J_TYPE;
        when others =>  
            return ERR; 
    end case;
	 
  end function;



  
  
  
end package body riscv_pkg;