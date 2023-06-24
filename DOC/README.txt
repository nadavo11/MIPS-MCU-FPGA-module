This is an README file of the MCU Architecture
, which operates as a fully functional MCU Micro Controller,
 Powered by a complete- ISA-enabled Single-Cycle MIPS processor,
being fed a memory component with data and a MIPS Assembly program, and syncs fetching the program,
 decoding, executing and reading/ writing to memory if needed and handling Interrupt Service Routines 


the MCU design consists of 3 units

CPU MIPS core:

The Core is interrupt-enabled. Controlled by hardware inputs
, an  Interrupt signal may cause the CPU to perform a JAL command emulation,
 sending the PC to the Interrupt Service Routine address stored in memory, ACK’ing when it returns from said routine.   
full description will be given next.

interrupt controller:

The Interrupt Controller module is driven by keys-input on the Cyclone V hardware, is responsible to decode
,prioritize and trigger the correct Interrupt signals for each trigger- either from Hardware inputs or from the Basic timer module.

BASIC TIMER:
The basic timer is an Interrupt enabled module which offers the user some advanced clock related functionality including:
 clock based delay ,custom frequency recurring interrupts, and a clock based  “sleep mode”. The BT module consists of a divisible clock,
 a custom trigger counter, and a “BT flag” output in order to cause an interrupt procedure in the MIPS core.  


the MIPS design consists of 5 units:

Instruction FETCH block:
The fetch instruction block is responsible for the fetch instruction phase of each operation. It performs it and passes on the relevant signals to the next unit wich is ID. 

Instruction Decode Block:
The Instruction Decode block is responsible for the decode phase of each operation. 
performs it and passes on the relevant signals to the next unit wich is EX.

Execute Block:
The Execute block is responsible for the execute phase of each operation. 
It performs it and passes on the relevant signals tothe next unit wich is MEM

Memory Stage Block:
The DMem Unit is responsible for the memory access (read/write) phase of each operation. 
performs the read/writ. the write back stage,
which, in our design, happens back in the Instruction Decode block.

Control Unit:
The Control Unit is responsible for the control signals for the MIPS CPU.

to use: \
1. write a MIPS assembly code, validate and test it
2. compile it and dump memory and instruction to .hex
3. reassign the path of the memory and code in "fetch" and "DMEM"
4. enjoy! 