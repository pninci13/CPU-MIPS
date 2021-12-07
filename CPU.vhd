LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_signed.all;

ENTITY CPU IS
    PORT(
        Clock: IN STD_LOGIC;
		  
		  -- Multiplexer 
		  PCAddr : BUFFER STD_LOGIC_VECTOR (7 DOWNTO 0); 
		  
		  -- 8 bit register 
		  WriteReg: BUFFER STD_LOGIC;
		  
		  -- Register File 
		  ReadReg1: BUFFER STD_LOGIC_VECTOR (1 DOWNTO 0);
		  ReadReg2: BUFFER STD_LOGIC_VECTOR (1 DOWNTO 0); 
		  WriteRegAddr: BUFFER STD_LOGIC_VECTOR (1 DOWNTO 0);
		  OutputReg1: BUFFER STD_LOGIC_VECTOR (7 DOWNTO 0); 
		  OutputReg2: BUFFER STD_LOGIC_VECTOR (7 DOWNTO 0); 
		  
		  -- PC
		  PCOutput: BUFFER STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
		  
		  -- InstructionRegister
		  Opcode: BUFFER STD_LOGIC_VECTOR (1 DOWNTO 0);
		  
		  -- ALU 
        ALU_OUT: BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        Zero: BUFFER STD_LOGIC;
		  
		  -- Memory			
		  ReadData: BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        
		  -- Unit Control
		  PCWriteCond: BUFFER STD_LOGIC;
		  PCInc, MemRead, IRWrite: BUFFER STD_LOGIC;
		  WriteEND, ALUop, PCSource, RegWrite, WriteAB, WriteALUout, PCWriteJUMP: BUFFER STD_LOGIC
    );    	
    
END ENTITY;


ARCHITECTURE Behavior OF CPU IS

    SIGNAL JUMPAddress: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL PCWrite: STD_LOGIC := '0';
	 SIGNAL OutputA, OutputB, OutputALUout, OutputEND: STD_LOGIC_VECTOR(7 DOWNTO 0);
    
BEGIN
	
	 PCWrite <= (PCWriteCond AND Zero) OR PCWriteJUMP;
	
	 JUMPAddress(7 DOWNTO 6) <= PCOutput(7 DOWNTO 6);
	 JUMPAddress(5 DOWNTO 4) <= ReadReg1;
	 JUMPAddress(3 DOWNTO 2) <= ReadReg2;
	 JUMPAddress(1 DOWNTO 0) <= WriteRegAddr;
	 
	
	 Mux1 : ENTITY WORK.Mux2x1 PORT MAP(PCSource, OutputEND, JUMPAddress, PCAddr); 
	 
	 ARegister : ENTITY WORK.Reg8 PORT MAP(WriteAB, Clock, OutputReg1, OutputA);
	 
	 BRegister : ENTITY WORK.Reg8 PORT MAP(WriteAB, Clock, OutputReg2, OutputB);
	 
	 ENDRegister : ENTITY WORK.Reg8 PORT MAP(WriteEND, Clock, ReadData, OutputEND);
	 
	 ALUoutRegister : ENTITY WORK.Reg8 PORT MAP(WriteALUout, Clock, ALU_OUT, OutputALUout);
	 
	 RegFile : ENTITY WORK.RegisterFile PORT MAP(RegWrite, Clock, ReadReg1, ReadReg2, WriteRegAddr, OutputALUout, OutputReg1, OutputReg2);

	 CPU_PC : ENTITY WORK.PC PORT MAP(Clock, PCWrite, PCInc, PCAddr, PCOutput);
	 
	 IR : ENTITY WORK.InstructionRegister PORT MAP(Clock, IRWrite, ReadData, Opcode, ReadReg1, ReadReg2, WriteRegAddr);
	 
	 ALU : ENTITY WORK.ALU PORT MAP(OutputA, OutputB, ALUop, ALU_OUT, Zero); 
	 
	 IM : ENTITY WORK.InstructionMemory PORT MAP(PCOutput, MemRead, Clock, ReadData);
	 
	 CPU_UC : ENTITY WORK.ControlUnit PORT MAP(PCWriteCond, PCInc, MemRead, IRWrite, WriteEND, ALUop, PCsource, RegWrite, WriteAB, WriteALUout, PCWriteJUMP, Clock, Opcode, Zero);
	 
END Behavior;