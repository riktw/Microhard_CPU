library ieee;
use ieee.std_logic_1164.all;

entity reg16 is 
port(d   : in std_logic_vector(15 downto 0);
    ld  : in std_logic; -- load/enable.
    clr : in std_logic; -- async. clear.
    clk : in std_logic; -- clock.
    q   : out std_logic_vector(15 downto 0) := (others => '0')); -- output
end reg16;

architecture rtl of reg16 is

begin
    process(clk, clr)
    begin
        if clr = '1' then
            q <= x"0000";
        elsif rising_edge(clk) then
            if ld = '1' then
                q <= d;
            end if;
        end if;
    end process;
end rtl; 
