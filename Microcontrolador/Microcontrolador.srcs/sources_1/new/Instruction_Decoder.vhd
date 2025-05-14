library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ID is
    Port (
    codigo_instr: in std_logic_vector(4 downto 0);
    dir_mem_control: out std_logic_vector(7 downto 0)
     );
end ID;

architecture Behavioral of ID is
begin

with codigo_instr select
    dir_mem_control <= "00000011" when "00000",
                       "00000100" when "00001",
                       "00000101" when "00010",
                       "00000110" when "00011",
                       "00000111" when "00100",
                       "00001000" when "00101",
                       "00001001" when "00110",
                       "00001010" when "00111",
                       "00001011" when "01000",
                       "00001100" when "01001",
                       "00001101" when "01010",
                       "00001110" when "01011",
                       "00001111" when "01100",
                       "00010000" when "01101",
                       "00010001" when "01110",
                       "00010010" when "01111",
                       "00010011" when "10000",
                       "00010100" when "10001",
                       "00010101" when "10010",
                       "00010110" when "10011",
                       "00010111" when "10100",
                       "00011000" when "10101",
                       "00011010" when "10110",
                       "00011100" when "10111",
                       "00011110" when "11000",
                       "00100000" when "11001",
                       "00100010" when "11010",
                       "00100100" when "11011",
                       "00100101" when "11100",
                       "00100110" when others;
end Behavioral;