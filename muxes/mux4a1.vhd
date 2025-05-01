library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        C : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 2
        D : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 3
        Sel : in STD_LOGIC_VECTOR(1 downto 0); -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end MUX4to1_8bits;

architecture Behavioral of MUX4to1_8bits is
begin
    process(A, B, C, D, Sel)
    begin
        case Sel is
            when "00" => Y <= A;
            when "01" => Y <= B;
            when "10" => Y <= C;
            when "11" => Y <= D;
            when others => Y <= (others => '0'); -- Valor por defecto
        end case;
    end process;
end Behavioral;