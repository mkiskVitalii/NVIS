library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_8bit is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        EN : in STD_LOGIC;
        D : in STD_LOGIC_VECTOR(7 downto 0);
        D_OUT : out STD_LOGIC_VECTOR(7 downto 0)
    );
end reg_8bit;

architecture Behavioral of reg_8bit is
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            D_OUT <= (others => '0');
        elsif rising_edge(CLK) then
            if EN = '1' then
                D_OUT <= D;
            end if;
        end if;
    end process;
end Behavioral;