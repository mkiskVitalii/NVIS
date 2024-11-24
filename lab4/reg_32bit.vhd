library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_32bit is
    Port (
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        D : in STD_LOGIC_VECTOR(31 downto 0);
        D_OUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end reg_32bit;

architecture Behavioral of reg_32bit is
begin
    process (CLK, RESET)
    begin
        if RESET = '1' then
            D_OUT <= (others => '0');
        elsif rising_edge(CLK) then
            D_OUT <= D;
        end if;
    end process;
end Behavioral;