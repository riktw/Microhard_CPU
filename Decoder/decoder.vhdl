library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
port (instr : in std_logic_vector(15 downto 0);
	cToM, loadA, loadD, loadM, op1, jmpIfZ : out std_logic;
	op2 : out std_logic_vector(1 downto 0);
	OpCode : out std_logic_vector(3 downto 0);
	const : out std_logic_vector(14 downto 0)); 
end decoder;

architecture rtl of decoder is

	signal loads : std_logic_vector(2 downto 0);

begin


	loads <= "000" when instr(14 downto 13) = "00"  else
		"001" when instr(14 downto 13) = "01" else
		"010" when instr(14 downto 13) = "10" else
		"100" when instr(14 downto 13) =  "11";

	loadA  <= '0' when instr(15) = '1' else loads(0);
	loadM  <= '1' when instr(15) = '1' else loads(1);
	loadD  <= '0' when instr(15) = '1' else loads(2);
	jmpIfZ <= '0' when instr(15) = '1' else instr(5);

	cToM   <= instr(15);
	const  <= instr(14 downto 0);
	op1    <= instr(12);
	op2    <= instr(11 downto 10);
	OpCode <= instr(9 downto 6);


end rtl;
