LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY flipflop IS
	PORT ( clock, reset, input   : IN  STD_LOGIC;
	       output                : OUT STD_LOGIC);
END flipflop;

ARCHITECTURE Behavior OF flipflop IS

BEGIN 
	PROCESS (clock, reset)
	BEGIN 
		IF reset = '0' THEN 
			output <= '0';
		ELSIF clock'EVENT AND clock = '1' THEN 
			output <= input;
		END IF;
	END PROCESS; 
	
END Behavior;
			 