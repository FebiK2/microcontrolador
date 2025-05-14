library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TB_Main_Microcontrolador is
end TB_Main_Microcontrolador;

architecture behavior of TB_Main_Microcontrolador is

    -- Component under test
    component Main_Microcontrolador
        Port (
            PuertoA : in std_logic_vector(7 downto 0);
            PuertoB : in std_logic_vector(7 downto 0);
            clk : in std_logic;
            reset_maestro : in std_logic
        );
    end component;

    -- Señales del banco de pruebas
    signal PuertoA_tb, PuertoB_tb : std_logic_vector(7 downto 0) := (others => '0');
    signal clk_tb : std_logic := '0';
    signal reset_maestro_tb : std_logic := '0';

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instancia del DUT (Device Under Test)
    UUT: Main_Microcontrolador
        port map (
            PuertoA => PuertoA_tb,
            PuertoB => PuertoB_tb,
            clk => clk_tb,
            reset_maestro => reset_maestro_tb
        );

    -- Proceso para generar reloj
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Proceso principal de prueba
    stim_proc: process
    begin

        -- Simulación básica: cambiar entradas si fuera necesario
        PuertoA_tb <= X"AA";
        PuertoB_tb <= X"55";

        -- Esperar unas instrucciones
        wait for 100 ns;

        -- Final de simulación
        wait;
    end process;

end behavior;
