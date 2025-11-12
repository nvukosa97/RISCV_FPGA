library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity decode is
  port (
    --INPUTS
    clk            : in std_logic,
	reset          : in std_logic,
	pc             : in std_logic_vector(31 downto 0),
	fetch_inst     : in std_logic_vector(31 downto 0),
    wb_inst        : in std_logic_vector(31 downto 0),
    wb_data        : in std_logic_vector(31 downto 0),

    --OUTPUTS
	instruct_pass : out std_logic_vector(31 downto 0),
    pc_pass       : out std_logic_vector(31 downto 0),
    rs1           : out std_logic_vector(31 downto 0),
    rs2           : out std_logic_vector(31 downto 0)
		  
    );  
end decode;
 
architecture rtl of inst_fetch is

type register_file is array(natural range <>) of std_logic_vector(32 downto 0);

signal reg_file: register_file(31 downto 0) := (others => (others => '0'));

signal addr_rd: std_logic_vector(4 downto 0);
signal addr_rs1: std_logic_vector(4 downto 0);
signal addr_rs2: std_logic_vector(4 downto 0);
signal w_en    : std_logic;
signal wb_opcode : std_logic_vector(6 downto 0);

signal rs1_rd : std_logic_vector(31 downto 0);
signal rs2_rd : std_logic_vector(31 downto 0);

 
begin

wb_opcode <= wb_inst(6 downto 0);
addr_rs1  <= fetch_inst(19 downto 15);
addr_rs2  <= fetch_inst(24 downto 20);
addr_rd   <= wb_inst(11 downto 7);



w_en <= '1' when (wb_opcode = "0110011" or wb_opcode = "0010011" or wb_opcode = "0000011" or 
                  wb_opcode = "1101111" or wb_opcode = "1100111" or wb_opcode = "0110111" or
                  wb_opcode = "0010111") else '0';

p_reg_file : process(clk, reset)

begin

if (reset) then

reg_file <= others => (others => '0');


elsif (rising_edge(clk)) then

rs1_rd <= reg_file(to_integer(unsigned(addr_rs1)));
rs2_rd <= reg_file(to_integer(unsigned(addr_rs2)));

if (w_en = '1') then

reg_file(to_integer(unsigned(addr_rd))) <= wb_data;

end if;




end if;


end process;




end rtl;