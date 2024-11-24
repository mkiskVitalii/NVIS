library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity cont_unit is
    port(
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        I_ack : in STD_LOGIC;
        I_clk : in STD_LOGIC;
        en_r1 : out STD_LOGIC;
        en_r2 : out STD_LOGIC;
        en_r3 : out STD_LOGIC;
        en_r4 : out STD_LOGIC;
        TX_DV : out STD_LOGIC;
        TX_BYTE : out STD_LOGIC_VECTOR(7 downto 0);
        TX_DONE : in STD_LOGIC;
        R5_out : in STD_LOGIC_VECTOR(31 downto 0)
    );
end cont_unit;
architecture Behavioral of cont_unit is
    type states is (init, s0, s1, s2, s3 ,s4 ,s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15);
    signal state, next_state : states;
    signal byte_index : integer range 0 to 3 := 0;
    signal tx_done_latched : std_logic := '0';
begin
    state_reg: process(clk, rst)
    begin
        if rst = '1' then
            state <= init;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;
    trans: process(state, I_ack, I_clk, TX_DONE)
    begin
        en_r1 <= '0';
        en_r2 <= '0';
        en_r3 <= '0';
        en_r4 <= '0';
        TX_DV <= '0';
        case state is
            when init =>
                next_state <= s0;
            when s0 =>
                if I_ack = '0' then
                    next_state <= s0;
                else
                    next_state <= s1;
                end if;
            when s1 =>
                if I_clk = '0' then
                    next_state <= s1;
                else
                    en_r1 <= '1';
                    next_state <= s2;
                end if;
            when s2 =>
                if I_clk = '1' then
                    next_state <= s2;
                else
                    next_state <= s3;
                end if;
            when s3 =>
                if I_clk = '0' then
                    next_state <= s3;
                else
                    en_r2 <= '1';
                    next_state <= s4;
                end if;
            when s4 =>
                if I_clk = '1' then
                    next_state <= s4;
                else
                    next_state <= s5;
                end if;
            when s5 =>
                if I_clk = '0' then
                    next_state <= s5;
                else
                    en_r3 <= '1';
                    next_state <= s6;
                end if;
            when s6 =>
                if I_clk = '1' then
                    next_state <= s6;
                else
                    next_state <= s7;
                end if;
            when s7 =>
                if I_clk = '0' then
                    next_state <= s7;
                else
                    en_r4 <= '1';
                    next_state <= s8;
                end if;
            when s8 => next_state <= s9;
            when s9 => next_state <= s10;
            when s10 => next_state <= s11;
            when s11 =>
                next_state <= s12;
            when s12 =>
                TX_BYTE <= R5_out(7 downto 0); 
                TX_DV <= '1';
                if TX_DONE = '1' and tx_done_latched = '0' then
                    TX_DV <= '0';
                    tx_done_latched <= '1';
                    next_state <= s13;
                end if;
                if TX_DONE = '0' then
                    tx_done_latched <= '0';
                end if;
            when s13 =>
                TX_BYTE <= R5_out(15 downto 8);
                TX_DV <= '1';
                if TX_DONE = '1' and tx_done_latched = '0' then
                    TX_DV <= '0';
                    tx_done_latched <= '1';
                    next_state <= s14;
                end if;
                if TX_DONE = '0' then
                    tx_done_latched <= '0';
                end if;
            when s14 =>
                TX_BYTE <= R5_out(23 downto 16);
                TX_DV <= '1';
                if TX_DONE = '1' and tx_done_latched = '0' then
                    TX_DV <= '0';
                    tx_done_latched <= '1';
                    next_state <= s15;
                end if;
                if TX_DONE = '0' then
                    tx_done_latched <= '0';
                end if;
            when s15 =>
                TX_BYTE <= R5_out(31 downto 24);
                TX_DV <= '1';
                if TX_DONE = '1' and tx_done_latched = '0' then
                    TX_DV <= '0';
                    tx_done_latched <= '1';
                    next_state <= init;
                end if;
                if TX_DONE = '0' then
                    tx_done_latched <= '0';
                end if;
            when others =>
                next_state <= init;
        end case;
    end process;
end Behavioral;