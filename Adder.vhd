LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY adder IS
 PORT (
			CIN, A, B: IN STD_LOGIC;
			S, COUT: OUT STD_LOGIC
		);
END ENTITY;

ARCHITECTURE BEHAVIOR OF adder IS
	SIGNAL M0, M1, M2: STD_LOGIC;		
		BEGIN
			M0 <= CIN XOR B;	
			M1 <= M0 AND  A;
			M2 <= B AND CIN;
				
			S <= A XOR M0;
			COUT <= M1 OR M2;
			
END ARCHITECTURE;