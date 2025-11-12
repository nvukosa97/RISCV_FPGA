library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity execute is
  port (
        --INPUTS
        clk           : in std_logic;
        reset         : in std_logic;
	     pc            : in std_logic_vector(31 downto 0); --RS1 or PC
		  instruct      : in std_logic_vector(31 downto 0); --imm or RS2
        rs1           : in std_logic_vector(31 downto 0);
        rs2           : in std_logic_vector(31 downto 0);
          
          
          
		  
		--OUTPUTS
		  instruct_pass  : out std_logic_vector(31 downto 0);
        pc_pass        : out std_logic_vector(31 downto 0);
        data_w         : out std_logic_vector(31 downto 0);
        alu_out        : out std_logic_vector(31 downto 0);
        BrEq           : out std_logic;
        BrLt           : out std_logic

    );  
end execute;
 
architecture rtl of execute is

signal opcode : std_logic_vector(6 downto 0);
signal imm    : std_logic_vector(31 downto 0);
signal instruct_type: inst_type;
signal A      : std_logic_vector(31 downto 0);
signal B      : std_logic_vector(31 downto 0);


 
begin



opcode <= instruct(6 downto 0);

instruct_type <= get_type(opcode(6 downto 2));

p_imm_gen : process (instruct_type, instruct)

begin

case instruct_type is

    when R_TYPE => imm <= (others => '0');
    when I_TYPE => imm <= ((31 downto 12 => '0') & instruct(31 downto 20));
    when S_TYPE => imm <= ((31 downto 12 => '0') & instruct(31 downto 25) & instruct(11 downto 7));
    when B_TYPE => imm <= ((31 downto 13 => '0') & instruct(31) & instruct(7) & instruct(30 downto 25) & instruct(11 downto 8) & '0');
    when U_TYPE => imm <= (instruct(31 downto 12) & (11 downto 0 => '0'));
    when J_TYPE => imm <= ((31 downto 21 => '0') & instruct(31) & instruct(19 downto 12) & instruct(20) & instruct(30 downto 21) & '0');
	 when others =>

end case;

end process;

p_mux_A: process (opcode)

begin

case opcode is

        when ("0110011" or "0010011" or "0000011"  or "0100011" or "1100111") => 
            A <= rs1; --rs1
        when ("1100011" or "1101111" or "0010111") => 
            A <= pc;
        when "0110111" => 
            A <= (others => '0');
        when others =>  
            A <= (others => '0');
end case;


end process;

p_mux_B: process (opcode)

begin

case opcode is
        when "0110011" => 
            B <= rs2; --rs2
        when ("0010011" or "0000011" or "0100011" or "1100011" or "1101111" or "1100111" or "0110111" or "0010111") => 
            B <= imm;
        when others =>  
            B <= (others => '0');
end case;


end process;

u_alu: entity work.alu

port map(

    --INPUTS
	A            => A, --RS1 or PC
	B            => B, --imm or RS2
    funct3       => instruct(14 downto 12),
    funct7       => instruct(31 downto 25),
    opcode       => opcode,
        
          
		  
	--OUTPUTS
	result       => alu_out

);


u_bc: entity work.branch_control

port map(

    --INPUTS
    rs1    => rs1,
    rs2    => rs2, 
    funct3 => instruct(14 downto 12),

    --OUTPUTS
    BrEq   => open,
    BrLt   => open





);






end rtl;