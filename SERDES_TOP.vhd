LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY SERDES_TOP IS
	PORT (KEY      : IN    STD_LOGIC_VECTOR(1 downto 0) ;
			HEX0     : OUT   STD_LOGIC_VECTOR(6 downto 0) ;
			HEX1     : OUT   STD_LOGIC_VECTOR(6 downto 0) ;
			HEX2     : OUT   STD_LOGIC_VECTOR(6 downto 0) ;
			HEX3     : OUT   STD_LOGIC_VECTOR(6 downto 0);
			GPIO_0   : INOUT STD_LOGIC_VECTOR(3 downto 0);
			CLOCK_50 : IN    STD_LOGIC);
END SERDES_TOP;

ARCHITECTURE Behavior OF SERDES_TOP IS

SIGNAL Clk_tx, Clk_ref, reset, reset2, Din_out, Dout_out, clk_rec_out   : STD_LOGIC;
SIGNAL output : STD_LOGIC_VECTOR(15 DOWNTO 0); 

COMPONENT SERDES
	PORT (Clk_tx, Clk_ref, reset, reset2   : IN  STD_LOGIC;
	      Din_out, Dout_out, clk_rec_out   : OUT  STD_LOGIC;
	      output : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
END COMPONENT;

COMPONENT segment
   PORT (Sw   : IN STD_LOGIC_VECTOR(3 downto 0) ;
         HEX0 : OUT STD_LOGIC_VECTOR(6 downto 0) );
END COMPONENT ;	

BEGIN 

reset       <= KEY(0);
reset2      <= KEY(1);
clk_tx      <= GPIO_0(0);
clk_ref     <= CLOCK_50;
 GPIO_0(1)  <= Din_out     ;
GPIO_0(2)    <=   Dout_out  ;
 GPIO_0(3)   <= clk_rec_out ;


--Instantiate SERDES
S1: SERDES
	PORT MAP (clk_tx, clk_ref, reset, reset2, Din_out, Dout_out, clk_rec_out, output);
	
-- Instantiate segment
decoder1: segment
    PORT MAP ( output(3 DOWNTO 0), HEX0) ; 

decoder2: segment
    PORT MAP ( output(7 DOWNTO 4), HEX1) ; 

decoder3: segment
    PORT MAP ( output(11 DOWNTO 8), HEX2) ; 

decoder4: segment
    PORT MAP ( output(15 DOWNTO 12), HEX3) ;
	
END Behavior;	