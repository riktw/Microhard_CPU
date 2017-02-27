library ieee;
use ieee.std_logic_1164.all;


entity alu16b_tb is
end alu16b_tb;

architecture behav of alu16b_tb is

	component alu16b
    port (in1, in2 : in std_logic_vector(15 downto 0);
    opcode : in std_logic_vector(3 downto 0);
    sout : out std_logic_vector(15 downto 0);
    zero, negative : out std_logic);
	end component;

	for alu_0: alu16b use entity work.alu16b;
  signal i0, i1, s : std_logic_vector(15 downto 0);
	signal zero, neg : std_logic;
  signal opcode : std_logic_vector(3 downto 0);

	begin
--  Component instantiation.
    alu_0: alu16b port map (i0 , i1, opcode, s, zero, neg);
 
    --  This process does the real job.
    process
       type pattern_type is record
          --  The inputs of the adder16B.
          i0, i1 : std_logic_vector(15 downto 0);
          opcode : std_logic_vector(3 downto 0);
          --  The expected outputs of the adder16B.
          s : std_logic_vector(15 downto 0); 
          zero, neg : std_logic;
       end record;
       --  The patterns to apply.
       type pattern_array is array (natural range <>) of pattern_type;
       constant patterns : pattern_array :=
         ((x"0003", x"0005", "0000", x"0008", '0', '0'),
          (x"0001", x"FFFF", "0000", x"0000", '1', '0'),
          (x"0003", x"0005", "0101", x"0002", '0', '0'),
          (x"0003", x"0005", "1001", x"FFFE", '0', '1'),
          (x"0003", x"0005", "0010", x"FFFE", '0', '1'),
          (x"0003", x"0005", "0011", x"0001", '0', '0'),
          (x"0003", x"0005", "1110", x"0007", '0', '0'),
          (x"0003", x"0000", "0101", x"FFFD", '0', '1'),
          (x"FF00", x"0000", "0001", x"00FF", '0', '0'));
    begin
       --  Check each pattern.
       for i in patterns'range loop
          --  Set the inputs.
          i0 <= patterns(i).i0;
          i1 <= patterns(i).i1;
          opcode <= patterns(i).opcode;
          --  Wait for the results.
          wait for 1 ns;
          --  Check the outputs.
          assert s = patterns(i).s
             report "bad sum value" severity error;
          assert zero = patterns(i).zero
             report "bad zero out value" severity error;
          assert neg = patterns(i).neg
             report "bad neg out value" severity error;
       end loop;
       assert false report "end of test" severity note;
       --  Wait forever; this will finish the simulation.
       wait;
    end process;
end behav;
