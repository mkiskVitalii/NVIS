library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity lab4_5_6 is
    Port (
        D_in : in STD_LOGIC_VECTOR(7 downto 0);
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        I_CLK : in STD_LOGIC;
        I_ACK : in STD_LOGIC;
        D_OUT : out STD_LOGIC);
end lab4_5_6;

architecture Behavioral of lab4_5_6 is
    signal R1_out, R2_out, R3_out, R4_out : STD_LOGIC_VECTOR(7 downto 0);
    signal R5_out : STD_LOGIC_VECTOR(31 downto 0);
    signal EN_R1, EN_R2, EN_R3, EN_R4 : STD_LOGIC;
    signal DATA_32 : STD_LOGIC_VECTOR(31 downto 0);
    signal Reg32_Out: STD_LOGIC_VECTOR(31 downto 0);
    signal TX_DV: STD_LOGIC := '0';
    signal TX_RECEIVE_BYTE : STD_LOGIC_VECTOR(7 downto 0);
    signal TX_RECEIVE_DONE: STD_LOGIC := '0';
    constant c_CLKS_PER_BIT : integer := 87;
begin
    INPUT_IF: entity work.input_interface
    port map (
        RESET   => RESET,
        CLK     => CLK,
        D_in    => D_in,
        EN_R1   => EN_R1,
        EN_R2   => EN_R2,
        EN_R3   => EN_R3,
        EN_R4   => EN_R4,
        R1      => R1_out,
        R2      => R2_out,
        R3      => R3_out,
        R4      => R4_out
    );
    DATA_32 <= R1_out & R2_out & R3_out & R4_out;

    CONV_MULT: entity work.multiple_conv
    port map (
        DATA_32,
        CLK,
        RESET,
        R5_out
    );

    R5: entity work.reg_32bit
    port map (
        CLK,
        RESET,
        R5_out,
        Reg32_Out
    );

    TX: entity work.rs232_tx
    generic map (
        g_CLKS_PER_BIT => c_CLKS_PER_BIT
    )
    port map (
        i_clk => CLK,
        i_tx_dv => TX_DV,
        i_tx_byte => TX_RECEIVE_BYTE,
        o_tx_active => open,
        o_tx_serial => D_OUT,
        o_tx_done => TX_RECEIVE_DONE
    );
    
    CONTROLLER: entity work.cont_unit
    port map (
        clk => CLK,
        rst => RESET,
        I_ack => I_ACK,
        I_clk => I_CLK,
        en_r1 => EN_R1,
        en_r2 => EN_R2,
        en_r3 => EN_R3,
        en_r4 => EN_R4,
        TX_DV => TX_DV,
        TX_BYTE => TX_RECEIVE_BYTE,
        TX_DONE => TX_RECEIVE_DONE,
        R5_out => Reg32_Out
    );
end Behavioral;