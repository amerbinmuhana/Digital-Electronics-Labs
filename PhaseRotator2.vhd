LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY PhaseRotator2 IS
   PORT ( reset, clock, INC, DEC                  : IN  STD_LOGIC;
	       PG                                      : IN  STD_LOGIC_VECTOR(7 downto 0);
	       CLK_early, CLK_edge, CLK_late, clk_div  : OUT STD_LOGIC);
END PhaseRotator2;

ARCHITECTURE Behavior OF PhaseRotator2 IS

SIGNAL counter : STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN

-- counter INC/DEC
   PROCESS (reset, clock)
	BEGIN
	IF reset = '0' THEN 
	   counter <= "000";
	ELSIF clock'EVENT AND clock = '1' THEN
	   IF INC = '1' THEN 
		   counter <= counter + '1'; 
		ELSIF DEC = '1' THEN
		   counter <= counter - '1';
		END IF;
	END IF;
	END PROCESS;
	

	-- Mux
   Process (counter)
   BEGIN
   CASE (counter) is
   when "000" => CLK_early <= PG(0); CLK_edge <= PG(2); CLK_late <= PG(4); 
   when "001" => CLK_early <= PG(1); CLK_edge <= PG(3); CLK_late <= PG(5); 
	when "010" => CLK_early <= PG(2); CLK_edge <= PG(4); CLK_late <= PG(6); 
	when "011" => CLK_early <= PG(3); CLK_edge <= PG(5); CLK_late <= PG(7); 
	when "100" => CLK_early <= PG(4); CLK_edge <= PG(6); CLK_late <= PG(0); 
	when "101" => CLK_early <= PG(5); CLK_edge <= PG(7); CLK_late <= PG(1); 
	when "110" => CLK_early <= PG(6); CLK_edge <= PG(0); CLK_late <= PG(2); 
	when "111" => CLK_early <= PG(7); CLK_edge <= PG(1); CLK_late <= PG(3); 
	end CASE;
   end PROCESS;
	
END Behavior;