library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Flag_Register is
end tb_Flag_Register;

architecture sim of tb_Flag_Register is

    -- Componentes
    component Flag_Register
      Port (C, Zero, N, V : in std_logic;
            LFlags, clk, arst : in std_logic;
            Cout, Zero_out, Nout, Vout : out std_logic);
    end component;

    -- Señales para conectar
    signal C, Zero, N, V : std_logic := '0';
    signal LFlags, clk, arst : std_logic := '0';
    signal Cout, Zero_out, Nout, Vout : std_logic;

begin

    -- Instancia
    DUT: Flag_Register
        port map (
            C => C,
            Zero => Zero,
            N => N,
            V => V,
            LFlags => LFlags,
            clk => clk,
            arst => arst,
            Cout => Cout,
            Zero_out => Zero_out,
            Nout => Nout,
            Vout => Vout
        );

    -- Generador de reloj (periodo de 10 ns)
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Estímulos
    stim_proc : process
    begin
        -- Reset
        arst <= '1';
        wait for 20 ns;
        arst <= '0';

        -- Espera un ciclo de reloj
        wait for 10 ns;

        -- Cargar flags
        C <= '1';
        Zero <= '0';
        N <= '1';
        V <= '1';
        LFlags <= '1';
        wait for 10 ns;
        LFlags <= '0';

        -- Esperar un poco
        wait for 20 ns;

        -- Cambiar entradas sin cargar
        C <= '0';
        Zero <= '1';
        N <= '0';
        V <= '0';
        wait for 20 ns;

        -- Cargar nuevos valores
        LFlags <= '1';
        wait for 10 ns;
        LFlags <= '0';

        -- Final
        wait for 20 ns;
        assert false report "Fin de simulación" severity failure;
    end process;

end sim;
