After playing MRHD, a game in which you design a CPU starting with just a single NAND gate I decided to see if I can clone the CPU in VHDL while adding some feedback and insight in the design of the CPU.
This repository will contain some game spoilers, but no copypaste solutions for MRHD. 

I will try to keep the VHDL in the same style as the MRHD code, so as much stuff build from logic gates, even if it makes the code larger then needed. 

All files in here can be simulated using the free GHDL simulator, the results can be viewed with the free GTKWave viewer.
After installing GHDL and GTKWave, simply type make to build a part of the CPU and open the created .ghw file with GTKWave. This has been tested on Ubuntu 16.04 and Debian 8.

The MHRD game can be bought on steam here: http://store.steampowered.com/app/576030 and is highly recommended. To fully understand everything in this repo it's probably best to have played MRHD first, so please give it a go :)
