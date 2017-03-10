And a complete CPU, with RAM and ROM. 2 example ROM's are included.
A GPIO module is also included, truth be told, it's only GPO :)
It's connected to the RAM bus, when a value is written to address 0x4001 it's written to the ouput pins.

First the instruction set of the CPU. This might not be complete, but it's usable for now:
Most instructions have 4 arguments, the ALU has 2 inputs and 1 output and optionally the instruction can execute a jump if the result is zero.
As listed in the ALU readme the ALU can do around 8 usefull instructions.
The CPU can also load a constant into the MR register, making 9 instructions total.
Instruction set:
Add, 	in1, 	in2, 	out,	jmp		//in1+in2		
Sub1, 	in1, 	in2, 	out,	jmp		//in1-in2		
Sub2, 	in1, 	in2, 	out,	jmp		//in2-in1		
Nand, 	in1, 	in2, 	out,	jmp		//in1 !& in2		
And, 	in1, 	in2, 	out,	jmp		//in1 & in2		
Or, 	in1, 	in2, 	out,	jmp		//in1 | in2		
Not, 	in1, 	    	out,	jmp		//!in1			
Inv, 	in1, 	    	out,	jmp		//-in1			
Lcm, 	const					// load const in MR, effect: select DataRAM addr

a few pseudo instructions can also be made:
Jmp,						//Jump to MR
Mov,	src, 	dst				//Move src (AR, MR, dataram, 5 bit const) to dst(AR, MR, dataram)

These are made like this:
jmp = add, 0, 0, 0, jmp
mov = add, 0, src, dst

With just 11 instructions it is a very minimal CPU. But as it can operate directly on RAM it's still a complex instruction set CPU :)



Included ROMs:

The first ROM, roms_cnt is a simple program that increases a variable to 10 and if it reaches 10 it jumps to the end of the program.

The other is a blink a LED, in essence it's a delay loop that counts until a certain value is reached, then one of the GPIO's is turned on, after that another delay loop, the GPIO's are turned off and it repeats itself.
For simulation it counts to 5, when programmed in a FPGA it should count to a much higher value unless the FPGA is clocked with an extremely low clock.



Programming the MHRD CPU:

To design a program I first designed it in assembler language and then translated it to machine code by hand. For example, the code of the roms_cnt

0: lcm 		#addrofvar			0x800A		//set address of variable to MR
1: Mov		databus, ar			0x3C00		//load variable to ar
2: lcm 		0x0B				0x800B		//load 7 to mr
3: add		1, ar, ar			0x3401		//add 1 to ar
4: nand		10, ar, 0, jmp			0x156A		//if AR = 10, jmp to mr
5: lcm		#addrofvar			0x800A		//set address of variable to MR
6: Mov, 	AR, dataram			0x7400		//move AR to data ram
7: lcm		2				0x8002		//load 2 to mr
8: jmp						0x1020		//jump to mr
Rest of the ROM filled with nops (0x1000)

To translate an instruction to machine code I like to keep these snippets from the MRHD game and my ALU readme by hand:
bit:                         16 15 14 13 12 11 10  9  8  7  6  5  4  3  2  1
instr[1:16]:                  0  d  d  a  b  b  o  o  o  o  j  c  c  c  c  c
                                 \__/  |  \__/  \________/  |  \___________/
instr[14:15] destination    ------/    |   |        |       |        |
instr[13]    operand1       -----------/   |        |       |        | 
instr[11:12] operand2       ---------------/        |       |        |
instr[7:10]  operation code ------------------------/       |        |
instr[6]     jump if zero   --------------------------------/        |
instr[1:5]   constant       -----------------------------------------/ 

First, if instr[16] equals "1", then instr[1:15] have to be interpreted as a constant which has to be loaded into the memory register.

destination = 00 -> Ignore ALU output
destination = 01 -> Store ALU output in AR
destination = 10 -> Store ALU output in MR
destination = 11 -> Store ALU output in selected RAM word

If the "op1" output of the DECODER is "1", the "constant" has to be fed in to
  the ALU as the first operand. Otherwise the AR has to be fed into the ALU.

For the "op2" output of the DECODER:
  "00" -> feed "constant" as second operator into the ALU
  "01" -> feed AR as second operator into the ALU
  "10" -> feed MR as second operator into the ALU
  "11" -> feed data bus as second operator into the ALU

ALU opcodes:
opcode 			instruction
0000			in1 + in2
0101			in2 - in1
1001			in1 - in2
0010			in1 nand in2
0011			in1 and in2
1110			in1 or in2
By making in2 0x0000 some more instructions are possible as well, for example:
0001			not in1
0101			-in1
