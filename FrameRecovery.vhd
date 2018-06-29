LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY FrameRecovery IS
   PORT ( Dout, clock, reset  : IN  STD_LOGIC;
	       Rout                : OUT STD_LOGIC;
			 Lout                : OUT STD_LOGIC);
END FrameRecovery;

ARCHITECTURE Behavior OF FrameRecovery IS

SIGNAL R : STD_LOGIC;
SIGNAL L : STD_LOGIC_VECTOR(9 DOWNTO 0);

COMPONENT ShiftRegister
	PORT ( Dout, clock, reset  : IN  STD_LOGIC;
	       Rout                : OUT STD_LOGIC;
			 Lout                : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
END COMPONENT;

BEGIN 

-- Instantiate ShiftReg
SR1: ShiftRegister
	PORT MAP (Dout, clock, reset, R, L);
	

	PROCESS (clock, reset) 
	BEGIN 
		IF L = "1111111111" THEN
			Lout <= '0';
		ELSE
			Lout <= '1';
		END IF;
		
		IF clock'EVENT AND clock = '1' THEN
			Rout <= R;
		END IF;
	END PROCESS;
	
END Behavior;


