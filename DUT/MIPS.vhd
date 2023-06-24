				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY MIPS IS
	GENERIC(instruction_address_width:	positive:=10;
			memory_address_width: 		positive:=11 );
	PORT( reset, clock					: IN 	STD_LOGIC; 
		-- Output important signals to pins for easy display in Simulator
		PC								: OUT 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
		address_out						: OUT  	STD_LOGIC_VECTOR( 11 downto 0 );
		ALU_result_out, 
		read_data_1_out,
		read_data_2_out, 
		write_data_out,	
     	Instruction_out					: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
		read_data_in 					: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );	-- data read from INPUT SWITCH			
		
		Branch_out,
		Zero_out,
		Memwrite_out, 
		Regwrite_out					: OUT 	STD_LOGIC;
		-----------------------------------------------------------------------
		k0								: OUT	STD_LOGIC;
		INTR							: IN	STD_LOGIC := '0';
		ITYPE							: IN 	STD_LOGIC_VECTOR( 5 downto 0 );
		ena_pc							: IN 	STD_LOGIC

		);
END 	MIPS;

ARCHITECTURE structure OF MIPS IS

	COMPONENT Ifetch
		GENERIC(instruction_address_width: 	positive:=8);
   	     PORT(	Instruction			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		PC_plus_4_out 		: OUT  	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				ALU_Result 			: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		Add_result 			: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        		Branch 				: IN 	STD_LOGIC;
        		Zero 				: IN 	STD_LOGIC;
        		PC_out 				: OUT 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				bne					: IN 	STD_LOGIC;
				jr					: IN 	STD_LOGIC;
				jump				: IN	STD_LOGIC;
				Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
				
				read_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				INTR				: IN	STD_LOGIC;
        		clock,reset 		: IN 	STD_LOGIC;
				ena_pc				: IN 	STD_LOGIC

				);
				
	END COMPONENT; 

	COMPONENT Idecode
 	     PORT(	read_data_1			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2				: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data 				: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALU_result				: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Function_opcode			: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			k0						: OUT	STD_LOGIC;

			
			RegWrite 				: IN 	STD_LOGIC;
			MemtoReg 				: IN 	STD_LOGIC;
			RegDst 					: IN 	STD_LOGIC;
			Sign_extend 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			PC_PLUS_4				: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			link					: IN    STD_LOGIC;
			INTR					: IN    STD_LOGIC;			
			clock,reset				: IN 	STD_LOGIC;
			PC						: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 )
			);			
	END COMPONENT;

	COMPONENT control
	     PORT( 	Opcode 				: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
             	RegDst 				: OUT 	STD_LOGIC;
             	ALUSrc 				: OUT 	STD_LOGIC;
             	MemtoReg 			: OUT 	STD_LOGIC;
             	RegWrite 			: OUT 	STD_LOGIC;
             	MemRead 			: OUT 	STD_LOGIC;
             	MemWrite 			: OUT 	STD_LOGIC;
				Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
             	Branch 				: OUT 	STD_LOGIC;
				bne 				: OUT 	STD_LOGIC;
				jump				: OUT	STD_LOGIC;
				link				: OUT	STD_LOGIC;	
				jr					: OUT	STD_LOGIC;
             	ALUop 				: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
             	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;

	COMPONENT  Execute
   	     PORT(	Read_data_1 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
                Read_data_2 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Sign_Extend 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Function_opcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
				opcode				: IN	STD_LOGIC_VECTOR( 5 downto 0 );

               	ALUOp 				: IN 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
               	ALUSrc 				: IN 	STD_LOGIC;
               	Zero 				: OUT	STD_LOGIC;
               	ALU_Result 			: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
               	Add_Result 			: OUT	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
               	PC_plus_4 			: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
               	clock, reset		: IN 	STD_LOGIC );
	END COMPONENT;


	COMPONENT dmemory
		GENERIC( memory_address_width: 		positive:=9);
	     PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        		write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		MemRead, Memwrite 	: IN 	STD_LOGIC;
				MEM_ACCESS			: IN 	STD_LOGIC;
				MEM_WR_EN			: IN 	STD_LOGIC;
				INPUT_read_data 	: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );	-- data read from INPUT SWITCH	
				---------------------------------------------------------------
				INTR				: IN	STD_LOGIC;
				ITYPE				: IN 	STD_LOGIC_VECTOR( 5 downto 0 );
        		Clock,reset			: IN 	STD_LOGIC );
	END COMPONENT;

					-- declare signals used to connect VHDL components
	SIGNAL PC_plus_4 		: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL read_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_Extend 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Add_result 		: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL ALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALUSrc 			: STD_LOGIC;
	SIGNAL Branch 			: STD_LOGIC;
	SIGNAL RegDst 			: STD_LOGIC;
	SIGNAL Regwrite 		: STD_LOGIC;
	SIGNAL Zero 			: STD_LOGIC;
	SIGNAL MemWrite 		: STD_LOGIC;
	SIGNAL MemtoReg 		: STD_LOGIC;
	SIGNAL MemRead 			: STD_LOGIC;
	SIGNAL bne				: STD_LOGIC;
	SIGNAL ALUop 			: STD_LOGIC_VECTOR(  1 DOWNTO 0 );
	SIGNAL Instruction		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL jr	 			: STD_LOGIC;
	SIGNAL jump	 			: STD_LOGIC;
	SIGNAL R_format	 		: STD_LOGIC;
	SIGNAL link				: STD_LOGIC;
	SIGNAL MEM_ACCESS		: STD_LOGIC;
	SIGNAL MEM_WR_EN		: STD_LOGIC;
	SIGNAL PC_sig			: STD_LOGIC_VECTOR(9 downto 0);


