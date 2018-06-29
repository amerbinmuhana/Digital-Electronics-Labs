LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY BBPDTopLevel2 IS
   PORT ( Din, reset, clock, INC, DEC  : IN  STD_LOGIC;
	       pg_out                       : OUT STD_LOGIC_VECTOR(7 downto 0);
	       clk_early1, clk_edge1, clk_late1, up, down, reg1, reg2, reg3, clk_div    : OUT STD_LOGIC);
END BBPDTopLevel2;


ARCHITECTURE Behavior OF BBPDTopLevel2 IS

SIGNAL  clk_pr, CLK_early, CLK_edge, CLK_late  : STD_LOGIC;
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

BEGIN 

-- Instantiate clock divider
CD1 : ClockDivider
  PORT MAP (clock, reset, clk_pr, clk_div);
  
 --Instantiate PhaseGenerator
PG1 : PhaseGenerator
  PORT MAP ( reset, clock, PG);
  
pg_out <= PG;

--Instantiate PhaseRotator
PR1 : PhaseRotator2
  PORT MAP  (reset, clk_pr, INC, DEC, PG, CLK_early, CLK_edge, CLK_late);
	
-- Instantiate BBPD
bbpd1 : BBPD
   PORT MAP (Din, CLK_early, CLK_edge, CLK_late, up, down, reg1, reg2, reg3);
	
clk_early1 <= CLK_early;
clk_edge1 <= CLK_edge;
clk_late1 <= CLK_late;

END Behavior;
