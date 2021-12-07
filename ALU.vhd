LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY ALU IS
    PORT (
        A, B: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        ALU_OP: IN STD_LOGIC;
        ALU_OUT: BUFFER STD_LOGIC_VECTOR(7 DOWNTO 0);
        ZERO: OUT STD_LOGIC
    ); 
END ENTITY;

ARCHITECTURE ALU_ARCH OF ALU IS
BEGIN
    ALU_OUT <= A + B WHEN ALU_OP = '0' ELSE A - B;

    ZERO <= '1' WHEN ALU_OUT = 0 ELSE '0'; 

END ALU_ARCH;