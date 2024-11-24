library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity tb_cont_unit is
-- No ports for a test bench
end tb_cont_unit;

architecture Behavioral of tb_cont_unit is

    -- Component declaration for the Unit Under Test (UUT)
    component cont_unit
    port(
        clk      : in STD_LOGIC;
        rst      : in STD_LOGIC;
        I_ack    : in STD_LOGIC;
        I_clk    : in STD_LOGIC;
        en_r1    : out STD_LOGIC;
        en_r2    : out STD_LOGIC;
        en_r3    : out STD_LOGIC;
        en_r4    : out STD_LOGIC;
        TX_DV    : out STD_LOGIC;
        TX_BYTE  : out STD_LOGIC_VECTOR(7 downto 0);
        TX_DONE  : in STD_LOGIC;
        R5_out   : in STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

    -- Testbench signals
signal clk      : STD_LOGIC := '0';
signal rst      : STD_LOGIC := '0';
signal I_ack    : STD_LOGIC := '0';
signal I_clk    : STD_LOGIC := '0';
signal en_r1    : STD_LOGIC;
signal en_r2    : STD_LOGIC;
signal en_r3    : STD_LOGIC;
signal en_r4    : STD_LOGIC;
signal TX_DV    : STD_LOGIC;
signal TX_BYTE  : STD_LOGIC_VECTOR(7 downto 0);
signal TX_DONE  : STD_LOGIC := '0';
signal R5_out   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    -- Clock period
constant CLK_PERIOD : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: cont_unit
    port map (
        clk      => clk,
        rst      => rst,
        I_ack    => I_ack,
        I_clk    => I_clk,
        en_r1    => en_r1,
        en_r2    => en_r2,
        en_r3    => en_r3,
        en_r4    => en_r4,
        TX_DV    => TX_DV,
        TX_BYTE  => TX_BYTE,
        TX_DONE  => TX_DONE,
        R5_out   => R5_out
    );

    -- Clock generation process
    clk_process : process
    begin
        while True loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Reset the system
        rst <= '1';
        wait for 2 * CLK_PERIOD;
        rst <= '0';

        -- Test sequence
        -- Initialize inputs
        I_ack <= '0';
        I_clk <= '0';
        TX_DONE <= '0';
        R5_out <= x"12345678";  -- Example data to transmit

        -- Test the state transitions
        -- Step 1: Assert I_ack to start the state machine
        wait for 5 * CLK_PERIOD;
        I_ack <= '1';
        wait for CLK_PERIOD;
        I_ack <= '0';

        -- Step 2: Simulate clock pulses (I_clk) for state machine transitions
        for i in 0 to 15 loop
            I_clk <= '1';
            wait for CLK_PERIOD;
            I_clk <= '0';
            wait for CLK_PERIOD;
        end loop;

        -- Step 3: Simulate TX_DONE signals for the transmission
        for i in 0 to 3 loop
            TX_DONE <= '1';
            wait for 2 * CLK_PERIOD;
            TX_DONE <= '0';
            wait for 3 * CLK_PERIOD;
        end loop;

        -- Observe outputs
        wait for 20 * CLK_PERIOD;

        -- End simulation
        wait;
    end process;

end Behavioral;
