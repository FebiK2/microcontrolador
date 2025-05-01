library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity PC_tb is
-- Sin puertos en el testbench
end PC_tb;

architecture Behavioral of PC_tb is

    -- Señales para conectar a la UUT (unidad bajo prueba)
    signal clk_tb : STD_LOGIC := '0';
    signal L_tb   : STD_LOGIC := '0';
    signal d_in_tb : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal q_tb   : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period
    constant clk_period : time := 10 ns;

begin

    -- Instanciación de la UUT
    uut: entity work.PC
        port map (
            clk => clk_tb,
            L   => L_tb,
            d_in => d_in_tb,
            q => q_tb
        );

    -- Generador de reloj
    clk_process : process
    begin
        while now < 1000 ns loop
            clk_tb <= '0';
            wait for clk_period / 2;
            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Cargar el valor 10
        wait for 20 ns;
        d_in_tb <= std_logic_vector(to_unsigned(180, 8));
        L_tb <= '1';
        wait for 10 ns;
        L_tb <= '0';

        -- Dejar que el contador cuente
        wait for 500 ns;

        -- Final de la simulación
        wait;
    end process;

end Behavioral;
