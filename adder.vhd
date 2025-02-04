library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( 
        A  : in  STD_LOGIC_VECTOR (7 downto 0);
        B  : in  STD_LOGIC_VECTOR (7 downto 0);
        S  : out STD_LOGIC_VECTOR (7 downto 0);
        Co : out STD_LOGIC 
    );       
end ALU;

architecture Behavioral of ALU is
begin
    -- Process pour l'addition
    ADDITION_PROCESS: process(A, B)
        variable carry : STD_LOGIC_VECTOR(8 downto 0);  -- Variable pour le carry
    begin
        carry := (others => '0');  -- Initialisation à zéro
        
        -- Boucle pour l'addition bit par bit
        for i in 0 to 7 loop
            S(i) <= A(i) xor B(i) xor carry(i);
            carry(i+1) := (A(i) and B(i)) or (A(i) and carry(i)) or (B(i) and carry(i));
        end loop;

        Co <= carry(8);  -- Affectation du carry-out
    end process;
end Behavioral;
