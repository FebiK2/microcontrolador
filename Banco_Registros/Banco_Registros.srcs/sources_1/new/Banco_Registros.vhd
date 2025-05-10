library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Banco_Registros is
    Port (entrada : in std_logic_vector(7 downto 0);
          clk : in std_logic;
          Sel : in std_logic_vector(2 downto 0); -- Selector de Entrada
          Sel_n : in std_logic_vector(2 downto 0);
          Sel_m : in std_logic_vector(2 downto 0);
          L, Arst : in std_logic;
          salida : out std_logic_vector(15 downto 0));

end Banco_Registros;

architecture Behavioral of Banco_Registros is

type mem is array(0 to 7) of std_logic_vector(7 downto 0);
signal contenido : mem := (others => (others => '0'));
signal registro_n, registro_m : std_logic_vector(7 downto 0):= (others => '0');
signal Sel_ns, Sel_ms, Sel_s : std_logic_vector(2 downto 0):= (others => '0');

begin

Sel_s <= Sel; -- Selector de entrada
Sel_ns <= Sel_n;
Sel_ms <= Sel_m;

process(clk, L, Arst) 
begin
    if (Arst = '1') then
       contenido <= (others => (others => '0'));
       registro_n <= (others => '0');
       registro_m <= (others => '0');
    elsif (rising_edge(clk)) then
        registro_n <= contenido(to_integer(unsigned(Sel_ns)));
        registro_m <= contenido(to_integer(unsigned(Sel_ms)));
        if (L = '1') then
            contenido(to_integer(unsigned(Sel_s))) <= entrada;
        end if;
    end if;
end process;

salida(15 downto 8) <= registro_n;
salida(7 downto 0) <= registro_m;

end Behavioral;
