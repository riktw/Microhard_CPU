library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter16b_tb is
end counter16b_tb;

architecture behav of counter16b_tb is

	component counter16b
		port( Load: in std_logic;
		Clock: in std_logic;
		Reset: in std_logic;
		Input: in std_logic_vector(15 downto 0);
		Output: out std_logic_vector(15 downto 0));
	end component;

	for Counter16B_0: counter16b use entity work.counter16b;
	signal Load, Clock, Reset : std_logic;
	signal Input, Output : std_logic_vector(15 downto 0);

	begin

		Counter16B_0: counter16b port map(Load, Clock, Reset, Input, Output);

		process

			type pattern_type is record
				Load, Reset : std_logic;
				Input, Output : std_logic_vector(15 downto 0);
			end record;

			type pattern_array is array (natural range <>) of pattern_type;
			constant patterns : pattern_array :=
			(('0', '1', x"0000", x"0000"),
			 ('0', '0', x"0000", x"0001"),
			 ('0', '0', x"0000", x"0002"),
			 ('0', '0', x"0000", x"0003"),
			 ('1', '0', x"FFFE", x"FFFE"),
			 ('0', '0', x"0000", x"FFFF"),
			 ('0', '0', x"0000", x"0000"),
			 ('0', '0', x"0000", x"0001"),
			 ('0', '0', x"0000", x"0002"),
			 ('1', '1', x"1234", x"0000"),
			 ('0', '0', x"0000", x"0001"));

		begin

			Clock <= '0';

			for i in patterns'range loop

				Load   <= patterns(i).Load;
				Reset  <= patterns(i).Reset;
				Input  <= patterns(i).Input;

				wait for 1 ns;
				Clock <= '1';
				wait for 1 ns;
				Clock <= '0';

				assert Output = patterns(i).Output
					report "Output not matched" severity error;

			end loop;
			assert false report "end of test" severity note;
       --  Wait forever; this will finish the simulation.
       wait;
    end process;
end behav;

