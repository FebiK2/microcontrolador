library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Scratch_Pad is
end tb_Scratch_Pad;

architecture behavior of tb_Scratch_Pad is

    -- Component Declaration
    component Scratch_Pad is
        Port(Addr : in std_logic_vector(5 downto 0);
             WE, clk, Arst: in std_logic;
             Din: in std_logic_vector(7 downto 0);
             Dout: out std_logic_vector(7 downto 0));
    end component;

    -- Signals
    signal Addr : std_logic_vector(5 downto 0) := (others => '0');
    signal WE, clk, Arst : std_logic := '0';
    signal Din : std_logic_vector(7 downto 0) := (others => '0');
    signal Dout : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Scratch_Pad Port Map (
        Addr => Addr,
        WE => WE,
        clk => clk,
        Arst => Arst,
        Din => Din,
        Dout => Dout
    );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        Arst <= '1';
        wait for clk_period;
        Arst <= '0';
        wait for clk_period;

        -- Write data 0xAA at address 5
        Addr <= "000101";
        Din <= "10101010";
        WE <= '1';
        wait for clk_period;

        -- Disable write and read the same address
        WE <= '0';
        wait for clk_period;

        -- Write data 0x55 at address 10
        Addr <= "001010";
        Din <= "01010101";
        WE <= '1';
        wait for clk_period;

        -- Disable write and read back
        WE <= '0';
        wait for clk_period;

        -- Read address 5 again
        Addr <= "000101";
        wait for clk_period;

        wait;
    end process;

end behavior;
