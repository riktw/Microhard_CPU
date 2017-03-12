library ieee;
use ieee.std_logic_1164.all;

entity cputop is
port (clock, reset : in std_logic;
	gpio_out : out std_logic_vector(15 downto 0);
	results : out std_logic_vector(15 downto 0));
end cputop;

architecture rtl of cputop is

	component cpu
		port (instr, data : in std_logic_vector(15 downto 0);
		clock, reset : in std_logic;
		instraddr, dataaddr, result : out std_logic_vector(15 downto 0);
		writes : out std_logic);
	end component;

	component ram
		port (
	    clock   : in  std_logic;
	    we      : in  std_logic;
	    address : in  std_logic_vector(15 downto 0);
	    datain  : in  std_logic_vector(15 downto 0);
	    dataout : out std_logic_vector(15 downto 0)
	  );
    end component;

    component roms
    	port ( address : in std_logic_vector(15 downto 0);
    		clock : in std_logic;
	    data_out : out std_logic_vector(15 downto 0));
	end component;

	component gpio
		port (clock       : in std_logic; 
	    we          : in    std_logic;
	    address   : in    std_logic_vector (15 downto 0); 
	    datain      : in    std_logic_vector (15 downto 0); 
	    dataout     : out   std_logic_vector (15 downto 0)); 
	end component;

	component pll
	PORT
	(
		inclk0		: IN STD_LOGIC  := '0';
		c0		: OUT STD_LOGIC 
	);
	end component;
	
	for cpu_0 : cpu use entity work.cpu;
	for ram_0 : ram use entity work.ram;
	for rom_0 : roms use entity work.roms;
	for gpio_0 : gpio use entity work.gpio;
	for pll_0 : pll use entity work.pll;

	signal instr 		: std_logic_vector(15 downto 0);
	signal data 		: std_logic_vector(15 downto 0);
	signal instraddr 	: std_logic_vector(15 downto 0);
	signal dataaddr 	: std_logic_vector(15 downto 0);
	signal result 		: std_logic_vector(15 downto 0);
	signal writes 		: std_logic;
	signal clkslow		: std_logic;

	begin

	pll_0 : pll port map(clock, clkslow);
	cpu_0 : cpu port map(instr, data, clkslow, not(reset), instraddr, dataaddr, result, writes);
	ram_0 : ram port map(clkslow, writes, dataaddr, result, data);
	gpio_0 : gpio port map(clkslow, writes, dataaddr, result, gpio_out);
	rom_0 : roms port map(instraddr, clkslow, instr);

	results <= result;

end rtl;

