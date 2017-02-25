library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter16b is
   port( Load: in std_logic;
 	 Clock: in std_logic;
 	 Reset: in std_logic;
 	 Input: in unsigned(15 downto 0);
 	 Output: out unsigned(15 downto 0));
end counter16b;
 
architecture Behavioral of counter16b is

   signal temp: unsigned(15 downto 0);

begin   
process(Clock,Reset)
   	begin
	if Reset='1' then
		temp <= x"0000";
	elsif(rising_edge(Clock)) then
 	 	if Load='0' then
	    	if temp = x"FFFF" then
	       		temp <= x"0000";
	    	else
	       		temp <= temp + 1;
	    	end if;
	    else
	    	temp <= Input;
        end if;
      end if;
   end process;
   Output <= temp;
end Behavioral; 
