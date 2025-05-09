library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8to1 is
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
end MUX8to1;

architecture Behavioral of MUX8to1 is
begin
with Sel select
    Y <= A when "000",
         B when "001",
         C when "010",
         D when "011",
         E when "100",
         F when "101",
         G when "110",
         H when others;
end Behavioral;
