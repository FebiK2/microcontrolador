library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Memoria_Control is
end tb_Memoria_Control;

architecture sim of tb_Memoria_Control is

    -- Señales para conectar al DUT (Device Under Test)
    signal direccion_tb : std_logic_vector(7 downto 0);
    signal salida_tb    : std_logic_vector(34 downto 0);

    -- Componente bajo prueba
    component Memoria_Control is
        Port (
            direccion : in std_logic_vector(7 downto 0);
            salida    : out std_logic_vector(34 downto 0)
        );
    end component;

begin

    -- Instancia del DUT
    uut: Memoria_Control
        port map (
            direccion => direccion_tb,
            salida    => salida_tb
        );

    -- Proceso de estimulación
    stim_proc: process
    begin
        for i in 0 to 38 loop
            direccion_tb <= std_logic_vector(to_unsigned(i, 8));
            wait for 10 ns;
            -- Aquí podrías agregar una sentencia assert si quieres comparar contra valores esperados
        end loop;

        wait; -- Detener la simulación
    end process;

end sim;
