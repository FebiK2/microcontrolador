library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        Sel : in STD_LOGIC;                    -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end MUX2to1_8bits;

architecture Behavioral of MUX2to1_8bits is
begin
with Sel select
    Y <= A when '0',
         B when others;
end Behavioral;