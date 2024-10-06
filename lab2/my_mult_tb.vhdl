library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity my_mult_tb is
end my_mult_tb;

architecture Behavioral of my_mult_tb is

    -- Component Declaration for the DUT
    component my_mult
    port(
        DIN  : in  STD_LOGIC_VECTOR(31 downto 0);
        DOUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

    -- Signals for connecting to the DUT
signal DIN  : STD_LOGIC_VECTOR(31 downto 0);
signal DOUT : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instantiate the DUT
    uut: my_mult
    port map (
        DIN => DIN,
        DOUT => DOUT
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test case 1
        DIN <= X"00000000";
        wait for 10 ns;
        assert (DOUT = X"00000000") report "Test case 1 failed" severity error;
        
        -- Test case 2
        DIN <= X"FFFFFFFF";
        wait for 10 ns;
        assert (DOUT = X"5B3B0709") report "Test case 2 failed" severity error;
        
        -- Test case 3
        DIN <= X"ABCABCAB";
        wait for 20 ns;
        assert (DOUT = X"3D38AD83") report "Test case 3 failed" severity error;
        
        -- Test case 4
        DIN <= X"CDAABCDC";
        wait for 20 ns;
        assert (DOUT = X"494B1D23") report "Test case 4 failed" severity error;
        
        -- End of simulation
        wait;
    end process;

end Behavioral;