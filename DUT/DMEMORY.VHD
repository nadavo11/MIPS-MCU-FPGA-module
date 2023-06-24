						--  Dmemory module (implements the data
						--  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS

	GENERIC( memory_address_width: 		positive:=9);

	PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			INPUT_read_data 	: IN	STD_LOGIC_VECTOR( 31 DOWNTO 0 );	-- data read from INPUT SWITCH			
        	address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 ); ---adress space is now 0x000 to 0x7FC
        	write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   		MemRead, Memwrite 	: IN 	STD_LOGIC;
			MEM_ACCESS			: IN 	STD_LOGIC;   --- is the program trying to access Memory adress? or IO?
			MEM_WR_EN			: IN	STD_LOGIC;
			INTR				: IN	STD_LOGIC;
			ITYPE				: IN 	STD_LOGIC_VECTOR( 5 downto 0 );
            clock,reset			: IN 	STD_LOGIC );
END dmemory;

ARCHITECTURE behavior OF dmemory IS
SIGNAL write_clock : STD_LOGIC;
	TYPE IO_registers IS ARRAY ( 0 TO 7 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	
	SIGNAL  IO_registers_array				: IO_registers;
	SIGNAL	IO_ADRESS					: STD_LOGIC_VECTOR( 2 DOWNTO 0 );
	SIGNAL	IO_ACCESS					: STD_LOGIC;
	SIGNAL  read_data_internal			: STD_LOGIC_VECTOR( 31 DOWNTO 0 );	
	SIGNAL  address_sig			: STD_LOGIC_VECTOR( 11 DOWNTO 0 );	

BEGIN
	address_sig			<=		address		WHEN 	INTR = '0'		--forcefully get Instruction Service Rutine
								else	"000000" & ITYPE;					-- (ISR) address from memory in case of INTERRUPT.
	
	
	data_memory : altsyncram
	GENERIC MAP  (
		operation_mode => "SINGLE_PORT",
		width_a => 32,
		widthad_a => memory_address_width,
		lpm_type => "altsyncram",
		outdata_reg_a => "UNREGISTERED",
		init_file => "C:\altera\final projrct\assembly test files\tests\data.hex",
		intended_device_family => "Cyclone"
	)
	PORT MAP (
		
		wren_a => MEM_WR_EN,
		clock0 => write_clock,
		address_a => address_sig(10 downto 11 - memory_address_width),
		data_a => write_data,
		q_a => read_data_internal 
		);
		
		
		read_data <= read_data_internal when MEM_ACCESS = '1' else INPUT_read_data;
-- Load memory address register with write clock
    
		IO_ADRESS 	 <= address(4 downto 2);
		IO_ACCESS    <= address(11);
		write_clock  <= NOT clock;
		--__________________________________________________________________________________________________________
		
		-- 								a process to control Output peiferals
		--__________________________________________________________________________________________________________
--		PROCESS BEGIN
--		WAIT UNTIL clock'EVENT AND clock = '1';
--		IF reset = '1' THEN
					-- Initial register values on reset are register = reg#
					-- use loop to automatically generate reset logic
					-- for all registers
--			FOR i IN 0 TO 6 LOOP										-- we ONLY reset outputs ie. 0 through 6..
--				IO_registers_array(i) <= CONV_STD_LOGIC_VECTOR( 0 , 32 );		-- TODO: ADD IE check logic
 --			END LOOP;
--					-- Write back to register - don't write to register 0
  --		ELSIF IO_ACCESS = '1' AND Memwrite = '1' THEN
		  --    IO_registers_array( CONV_INTEGER( IO_ADRESS )) <= write_data;	-- can add security for invalid addresses
		--END IF;
	--END PROCESS;
END behavior;