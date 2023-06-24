library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE IEEE.STD_LOGIC_ARITH.ALL;

 
entity INTERRUPT_CONTROLLER is port (
	clock,reset 				: IN STD_LOGIC;	
	INTR_out					: OUT STD_LOGIC;
	ITYPE						: OUT STD_LOGIC_VECTOR( 5 downto 0 );
	ACK							: IN STD_LOGIC;
	WR_DATA 					: IN STD_LOGIC_VECTOR  ( 31 downto 0 );
	WR_ADDRESS					: IN STD_LOGIC_VECTOR  ( 11 downto 0 );
	IRQ							: IN STD_LOGIC_VECTOR  ( 3 downto 0 );	-- IRQ(0) IS BT_IRQ
	IO_WRITE					: IN STD_LOGIC;
	
	k0							: IN	STD_LOGIC;
	IE_out						: OUT STD_LOGIC_VECTOR  ( 7 downto 0 );
	IFG_out						: OUT STD_LOGIC_VECTOR  ( 7 downto 0 )


	); 
	
end INTERRUPT_CONTROLLER;

architecture rtl of INTERRUPT_CONTROLLER is

	SIGNAL IE					: STD_LOGIC_VECTOR ( 7 downto 0) := X"00";
	SIGNAL IFG					: STD_LOGIC_VECTOR ( 7 downto 0) := X"00";
	SIGNAL ITYPE_reg			: STD_LOGIC_VECTOR ( 7 downto 0) := X"00";

	SIGNAL pending				: STD_LOGIC;
	
	SIGNAL enables				: STD_LOGIC_VECTOR ( 3 downto 0) := "0000";

	SIGNAL ITYPE_sig			: STD_LOGIC_VECTOR ( 5 downto 0);
	signal cnt_q 				: std_logic_vector (31 downto 0):=x"00000000";
	SIGNAL cnt_en				: STD_LOGIC :='0';
	
	SIGNAL cnt_en_pend_down		: STD_LOGIC :='0';
	
	SIGNAL BT_src				: STD_LOGIC;


begin
	IE_out			<= IE;
	IFG_out			<= IFG;
	enables 		<= IE ( 5 downto 2 );
			
	ITYPE			<= ITYPE_reg ( 5 downto 0 );
	ITYPE_sig		<= ITYPE_reg ( 5 downto 0 );
	
	------------------- IRQ REG -------------------
	
	------------------- proccess to select and trigger interrupts -----------------------------------------------------
	process (clock, reset)
    begin
	
		if reset ='1' then	
			IFG <= X"00";			
		---_______________________________
		elsif (rising_edge(clock)) then  -- #IF0
		
		---------------------------------- REGISTER WRITE ---------------------------------------------------------------
			IF 	  WR_ADDRESS  = X"82C" and IO_WRITE = '1'	THEN 	IE 			<= 	WR_DATA( 7 downto 0);
			
			ELSIF WR_ADDRESS  = X"82D" and IO_WRITE = '1'	THEN 	IFG 		<= 	WR_DATA ( 7 downto 0);
			
			ELSIF WR_ADDRESS  = X"82E" and IO_WRITE = '1'	THEN 	ITYPE_reg 	<= 	WR_DATA( 7 downto 0);
											
		---------------------------- raise relevant flags  -------------------------
			ELSE 
				if	k0 ='1' THEN------------------------------ GIE IF STATEMENT -----------------------------------------
				
					--------------------------------- IRQ's & FLAGS IF STATEMENT------------------------------------------
					if ( ( (IRQ(1)='1') OR (IRQ(2)='1') OR (IRQ(3)='1') ) and pending ='0' ) then						--
						cnt_en <= '1';
						IFG(5 downto 3) <= IRQ(3 downto 1) AND enables (3 downto 1) ;									--

					elsif BT_src = '1' and enables(0) = '1' and pending = '0' then										--
						IFG(2) <= '1';
																														--
					end if; ----------------------------------------------------------------------------------------------
					
					
					if cnt_en_pend_down = '1' then
						cnt_en <= '0';		
					end if;	
					------------------------------------------------------------------------------------------------------
				
		------------------------- WHEN AN ACK ARRIVES ---------------------------
					IF ACK = '1' and IFG(2) = '1' then --- reset ACK'd FLAG AUTOMATICALLY for Basic Timer		
							IFG(2) <= '0';		---Basic timer flag is the only one to be reset automatically in hardware
					end if;
				
		------------------------- When we can handle ANOTHER INTERRUPT ---------------------------
					IF pending = '0' AND IFG(5 downto 0) /= "0000" then		---priority Queue
						IF 				IFG(2) = '1'		THEN 	ITYPE_reg   <= 	"00010000" ; 		-- BTI is waiting
						ELSIF 			IFG(3) = '1'		THEN 	ITYPE_reg   <= 	"00010100" ; 		-- KEY1 INTRRUPT is waiting
						ELSIF 			IFG(4) = '1'		THEN 	ITYPE_reg   <= 	"00011000" ; 	-- KEY2 INTRRUPT is waiting
						ELSIF			IFG(5) = '1'		THEN 	ITYPE_reg   <= 	"00011100" ; 	-- KEY3 INTRRUPT is waiting
						END IF;
						INTR_out 	<= '1';
						
					ELSE INTR_out <='0';
					
					end if;	
				END IF;		
				
			end IF;			
	
		end if;
		 
    end process;
	
	--------- BT INT -----------------
process (IRQ(0),reset, IFG(2)) -- INR reg BT
		begin
		if (reset = '1' or IFG(2) = '1') then 
			BT_src <= '0';
		elsif (IRQ(0)'EVENT AND IRQ(0) = '1' and pending = '0' ) then -- rising edge interrupt
			if IE(2) = '1' AND k0 = '1' then  -- if the BT IE is on
			BT_src <= '1'; 
			end if;	
		end if;
	end process;	
	
-----------delay for buttons---------------------
	process (clock)
    begin
		if (rising_edge(clock)) then 
			if reset ='1' 	then	
				pending <= '0';
				cnt_q <= x"00000000";
				cnt_en_pend_down <= '0';
				
			elsif pending = '0' AND IFG(5 downto 0) /= "0000" then	
				pending <= '1';
				
			end if;
			
			if cnt_en = '1' then
				cnt_q <= cnt_q + 1;
			end if;
			
			if cnt_q(23) = '1' then
					pending <= '0';
					cnt_q   <= x"00000000";
					cnt_en_pend_down <= '1';
			end if;
			
			if cnt_en_pend_down = '1' then
					cnt_q   <= x"00000000";
					cnt_en_pend_down <= '0';
			end if;
			
			IF	ITYPE_sig = "010000" and ACK = '1' THEN
				pending <= '0';
			end if;
			
		end if;
    end process;
	
	

end rtl;

	