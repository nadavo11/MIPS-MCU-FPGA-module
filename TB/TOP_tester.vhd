-- VHDL Entity MIPS.MIPS_tester.interface
--
-- Created:
--          by - kolaman.UNKNOWN (KOLAMAN-PC)
--          at - 09:22:44 17/02/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2011.1 (Build 18)
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY TOP_tester IS

      PORT( 	reset, clock						: OUT 	STD_LOGIC; 
				PORT_LEDG						: IN 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_LEDR						: IN 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_HEX0						: IN 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX1						: IN 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX2						: IN 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_HEX3						: IN 	STD_LOGIC_VECTOR(6 downto 0);
				PORT_SW							: OUT 	STD_LOGIC_VECTOR(7 downto 0);
				PORT_KEY						: OUT 	STD_LOGIC_VECTOR(2 downto 0);
				ena_pc							: OUT 	STD_LOGIC

				);

-- Declarations

END TOP_tester ;

--
-- VHDL Architecture MIPS.MIPS_tester.struct
--
-- Created:
--          by - kolaman.UNKNOWN (KOLAMAN-PC)
--          at - 09:22:44 17/02/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2011.1 (Build 18)
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;


ARCHITECTURE struct OF TOP_tester IS

   -- Architecture declarations

   -- Internal signal declarations


   -- ModuleWare signal declarations(v1.9) for instance 'U_0' of 'clk'
   SIGNAL mw_U_0clk : std_logic;
   SIGNAL mw_U_0disable_clk : boolean := FALSE;

   -- ModuleWare signal declarations(v1.9) for instance 'U_1' of 'pulse'
   SIGNAL mw_U_1pulse : std_logic :='1';


BEGIN

ena_pc <= '1';

   -- ModuleWare code(v1.9) for instance 'U_0' of 'clk'
   u_0clk_proc: PROCESS
   BEGIN
      WHILE NOT mw_U_0disable_clk LOOP
         mw_U_0clk <= '0', '1' AFTER 50 ns;
         WAIT FOR 100 ns;
      END LOOP;
      WAIT;
   END PROCESS u_0clk_proc;
   mw_U_0disable_clk <= TRUE AFTER 40000 ns;
   clock <= mw_U_0clk;

   -- ModuleWare code(v1.9) for instance 'U_1' of 'pulse'
   reset <= mw_U_1pulse;
   u_1pulse_proc: PROCESS
   BEGIN
      mw_U_1pulse <= 
         '1',
         '0' AFTER 20 ns,
         '1' AFTER 120 ns;
      WAIT;
    END PROCESS u_1pulse_proc;

   -- Instance port mappings.
   
   u_2inter_proc: process
   BEGIN
   PORT_KEY <= "111",
   "101" AFTER 2200 ns,
   "111" after 4200 ns,
   "101" AFTER 6200 ns,
   "111" AFTER 8200 ns,
   "101" AFTER 9200 ns,
   "111" AFTER 11200 ns;
   wait;
   end process u_2inter_proc;
   
   u_3SW: process
   BEGIN
   PORT_SW <= "01010101";   
   wait;
   end process u_3SW;
   
   
   

END struct;