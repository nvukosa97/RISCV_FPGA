library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
package riscv_pkg is
   
  subtype inst is std_logic_vector(31 downto 0);

  type inst_type is
      (R_TYPE, I_TYPE, S_TYPE, B_TYPE, U_TYPE, J_TYPE, ERR);
   
  function get_type(opcode: std_logic_vector(4 downto 0)) return inst_type;

  type r_inst is record
    inst_typ   : inst_type := R_TYPE;               
    rd         : std_logic_vector(4 downto 0);
    funct3     : std_logic_vector(2 downto 0);
    rs1        : std_logic_vector(4 downto 0);
    rs2        : std_logic_vector(4 downto 0);
    funct7     : std_logic_vector(6 downto 0);

  end record r_inst;

  type i_inst is record
    inst_typ   : inst_type := I_TYPE;               
    rd         : std_logic_vector(4 downto 0);
    funct3     : std_logic_vector(2 downto 0);
    rs1        : std_logic_vector(4 downto 0);
    imm        : std_logic_vector(11 downto 0);

  end record i_inst;

  type s_inst is record
    inst_typ   : inst_type := S_TYPE;               
    funct3     : std_logic_vector(2 downto 0);
    rs1        : std_logic_vector(4 downto 0);
    rs2        : std_logic_vector(4 downto 0);
    imm        : std_logic_vector(11 downto 0);

  end record s_inst;

  type b_inst is record

    inst_typ   : inst_type := B_TYPE;               
    funct3     : std_logic_vector(2 downto 0);
    rs1        : std_logic_vector(4 downto 0);
    rs2        : std_logic_vector(4 downto 0);
    imm        : std_logic_vector(12 downto 0);

  end record b_inst;

  type u_inst is record
  
    inst_typ   : inst_type := U_TYPE;               
    rd        : std_logic_vector(4 downto 0);
    imm        : std_logic_vector(19 downto 0);

  end record u_inst;

  type j_inst is record
  
    inst_typ   : inst_type := U_TYPE;               
    rd        : std_logic_vector(4 downto 0);
    imm        : std_logic_vector(20 downto 0);

  end record j_inst;
 
   
   
end package riscv_pkg;

package body riscv_pkg is

  -- Get type of instruction using opcode, can ignore first 2 bits since they are the same across all opcodes (11)
  function get_type(instruction: inst) return inst_type is

  variable opcode: std_logic_vector(4 downto 0) := inst(6 downto 2);

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

  function

  function get_r_type_fields(instruction: inst) return r_inst is
  
    variable r_instruct: r_inst;

    r_instruct.rd       <= inst(11 downto 7);
    r_instruct.funct3   <= inst(14 downto 12);
    r_instruct.rs1      <= inst(19 downto 15);
    r_instruct.rs2      <= inst(24 downto 20);
    r_instruct.funct7   <= inst(31 downto 25);

    return r_instruct;

  end function;

  function get_i_type_fields(instruction: inst) return i_inst is
  
    variable i_instruct: i_inst;

    i_instruct.rd       <= inst(11 downto 7);
    i_instruct.funct3   <= inst(14 downto 12);
    i_instruct.rs1      <= inst(19 downto 15);
    i_instruct.imm      <= inst(31 downto 20);

    return i_instruct;

  end function;

  function get_s_type_fields(instruction: inst) return s_inst is
  
    variable s_instruct: s_inst;

    s_instruct.funct3   <= inst(14 downto 12);
    s_instruct.rs1      <= inst(19 downto 15);
    s_instruct.rs2      <= inst(24 downto 20);
    s_instruct.imm      <= inst(31 downto 25) & inst(11 downto 7);

    return s_instruct;

  end function;

  function get_b_type_fields(instruction: inst) return b_inst is
  
    variable b_instruct: b_inst;

    b_instruct.funct3   <= inst(14 downto 12);
    b_instruct.rs1      <= inst(19 downto 15);
    b_instruct.rs2      <= inst(24 downto 20);
    b_instruct.imm      <= inst(31) & inst(7) & inst(30 downto 25) & inst(11 downto 8) & '0';

    return b_instruct;

  end function;

  function get_u_type_fields(instruction: inst) return u_inst is
  
    variable u_instruct: u_inst;

    u_instruct.rd   <=  inst(11 downto 7);
    u_instruct.imm      <= inst(31 downto 12);

    return u_instruct;

  end function;

  function get_j_type_fields(instruction: inst) return j_inst is
  
    variable j_instruct: j_inst;

    j_instruct.rd   <=  inst(11 downto 7);
    j_instruct.imm      <= inst(31) & inst(19 downto 12) & inst(20) & inst(30 downto 21) & '0';

    return j_instruct;

  end function;
  
  
end package body riscv_pkg;