LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY ClockDivider IS
   PORT ( clock, reset           : IN  STD_LOGIC;
	       clock_out, clock_out2  : OUT STD_LOGIC);
END ClockDivider;

ARCHITECTURE Behavior OF ClockDivider IS

SIGNAL temp  : STD_LOGIC;
SIGNAL count : integer := 0;


BEGIN
   PROCESS (clock, reset)
	BEGIN
	IF (reset = '0') THEN
	  temp  <= '0';
	  count <=  0;
	  ELSIF clock'EVENT AND clock = '1' THEN
	    IF (count = 1) THEN
		   temp  <= NOT(temp);
			count <= 0;
		 ELSE
		   count <= count + 1;
		 END IF;
	END IF;
   END PROCESS;

   clock_out  <= temp;
	clock_out2 <= temp;

END Behavior;	