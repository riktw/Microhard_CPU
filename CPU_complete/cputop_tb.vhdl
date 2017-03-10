 library ieee;
use ieee.std_logic_1164.all;

entity cputop_tb is
end cputop_tb;

architecture behav of cputop_tb is
	
	component cputop
	port (
		clock, reset : in std_logic;
		results : out std_logic_vector(15 downto 0));
	end component;

	for cputop_0: cputop use entity work.cputop;
	signal clock, reset : std_logic;
	signal results : std_logic_vector(15 downto 0);

    begin

    	cputop_0: cputop port map(clock, reset, results);

    	 --  This process does the real job.
	    process
	       type pattern_type is record
	          --  The inputs of the adder16B.
			reset : std_logic;
			results : std_logic_vector(15 downto 0);
	       end record;
	       --  The patterns to apply.
	       type pattern_array is array (natural range <>) of pattern_type;
	       constant patterns : pattern_array :=
	         (('1', x"0000"),
         	  ('0', x"0000"),
         	  ('0', x"0000"),
         	  ('0', x"0000"));
	    begin

	    	clock <= '0';
	    	reset <= '0';
	    	wait for 1 ns;
	    	reset <= '0';

	       --  Check each pattern.
	       for i in 0 to 200 loop
	          --  Set the inputs.
				wait for 1 ns;
				clock <= '1';

	          --reset <= patterns(i).reset;
	          --  Wait for the results.
	          
				wait for 1 ns;
				clock <= '0';
	          --  Check the outputs.
	          --assert results = patterns(i).results
	            --report "bad results out value" severity error;
	       end loop;
	       assert false report "end of test" severity note;
	       --  Wait forever; this will finish the simulation.
	       wait;
	    end process;
end behav;
