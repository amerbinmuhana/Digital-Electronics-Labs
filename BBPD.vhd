LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY BBPD IS
   PORT ( Din, CLK_early, CLK_edge, CLK_late  : IN  STD_LOGIC;
	       up, down, reg11, reg22, reg33             : OUT STD_LOGIC);
END BBPD;

ARCHITECTURE Behavior OF BBPD IS

SIGNAL  reg1, reg2, reg3, reg4, reg5, sigA, sigB : STD_LOGIC;	 

BEGIN

  PROCESS (CLK_early, CLK_edge, CLK_late)
  BEGIN
  IF  CLK_early'EVENT AND CLK_early = '1' THEN
      reg1 <= Din;
  END IF;
  IF CLK_edge'EVENT AND CLK_edge = '1' THEN
        reg2 <= Din;
  END IF;  
  IF CLK_late'EVENT AND CLK_late = '1' THEN
        reg3 <= Din;
  END IF;
  IF CLK_late'EVENT AND CLK_late = '0' THEN
     reg4 <= sigA;
	  reg5 <= sigB;
  END IF;
  END PROCESS;
  
sigA <= reg1 XOR reg2;
sigB <= reg2 XOR reg3;

up   <= reg4;
down <= reg5; 

reg11 <= reg1;
reg22 <= reg2;
reg33 <= reg3;
  
END Behavior;