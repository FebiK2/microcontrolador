library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ALU_Main is
end tb_ALU_Main;

architecture sim of tb_ALU_Main is

    component ALU_Main
        Port (
            A, B : in std_logic_vector(7 downto 0);
            Cin : in std_logic;
            BP : in std_logic_vector(2 downto 0);
            S : in std_logic_vector(4 downto 0);
            Zero : out std_logic;
            C : out std_logic;
            Salida : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Señales de prueba
    signal A, B       : std_logic_vector(7 downto 0) := (others => '0');
    signal Cin        : std_logic := '0';
    signal BP         : std_logic_vector(2 downto 0) := (others => '0');
    signal S          : std_logic_vector(4 downto 0) := (others => '0');
    signal Zero, C    : std_logic;
    signal Salida     : std_logic_vector(7 downto 0);

begin

    -- Instanciación del DUT (Device Under Test)
    DUT: ALU_Main port map (
        A => A,
        B => B,
        Cin => Cin,
        BP => BP,
        S => S,
        Zero => Zero,
        C => C,
        Salida => Salida
    );

    -- Proceso de prueba
    stim_proc: process
    begin
        -- Prueba 1: Suma 3 + 5
        A <= "00000011";
        B <= "00000101";
        S <= "00000"; -- Suma
        wait for 10 ns;

        -- Prueba 2: A - B (3 - 5) = -2 (como unsigned se verá como 254)
        S <= "00001"; -- Resta
        wait for 10 ns;

        -- Prueba 3: BSET (A OR Deco_out), A = 00000001, BP = 2 -> OR con "00000100"
        A <= "00000001";
        BP <= "010";  -- Bit 2
        S <= "01010"; -- BSET
        wait for 10 ns;

        -- Prueba 4: BCLR (A AND NOT Deco_out), A = 11111111, BP = 0 -> limpia LSB
        A <= "11111111";
        BP <= "000";  -- Bit 0
        S <= "01011"; -- BCLR
        wait for 10 ns;

        -- Prueba 5: AND lógico
        A <= "11001100";
        B <= "10101010";
        S <= "00100"; -- AND
        wait for 10 ns;

        wait;
    end process;

end sim;
