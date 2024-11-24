library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_input_interface is
-- Test bench does not have ports
end tb_input_interface;

architecture Behavioral of tb_input_interface is
    -- Component Declaration for the Unit Under Test (UUT)
    component input_interface
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
end component;

    -- Signals to connect to UUT
signal RESET    : STD_LOGIC := '0';
signal CLK      : STD_LOGIC := '0';
signal D_in     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
signal EN_R1    : STD_LOGIC := '0';
signal EN_R2    : STD_LOGIC := '0';
signal EN_R3    : STD_LOGIC := '0';
signal EN_R4    : STD_LOGIC := '0';
signal R1       : STD_LOGIC_VECTOR(7 downto 0);
signal R2       : STD_LOGIC_VECTOR(7 downto 0);
signal R3       : STD_LOGIC_VECTOR(7 downto 0);
signal R4       : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period constant
constant CLK_PERIOD : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: input_interface
    Port map (
        RESET   => RESET,
        CLK     => CLK,
        D_in    => D_in,
        EN_R1   => EN_R1,
        EN_R2   => EN_R2,
        EN_R3   => EN_R3,
        EN_R4   => EN_R4,
        R1      => R1,
        R2      => R2,
        R3      => R3,
        R4      => R4
    );

    -- Clock generation process
    clk_process : process
    begin
        while True loop
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset the system
        RESET <= '1';
        wait for 20 ns;
        RESET <= '0';
        wait for 20 ns;

        -- Write to R1
        D_in <= "10101010";
        EN_R1 <= '1';
        wait for CLK_PERIOD;
        EN_R1 <= '0';
        wait for CLK_PERIOD;

        -- Write to R2
        D_in <= "11001100";
        EN_R2 <= '1';
        wait for CLK_PERIOD;
        EN_R2 <= '0';
        wait for CLK_PERIOD;

        -- Write to R3
        D_in <= "11110000";
        EN_R3 <= '1';
        wait for CLK_PERIOD;
        EN_R3 <= '0';
        wait for CLK_PERIOD;

        -- Write to R4
        D_in <= "00001111";
        EN_R4 <= '1';
        wait for CLK_PERIOD;
        EN_R4 <= '0';
        wait for CLK_PERIOD;

        -- Test reset functionality
        RESET <= '1';
        wait for CLK_PERIOD;
        RESET <= '0';
        wait for CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
