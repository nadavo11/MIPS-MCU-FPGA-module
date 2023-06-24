		-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control IS
   PORT( 	
	Opcode 			    : IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	RegDst 		    	: OUT 	STD_LOGIC;
	ALUSrc 			    : OUT 	STD_LOGIC;
	MemtoReg 		    : OUT 	STD_LOGIC;
	RegWrite 		    : OUT 	STD_LOGIC;
	MemRead 		    : OUT 	STD_LOGIC;
	MemWrite 	     	: OUT 	STD_LOGIC;
	Branch 				: OUT 	STD_LOGIC;
	bne					: OUT	STD_LOGIC;
	jump				: OUT	STD_LOGIC;
	link				: OUT	STD_LOGIC;
	jr					: OUT   STD_LOGIC;	
	ALUop 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	Function_opcode 	: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );

	clock, reset		: IN 	STD_LOGIC );

END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  Lw, Sw, Beq, mul, jal, R_format, lui,addi, andi, bneOp, ori, xori, slti, j	: STD_LOGIC;

BEGIN           
				-- Code to generate control signals using opcode bits
	R_format 	<=  '1'  WHEN  Opcode = "000000"  ELSE '0';
	mul			<=	'1'  WHEN  Opcode = "011100"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
   	Beq         <=  '1'  WHEN  Opcode = "000100"  ELSE '0';
	BneOp       <=  '1'  WHEN  Opcode = "000101"  ELSE '0';
	lui			<=	'1'  WHEN  Opcode = "001111"  ELSE '0';
	j	        <=  '1'  WHEN  Opcode = "000010"  ELSE '0';	
	jal			<=	'1'  WHEN  Opcode = "000011"  ELSE '0';	
	xori		<=	'1'  WHEN  Opcode = "001110"  ELSE '0';	
	slti		<=	'1'  WHEN  Opcode = "001010"  ELSE '0';	
	ori			<=  '1'  WHEN  Opcode = "001101"  ELSE '0';	
	andi		<=	'1'  WHEN  Opcode = "001100"  ELSE '0';	
	addi        <=  '1'  WHEN  ( (Opcode = "001000") or (Opcode = "001001") ) ELSE '0';	--	addiu do addi
	jr			<= 	'1'  WHEN (( Function_opcode = "001000") AND R_format= '1' ) ELSE '0';

	jump		<=  j OR jal;
  	RegDst    	<=  R_format OR mul;
 	ALUSrc  	<=  Lw OR Sw or lui OR addi OR andi OR ori OR xori OR slti;
	MemtoReg 	<=  Lw;
  	RegWrite 	<=  R_format OR mul OR Lw OR lui OR addi OR andi OR ori OR xori OR slti OR jal;
  	MemRead 	<=  Lw;
   	MemWrite 	<=  Sw; 
 	Branch      <=  Beq or bneOp;
	bne 		<=  bneOp;
	link		<=  jal;
	ALUOp( 1 ) 	<=  R_format;
	ALUOp( 0 ) 	<=  Beq; 

   END behavior;


