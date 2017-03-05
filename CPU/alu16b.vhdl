library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu16b is
port (in1, in2 : in std_logic_vector(15 downto 0);
	opcode : in std_logic_vector(3 downto 0);
	sout : out std_logic_vector(15 downto 0);
	zero, negative : out std_logic);
end alu16b;

architecture rtl of alu16b is

	component adder16b 
		port (in1, in2 : in std_logic_vector(15 downto 0);
		carryIn : in std_logic;
		sout : out std_logic_vector(15 downto 0);
		carryOut : out std_logic);
	end component;

	component mux16b is
		Port ( sel : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (15 downto 0);
           in2 : in  STD_LOGIC_VECTOR (15 downto 0);
           sout: out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	for adder16b_0 : adder16b use entity work.adder16b;
	for mux16b_0 : mux16b use entity work.mux16b;

	signal in1_neg : std_logic_vector(15 downto 0);
	signal in2_neg : std_logic_vector(15 downto 0);
	signal nandout : std_logic_vector(15 downto 0);
	signal addout  : std_logic_vector(15 downto 0);
	signal outtemp : std_logic_vector(15 downto 0);
	signal out_neg : std_logic_vector(15 downto 0);
 
begin

	in1_neg <= (in1 xor x"0000") when opcode(3) = '0' else (in1 xor x"FFFF");
	in2_neg <= (in2 xor x"0000") when opcode(2) = '0' else (in2 xor x"FFFF");

	nandout <= in1_neg nand in2_neg;
	adder16b_0: adder16b port map (in1_neg, in2_neg, '0', addout, open);

	mux16b_0 : mux16b port map (opcode(1), nandout, addout, outtemp);
	out_neg <= (outtemp xor x"0000") when opcode(0) = '0' else (outtemp xor x"FFFF");
	negative <= out_neg(15);
	zero <= '1' when out_neg = x"0000" else '0';
	sout <= out_neg;

end rtl;

