LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY InstructionRegister IS
PORT (	
			Clock, IRWrite: IN STD_LOGIC;
			IRInput: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		   Opcode: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Instruction54: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Instruction32: OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Instruction10: OUT STD_LOGIC_VECTOR (1 DOWNTO 0)
		);	
END ENTITY;

ARCHITECTURE Behavior OF InstructionRegister IS
	SIGNAL Data : STD_LOGIC_VECTOR (7 DOWNTO 0);
	
		BEGIN
		
		Opcode(0) <= Data(6);
		Opcode(1) <= Data(7);
		Instruction54(0) <= Data(4);
		Instruction54(1) <= Data(5);			
		Instruction32(0) <= Data(2);
		Instruction32(1) <= Data(3);				
		Instruction10(0) <= Data(0);
		Instruction10(1) <= Data(1);
		
		PROCESS ( Clock )
				BEGIN
					IF RISING_EDGE(Clock) THEN
						
					IF (IRWrite = '1') THEN
						Data <= IRInput;  
					END IF;
				END IF;
		END PROCESS;
END ARCHITECTURE;