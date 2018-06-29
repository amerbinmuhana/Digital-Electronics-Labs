LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY CDR_TestBench IS
	PORT (Clk_tx, Clk_ref, reset   : IN  STD_LOGIC;
	      Din_a, Dout, INC_out, DEC_out, clk_late_out, regB_out, Clk_rec  : OUT STD_LOGIC);
END CDR_TestBench;

ARCHITECTURE Behavior OF CDR_TestBench IS

SIGNAL Din , a    : STD_LOGIC;

COMPONENT CDR 
	PORT (reset, clock, Din  : IN  STD_LOGIC;
        Dout, INC_out, DEC_out, clk_late_out, regB_out, regC_out      : OUT STD_LOGIC);  
END COMPONENT;

COMPONENT LFSR2
	PORT ( reset, clock : IN  STD_LOGIC;
	       Q            : OUT STD_LOGIC;
			 z            : OUT STD_LOGIC);
END COMPONENT;

BEGIN 

-- Instantiate LFSR
LFSR1: LFSR2
	PORT MAP (reset, Clk_tx, Din, a);
	
-- Instantiate CDR
CDR1:  CDR
	PORT MAP (reset, Clk_ref, Din, Dout, INC_out, DEC_out, clk_late_out, regB_out, Clk_rec);
	
Din_a <= Din;
	
END Behavior;
