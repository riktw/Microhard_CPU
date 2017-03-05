library ieee;
use ieee.std_logic_1164.all;

entity cpu is
port (instr, data : in std_logic_vector(15 downto 0);
	clock, reset : in std_logic;
	instraddr, dataaddr, result : out std_logic_vector(15 downto 0);
	writes : out std_logic);
end cpu;

architecture rtl of cpu is

	component decoder
		port (instr : in std_logic_vector(15 downto 0);
		cToM, loadA, loadD, loadM, op1, jmpIfZ : out std_logic;
		op2 : out std_logic_vector(1 downto 0);
		OpCode : out std_logic_vector(3 downto 0);
		const : out std_logic_vector(14 downto 0)); 
	end component;

	component alu16b
	    port (in1, in2 : in std_logic_vector(15 downto 0);
	    opcode : in std_logic_vector(3 downto 0);
	    sout : out std_logic_vector(15 downto 0);
	    zero, negative : out std_logic);
	end component;

	component counter16b
		port( Load: in std_logic;
		Clock: in std_logic;
		Reset: in std_logic;
		Input: in std_logic_vector(15 downto 0);
		Output: out std_logic_vector(15 downto 0));
	end component;

	for alu_0 : alu16b use entity work.alu16b;
	for decoder_0: decoder use entity work.decoder;
	for counter_0: counter16b use entity work.counter16b;

	signal alu_out 		: std_logic_vector(15 downto 0);
	signal alu_in1 		: std_logic_vector(15 downto 0);
	signal alu_in2 		: std_logic_vector(15 downto 0);
	signal mr, pc, ar 	: std_logic_vector(15 downto 0) := (others => '0');
	signal mrmux		: std_logic_vector(15 downto 0);
	signal ldpc, zero	: std_logic;
	signal cToM, loadA, loadD, loadM, op1, jmpIfZ  : std_logic;
	signal op2			: std_logic_vector(1 downto 0);
	signal OpCode 		: std_logic_vector(3 downto 0);
	signal const 		: std_logic_vector(14 downto 0);
	signal constse		: std_logic_vector(15 downto 0);


	begin

		counter_0 : counter16b port map(ldpc, clock, reset, mr, pc);
		decoder_0 : decoder port map(instr, cToM, loadA, loadD, loadM, op1, jmpIfZ, op2, OpCode, const);

		constse(15 downto 4) <= "111111111111" when const(4) = '1' else "000000000000";
		constse(3 downto 0) <= const(3 downto 0);

		alu_in1 <= constse when op1 = '1' else ar;

		alu_in2 <= constse when op2 = "00" else
					ar when op2 = "01" else
					mr when op2 = "10" else
					data when op2 = "11";

		alu_0 : alu16b port map(alu_in1, alu_in2, OpCode, alu_out, zero);
		ldpc <= (zero and jmpIfZ);

		mrmux <= alu_out when cToM = '0' else ('0' & const);
		mr <= mrmux when loadM = '1' else mr;
		ar <= alu_out when loadA = '1' else ar;
		result <= alu_out;
		writes <= loadD;
		instraddr <= pc;
		dataaddr <= mr;

	end rtl;