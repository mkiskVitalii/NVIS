LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_lab4_5_6 IS
END tb_lab4_5_6;

ARCHITECTURE behavior OF tb_lab4_5_6 IS
    
    COMPONENT lab4_5_6
    PORT(
        D_in : IN std_logic_vector(7 downto 0);
        CLK : IN std_logic;
        RESET : IN std_logic;
        I_CLK : IN std_logic;
        I_ACK : IN std_logic;
        D_OUT : OUT std_logic
    );
END COMPONENT;

signal D_in : std_logic_vector(7 downto 0) := (others => '0');
signal CLK : std_logic := '0';
signal RESET : std_logic := '0';
signal I_CLK : std_logic := '0';
signal I_ACK : std_logic := '0';
signal D_OUT : std_logic;

constant CLK_period : time := 10 ns;
constant c_CLKS_PER_BIT : integer := 87;
constant c_BIT_PERIOD : time := 8680 ns;

BEGIN
    uut: lab4_5_6 PORT MAP (
        D_in => D_in,
        CLK => CLK,
        RESET => RESET,
        I_CLK => I_CLK,
        I_ACK => I_ACK,
        D_OUT => D_OUT
    );
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
    stim_proc: process
    begin
        RESET <= '1';
        wait for CLK_period;
        RESET <= '0';

        I_ACK <= '0';
        wait for 4 * CLK_period;

        I_ACK <= '1';
        wait for CLK_period;

        I_CLK <= '1';
        D_in <= "11111111";
        wait for CLK_period;
        I_CLK <= '0';
        wait for CLK_period;
        I_CLK <= '1';
        D_in <= "11111111";
        wait for CLK_period;
        I_CLK <= '0';
        wait for CLK_period;
        I_CLK <= '1';
        D_in <= "11111111";
        wait for CLK_period;
        I_CLK <= '0';
        wait for CLK_period;
        I_CLK <= '1';
        D_in <= "11111111";
        wait for CLK_period;
        I_CLK <= '0';
        I_ACK <= '0';
        wait for CLK_period;

        wait for CLK_period*10;
        wait;
    end process;
END;