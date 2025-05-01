library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        C : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 2
        D : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 3
        E : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 4
        F : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 5
        G : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 6
        H : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 7
        Sel : in STD_LOGIC_VECTOR(2 downto 0); -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end MUX8to1_8bits;

architecture Behavioral of MUX8to1_8bits is
begin
    process(A, B, C, D, E, F, G, H, Sel)
    begin
        case Sel is
            when "000" => Y <= A;
            when "001" => Y <= B;
            when "010" => Y <= C;
            when "011" => Y <= D;
            when "100" => Y <= E;
            when "101" => Y <= F;
            when "110" => Y <= G;
            when "111" => Y <= H;
            when others => Y <= (others => '0'); -- Valor por defecto
        end case;
    end process;
end Behavioral;