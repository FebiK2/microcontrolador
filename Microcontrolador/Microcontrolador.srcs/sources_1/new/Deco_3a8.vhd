library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Deco_3a8 is
    Port (W: in std_logic_vector(2 downto 0);
          Y: out unsigned(7 downto 0));
end Deco_3a8;

architecture Behavioral of Deco_3a8 is
begin

Y <= "00000001" when (W = "000") else
     "00000010" when (W = "001") else  
     "00000100" when (W = "010") else  
     "00001000" when (W = "011") else  
     "00010000" when (W = "100") else  
     "00100000" when (W = "101") else  
     "01000000" when (W = "110") else
     "10000000";  

end Behavioral;