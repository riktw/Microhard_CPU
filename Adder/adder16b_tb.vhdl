library ieee;
use ieee.std_logic_1164.all;


entity adder16b_tb is
end adder16b_tb;

architecture behav of adder16b_tb is

	component adder16b
    port (in1, in2 : in std_logic_vector(15 downto 0);
    carryIn : in std_logic;
    sout : out std_logic_vector(15 downto 0);
    carryOut : out std_logic);
	end component;

	for adder_0: adder16b use entity work.adder16b;
  signal i0, i1, s : std_logic_vector(15 downto 0);
	signal ci, co : std_logic;

	begin
--  Component instantiation.
    adder_0: adder16b port map (i0 , i1, ci, s, co);
 
    --  This process does the real job.
    process
       type pattern_type is record
          --  The inputs of the adder16B.
          i0, i1 : std_logic_vector(15 downto 0);
          ci : std_logic;
          --  The expected outputs of the adder16B.
          s : std_logic_vector(15 downto 0); 
          co : std_logic;
       end record;
       --  The patterns to apply.
       type pattern_array is array (natural range <>) of pattern_type;
       constant patterns : pattern_array :=
         ((x"0000", x"0000", '0', x"0000", '0'),
          (x"0000", x"0000", '1', x"0001", '0'),
          (x"1234", x"1234", '0', x"2468", '0'),
          (x"1234", x"0000", '1', x"1235", '0'),
          (x"0000", x"1234", '0', x"1234", '0'),
          (x"FFFF", x"0000", '1', x"0000", '1'),
          (x"FFFF", x"0001", '0', x"0000", '1'),
          (x"0000", x"FFFF", '1', x"0000", '1'));
    begin
       --  Check each pattern.
       for i in patterns'range loop
          --  Set the inputs.
          i0 <= patterns(i).i0;
          i1 <= patterns(i).i1;
          ci <= patterns(i).ci;
          --  Wait for the results.
          wait for 1 ns;
          --  Check the outputs.
          assert s = patterns(i).s
             report "bad sum value" severity error;
          assert co = patterns(i).co
             report "bad carray out value" severity error;
       end loop;
       assert false report "end of test" severity note;
       --  Wait forever; this will finish the simulation.
       wait;
    end process;
end behav;
