library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_DataPath is
    Port (PuertoA, PuertoB, kk: in std_logic_vector(7 downto 0);
          Cin, WE, L, MMD, reset_maestro, clk: in std_logic;
          Addr : in std_logic_vector(5 downto 0); 
          S: in std_logic_vector(4 downto 0);
          BP, MCC, Sel_m, Sel_n, Sel: in std_logic_vector(2 downto 0);
          MA, MB, MD: in std_logic_vector(1 downto 0);
          C, Zero : out std_logic;
          Salida_Registro_n : out std_logic_vector(7 downto 0));
          
end Main_DataPath;

architecture Behavioral of Main_DataPath is

-- Componentes
component ALU_Main is
    Port (A,B : in std_logic_vector(7 downto 0);
          Cin : in std_logic;
          BP : in std_logic_vector(2 downto 0);
          S: in std_logic_vector(4 downto 0);
          Zero : out std_logic;
          C : out std_logic;
          Salida : out std_logic_vector(7 downto 0));
end component;

component Banco_Registros is
    Port (entrada : in std_logic_vector(7 downto 0);
          clk : in std_logic;
          Sel : in std_logic_vector(2 downto 0); -- Selector de Entrada
          Sel_n : in std_logic_vector(2 downto 0);
          Sel_m : in std_logic_vector(2 downto 0);
          L, Arst : in std_logic;
          salida : out std_logic_vector(15 downto 0));

end component;

component MUX2to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        Sel : in STD_LOGIC;                    -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end component;

component MUX4to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        C : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 2
        D : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 3
        Sel : in STD_LOGIC_VECTOR(1 downto 0); -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end component;

component Flag_Register is
    Port ( C, Zero: in std_logic; -- Carry
          LFlags, clk, arst : in std_logic; -- Load General, reloj y reset asincronico (Por si acaso)
          Cout, Zero_out: out std_logic
          );
end component;

component Scratch_Pad is
    Port(Addr : in std_logic_vector(5 downto 0);
         WE, clk, Arst: in std_logic;
         Din: in std_logic_vector(7 downto 0);
         Dout: out std_logic_vector(7 downto 0));
end component;

-- señales
signal MUX_A_out, MUX_B_out, ALU_out, Banco_Registros_in, Scratch_Pad_in, Scratch_Pad_out : std_logic_vector(7 downto 0):= (others => '0');
signal Banco_Registros_out : std_logic_vector(15 downto 0):= (others => '0');
signal C_ALU, Zero_ALU, Cout, Zero_out : std_logic:= '0';


begin

Multiplexor_A: MUX4to1_8bits port map(A => Banco_Registros_out(15 downto 8), B => Banco_Registros_out(7 downto 0), C => (others => '0'), D=> (others => '0'), Sel => MA, Y => MUX_A_out);
Multiplexor_B: MUX4to1_8bits port map(A => Banco_Registros_out(7 downto 0), B => Banco_Registros_out(15 downto 8), C => kk, D=> (others => '0'), Sel => MB, Y => MUX_B_out);

Unidad_Logico_Aritmetica: ALU_Main port map(A => MUX_A_out, B => MUX_B_out, Cin => Cin, BP => BP, S => S, Zero => Zero_ALU, C => C_ALU, Salida => ALU_out);
Flags: Flag_Register port map(C => C_ALU, Zero => Zero_ALU, LFlags => '1', clk => clk, arst => reset_maestro, Cout => Cout, Zero_out => Zero_out);

C <= Cout;
Zero <= Zero_out;

Multiplexor_Banco_Registros: MUX4to1_8bits port map(A => (others => '0'), B => PuertoA, C => PuertoB, D => ALU_out, Sel => MD, Y => Banco_Registros_in);

Memoria_Banco_Registros: Banco_Registros port map(entrada => Banco_Registros_in, clk => clk, Sel => Sel, Sel_n => Sel_n, Sel_m => Sel_m, L => L, Arst => reset_maestro, salida => Banco_Registros_out);

-- Falta Scratch Pad y su MUX, conectar la salida del banco de registros al MUX_A y MUX_B

Multiplexor_Scratch_Pad: MUX2to1_8bits port map(A => ALU_out, B => Banco_Registros_out(15 downto 8), Sel => MMD, Y => Scratch_Pad_in);

Memoria_Datos_Scratch_Pad:  Scratch_Pad port map(Din => Scratch_Pad_in, clk => clk, Arst => reset_maestro, Addr => Addr, WE => WE, Dout => Scratch_Pad_out);

Salida_Registro_n <= Banco_Registros_out(15 downto 8);
end Behavioral; 