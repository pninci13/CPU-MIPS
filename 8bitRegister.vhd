LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY Reg8 IS
	PORT 
	(
		 WriteReg, Clock: IN STD_LOGIC;
		 InputData: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		 OutputData: OUT STD_LOGIC_VECTOR (7 DOWNTO 0) :=  "00000000"
	 );
END ENTITY;

ARCHITECTURE Behavior OF Reg8 IS
		BEGIN
	   PROCESS (Clock)
				BEGIN
						IF WriteReg = '1' THEN
						   OutputData <= InputData;
						END IF;
			END PROCESS;
END ARCHITECTURE;