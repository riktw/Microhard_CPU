The complete CPU from MHRD, an interesting CPU. 
First a note, if you would simulate this CPU the results are a bit different from the MRHD one.
The reason is that I choose to implement a asynchonous reset in the counter, so when the reset pin is made high it will immediately reset the PC.

The CPU has 3 registers, the PC, (program counter, counts where the program is), the MR (Memory Register, selects a word of RAM) and the AR (arithmetic register, stores a temporary result)

The CPU needs 2 pieces of memory attached, one as RAM and one with the compiled code.
The latter is connected to the instr and instraddr. The PC register outputs it's value to the instraddr to select the next instruction to execute.
The RAM is connected to data, dataaddr, result and writes.
Data is the input of the ALU, result is connected to the input of the data RAM.
dataaddr selects the address and writes selects read or write.

The 16 bit opcode is decoded by the decoder and every bit has it's function:
bit 16 high: load constant in MR.
Bit 15 to 11 decide what is fed to the ALU and where the result is places.
The ALU has 2 inputs, 1 output
Input 1 can be 5 bit constant or AR (op1 selects it)
Input 2 can be 5 bit const, AR, MR, data bus (op2 selects it)
The output can be send to AR or MR by selecting loadA or loadM. Always send to result (connected to data RAM)

LoadD high means write result of ALU to dataram, using MR as address
Only one of loadA, loadM, loadD can be high!
None high is also possible, to discard the output of the ALU.

The bits 10 to 7 are fed to the ALU and select the instruction of the ALU.

Bit 6 selects a jump or not. If this bit and the zero bit of the ALU are both high, the MR register is stored in the PC register, making the CPU jump to that place in memory.

The last 5 bits are a constant that can be used by the ALU.


The next upload will be one with a working example, including RAM and ROM and a list of the possible instructions.
