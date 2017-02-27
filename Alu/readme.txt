The CPU of MHRD is rather interesting.
In essention it can only do 2 instructions:
1: in1 + in2
2: in1 nand in2

The second opcode selets which of these 2 is used.
But it can optionally invert in1, in2 or the output, which is selected by the other opcodes.
The first opcode inverts the output, the 3th one inverts in2 and the 4th one inverts in1. 
For example, to do an AND instruction: in1 nand in2, invert the output. 
To substract in1 from in2: Invert in2, add in1, in2, invert the output.
In this way a number of instructions are possible:
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

An interesting ALU design, that uses a fairly little amount of logic.