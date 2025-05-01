library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_Main is
    Port (A,B : in std_logic_vector(7 downto 0);
          Cin : in std_logic;
          BP : in std_logic_vector(2 downto 0);
          S: in std_logic_vector(4 downto 0);
          Zero : out std_logic;
          C : out std_logic;
          Salida : out std_logic_vector(7 downto 0));
end ALU_Main;

architecture Behavioral of ALU_Main is
signal A_s, B_s : unsigned(8 downto 0):= (others => '0');
signal Cin_s, Zero_s, C_s : std_logic:= '0';
signal S_s: std_logic_vector(4 downto 0):= (others => '0');
signal BP_s: std_logic_vector(2 downto 0):= (others => '0');
signal Deco_out : unsigned(7 downto 0):= (others => '0');
signal Salida_ALU : unsigned(8 downto 0):= (others => '0');

component Deco_3a8 is
    Port (W: in std_logic_vector(2 downto 0);
          Y: out unsigned(7 downto 0));
end component;

begin
-- Asignación de señales
A_s <= '0' & unsigned(A);
B_s <= '0' & unsigned(B);
Cin_s <= Cin;
S_s <= S;
BP_s <= BP;
Decodificador_3a8: Deco_3a8 port map(W => BP_s, Y => Deco_out);
-- Operaciones de la ALU
with S_s select
    Salida_ALU <= A_s + B_s when "00000",
                  A_s - B_s when "00001",
                  A_s + 1 when "00010",
                  A_s - 1 when "00011",
                  A_s AND B_s when "00100",
                  A_s OR B_s when "00101",
                  A_s XOR B_s when "00110",
                  A_s XOR B_s when "00111",
                  A_s  when "01000",
                  B_s  when "01001",
                  A_s OR ('0' & Deco_out) when "01010",
                  A_s AND NOT('0' & Deco_out) when "01011",
                  (others => '0') when others; -- Para modificarlo en caso de más operaciones
-- Modificación de banderas
C_s <= Salida_ALU(8);
Zero_s <= '0' when (Salida_ALU(7 downto 0) = "00000000") else
          '1';
     
-- Salidas
Zero <= Zero_s;
C <= C_s;
Salida <= std_logic_vector(Salida_ALU(7 downto 0));
end Behavioral;
