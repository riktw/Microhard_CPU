library ieee;
use ieee.std_logic_1164.all;

entity gpio is
port (   clock       : in std_logic; 
    we          : in    std_logic;
    address   : in    std_logic_vector (15 downto 0); 
    datain      : in    std_logic_vector (15 downto 0); 
    dataout     : out   std_logic_vector (15 downto 0)); 
end entity;

architecture rtl of gpio is

begin

    process(clock)
    begin
        if(rising_edge(clock)) then
            if(address = x"4001") then
                dataout <= datain;
            end if;
        end if;
    end process;

end rtl;