library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Scratch_Pad is
    Port(Addr : in std_logic_vector(5 downto 0);
         WE, clk, Arst: in std_logic;
         Din: in std_logic_vector(7 downto 0);
         Dout: out std_logic_vector(7 downto 0));
end Scratch_Pad;

architecture Behavioral of Scratch_Pad is

type mem is array(0 to 59) of std_logic_vector(7 downto 0);
signal contenido : mem:=(others => (others => '0'));
signal Addr_s : std_logic_vector(5 downto 0):= (others => '0');
signal Din_s : std_logic_vector(7 downto 0):= (others => '0');

begin

Addr_s <= Addr;
Din_s <= Din;

process(clk, Arst, WE)
begin

    if (Arst = '1') then
        contenido <= (others => (others => '0'));
     elsif (rising_edge(clk)) then
        if (WE = '1') then
            contenido(to_integer(unsigned(Addr_s))) <= Din_s;
        end if;
     end if;
     
end process;

Dout <= contenido(to_integer(unsigned(Addr_s)));


end Behavioral;