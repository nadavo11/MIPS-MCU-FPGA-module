				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY TOP IS

		PORT( 	reset, clock					: IN 	STD_LOGIC; 
				PORT_LEDG						: OUT 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_LEDR						: OUT 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_HEX0						: OUT 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX1						: OUT 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX2						: OUT 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX3						: OUT 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_SW							: IN 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_KEY						: IN 	STD_LOGIC_VECTOR(2 downto 0);
				ena_pc							: IN 	STD_LOGIC
				
				);
END 	TOP;

ARCHITECTURE structure OF TOP IS

	COMPONENT MIPS
   	     PORT(	Instruction_out					: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        		PC			 					: OUT  	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
				ALU_Result_out 					: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				------------------------------------------------------------------------
				read_data_1_out 				: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				read_data_2_out 				: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				write_data_out 					: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
				read_data_in 					: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );				
				address_out						: OUT   STD_LOGIC_VECTOR( 11 downto 0 );
				
				------------------------	interrupts	  ------------------------------
				k0								: OUT	STD_LOGIC;
				INTR							: IN	STD_LOGIC;
				ITYPE							: IN 	STD_LOGIC_VECTOR( 5 downto 0 );

				------------------------------------------------------------------------
        		Branch_out 						: OUT 	STD_LOGIC;
        		Zero_out 						: OUT 	STD_LOGIC;				
				MemWrite_out					: OUT 	STD_LOGIC;
				RegWrite_out					: OUT 	STD_LOGIC;
        		clock,reset						: IN 	STD_LOGIC;
				ena_pc							: IN 	STD_LOGIC

				);
	END COMPONENT; 	
	
	
	COMPONENT BT
		port (
				clock,reset 					: IN STD_LOGIC;	
				ACK								: IN STD_LOGIC;
				BT_IRQ							: OUT STD_LOGIC;
				WR_data							: IN STD_LOGIC_VECTOR(31 downto 0);
				WR_Address						: IN STD_LOGIC_VECTOR(11 downto 0);
				IO_WRITE						: IN STD_LOGIC

			); 
		END COMPONENT;
			
	COMPONENT INTERRUPT_CONTROLLER 
		port (
				clock,reset 					: IN STD_LOGIC;	
				INTR_out						: OUT STD_LOGIC;	
				ITYPE						  	: OUT STD_LOGIC_VECTOR( 5 downto 0 );
				ACK								: IN STD_LOGIC;
				WR_DATA 						: IN STD_LOGIC_VECTOR  ( 31 downto 0 );
				WR_ADDRESS						: IN STD_LOGIC_VECTOR  ( 11 downto 0 );
				IRQ								: IN STD_LOGIC_VECTOR  ( 3 downto 0 );
				IO_WRITE						: IN STD_LOGIC;	
				k0								: IN	STD_LOGIC;				
				IE_out							: OUT STD_LOGIC_VECTOR  ( 7 downto 0 );
				IFG_out							: OUT STD_LOGIC_VECTOR  ( 7 downto 0 )
				
	); 
	

	END COMPONENT;
	
	COMPONENT HEX_DEC IS
	 PORT ( reg: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            hex: OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	END COMPONENT;
	
----------------------------	SIGNALS		----------------------------------------


	--______________________________________________________
	--
	--					MIPS
	--______________________________________________________

					-- declare signals used to connect VHDL components
	SIGNAL rst				: STD_LOGIC;
	SIGNAL ALU_result 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_1 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Instruction 		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL PC				: STD_LOGIC_VECTOR( 9 DOWNTO 0 );

	SIGNAL Add_result 		: STD_LOGIC_VECTOR( 7 DOWNTO 0 );
	SIGNAL Branch 			: STD_LOGIC;
	SIGNAL Zero 			: STD_LOGIC;
	SIGNAL MemWrite 		: STD_LOGIC;
	SIGNAL RegWrite 		: STD_LOGIC;
	SIGNAL address			: STD_LOGIC_VECTOR(11 downto 0);
	
	SIGNAL INTR				: STD_LOGIC;
	SIGNAL ITYPE			: STD_LOGIC_VECTOR( 5 downto 0 );
	--______________________________________________________
	--
	--				Basic Timer
	--______________________________________________________
	SIGNAL BT_en 			: STD_LOGIC;
	SIGNAL BTI_ACK			: STD_LOGIC;
	SIGNAL MEM_ACCESS		: STD_LOGIC;
	SIGNAL MEM_WR_EN		: STD_LOGIC;
	--______________________________________________________
	--
	--				INTERRUPT_CONTROLLER
	--______________________________________________________
	SIGNAL interrupt_REG	: STD_LOGIC_VECTOR( 31 downto 0);
	SIGNAL flags			: STD_LOGIC_VECTOR( 3 downto 0 );		--for convinience we will work with flags REAL indexes
	SIGNAL IFG				: STD_LOGIC_VECTOR( 7 downto 0 );		
	SIGNAL ACK				: STD_LOGIC := '0';
	SIGNAL BT_IRQ			: STD_LOGIC;
	SIGNAL IRQ				: STD_LOGIC_VECTOR  ( 3 downto 0 );
	
	SIGNAL	IE				: STD_LOGIC_VECTOR  ( 7 downto 0 );
	SIGNAL k0				: STD_LOGIC;
	
	--______________________________________________________
	--
	--				   IO ACCESS
	--______________________________________________________
	SIGNAL IO_ACCESS 		: STD_LOGIC;
	SIGNAL IO_ADDRESS		: STD_LOGIC_VECTOR(8 downto 0); 
	SIGNAL write_data		: STD_LOGIC_VECTOR( 31 DOWNTO 0 );	-- data to be written to OUTPUT ports
	SIGNAL READ_DATA		: STD_LOGIC_VECTOR( 31 downto 0);	-- data to be read from INPUT switches
	SIGNAL IO_WRITE			: STD_LOGIC;						-- are we looking to write to an output?
	SIGNAL IO_READ			: STD_LOGIC;						-- are we looking to READ from an intput?
	SIGNAL switches			: STD_LOGIC_VECTOR(7 downto 0); 
	SIGNAL keys				: STD_LOGIC_VECTOR(3 downto 1); 

	
  	-- DECLARATION OF 12 IO REGISTERS:
	SIGNAL write_clock : STD_LOGIC;
	TYPE IO_array IS ARRAY ( 0 TO 11 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	
	SIGNAL  IO_registers				: IO_array;
	
BEGIN
	
	rst			<= NOT reset;
	--______________________________________________________
	--
	--					IO MEM
	--______________________________________________________

	IO_ACCESS  	<= address(11);		---- are we trying to reach an IO periferial?
	IO_ADDRESS	<= address(10 downto 2);
	IO_WRITE	<= '1' WHEN (IO_ACCESS = '1') AND ( MemWrite = '1') 
					ELSE '0';							--- we DONT write to 0x818, 0x81C because these are INPUTS 
					
	IO_READ		<= '1' WHEN (IO_ACCESS = '1') AND (not ( MemWrite = '1'))
					ELSE '0';							--- we ONLY read from 0x818, 0x81C because these are INPUTS  
	switches	<=	PORT_SW;	
	keys		<=  not PORT_KEY;
	--______________________________________________________
	--
	--					IO PERIFERIALS CONNECTIONS
	--______________________________________________________
	
				PORT_LEDG							<= IO_registers(0)(7 downto 0);			--- 0x800
				PORT_LEDR							<= IO_registers(1)(7 downto 0);			--- 0x804
				--PORT_HEX0							<= IO_registers(2)(7 downto 0);			--- 0x808
				--PORT_HEX1							<= IO_registers(3)(7 downto 0);			--- 0x80C
				--PORT_HEX2							<= IO_registers(4)(7 downto 0);			--- 0x810
				--PORT_HEX3							<= IO_registers(5)(7 downto 0);			--- 0x814
				
	---------------- 			OUTPUT REGISTERS
				--IO_registers(6)(7 downto 0) 		<= switches; 							--- 0x818
				--IO_registers(7)(3 downto 1)			<= keys;								--- 0x81C
			
	
		IRQ    <=  keys & BT_IRQ;
		
		--- if command was 	jr   $k1        # reti 
		ACK    			<= 		'1'		when	Instruction = x"03600008" 	-------- TODO :  ADD AN ACK MECHANISM HERE
						ELSE	'0';	
								
		--- if command was 	jr   $k1        # reti 
		
		BTI_ACK <= ACK		WHEN	ITYPE = "010000"
				else	'0';
--__________________________________________________________________________________________________________
		
-- 								a process to control Output peiferals
--__________________________________________________________________________________________________________
	PROCESS BEGIN
		WAIT UNTIL clock'EVENT AND clock = '1';
		IF rst = '1' THEN
				
					-- use loop to automatically generate reset logic
					-- for all registers
			FOR i IN 0 TO 11 LOOP										-- we ONLY reset outputs ie. 0 through 6..
				IO_registers(i) <= CONV_STD_LOGIC_VECTOR( 0 , 32 );		-- TODO: ADD IE check logic
 			END LOOP;
					-- Write back to register - don't write to register 0
  		ELSIF IO_ACCESS = '1' AND (IO_WRITE = '1')  THEN 
		      IO_registers( CONV_INTEGER( unsigned(IO_ADDRESS) )) <= read_data_2;	-- can add security for invalid addresses


--__________________________________________________________________________________________________________
		
-- 								a process to read from Input peiferals
--__________________________________________________________________________________________________________

		
	--	ELSIF IO_ACCESS = '1' AND (IO_READ = '1')  THEN 
	--		IF 		IO_ADDRESS = "000000110" 	THEN 	READ_DATA 	<=	x"000000" & switches;
	--		ELSIF	address    = x"82c"			THEN	READ_DATA	<=  x"000000" & IE;	
	--		ELSIF	address    = x"82d"			THEN	READ_DATA	<=  x"000000" & IFG;	
	--		ELSIF	address    = x"82e"			THEN	READ_DATA	<=  x"000000" & "00" & ITYPE;	


		     -- READ_DATA <= IO_registers( CONV_INTEGER( unsigned(IO_ADDRESS) ));	-- can add security for invalid addresses
	--		END IF;
	
		END IF;
	END PROCESS;
	
	READ_DATA 	<=	x"000000" & switches 	 when IO_ACCESS = '1' AND IO_READ = '1' and IO_ADDRESS = "000000110" else
					x"000000" & IE 		 	 when IO_ACCESS = '1' AND IO_READ = '1' and address    = x"82c" else
					x"000000" & IFG 	 	 when IO_ACCESS = '1' AND IO_READ = '1' and address    = x"82d" else
					x"000000" & "00" & ITYPE when IO_ACCESS = '1' AND IO_READ = '1' and address    = x"82e" else
					READ_DATA;
			
	
	
	
-----------------------------------------------------------------------------------------
--
--									PORT MAPS
--
-----------------------------------------------------------------------------------------		
				-- HEX DECODER --
				
 DECODER_HEX0: HEX_DEC
	PORT MAP ( reg	=> IO_registers(2)(3 downto 0),
           hex  => PORT_HEX0
		   );
		   
 DECODER_HEX1: HEX_DEC
	PORT MAP ( reg	=> IO_registers(3)(3 downto 0),
           hex  => PORT_HEX1
		   );
		   
 DECODER_HEX2: HEX_DEC
	PORT MAP ( reg	=> IO_registers(4)(3 downto 0),
           hex  => PORT_HEX2
		   );

 DECODER_HEX3: HEX_DEC
	PORT MAP( reg	=> IO_registers(5)(3 downto 0),
           hex  => PORT_HEX3
		   );		   
	--______________________________________________________
	--
	--					MIPS
	--______________________________________________________		
					
  MIPS_CORE : MIPS
	PORT MAP (	Instruction_out				=> Instruction,
        		PC			 				=> PC,
				ALU_Result_out 				=> ALU_result,
				read_data_1_out 			=> read_data_1,
				read_data_2_out 			=> read_data_2,
				write_data_out 				=> write_data,
				read_data_in				=> READ_DATA,
				address_out					=> address,
				k0							=> k0,
				INTR						=> INTR,
				ITYPE						=> ITYPE,
        		Branch_out 					=> Branch,
        		Zero_out 					=> zero,				
				MemWrite_out				=> MemWrite,
				RegWrite_out				=> RegWrite,
        		clock						=> clock,
				reset						=> rst,
				ena_pc						=> ena_pc
	----------------------------------------------------
				);
	--______________________________________________________
	--
	--					BASIC TIMER
	--______________________________________________________		
					
   BASIC_TIMER : BT
   	PORT MAP (	clock						=> clock,
				reset 						=> rst,
				ACK							=> BTI_ACK,
				BT_IRQ						=> BT_IRQ,
				WR_data						=> write_data,
				WR_Address					=> address,
				IO_WRITE					=> IO_WRITE
				 );

	--______________________________________________________
	--
	--					INTERRUPT CONTROLLER
	--______________________________________________________		
					
   ICT:   INTERRUPT_CONTROLLER
	PORT MAP ( 	clock		 				=> clock,
				INTR_out					=> INTR,
				ACK							=> ACK,
				ITYPE						=> ITYPE,
				WR_DATA 					=> read_data_2,
				WR_ADDRESS					=> address,
				IRQ							=> IRQ,
				IO_WRITE					=> IO_WRITE,
				
				k0							=>k0, --GIE
				IE_out						=>IE,
				IFG_out						=>IFG,
				reset 						=> rst );
		
  
END structure;

