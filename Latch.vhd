LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY Latch IS
   PORT ( clock, reset  : IN  STD_LOGIC;
			 Lin           : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);	
	       Lout          : OUT STD_LOGIC);
END Latch;

ARCHITECTURE Behavior OF Latch IS

SIGNAL a : STD_LOGIC;

BEGIN 

	PROCESS (clock, reset) 
	BEGIN 
		IF Lin = "1111111111" THEN
			a <= '0';
		ELSE
			a <= '1';
		END IF;
	END PROCESS;

Lout <= a;
	
END Behavior;
