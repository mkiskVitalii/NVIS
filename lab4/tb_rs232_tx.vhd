library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rs232_tx is
-- No ports for test bench
end tb_rs232_tx;

architecture Behavioral of tb_rs232_tx is
    -- Component declaration for the Unit Under Test (UUT)
    component rs232_tx
    generic (
        g_CLKS_PER_BIT : integer := 115
    );
    port (
        i_Clk       : in std_logic;
        i_TX_DV     : in std_logic;
        i_TX_Byte   : in std_logic_vector(7 downto 0);
        o_TX_Active : out std_logic;
        o_TX_Serial : out std_logic;
        o_TX_Done   : out std_logic
    );
end component;

    -- Testbench signals
signal i_Clk       : std_logic := '0';
signal i_TX_DV     : std_logic := '0';
signal i_TX_Byte   : std_logic_vector(7 downto 0) := (others => '0');
signal o_TX_Active : std_logic;
signal o_TX_Serial : std_logic;
signal o_TX_Done   : std_logic;

    -- Clock period constant
constant CLK_PERIOD : time := 10 ns;
    -- Baud rate control
constant CLKS_PER_BIT : integer := 115;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: rs232_tx
    generic map (
        g_CLKS_PER_BIT => CLKS_PER_BIT
    )
    port map (
        i_Clk       => i_Clk,
        i_TX_DV     => i_TX_DV,
        i_TX_Byte   => i_TX_Byte,
        o_TX_Active => o_TX_Active,
        o_TX_Serial => o_TX_Serial,
        o_TX_Done   => o_TX_Done
    );

    -- Clock generation process
    clk_process : process
    begin
        while True loop
            i_Clk <= '0';
            wait for CLK_PERIOD / 2;
            i_Clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Wait for reset conditions to settle
        wait for 20 ns;

        -- Test Case 1: Transmit byte "10101010"
        i_TX_Byte <= "10101010";
        i_TX_DV <= '1'; -- Signal the start of data transmission
        wait for CLK_PERIOD; -- Hold TX_DV for one clock cycle
        i_TX_DV <= '0';

        -- Wait for transmission to complete
        wait until o_TX_Done = '1';
        wait for CLK_PERIOD;

        -- Test Case 2: Transmit byte "11001100"
        i_TX_Byte <= "11001100";
        i_TX_DV <= '1';
        wait for CLK_PERIOD;
        i_TX_DV <= '0';

        -- Wait for transmission to complete
        wait until o_TX_Done = '1';
        wait for CLK_PERIOD;

        -- End of simulation
        wait;
    end process;
end Behavioral;
