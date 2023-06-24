-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY Ifetch IS

	GENERIC(instruction_address_width: 	positive:=10);

	PORT(	SIGNAL Instruction 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	SIGNAL PC_plus_4_out 	: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	SIGNAL Add_result 		: IN 	STD_LOGIC_VECTOR( 7 DOWNTO 0 );
        	SIGNAL Branch 			: IN 	STD_LOGIC;
        	SIGNAL Zero 			: IN 	STD_LOGIC;
			SIGNAL bne	 			: IN 	STD_LOGIC;
			SIGNAL jump				: IN    STD_LOGIC;
      		SIGNAL PC_out 			: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			SIGNAL ALU_Result 		: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			SIGNAL jr				: IN 	STD_LOGIC;
			SIGNAL INTR				: IN	STD_LOGIC;
			SIGNAL read_data 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			SIGNAL Function_opcode	: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );

        	SIGNAL clock, reset 	: IN 	STD_LOGIC;
			SIGNAL ena_pc			: IN 	STD_LOGIC
			);
END Ifetch;

ARCHITECTURE behavior OF Ifetch IS
	SIGNAL PC, PC_plus_4 ,Mem_Addr			: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL next_PC  		 				: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL Instruction_internal				: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
BEGIN



		Instruction 	<= X"0C000000" when INTR = '1' else   --- 	jal 0X0000
							Instruction_internal;
					--- on INTERRUPT we fetch a jal instruction, and ignore the  
					---current OP, it will be dealt with after service rutine is over
					
					
						--ROM for Instruction Memory
inst_memory: altsyncram
	
	GENERIC MAP (
		operation_mode => "ROM",
		width_a => 32,
		widthad_a => instruction_address_width,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "C:\altera\final projrct\assembly test files\tests\text.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		clock0     				=> clock,
		address_a 				=> Mem_Addr(9 downto 10 - instruction_address_width), 
		q_a 					=> Instruction_internal);
		

									-- Instructions always start on word address - not byte
		PC(1 DOWNTO 0) <= "00";
					-- copy output signals - allows read inside module
		PC_out 			<= PC;
		PC_plus_4_out 	<= PC_plus_4;
						-- send address to inst. memory address register
		Mem_Addr <= Next_PC & "00";
						-- Adder to increment PC by 4        
      	PC_plus_4( 9 DOWNTO 2 )  <= PC( 9 DOWNTO 2 ) + 1;
       	PC_plus_4( 1 DOWNTO 0 )  <= "00";
						-- Mux to select Branch Address or PC + 4        
		Next_PC  <= X"00" WHEN Reset = '1' 
				   ELSE read_data( 9 downto 2 )					WHEN		INTR = '1'						--interrupt support
			       ELSE Add_result  							WHEN 		( ( Branch ='1') AND ( (Zero ='1')  XOR (bne ='1') ) )
			       ELSE Instruction_internal( 7 downto 0 )  	WHEN 		jump = '1'						--jmp support
			       ELSE ALU_Result	(7 downto 0)				WHEN		jr = '1'						--jr support
				   ELSE Next_PC									WHEN   		ena_pc = '0'     
				   ELSE PC_plus_4( 9 DOWNTO 2 );
			
	----- PC REG -----	
	PROCESS
		BEGIN
			WAIT UNTIL ( clock'EVENT ) AND ( clock = '1' );
			IF reset = '1' THEN
				   PC( 9 DOWNTO 2) <= "00000000" ; 
			ELSIF ena_pc = '1' THEN 
				   PC( 9 DOWNTO 2 ) <= next_PC;
			ELSE PC( 9 DOWNTO 2 ) <= PC( 9 DOWNTO 2 );
			END IF;
	END PROCESS;
END behavior;


