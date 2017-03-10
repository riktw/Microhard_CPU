library ieee ;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity roms is 
port (address : in std_logic_vector(15 downto 0);
	  clock : in std_logic;
      data_out : out std_logic_vector(15 downto 0));
end entity ;

------------------
architecture rtl of roms is 

	type memory is array ( 0 to 31 ) of std_logic_vector(15 downto 0);
	constant myrom : memory := (
	1 => x"1000" ,
	2 => x"800A" , 
	3 => x"3C00" , 
	4 => x"800B" , 
	5 => x"3401" , 
	6 => x"156A" , 
	7 => x"800A" , 
	8 => x"7400" , 
	9 => x"8002" , 
	10 => x"1020" , 
	others => x"1000" ) ;
	begin 

	process(clock)
	begin
		if rising_edge(clock) then
			data_out <= myrom(to_integer(unsigned(address)));
		end if;
	end process;

end rtl ; 

