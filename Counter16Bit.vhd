LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY Counter16Bit IS
   PORT ( clock, reset, INC   : IN  STD_LOGIC;
	       count_out           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END Counter16Bit;

ARCHITECTURE Behavior OF Counter16Bit IS

SIGNAL count : STD_LOGIC_VECTOR(15 DOWNTO 0);

BEGIN

	PROCESS (clock, reset)
	BEGIN
		IF reset = '0' THEN 
			count <= "0000000000000000";
		ELSIF clock'EVENT AND clock = '1' THEN
			IF INC = '1' THEN
				count <= count + '1';
			END IF;
		END IF;
	END PROCESS;

count_out <= count;	
	
END Behavior;	
