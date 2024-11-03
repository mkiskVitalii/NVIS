library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_multiple_conv is
end tb_multiple_conv;

architecture behavior of tb_multiple_conv is
    signal DIN : STD_LOGIC_VECTOR(31 downto 0);
    signal CLK : STD_LOGIC := '0';
    signal RST : STD_LOGIC := '0';
    signal DOUT : STD_LOGIC_VECTOR(31 downto 0);
    
    constant clk_period : time := 10 ns; -- Define the clock period

begin
    uut: entity work.multiple_conv
    port map (
        DIN => DIN,
        CLK => CLK,
        RST => RST,
        DOUT => DOUT
    );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            CLK <= '0';
            wait for clk_period / 2;
            CLK <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Test process
    stim_process : process
    begin
        -- Initialize inputs
        DIN <= (others => '0');
        RST <= '1'; -- Assert reset
        wait for clk_period;

        RST <= '0'; -- Deassert reset
        wait for clk_period;

        -- Test case: Check output for DIN = FFFFFFFF
        DIN <= X"FFFFFFFF";
        wait for clk_period; -- Wait for a clock cycle to let the output stabilize
        -- Wait to allow the output to propagate through the design
        wait for clk_period * 10;
        -- Check the output
        assert (DOUT = X"5B3B0709")
        report "Test case for DIN = FFFFFFFF failed: DOUT is not 5B3B0709" severity error;
        
        -- Test case: Check output for DIN = 00000000
        DIN <= X"00000000";
        wait for clk_period; -- Wait for a clock cycle to let the output stabilize
        -- Wait to allow the output to propagate through the design
        wait for clk_period * 10;
        -- Check the output
        assert (DOUT = X"00000000")
        report "Test case for DIN = 00000000 failed: DOUT is not 00000000" severity error;
        
        -- Test case: Check output for DIN = ABCABCAB
        DIN <= X"ABCABCAB";
        wait for clk_period; -- Wait for a clock cycle to let the output stabilize
        -- Wait to allow the output to propagate through the design
        wait for clk_period * 10;
        -- Check the output
        assert (DOUT = X"3D38AD83")
        report "Test case for DIN = ABCABCAB failed: DOUT is not 3D38AD83" severity error;

        -- Test case: Check output for DIN = CDAABCDC
        DIN <= X"CDAABCDC";
        wait for clk_period; -- Wait for a clock cycle to let the output stabilize
        -- Wait to allow the output to propagate through the design
        wait for clk_period * 10;
        -- Check the output
        assert (DOUT = X"494B1D23")
        report "Test case for DIN = CDAABCDC failed: DOUT is not 494B1D23" severity error;
        -- Finish simulation
        wait; -- Wait indefinitely to prevent further simulation
    end process;

end behavior;