BEGIN
					-- copy important signals to output pins for easy 
					-- display in Simulator
   Instruction_out 	<= Instruction;
   ALU_result_out 	<= ALU_result;
   read_data_1_out 	<= read_data_1;
   read_data_2_out 	<= read_data_2;
   write_data_out  	<= read_data_2 	WHEN MemWrite = '1' ELSE ALU_result;
   address_out		<= Instruction( 11 downto 0 ) WHEN (MemRead='1' or MemWrite='1')	ELSE X"000"; ------------------------ONLY IN LW or SW
   Branch_out 		<= Branch;
   Zero_out 		<= Zero;
   RegWrite_out 	<= RegWrite;
   MemWrite_out 	<= MemWrite;	
   MEM_ACCESS		<= NOT ALU_Result(11);
   MEM_WR_EN		<= MemWrite AND NOT ALU_Result(11);  ---we check the value of big endian to determine if we are using IO or memory
					 
   PC			    <= PC_sig; 

   -- connect the 5 MIPS components
  IFE : Ifetch
  	
	GENERIC MAP(instruction_address_width)

	PORT MAP (	Instruction 	=> Instruction,
    	    	PC_plus_4_out 	=> PC_plus_4,
				Add_result 		=> Add_result,
				Branch 			=> Branch,
				Zero 			=> Zero,
				bne				=> bne,
				PC_out 			=> PC_sig,   
				jr				=> jr,
				jump			=> jump,
				clock 			=> clock,  
				ALU_Result		=> ALU_Result,
				Function_opcode => Instruction( 5 DOWNTO 0 ),

				read_data 		=> read_data,
				INTR			=> INTR,
				reset 			=> reset,
				ena_pc			=> ena_pc

				);
				
				

   ID : Idecode
   	PORT MAP (	read_data_1 	=> read_data_1,
        		read_data_2 	=> read_data_2,
        		Instruction 	=> Instruction,
        		read_data 		=> read_data,
				ALU_result 		=> ALU_result,
				RegWrite 		=> RegWrite,
				MemtoReg 		=> MemtoReg,
				RegDst 			=> RegDst,
				Sign_extend 	=> Sign_extend,
				PC_plus_4		=> PC_plus_4,
				link			=> link,
				INTR			=> INTR,
				k0				=> k0,

        		clock 			=> clock,  
				Function_opcode => Instruction( 5 DOWNTO 0 ),
				reset 			=> reset, 
				PC   			=> PC_sig
				);


   CTL:   control
	PORT MAP ( 	Opcode 			=> Instruction( 31 DOWNTO 26 ),
				RegDst 			=> RegDst,
				ALUSrc 			=> ALUSrc,
				MemtoReg 		=> MemtoReg,
				RegWrite 		=> RegWrite,
				MemRead 		=> MemRead,
				MemWrite 		=> MemWrite,
				Branch 			=> Branch,
				jump			=> jump,
				jr				=> jr,
				bne				=> bne,
				link			=> link,
				ALUop 			=> ALUop,
				Function_opcode => Instruction( 5 DOWNTO 0 ),
                clock 			=> clock,
				reset 			=> reset );

   EXE:  Execute
   	PORT MAP (	Read_data_1 	=> read_data_1,
             	Read_data_2 	=> read_data_2,
				Sign_extend 	=> Sign_extend,
                Function_opcode	=> Instruction( 5 DOWNTO 0 ),
				opcode			=> Instruction( 31 DOWNTO 26 ),
				ALUOp 			=> ALUop,
				ALUSrc 			=> ALUSrc,
				Zero 			=> Zero,
                ALU_Result		=> ALU_Result,
				Add_Result 		=> Add_Result,
				PC_plus_4		=> PC_plus_4,
                Clock			=> clock,
				Reset			=> reset );

   MEM:  dmemory
   
   	GENERIC MAP( memory_address_width)

	PORT MAP (	read_data 		=> read_data,
				address 		=> ALU_Result (11 DOWNTO 0),--jump memory address by 4
				write_data 		=> read_data_2,
				INPUT_read_data => read_data_in,  -- data read from INPUT SWITCH				

				MemRead 		=> MemRead, 
				Memwrite 		=> MemWrite, 
				MEM_ACCESS		=> MEM_ACCESS,
				MEM_WR_EN		=> MEM_WR_EN,
				INTR			=> INTR,
				ITYPE			=> ITYPE,				
                clock 			=> clock,  
				reset 			=> reset );
END structure;

