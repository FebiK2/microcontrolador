library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Main_Control_Unit is
    Port (clk, C, Zero: in std_logic;
          reset_maestro : in std_logic;
          salida_MBR: out std_logic_vector(10 downto 0);
          Palabra_Control: out std_logic_vector(26 downto 0));
          
end Main_Control_Unit;

architecture Behavioral of Main_Control_Unit is
-- Definiendo componentes

Component STACK_Main is
    Port(direcciones: in std_logic_vector(7 downto 0);
         clk: in std_logic;
         pop: in std_logic;
         push: in std_logic;
         salida: out std_logic_vector(7 downto 0));
         
end component;

Component MUX4to1_8bits is
    Port (
        A : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 0
        B : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 1
        C : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 2
        D : in STD_LOGIC_VECTOR(7 downto 0);  -- Entrada 3
        Sel : in STD_LOGIC_VECTOR(1 downto 0); -- Selector
        Y : out STD_LOGIC_VECTOR(7 downto 0)   -- Salida
    );
end component;

Component MUX8to1 is
    Port (
        A : in STD_LOGIC;  -- Entrada 0
        B : in STD_LOGIC;  -- Entrada 1
        C : in STD_LOGIC;  -- Entrada 2
        D : in STD_LOGIC;  -- Entrada 3
        E : in STD_LOGIC;  -- Entrada 4
        F : in STD_LOGIC;  -- Entrada 5
        G : in STD_LOGIC;  -- Entrada 6
        H : in STD_LOGIC;  -- Entrada 7
        Sel : in STD_LOGIC_VECTOR(2 downto 0); -- Selector
        Y : out STD_LOGIC   -- Salida
    );
end Component;


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
           Din : in STD_LOGIC_VECTOR (15 downto 0);
           Dout : out STD_LOGIC_VECTOR (15 downto 0));
end component;

Component ID is
    Port (codigo_instr: in std_logic_vector(4 downto 0);
    	 dir_mem_control: out std_logic_vector(7 downto 0));
end Component;


Component Memoria_Control is
    Port (direccion: in std_logic_vector(7 downto 0);
          salida: out std_logic_vector(26 downto 0));
end component;

Component PC is
    Port ( clk : in STD_LOGIC;
           L, Arst : in STD_LOGIC;
           d_in : in STD_LOGIC_VECTOR(7 downto 0);
           q : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component memoria_programa is
    Port (direcciones : in std_logic_vector(7 downto 0);
          salida: out std_logic_vector(15 downto 0));
end component;


-- Señales o cables
signal PC_in, PC_out, MAR_out, STACK_out: std_logic_vector(7 downto 0):= (others => '0');
signal MP_out, MBR_out : std_logic_vector(15 downto 0):= (others => '0');
signal ID_out, CAR_out: std_logic_vector(7 downto 0):= (others => '0');
signal LCAR, LMBR, LMAR, LPC, Pop, Push, MMD, WE : std_logic:= '0';
signal MPC, MCAR, MA, MB : std_logic_vector(1 downto 0):= (others => '0');
signal MCC : std_logic_vector(2 downto 0):= (others => '0');
signal NA, BRA, OO, CAR_in : std_logic_vector(7 downto 0):= (others => '0');
signal MC_out : std_logic_vector(26 downto 0):= (others => '0');

-- Banderas Negadas
signal NZero, NC : std_logic:= '0';

begin

STACK_LIFO: STACK_Main port map(direcciones => PC_out, clk => clk, pop => Pop, push => Push, salida => STACK_out);

MUX_PC: MUX4to1_8bits port map( A=>  MP_out(7 downto 0), B => STACK_out, C => PC_out, D => (others => '0'), Sel => MPC, Y => PC_in);

Program_Counter: PC port map(d_in => PC_in, L => LPC, Arst => reset_maestro, clk => clk, q => PC_out);

MAR_reg: MAR_Main port map(Din => PC_out, LMAR => LMAR, clk => clk, Arst => reset_maestro, Dout => MAR_out);

Memory_Program: memoria_programa port map(direcciones => MAR_out, salida => MP_out);

Memory_Buffer_Register: MBR port map(CLK => clk, Arst => reset_maestro, LMBR => LMBR, Din => MP_out, Dout => MBR_out);

Salida_MBR <= MBR_out(10 downto 0);

-- MBR_out(10 downto 0) son los valores de número de registro, constantes, etc…

Decodificador_Instrucciones: ID port map(codigo_instr => MBR_out(15 downto 11), dir_mem_control => ID_out);

MUX_CAR: MUX4to1_8bits port map(A => NA, B => BRA, C => OO, D => ID_out, Sel => MCAR, Y => CAR_in);

NZero <= NOT(Zero);
NC <= NOT(C);

MUX_LCAR: MUX8to1 port map(A => Zero, B => NZero, C => C, D => NC, E => '0', F => '1', G => '1', H => '1', Sel => MCC, Y => LCAR);

Counter_Address_Register: CAR port map(clk => clk, L => LCAR, Arst => reset_maestro, d_in => CAR_in, q => CAR_out);

Memoria_de_control: Memoria_Control port map(direccion => CAR_out, salida => MC_out);


LPC <= MC_out(4);
Pop <= MC_out(7);
Push <= MC_out(8);
LMAR <= MC_out(3);
LMBR <= MC_out(2);
BRA <= "00010111";
MCAR <= MC_out(1 downto 0);
MCC <= MC_out(11 downto 9);
MPC <= MC_out(6 downto 5);
MA <= MC_out(24 downto 23);
MB <= MC_out(22 downto 21);
WE <= MC_out(25);
MMD <= MC_out(26);

Palabra_Control <= MC_out;


end Behavioral;
