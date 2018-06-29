LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY DigitalFilter IS
  PORT (In_P, In_N, clock, reset    : IN  STD_LOGIC;
        Out_P, Out_N                : OUT STD_LOGIC);
	
END DigitalFilter;

ARCHITECTURE Behavior OF DigitalFilter IS

SIGNAL reg1, reg2, reg3, reg4, reg5, reg6, reg7, reg8, sigA, sigB : STD_LOGIC;

BEGIN

   PROCESS (reset, clock)
	BEGIN
	IF reset = '0' THEN 
	
	reg1 <= '0'; reg2 <= '0'; reg3 <= '0'; reg4 <= '0'; 
   reg5 <= '0'; reg6 <= '0'; reg7 <= '0'; reg8 <= '0';
	
	ELSIF clock'EVENT AND clock = '1' THEN
	
	reg1 <= In_P; reg2 <= reg1; reg3 <= reg2; reg4 <= reg3; 
	reg5 <= In_N; reg6 <= reg5; reg7 <= reg6; reg8 <= reg7;
	
	END IF;
	
	END PROCESS; 
	
sigA <= reg1 OR reg2 OR reg3 OR reg4;
sigB <= reg5 OR reg6 OR reg7 OR reg8;
Out_P <= sigA AND (NOT sigB);
Out_N <= sigB AND (NOT sigA);
	
END Behavior;
	
