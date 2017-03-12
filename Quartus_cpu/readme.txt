And a project for Quartus.
I used a cheap cyclone IV board from Ebay to test this with, but any Quartus FPGA should have no problems with this at all.
The board I used was: 
I added a PLL to divide the on board 25Mhz oscillator down to 1Mhz. If a 1Mhz oscillator is used this design can run without. When porting to a different toolchain, for example Xilinx ISE, the current PLL needs to be removed and a new one added for the specific device.  
The current ROM code implements a blink a led on gpio_output(0)

This is all I wanted to do with this CPU, it was a fun challenge to implement it as a softcore. All files here are open source according to the GNU GPL V3 license except the generated PLL code.
If someone wants to do more with this CPU, feel free to contact me for any questions or support :)
