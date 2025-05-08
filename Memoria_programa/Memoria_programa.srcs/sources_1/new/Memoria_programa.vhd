library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity memoria_programa is
    Port (direcciones : in std_logic_vector(7 downto 0);
          salida: out std_logic_vector(14 downto 0));
end memoria_programa;

architecture Behavioral of memoria_programa is

type mem is array (0 to 199) of std_logic_vector(7 downto 0);

constant rom: mem :=(0 => "1000001000001000",
                     1 => "0000101000000001",
                     2 => "1010000000000001",
                     others => (others => '0'));

begin

salida <= rom(to_integer(unsigned(direcciones)));

end Behavioral;
