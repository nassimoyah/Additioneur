library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SUBS is
    Port ( 
        A, B : in  STD_LOGIC_VECTOR(7 downto 0);
        Cin  : in  STD_LOGIC;  -- Borrow-in for subtraction
        Co   : out STD_LOGIC;  -- Borrow-out
        S    : out STD_LOGIC_VECTOR(7 downto 0)
    );
end SUBS;

architecture Behavioral of SUBS is
begin
    SUBTRACTION_PROCESS: process(A, B, Cin)
        variable borrow : STD_LOGIC_VECTOR(8 downto 0);  -- Variable for borrow bits
        variable result : STD_LOGIC_VECTOR(7 downto 0);  -- Variable for the result
    begin
        borrow := (others => '0');
        borrow(0) := Cin;  -- Initialize borrow-in with Cin

        -- Bitwise subtraction loop
        for i in 0 to 7 loop
            result(i) := A(i) xor B(i) xor borrow(i);  -- Subtraction logic (A - B - borrow)
            
            -- Borrow logic corrected
            borrow(i+1) := ((not A(i)) and (B(i) or borrow(i))) or (B(i) and borrow(i));
        end loop;

        S <= result;    -- Assign the result to output
        Co <= borrow(8);  -- Final borrow-out
    end process;
end Behavioral;
