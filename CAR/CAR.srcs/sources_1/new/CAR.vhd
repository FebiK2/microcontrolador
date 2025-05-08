library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity CAR is
    Port ( clk : in STD_LOGIC;
           L, Arst : in STD_LOGIC;
           d_in : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0));
end CAR;

architecture Behavioral of CAR is
signal cont: Integer := 0;
signal limit : Integer := 199;
signal temp : unsigned(7 downto 0) := "00000000";
begin

process(clk, L, Arst)
begin
    if (Arst = '1') then
        temp <= (others => '0');
        cont <= 0;
    elsif (L = '1') then
        cont <= to_integer(unsigned(d_in));
    elsif (rising_edge(clk)) then
        temp <= to_unsigned(cont, 8);
        if (cont = limit) then
            cont <= 0;
        else
            cont <= cont + 1;
        end if;
    
else
    cont <= cont;
end if;
    
end process;


q <= std_logic_vector(temp);

end Behavioral;
