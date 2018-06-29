LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY PhaseGenerator IS
   PORT ( reset, clock : IN  STD_LOGIC;
	       P            : OUT STD_LOGIC_VECTOR(7 downto 0));
END PhaseGenerator;

ARCHITECTURE Behavior OF PhaseGenerator IS

SIGNAL Qreg : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
   PROCESS (reset, clock)
	BEGIN
   IF reset = '0' THEN 
	   Qreg(0) <= '1';  Qreg(1) <= '0'; Qreg(2) <= '0'; Qreg(3) <= '0'; Qreg(4) <= '0';  
		Qreg(5) <= '0';  Qreg(6) <= '0'; Qreg(7) <= '0'; 
		
	ELSIF clock'EVENT AND clock = '1' THEN
	
	Qreg(1) <= Qreg(0);
	Qreg(2) <= Qreg(1);
	Qreg(3) <= Qreg(2);
	Qreg(4) <= Qreg(3);
	Qreg(5) <= Qreg(4);
	Qreg(6) <= Qreg(5);
	Qreg(7) <= Qreg(6);
	Qreg(0) <= Qreg(7);
	
	END IF;
	
	End PROCESS;
	
	P(0) <= Qreg(0);
	P(1) <= Qreg(1);
	P(2) <= Qreg(2);
	P(3) <= Qreg(3);	
	P(4) <= Qreg(4);
	P(5) <= Qreg(5);
	P(6) <= Qreg(6);
	P(7) <= Qreg(7);
	
END Behavior;