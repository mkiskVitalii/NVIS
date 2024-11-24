library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_interface is
    Port (
        RESET        : in    STD_LOGIC;
        CLK          : in    STD_LOGIC;
        D_in         : in    STD_LOGIC_VECTOR(7 downto 0);
        EN_R1        : in    STD_LOGIC;
        EN_R2        : in    STD_LOGIC;
        EN_R3        : in    STD_LOGIC;
        EN_R4        : in    STD_LOGIC;
        R1           : OUT   STD_LOGIC_VECTOR(7 downto 0);
        R2           : OUT   STD_LOGIC_VECTOR(7 downto 0);
        R3           : OUT   STD_LOGIC_VECTOR(7 downto 0);
        R4           : OUT   STD_LOGIC_VECTOR(7 downto 0)
    );
end input_interface;

architecture Behavioral of input_interface is
    signal R1_reg, R2_reg, R3_reg, R4_reg : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
begin
    R1_inst : entity work.reg_8bit
    port map (
        RESET   => RESET,
        CLK     => CLK,
        D       => D_in,
        EN      => EN_R1,
        D_OUT   => R1_reg
    );

    R2_inst : entity work.reg_8bit
    port map (
        RESET   => RESET,
        CLK     => CLK,
        D       => D_in,
        EN      => EN_R2,
        D_OUT   => R2_reg
    );

    R3_inst : entity work.reg_8bit
    port map (
        RESET   => RESET,
        CLK     => CLK,
        D       => D_in,
        EN      => EN_R3,
        D_OUT   => R3_reg
    );

    R4_inst : entity work.reg_8bit
    port map (
        RESET   => RESET,
        CLK     => CLK,
        D       => D_in,
        EN      => EN_R4,
        D_OUT   => R4_reg
    );
    
    R1 <= R1_reg;
    R2 <= R2_reg;
    R3 <= R3_reg;
    R4 <= R4_reg;
end Behavioral;
