LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;

ENTITY ControlUnit IS
PORT (
			PCWriteCond, PCInc, MemRead, IRWrite: OUT STD_LOGIC;
			WriteEND, ALUop, PCSource, RegWrite, WriteAB, WriteALUout, PCWriteJUMP: OUT STD_LOGIC;
			Clock: IN STD_LOGIC;
			Opcode: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			Zero: IN STD_LOGIC
		  );
END ENTITY ;

ARCHITECTURE Behavior OF ControlUnit IS
	SIGNAL CurrentState: STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	BEGIN
		 PROCESS (Clock)
			BEGIN

				IF (RISING_EDGE(Clock)) THEN
						
					IF (CurrentState = "00") THEN   
						PCWriteCond <= '0';
						PCWriteJUMP <= '0';
						MemRead <= '1';
						PCInc <= '1';
						IRWrite <= '1';
						RegWrite <= '0';
						CurrentState <= "01";

					ELSIF (CurrentState = "01") THEN
						PCWriteCond <= '0';
						PCWriteJUMP <= '0';
						WriteEND <= '1';
						PCInc <= '0';
						MemRead <= '1';
						IRWrite <= '0';
						RegWrite <= '0';
						WriteAB <= '1';
						CurrentState <= "10";

					ELSIF (CurrentState = "10") THEN
					
						IF ( Opcode(1) = '0' ) THEN
							PCWriteCond <= '0';
							PCWriteJUMP <= '0';
							WriteEND <= '0';
							PCInc <= '0';
							MemRead <= '0';
							IRWrite <= '0';
							ALUop <= Opcode(0);
							RegWrite <= '0';
							WriteAB <= '0';
							WriteALUout <= '1';
							CurrentState <=  "11";
							
						ELSIF ( Opcode = "10" ) THEN
							PCWriteCond <= '1';
							PCWriteJUMP <= '0';
							WriteEND <= '0';
							IF Zero = '1' THEN
								PCInc <= '0';
							ELSE 
								PCInc <= '1';
							END IF;
							MemRead <= '0';
							IRWrite <= '0';
							ALUop <= '1';
							PCSource <= '1';
							RegWrite <= '0';
							WriteAB <= '0';
							CurrentState <= "00";	

						ELSIF ( Opcode = "11" ) THEN
							PCWriteCond <= '0';
							PCWriteJUMP <= '1';
							PCSource <= '0';
							WriteEND <= '0';
							PCInc <= '0';
							MemRead <= '0';
							IRWrite <= '0';
							RegWrite <= '0';		
							CurrentState <= "00"; 
						END IF;

					ELSIF (CurrentState = "11") THEN
						PCWriteCond <= '0';
						PCWriteJUMP <= '0';
						PCInc <= '0';
						MemRead <= '0';
						IRWrite <= '0';
						PCSource <= '0';
						RegWrite <= '1';
						CurrentState <= "00";
					END IF;	
					
				END IF;
			END PROCESS;
END ARCHITECTURE;