library ieee;
use ieee.std_logic_1164.all;

entity decoder_tb is
end decoder_tb;

architecture behav of decoder_tb is

	component decoder
		port (instr : in std_logic_vector(15 downto 0);
		cToM, loadA, loadD, loadM, op1, jmpIfZ : out std_logic;
		op2 : out std_logic_vector(1 downto 0);
		OpCode : out std_logic_vector(3 downto 0);
		const : out std_logic_vector(14 downto 0)); 
	end component;

	for decoder_0: decoder use entity work.decoder;
	signal instr : std_logic_vector(15 downto 0);
	signal cToM, loadA, loadD, loadM, op1, jmpIfZ : std_logic;
	signal op2 : std_logic_vector(1 downto 0);
	signal OpCode : std_logic_vector(3 downto 0);
	signal const : std_logic_vector(14 downto 0);

	begin

		decoder_0: decoder port map (instr, cToM, loadA, loadD, loadM, op1, jmpIfZ, op2, OpCode, const);

		process
			type pattern_type is record
				instr : std_logic_vector(15 downto 0);
				cToM, loadA, loadD, loadM, op1, jmpIfZ : std_logic;
				op2 : std_logic_vector(1 downto 0);
				OpCode : std_logic_vector(3 downto 0);
				const : std_logic_vector(15 downto 0);
			end record;

			type pattern_array is array (natural range <>) of pattern_type;
			constant patterns : pattern_array :=
				((x"0000", '0', '0', '0', '0', '0', '0', "00", "0000", x"0000"),
				 (x"8000", '1', '0', '0', '1', '0', '0', "00", "0000", x"0000"),
				 (x"FFFF", '1', '0', '0', '1', '1', '0', "11", "1111", x"7FFF"),
				 (x"7FFF", '0', '0', '1', '0', '1', '1', "11", "1111", x"7FFF"),
				 (x"7C1F", '0', '0', '1', '0', '1', '0', "11", "0000", x"7C1F"),
				 (x"7C0F", '0', '0', '1', '0', '1', '0', "11", "0000", x"7C0F"));

			begin

			for i in patterns'range loop

				instr <= patterns(i).instr;

				wait for 1 ns;

				assert cToM = patterns(i).cToM
					report "Bad cToM" severity error;
				assert loadA = patterns(i).loadA
					report "Bad LoadA" severity error;
				assert loadD = patterns(i).loadD
					report "Bad LoadD" severity error;
				assert loadM = patterns(i).loadM
					report "Bad LoadM" severity error;
				assert op1 = patterns(i).op1
					report "Bad op1" severity error;
				assert jmpIfZ = patterns(i).jmpIfZ
					report "Bad jump if zero" severity error;
				assert op2 = patterns(i).op2 
					report "Bad op2" severity error;
				assert OpCode = patterns(i).OpCode
					report "Bad opcode" severity error;
				assert const = patterns(i).const(14 downto 0)
					report "Bad const" severity error;
			end loop;
			assert false report "end of test" severity note;
			wait;
		end process;
end behav;
