library ieee;
use ieee.std_logic_1164.all;

entity cpu_tb is
end cpu_tb;

architecture behav of cpu_tb is
	
	component cpu
	port (instr, data : in std_logic_vector(15 downto 0);
		clock, reset : in std_logic;
		instraddr, dataaddr, result : out std_logic_vector(15 downto 0);
		writes : out std_logic);
	end component;

	for cpu_0: cpu use entity work.cpu;
	signal instr, data : std_logic_vector(15 downto 0);
	signal clock, reset : std_logic;
	signal instraddr, dataaddr, result : std_logic_vector(15 downto 0);
	signal writes : std_logic;

    begin

    	cpu_0: cpu port map(instr, data, clock, reset, instraddr, dataaddr, result, writes);

    	 --  This process does the real job.
	    process
	       type pattern_type is record
	          --  The inputs of the adder16B.
	        instr, data : std_logic_vector(15 downto 0);
			reset : std_logic;
			instraddr, dataaddr, result : std_logic_vector(15 downto 0);
			writes : std_logic;
	       end record;
	       --  The patterns to apply.
	       type pattern_array is array (natural range <>) of pattern_type;
	       constant patterns : pattern_array :=
	         ((x"0000", x"0000", '0', x"0001", x"0000", x"0000", '0'),
         	  (x"0000", x"0000", '0', x"0002", x"0000", x"0000", '0'),
         	  (x"80FF", x"0000", '1', x"0000", x"0000", x"0000", '0'),
         	  (x"3C01", x"0000", '0', x"0001", x"00FF", x"0001", '0'),
         	  (x"0000", x"0000", '0', x"0002", x"00FF", x"0001", '0'),
         	  (x"4000", x"0000", '0', x"0003", x"00FF", x"0001", '0'),
         	  (x"7800", x"0000", '0', x"0004", x"0001", x"0001", '1'),
         	  (x"1020", x"0001", '0', x"0005", x"0001", x"0000", '0'),
         	  (x"1000", x"0001", '0', x"0001", x"0001", x"0000", '0'),
         	  (x"1000", x"0001", '0', x"0002", x"0001", x"0000", '0'));
	    begin

	    	clock <= '0';

	       --  Check each pattern.
	       for i in patterns'range loop
	          --  Set the inputs.
				wait for 1 ns;
				clock <= '1';

	          instr <= patterns(i).instr;
	          data <= patterns(i).data;
	          reset <= patterns(i).reset;
	          --  Wait for the results.
	          
				wait for 1 ns;
				clock <= '0';
	          --  Check the outputs.
	          assert instraddr = patterns(i).instraddr
	            report "bad instraddr value" severity error;
	          assert dataaddr = patterns(i).dataaddr
	            report "bad dataaddr out value" severity error;
	          assert result = patterns(i).result
	            report "bad result out value" severity error;
	          assert writes = patterns(i).writes
	            report "bad writes out value" severity error;
	       end loop;
	       assert false report "end of test" severity note;
	       --  Wait forever; this will finish the simulation.
	       wait;
	    end process;
end behav;
