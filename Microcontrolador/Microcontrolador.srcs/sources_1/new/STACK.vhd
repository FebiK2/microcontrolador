library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity STACK_Main is
    Port(direcciones: in std_logic_vector(7 downto 0);
         clk: in std_logic;
         pop: in std_logic;
         push: in std_logic;
         salida: out std_logic_vector(7 downto 0));
end STACK_Main;

architecture Behavioral of STACK_Main is
type mem is array (0 to 9) of std_logic_vector(7 downto 0);
signal stack_s : mem:= (others => (others => '0'));
signal position : integer:= 0;
signal salida_s : std_logic_vector(7 downto 0):= (others => '0');

begin

process(clk, pop, push)
begin
    if (rising_edge(clk)) then
        if (push = '1') then
            stack_s(position) <= direcciones;
            position <= position + 1;
        elsif (pop = '1') then
            position <= position - 1;
            salida_s <= stack_s(position-1);
            stack_s(position-1) <= (others => '0');
        end if;
    end if;
end process;
salida <= salida_s;

end Behavioral;