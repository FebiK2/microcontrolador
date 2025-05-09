library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity PC is
    Port ( clk : in STD_LOGIC;
           L, Arst : in STD_LOGIC;
           d_in : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0));
end PC;

architecture Behavioral of PC is
signal cont: Integer := 0;
signal limit : Integer := 199;
begin

process(clk, L, Arst)
begin
    if (Arst = '1') then
        cont <= 0;
    elsif (rising_edge(clk)) then
        if (L = '1') then
            cont <= to_integer(unsigned(d_in));
        else
            if (cont = limit) then
                cont <= 0;
            else
                cont <= cont + 1;
            end if;
        end if;
else
    cont <= cont;
end if;
    
end process;


q <= std_logic_vector(to_unsigned(cont, 8));

end Behavioral;