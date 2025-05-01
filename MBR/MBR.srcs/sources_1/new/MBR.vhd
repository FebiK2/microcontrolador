library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MBR is
    Port ( CLK : in STD_LOGIC;
           Arst : in STD_LOGIC;
           LMBR : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (17 downto 0);
           Dout : out STD_LOGIC_VECTOR (17 downto 0));
end MBR;

architecture Behavioral_1 of MBR is
signal data : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
begin
    process(CLK, Arst, LMBR, Din)
    begin
        if (Arst = '1') then
            data <= (others => '0');
        elsif (rising_edge(CLK)) then
            if (LMBR = '1') then
                data <= Din;
            else
                data <= data;
            end if;
        else
            data <= data;
        end if;
     end process;
     Dout <= data;

end Behavioral_1;