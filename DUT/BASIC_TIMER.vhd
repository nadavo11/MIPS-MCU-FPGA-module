library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
 
entity BT is port (
	clock,reset 				: IN STD_LOGIC;	
	ACK							: IN STD_LOGIC;
	BT_IRQ						: OUT STD_LOGIC;
	WR_data						: IN STD_LOGIC_VECTOR(31 downto 0);
	WR_Address					: IN STD_LOGIC_VECTOR(11 downto 0);
	IO_WRITE					: IN STD_LOGIC
	
	); 
	
end BT;

architecture rtl of BT is
-------------------------------		INTERFACE REGISTERS		------------------------------------------------------
	SIGNAL BTCTL				: STD_LOGIC_VECTOR (7 downto 0	)	:="00000000";
	SIGNAL BTCNT				: STD_LOGIC_VECTOR (31 downto 0 )	:= x"00000000";
------------------------------------------------------------------------------------------------------------------	
------------------------------- 	DERRIVED FROM REGISTERS ------------------------------------------------------
	SIGNAL enable				: STD_LOGIC;
	SIGNAL BTSSEL				: STD_LOGIC_VECTOR  ( 1 downto 0);
	SIGNAL	BTIP				: STD_LOGIC_VECTOR  ( 2 downto 0);
------------------------------------------------------------------------------------------------------------------

    SIGNAL q_int 				: STD_LOGIC_VECTOR (31 downto 0	)	:=x"00000000";
	SIGNAL mod_n				: STD_LOGIC_VECTOR ( 3 downto 0	)	:="0000";
	SIGNAL clock_n				: STD_LOGIC:= '0';
	SIGNAL trigger				: integer	:= 0;
	SIGNAL flag					: STD_LOGIC := '0';
	SIGNAL n_sel				: integer;
	
	SIGNAL q_int_down			: STD_LOGIC := '0';
	
	SIGNAL BTSSEL_cnt			: STD_LOGIC_VECTOR  ( 3 downto 0);
	signal BTCNT_clk 			: std_logic;




begin

enable		<= 		NOT BTCTL( 5 );					
BTSSEL		<=			BTCTL( 4 downto 3);
BTIP		<= 			BTCTL( 2 downto 0);

	process (clock, reset) -- BTSEL REG - devide for BTCNT_clk
	begin
	if (reset = '1') then 
			BTSSEL_cnt <= X"0";
	elsif (clock'EVENT and clock ='1') then 
			BTSSEL_cnt <= BTSSEL_cnt + 1; 
	
	end if;
	end process;
	
with BTSSEL select  -- BTSSELL MUX
  BTCNT_clk <= BTSSEL_cnt (0) when "01",   --- clk/2
               BTSSEL_cnt (1) when "10",   --- clk/4
               BTSSEL_cnt (2) when "11",   --- clk/8
               clock		  when others; --- clk
			   
with BTCTL(2 DOWNTO 0) select  -- BTIPx MUX
    BT_IRQ	 <= BTCNT (3)  when "001",  --- Q3
                BTCNT (7)  when "010",  --- Q7
                BTCNT (11) when "011", 	--- Q11
				BTCNT (15) when "100", 	--- Q15
				BTCNT (19) when "101", 	--- Q19
				BTCNT (23) when "110", 	--- Q23
				BTCNT (25) when "111", 	--- Q25
                BTCNT (0)  when others; --- Q0
				
process (BTCNT_clk,reset) --  BTCNT REG
		begin
		if (reset = '1') then 
			BTCNT <= X"00000000";
			
		elsif (BTCNT_clk'EVENT AND BTCNT_clk = '1') then -- writes on falling edge
		
			if WR_ADDRESS = X"828" and IO_WRITE = '1' then
			BTCNT	<= 	WR_DATA;
			elsif enable = '1' then
			BTCNT <= BTCNT + 1;
			end if;
			
		end if;
		
	end process;
	
process (clock)
    begin
		
		if reset ='1' then
			BTCTL <= X"00";
	
        elsif (rising_edge(clock)) then
	--------------------------------	Allow Write to registers	----------------------------------------
			if WR_Address = x"824" and IO_WRITE = '1' then BTCTL <= WR_data( 7 downto 0);
						
			end if;
			
		end if;
	end process;

----=====================================================================================



	------------------------------------ SELECT CLOCK DEVIDER--------------------------------------------------
--	n_sel 			<= 		1 	when 	BTSSEL = "00"	--MCLCK
--					ELSE 	2 	when 	BTSSEL = "01"	--MCLCK:2
--					ELSE 	4 	when 	BTSSEL = "10"	--MCLCK:4
--					ELSE 	8;							--MCLCK:8
					
					
	------------------------------------ SELECT INTERRUPT TRIGGER ----------------------------------------------
	
--	trigger 		<= 		0 	when 	BTIP = "000"	--Q0
--					ELSE 	3 	when 	BTIP = "001"	--Q3
--					ELSE 	7 	when 	BTIP = "010"	--Q7					
--					ELSE 	11 	when 	BTIP = "011"	--Q11
--					ELSE 	15	when 	BTIP = "100"	--Q15
--					ELSE 	19 	when 	BTIP = "101"	--Q19					
--					ELSE 	23 	when 	BTIP = "110"	--Q23
--					ELSE 	25;							--Q25
					
				
	-------------------------------- DEVIDE CLOCK BY n -----------------------------------------------------
	--		ELSif reset = '1' then			
	--					mod_n 	<= 	"0000";
	--					flag  	<=	'0';
						
	--		ELSIF ACK = '1'  then				 -- reset the flag when interrupt is dealt with
	--					BTCNT 	<= 	x"00000000";
	--					flag	<=	'0';
	--					q_int_down <= '1';
						
							
	--		ELSif enable = '1'  		
	--			then	mod_n 	<= mod_n + 1;
	--			BTCNT <= q_int(31 downto 0);
				
	--			if (clock_n'event and q_int_down = '1') then
	--				q_int_down <= '0';
	--			end if;
								--___________________ DEAL WITH INTERRUPT FLAG___________________________
						
	--				if q_int(trigger) = '1' then --raise the flag when relevant bit is set
	--					flag <= '1'; 				
	--				end if;
	--		end if;
			
	--		if mod_n = n_sel
	--			then 	clock_n <= not clock_n;
	--					mod_n <= x"0";
	--		end if; 
	--	end if;
    --end process;

--    process (clock_n)
 --   begin
--		------------------------------- COUNTER based on MCLK : n	----------------------------------------------
 --       if (clock_n'event) then
--			if reset ='1' or ack ='1' then
--				q_int <= x"00000000";
				
--			elsif enable = '1' 	then
--				q_int <= q_int + 1;
		        
--			end if;
			
--	    end if;			
		 		
 --   end process;
	 ----------------------------- RAISE FLAG WHEN
     
--	BT_IRQ <= flag;				-- INTERRUPT FLAG
	
end rtl;


