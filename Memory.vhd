LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY InstructionMemory is
PORT (
			 addr: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			 MemRead, Clock: IN STD_LOGIC; 
			 ReadData: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END InstructionMemory;

ARCHITECTURE behavior OF InstructionMemory IS
	TYPE memory IS ARRAY (0 TO 2**3 - 1) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
		CONSTANT cpu_memory : memory := (
				0 => "00011001",        -- ADD 01,01,10							00000000
            1 => "01111011",        -- SUB 11,11,10 							00000001
            2 => "10010000",        -- BEQ 01,00 (Endereço 00000000)		00000010
            3 => "00000000",			-- 											00000011
				4 => "11000000",			-- JMP 00000000							00000100	
				5 => "00000000",       	-- 											00000101
            6 => "00000000",     	--											   00000110
            7 => "00000000");      	--											   00000111
				BEGIN
					PROCESS (addr, Clock)
						BEGIN
							IF MemRead = '1' THEN
								ReadData <= cpu_memory(TO_INTEGER(UNSIGNED(addr)));
							END IF;
				END PROCESS;
END ARCHITECTURE;
