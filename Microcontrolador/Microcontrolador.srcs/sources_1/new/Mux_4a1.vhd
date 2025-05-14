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
with Sel select
    Y <= A when "00",
         B when "01",
         C when "10",
         D when others;
end Behavioral;