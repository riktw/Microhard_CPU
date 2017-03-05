library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter16b is
   port( Load: in std_logic;
 	 Clock: in std_logic;
 	 Reset: in std_logic;
 	 Input: in std_logic_vector(15 downto 0);
 	 Output: out std_logic_vector(15 downto 0));
end counter16b;
 
architecture Behavioral of counter16b is

   signal temp: unsigned(15 downto 0):= (others => '0');

begin   
process(Clock)
   	begin
	if(rising_edge(Clock)) then
		if Reset='1' then
			temp <= x"0000";
 	 	elsif Load='0' then
	    	if temp = x"FFFF" then
	       		temp <= x"0000";
	    	else
	       		temp <= temp + 1;
	    	end if;
	    else
	    	temp <= unsigned(Input);
        end if;
      end if;
   end process;
   Output <= std_logic_vector(temp);
end Behavioral; 
