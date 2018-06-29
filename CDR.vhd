LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY CDR IS
  PORT (reset, clock, Din  : IN  STD_LOGIC;
        Dout, INC_out, DEC_out, clk_late_out, regB_out, regC_out      : OUT STD_LOGIC);  
END CDR;

ARCHITECTURE Behavior OF CDR IS

SIGNAL regA, regB, regC, regD, INC, DEC, up, down, reg1, reg2, reg3   : STD_LOGIC;
SIGNAL clk_pr, clk_div, clk_div_in, CLK_early, CLK_edge, CLK_late, Clk_rec  : STD_LOGIC;
SIGNAL PG      : STD_LOGIC_VECTOR(7 DOWNTO 0);

COMPONENT BBPD 
   PORT ( Din, CLK_early, CLK_edge, CLK_late  : IN  STD_LOGIC;
	       up, down, reg11, reg22, reg33       : OUT STD_LOGIC);
END COMPONENT;

COMPONENT PhaseGenerator
  PORT ( reset, clock : IN  STD_LOGIC;
	      P            : OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT ;

COMPONENT ClockDivider
   PORT ( clock, reset           : IN  STD_LOGIC;
	       clock_out, clock_out2  : OUT STD_LOGIC);
END COMPONENT;

COMPONENT PhaseRotator2
   PORT ( reset, clock, INC, DEC                  : IN  STD_LOGIC;
	       PG                                      : IN  STD_LOGIC_VECTOR(7 downto 0);
	       CLK_early, CLK_edge, CLK_late, clk_div  : OUT STD_LOGIC);
END COMPONENT;

COMPONENT DigitalFilter 
   PORT (In_P, In_N, clock, reset    : IN  STD_LOGIC;
        Out_P, Out_N                : OUT STD_LOGIC);	
END COMPONENT;

COMPONENt flipflop
	PORT (clock, reset, input   : IN  STD_LOGIC;
	       output                : OUT STD_LOGIC);
END COMPONENT;

BEGIN 

 --Instantiate PhaseGenerator
PG1 : PhaseGenerator
  PORT MAP (reset, clock, PG);
  
-- Instantiate clock divider
CD1 : ClockDivider
  PORT MAP (clk_div_in, reset, clk_pr, clk_div);
  
-- Instantiate flipflop1
F1  : flipflop
  PORT MAP ( clock, reset, clk_pr, regA);
  
--  PROCESS (clock, reset)
 -- BEGIN 
--  IF reset = '0' THEN 
  --   regA <= '0';
  --ELSIF clock'EVENT AND clock = '1' THEN
   --  regA <= clk_pr; 
  --END IF;
  --END PROCESS;
  
--Instantiate PhaseRotator
PR1 : PhaseRotator2
  PORT MAP  (reset, regA, INC, DEC, PG, CLK_early, CLK_edge, CLK_late);
  
-- Instantiate BBPD
bbpd1 : BBPD
  PORT MAP (Din, CLK_early, CLK_edge, CLK_late, up, down, reg1, reg2, reg3);

-- Instantiate flipflop2
F2  : flipflop
  PORT MAP ( clock, reset, CLK_late, regB);
  
--  PROCESS (clock, reset)
--  BEGIN 
--  IF reset = '0' THEN 
--     regB <= '0';
--  ELSIF clock'EVENT AND clock = '1' THEN
--     regB <= CLK_late; 
--  END IF;
--  END PROCESS;
  
clk_div_in <= NOT regB;

--Instantiate DigitalFilter
DG1 : DigitalFilter
  PORT MAP  (up, down, regB, reset, DEC, INC);
  
-- Instantiate flipflop3
F3  : flipflop
  PORT MAP ( clock, reset, regB, regC);  
  
--  PROCESS (clock, reset)
--  BEGIN 
--  IF reset = '0' THEN 
--     regC <= '0';
--  ELSIF clock'EVENT AND clock = '1' THEN
--     regC <= regB; 
--  END IF;
--  END PROCESS;
  
Clk_rec <= regC;

-- Instantiate flipflop4
F4  : flipflop
  PORT MAP ( Clk_rec, reset, Din, regD);
  
--  PROCESS (Clk_rec, reset)
--  BEGIN 
--  IF reset = '0' THEN 
--     regD <= '0';
--  ELSIF Clk_rec'EVENT AND Clk_rec = '1' THEN
--     regD <= Din; 
--  END IF;
--  END PROCESS;
  
Dout <= regD;

INC_out <= INC; 
DEC_out <= DEC;

clk_late_out <= CLK_late;
regB_out <= regB;
regC_out <= regC;


END Behavior;


