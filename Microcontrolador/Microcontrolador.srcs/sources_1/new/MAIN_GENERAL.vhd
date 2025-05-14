library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MAIN_GENERAL is
    Port(Reset, Up, Decrement, Right, Left, Set, Clear, Nothing : in std_logic;
         clk, reset_maestro : in std_logic;
         Salida_Procesador: out std_logic_vector(7 downto 0));
end MAIN_GENERAL;

architecture Behavioral of MAIN_GENERAL is

-- Componentes Datapath y la Unidad de Control
component Main_DataPath is
    Port (PuertoA, PuertoB, kk: in std_logic_vector(7 downto 0);
          Cin, WE, L, MMD, reset_maestro, clk: in std_logic;
          Addr : in std_logic_vector(5 downto 0); 
          S: in std_logic_vector(4 downto 0);
          BP, MCC, Sel_m, Sel_n, Sel: in std_logic_vector(2 downto 0);
          MA, MB, MD: in std_logic_vector(1 downto 0);
          C, Zero : out std_logic;
          Salida_Registro_n : out std_logic_vector(7 downto 0));
          
end component;

component Main_Control_Unit is
    Port (clk, C, Zero: in std_logic;
          reset_maestro : in std_logic;
          salida_MBR: out std_logic_vector(10 downto 0);
          Palabra_Control: out std_logic_vector(26 downto 0));
end component;

-- Señales
signal PuertoA_s, PuertoB_s, kk : std_logic_vector(7 downto 0):= (others => '0');
signal Salida_Procesador_s : std_logic_vector(7 downto 0):= (others => '0');
signal Cin, WE, L, MMD: std_logic:= '0';
signal C, Zero: std_logic:= '0';
signal S: std_logic_vector(4 downto 0):= (others => '0');
signal BP, MCC, Sel_m, Sel_n, Sel: std_logic_vector(2 downto 0):= (others => '0');
signal MA, MB, MD: std_logic_vector(1 downto 0):= (others => '0');
signal salida_MBR : std_logic_vector(10 downto 0):= (others => '0');
signal Palabra_Control : std_logic_vector(26 downto 0):= (others => '0');
signal Salida_Registro_n : std_logic_vector(7 downto 0):= (others => '0');
begin

PuertoA_s <= Reset & Up & Decrement & Right & Left & Set & Clear & Nothing; 
Salida_Procesador <= 
DataPath: Main_DataPath port map(PuertoA => PuertoA_s, PuertoB => (others => '0'), kk => salida_MBR(10 downto 0), Cin => Palabra_Control(15), WE => Palabra_Control(25),
          MMD => Palabra_Control(26), Addr => salida_MBR(7 downto 0), L => Palabra_Control(12), reset_maestro => reset_maestro, clk => clk,
          S => Palabra_Control(20 downto 16), BP => salida_MBR(7 downto 5), MCC => Palabra_Control(10 downto 9), Sel_n => salida_MBR(10 downto 8), Sel_m => salida_MBR(7 downto 5),
          Sel => salida_MBR(10 downto 8), MA => Palabra_Control(24 downto 23), MB => Palabra_Control(22 downto 21), MD => Palabra_Control(14 downto 13), C => C, Zero => Zero,
          Salida_Registro_n => Salida_Registro_n);


Control_Unit: Main_Control_Unit port map(clk => clk, C => C, Zero => Zero, reset_maestro => reset_maestro, salida_MBR => salida_MBR, Palabra_Control => Palabra_Control);
end Behavioral;
