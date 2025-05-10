library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Banco_Registros is
end TB_Banco_Registros;

architecture behavior of TB_Banco_Registros is

    -- Component declaration
    component Banco_Registros
        Port (entrada : in std_logic_vector(7 downto 0);
              clk : in std_logic;
              Sel : in std_logic_vector(2 downto 0);
              Sel_n : in std_logic_vector(2 downto 0);
              Sel_m : in std_logic_vector(2 downto 0);
              L, Arst : in std_logic;
              salida : out std_logic_vector(15 downto 0));
    end component;

    -- Signals
    signal entrada    : std_logic_vector(7 downto 0);
    signal clk        : std_logic := '0';
    signal Sel        : std_logic_vector(2 downto 0);
    signal Sel_n      : std_logic_vector(2 downto 0);
    signal Sel_m      : std_logic_vector(2 downto 0);
    signal L          : std_logic;
    signal Arst       : std_logic;
    signal salida     : std_logic_vector(15 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Banco_Registros Port Map (
        entrada => entrada,
        clk => clk,
        Sel => Sel,
        Sel_n => Sel_n,
        Sel_m => Sel_m,
        L => L,
        Arst => Arst,
        salida => salida
    );

    -- Clock generation
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        Arst <= '1';
        L <= '0';
        entrada <= (others => '0');
        Sel <= "000";
        Sel_n <= "000";
        Sel_m <= "000";
        wait for 20 ns;

        Arst <= '0';
        wait for 10 ns;

        -- Escribir valor 0xAA en registro 2
        entrada <= x"AA";
        Sel <= "010"; -- Dirección 2
        L <= '1';
        wait for 10 ns;

        L <= '0';
        entrada <= x"BB";
        wait for 10 ns;

        -- Escribir valor 0xBB en registro 3
        Sel <= "011";
        L <= '1';
        wait for 10 ns;

        L <= '0';
        wait for 10 ns;

        -- Leer registros 2 y 3
        Sel_n <= "010"; -- Reg 2
        Sel_m <= "011"; -- Reg 3
        wait for 20 ns;

        wait;
    end process;

end behavior;
