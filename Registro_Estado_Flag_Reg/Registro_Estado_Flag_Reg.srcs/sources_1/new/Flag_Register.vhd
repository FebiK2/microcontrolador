library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Flag_Register is
    Port ( C, Zero, N, V : in std_logic; -- Carry
          LFlags, clk, arst : in std_logic; -- Load General, reloj y reset asincronico (Por si acaso)
          Cout, Zero_out, Nout, Vout : out std_logic
          );
end Flag_Register;

architecture Behavioral of Flag_Register is
signal C_s, Zero_s, N_s, V_s : std_logic:= '0';
signal LFlags_s : std_logic:= '0';
signal Csaved, Zero_saved, Nsaved, Vsaved : std_logic:= '0';

begin 

LFlags_s <= LFlags;
C_s <= C;
Zero_s <= Zero;
N_s <= N;
V_s <= V;

process(clk, arst)
begin 
    if (arst = '1') then
        Csaved <= '0';
        Zero_saved <= '0';
        Nsaved <= '0';
        Vsaved <= '0'; 
    elsif (rising_edge(clk)) then
        if (LFlags_s = '1') then
            Csaved <= C_s;
            Zero_saved <= Zero_s;
            Nsaved <= N_s;
            Vsaved <= V_s;
        end if; 
    end if;
end process;

Cout <= Csaved;
Zero_out <= Zero_saved;
Nout <= Nsaved;
Vout <= Vsaved;
     

end Behavioral;
