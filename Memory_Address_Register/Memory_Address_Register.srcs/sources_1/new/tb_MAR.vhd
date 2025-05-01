library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_MAR is
-- Port ( );
end tb_MAR;

architecture Behavioral of tb_MAR is

component MAR_Main is
    Port (Din: in std_logic_vector(7 downto 0);
          LMAR, clk, arst: in std_logic; -- Load, Reloj y un reset (Por si acaso)
          Dout: out std_logic_vector(7 downto 0));
end component;
signal Din: std_logic_vector(7 downto 0):= (others => '0');
signal LMAR, clk, arst : std_logic:= '0';
signal Dout: std_logic_vector(7 downto 0):= (others => '0');

begin

Mapeo_Signals: MAR_Main port map(Din => Din, LMAR => LMAR, clk => clk, arst => arst, Dout => Dout);
process
begin
    clk <= '0'; wait for 5ns;
    clk <= '1'; wait for 5ns;
end process;
process
begin
    Din <= x"09"; LMAR <= '0'; wait for 10ns;
    Din <= x"C7"; LMAR <= '1'; wait for 10ns;
    Din <= x"00"; LMAR <= '0'; wait for 10ns;
    Din <= x"80"; LMAR <= '0'; arst <= '1'; wait for 10ns;
    Din <= x"0F"; LMAR <= '1'; arst <= '0'; wait for 10ns;
    Assert False
    Report "Simulación Completa"
    Severity Failure;
end process;

end Behavioral;
