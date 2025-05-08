
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_Microcontrolador is
    Port (PuertoA, PuertoB: in std_logic_vector(7 downto 0); -- Creo que es temporal
          clk: in std_logic;
          reset_maistro : in std_logic);
end Main_Microcontrolador;

architecture Behavioral of Main_Microcontrolador is
-- Definiendo componentes
Component CAR is
    Port ( clk : in STD_LOGIC;
           L, Arst : in STD_LOGIC;
           d_in : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0));
end component;

Component MAR_Main is
    Port (Din: in std_logic_vector(7 downto 0); -- Dato de entrada
          LMAR, clk, Arst: in std_logic; -- Load, Reloj y un reset (Por si acaso)
          Dout: out std_logic_vector(7 downto 0));
end component;

Component MBR is
    Port ( CLK : in STD_LOGIC;
           Arst : in STD_LOGIC;
           LMBR : in STD_LOGIC;
           Din : in STD_LOGIC_VECTOR (17 downto 0);
           Dout : out STD_LOGIC_VECTOR (17 downto 0));
end component;

Component Memoria_Control is
    Port (direccion: in std_logic_vector(7 downto 0);
          salida: out std_logic_vector(34 downto 0));
end component;

Component PC is
    Port ( clk : in STD_LOGIC;
           L, Arst : in STD_LOGIC;
           d_in : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0));
end component;

-- Señales o cables
signal PC_out


begin


end Behavioral;
