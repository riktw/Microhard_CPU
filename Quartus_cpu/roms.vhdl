library ieee ;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity roms is 
port (address : in std_logic_vector(15 downto 0);
	  clock : in std_logic;
      data_out : out std_logic_vector(15 downto 0));
end entity ;

------------------
architecture rtl of roms is 

	type memory is array ( 0 to 63 ) of std_logic_vector(15 downto 0);
	constant myrom : memory := (
	1 =>  x"1000" ,		--NOP
	2 =>  x"8001" , 	--select var cnt1
	3 =>  x"70C0" , 	--Clear var cnt1
	4 =>  x"8001" , 	--select var cnt1, start1
	5 =>  x"3C00" , 	--move var to AR
	6 =>  x"7401" , 	--add 1 to AR, store in RAM
	7 =>  x"E1A8" , 	--select a const, 25000, E1A8
	8 =>  x"3800" , 	--move const to AR
	9 =>  x"8001" , 	--select var cnt1
	10 => x"2E40" , 	--substract RAM (cnt1) from AR (const) and store in AR
	11 => x"8010" , 	--load jumpaddr in MR
	12 => x"0020" , 	--add 0 to AR, if output is 0, jump to MR(done1)(does a if(const == cnt1 combined with earlier instrs)) 
	13 => x"8004" , 	--load jumptaddr in MR
	14 => x"1020" , 	--Jump
	15 => x"1000" ,	--NOP
	16 => x"C001" , 	--select the GPIO reg, done1
	17 => x"70C1" , 	--move const to GPIO reg (turns LED on)
	18 => x"8001" , 	--select var cnt1
	19 => x"70C0" , 	--Clear var cnt1
	20 => x"8001" , 	--select var cnt1, start2
	21 => x"3C00" , 	--move var to AR
	22 => x"7401" ,	--add 1 to AR, store in RAM
	23 => x"E1A8" , 	--select a const, 25000
	24 => x"3800" , 	--move const to AR
	25 => x"8001" , 	--select var cnt1
	26 => x"2E40" , 	--substract RAM (cnt1) from AR (const) and store in AR
	27 => x"8020" ,	--load jumptaddr in MR
	28 => x"0020" , 	--add 0 to AR, if output is 0, jump to MR
	29 => x"8014" , 	--load jumptaddr in MR
	30 => x"1020" , 	--Jump
	31 => x"1000" ,	--NOP
	32 => x"C001" , 	--select the GPIO reg, done2
	33 => x"70C0" , 	--Move 0 to GPIO (turns LED off)
	34 => x"8002" , 	--load jumptaddr in MR
	35 => x"1020" ,  	--Jump
	others => x"1000" ) ;
	begin 

	process(clock)
	begin
		if rising_edge(clock) then
			data_out <= myrom(to_integer(unsigned(address)));
		end if;
	end process;

end rtl ; 

