library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.riscv_pkg.all;
 
entity riscv_top is
  port (
          --INPUTS
	      clk          : in std_logic;
		  reset        : in std_logic;
		  
		  --OUTPUTS
		  occupied     : out std_logic;
		  led          : out std_logic;
		  time_left    : out unsigned(6 downto 0)
    );  
end riscv_top;
 
architecture rtl of riscv_top is


 
begin

  inst_fetch : entity work.inst_fetch
  
  port map(
    
    --INPUTS
    clk           => '0',
	reset         => reset,
	current_pc    => (others => '0'),
    --OUTPUTS
	new_pc        => open,
	instruct      => open
  
  );

  --PIPELINE FOR NEW_PC AND INST

  decode : entity work.decode
  
  port map(

    --INPUTS
    clk                 => '0',
	reset               => reset,
	pc                  => (others => '0'),
	fetch_inst          => (others => '0'),
    wb_inst             => (others => '0'),

    --OUTPUTS
	instruct_pass      => open,
    pc_pass            => open,
    rs1                => open,
    rs2                => open

  
  );


  --PIPELINE--

  execute : entity work.execute
  
  port map(

    --INPUTS
    clk           => '0',
	reset         => reset,
	pc            => (others => '0'),
	instruct      => (others => '0'),
    rs1           => (others => '0'),
    rs2           => (others => '0')

    --OUTPUTS
	instruct_pass      => open,
    pc_pass            => open,
    data_w             => open,
    addr                => open

  
  );

  --PIPELINE--

  mem : entity work.mem
  
  port map(

    --INPUTS
    clk           => '0',
	reset         => reset,
	pc            => (others => '0'),
	addr          => (others => '0'),
    data_w        => (others => '0')
    
    --OUTPUTS
	instruct_pass      => open,
    pc_pass            => open,
    result             => open
    

  
  );

  --PIPELINE--

  wb : entity work.wb
  
  port map(

    --INPUTS
    clk           => '0',
	reset         => reset,
	pc            => (others => '0'),
    inst          => (others => '0'),
	result        => (others => '0'),
    
    
    --OUTPUTS
	data_d      => open,
    addr_d      => open
    

  
  );




  

  
end rtl;