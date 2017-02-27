library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux16b is
    Port ( sel : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           in2 : in  STD_LOGIC_VECTOR (15 downto 0);
           sout: out STD_LOGIC_VECTOR (15 downto 0));
end mux16b;

architecture rtl of mux16b is
begin
    sout <= in1 when (sel = '1') else in2;
end rtl; 
