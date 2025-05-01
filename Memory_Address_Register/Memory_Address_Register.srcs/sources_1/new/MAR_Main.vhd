library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAR_Main is
    Port (Din: in std_logic_vector(7 downto 0); -- Dato de entrada
          LMAR, clk, arst: in std_logic; -- Load, Reloj y un reset (Por si acaso)
          Dout: out std_logic_vector(7 downto 0));
end MAR_Main;

architecture Behavioral of MAR_Main is
signal Din_s, Dsaved : std_logic_vector(7 downto 0):= (others => '0');
signal LMAR_s : std_logic:= '0';
begin

Din_s <= Din;
LMAR_s <= LMAR;

process(clk, arst)
begin
    if (arst = '1') then
        Dsaved <= (others => '0');
    elsif (rising_edge(clk)) then
        if (LMAR_s = '1') then
            Dsaved <= Din_s;
        end if;
    end if;
end process;

Dout <= Dsaved;

end Behavioral;
