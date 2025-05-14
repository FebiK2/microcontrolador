library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Control_Unit is
end tb_Control_Unit;

architecture behavior of tb_Control_Unit is

    -- Component under test
    component Main_Control_Unit
        Port (
            clk : in std_logic;
            reset_maestro : in std_logic
        );
    end component;

    -- Señales del banco de pruebas
    signal clk_tb : std_logic := '0';
    signal reset_maestro_tb : std_logic := '0';

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instancia del DUT (Device Under Test)
    UUT: Main_Control_Unit
        port map (
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
        -- Esperar unas instrucciones
        wait for 100 ns;

        -- Final de simulación
        wait;
    end process;

end behavior;
