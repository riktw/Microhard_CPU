library ieee;
use ieee.std_logic_1164.all;

entity adder16b is
port (in1, in2 : in std_logic_vector(15 downto 0);
	carryIn : in std_logic;
	sout : out std_logic_vector(15 downto 0);
	carryOut : out std_logic);
end adder16b;

architecture rtl of adder16b is

	component adder
		port(i0, i1 : in std_logic;
		ci : in std_logic;
		s: out std_logic;
		co : out std_logic);
	end component;

	for adder_0: adder use entity work.adder;
	for adder_1: adder use entity work.adder;
	for adder_2: adder use entity work.adder;
	for adder_3: adder use entity work.adder;
	for adder_4: adder use entity work.adder;
	for adder_5: adder use entity work.adder;
	for adder_6: adder use entity work.adder;
	for adder_7: adder use entity work.adder;
	for adder_8: adder use entity work.adder;
	for adder_9: adder use entity work.adder;
	for adder_10: adder use entity work.adder;
	for adder_11: adder use entity work.adder;
	for adder_12: adder use entity work.adder;
	for adder_13: adder use entity work.adder;
	for adder_14: adder use entity work.adder;
	for adder_15: adder use entity work.adder;

	signal carry : std_logic_vector(15 downto 0);


begin

	adder_0: adder port map (in1(0), in2(0), carryIn, sout(0), carry(0));
	adder_1: adder port map (in1(1), in2(1), carry(0), sout(1), carry(1));
	adder_2: adder port map (in1(2), in2(2), carry(1), sout(2), carry(2));
	adder_3: adder port map (in1(3), in2(3), carry(2), sout(3), carry(3));
	adder_4: adder port map (in1(4), in2(4), carry(3), sout(4), carry(4));
	adder_5: adder port map (in1(5), in2(5), carry(4), sout(5), carry(5));
	adder_6: adder port map (in1(6), in2(6), carry(5), sout(6), carry(6));
	adder_7: adder port map (in1(7), in2(7), carry(6), sout(7), carry(7));
	adder_8: adder port map (in1(8), in2(8), carry(7), sout(8), carry(8));
	adder_9: adder port map (in1(9), in2(9), carry(8), sout(9), carry(9));
	adder_10: adder port map (in1(10), in2(10), carry(9), sout(10), carry(10));
	adder_11: adder port map (in1(11), in2(11), carry(10), sout(11), carry(11));
	adder_12: adder port map (in1(12), in2(12), carry(11), sout(12), carry(12));
	adder_13: adder port map (in1(13), in2(13), carry(12), sout(13), carry(13));
	adder_14: adder port map (in1(14), in2(14), carry(13), sout(14), carry(14));
	adder_15: adder port map (in1(15), in2(15), carry(14), sout(15), carryOut);

end rtl;