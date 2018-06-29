LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY ShiftRegister IS
   PORT ( Dout, clock, reset  : IN  STD_LOGIC;
	       Rout                : OUT STD_LOGIC;
			 Lout                : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END ShiftRegister;

ARCHITECTURE Behavior OF ShiftRegister IS

SIGNAL Qreg : STD_LOGIC_VECTOR(9 DOWNTO 0);

BEGIN

   PROCESS (reset, clock)
	BEGIN
		IF reset = '0' THEN 
			Qreg(0) <= '0';  Qreg(1) <= '0'; Qreg(2) <= '0'; Qreg(3) <= '0'; Qreg(4) <= '0';  
			Qreg(5) <= '0';  Qreg(6) <= '0'; Qreg(7) <= '0'; Qreg(8) <= '0'; Qreg(9) <= '0';
		ELSIF clock'EVENT AND clock = '1' THEN
			Qreg(0) <= Dout;
			Qreg(1) <= Qreg(0);
			Qreg(2) <= Qreg(1);
			Qreg(3) <= Qreg(2);
			Qreg(4) <= Qreg(3);
			Qreg(5) <= Qreg(4);
			Qreg(6) <= Qreg(5);
			Qreg(7) <= Qreg(6);
			Qreg(8) <= Qreg(7);
			Qreg(9) <= Qreg(8);
		END IF;
	END PROCESS;
	
Rout <= Qreg(9);
Lout <= Qreg;

END Behavior;
