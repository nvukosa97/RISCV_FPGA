library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity alu is
  port (
          --INPUTS
	      A            : in std_logic_vector(31 downto 0); --RS1 or PC
		  B            : in std_logic_vector(31 downto 0); --imm or RS2
          funct3       : in std_logic_vector(2 downto 0);
          funct7       : in std_logic_vector(6 downto 0);
          opcode       : in std_logic_vector(6 downto 0);
          
          
		  
		  --OUTPUTS
		  result       : out std_logic_vector(31 downto 0)
		  
    );  
end alu;
 
architecture rtl of alu is


 
begin

p_op_select: process (opcode, funct3, funct7)

begin

case opcode is
        --R-Type
        when "0110011" => 
            case funct3 is
                when "000" =>
                    case funct7 is
                        when "0000000" => result <= std_logic_vector(std_logic_vector(unsigned(A) + unsigned(B)));
                        when "0100000" => result <= std_logic_vector(unsigned(A) - unsigned(B));
                        when others    => result <= result;
                    end case;
                when "100" => 
                    case funct7 is 
                        when "0000000" => result <= A xor B;
                        when others    => result <= result;
                    end case;
                when "110" =>
                    case funct7 is 
                        when "0000000" => result <= A or B;
                        when others    => result <= result;
                    end case;
                when "111" =>
                    case funct7 is 
                        when "0000000" => result <= A and B;
                        when others    => result <= result;
                    end case;
                when "001" =>
                    case funct7 is 
                        when "0000000" => result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
                        when others    => result <= result;
                    end case;
                when "101" =>
                    case funct7 is 
                        when "0000000" => result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
                        when "0100000" => result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
                        when others    => result <= result;
                    end case;
                when "010" =>
                    case funct7 is 
                        when "0000000" => result <= x"00000001" when (signed(A) < signed(B)) else x"00000000";
                        when others    => result <= result;
                    end case;
                when "011" =>
                    case funct7 is 
                        when "0000000" => result <= x"00000001" when (unsigned(A) < unsigned(B)) else x"00000000";
                        when others    => result <= result;
                    end case;
                when others =>
                    result <= result;

            end case;
                
        --I-Type Arithmetic
        when "0010011" =>

            case funct3 is
                when "000" =>
                    result <= std_logic_vector(unsigned(A) + unsigned(B)) --rs1 + imm
                when "100" => 
                    result <= A xor B --rs1 xor imm
                when "110" =>
                    result <= A or B;
                when "111" =>
                    result <= A and B;
                when "001" =>
                    case B(11 downto 5) is 
                        when "0000000" => result <= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
                        when others    => result <= result;
                    end case;
                when "101" =>
                    case B(11 downto 5) is 
                        when "0000000" => result <= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
                        when "0100000" => result <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B))));
                        when others    => result <= result;
                    end case;
                when "010" =>

                    result <= x"00000001" when (signed(A) < signed(B)) else x"00000000";
                    
                when "011" =>

                    result <= x"00000001" when (unsigned(A) < unsigned(B)) else x"00000000";
                
                when others =>
                    result <= result;
            end case;
        --I-Type Load
        when "0000011" => 
                result <= std_logic_vector(unsigned(A) + unsigned(B)); -- rs1 + imm = mem address

        --S-Type    
        when "0100011" => 
            result <= std_logic_vector(unsigned(A) + unsigned(B)); -- rs1 + imm = mem address
        
        --B-Type
        when "1100011" =>
            --left-shift imm here?
            result <= std_logic_vector(unsigned(A) + unsigned(B)); -- PC + imm = new PC

        --I-Type Jalr
        when "1100111" =>
            --add funct3?
            result <= std_logic_vector(unsigned(A) + unsigned(B)) and x"FFFFFFFE"; --PC = rs1 + imm

        --J-Type
        when "1101111" =>
            result <= std_logic_vector(unsigned(A) + unsigned(B)); -- PC + imm = new PC

        --U-Tupe auipc
        when "0010111" =>
            result <= std_logic_vector(unsigned(A) + unsigned(B)); -- rd = PC + imm << 12
        
        --U-Type lui
        when "0010111" =>
            result <= B ;-- rd = PC + imm << 12

        when others =>
            result <= result;
        
    
end case;

end process;





end rtl;