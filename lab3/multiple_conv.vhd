library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity multiple_conv is
    port(
        DIN : in STD_LOGIC_VECTOR(31 downto 0);
        CLK : in STD_LOGIC;
        RST : in STD_LOGIC;
        DOUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end multiple_conv;


architecture multiple_conv of multiple_conv is
    signal X_L1, X_L3, X_L8, X_L11, X_L16, X_L18, X_L22, X_L24, X_L26, X_L29, X_L30 : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X1_0_in, X1_1_in, X1_2_in, X1_3_in, X1_4_in, X1_5_in : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X1_0_out,X1_1_out,X1_2_out,X1_3_out,X1_4_out,X1_5_out : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X2_0_in, X2_1_in, X2_2_in, X2_3_in : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X2_0_out, X2_1_out, X2_2_out, X2_3_out : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X3_0_in,X3_1_in : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X3_0_out,X3_1_out : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
    signal X4_0 : STD_LOGIC_VECTOR(63 downto 0) := (others => '0');
begin
-- X with shift
    X_L1  <= "0000000000000000000000000000000" & DIN & "0";
    X_L3  <= "00000000000000000000000000000" & DIN & "000";
    X_L8  <= "000000000000000000000000" & DIN & "00000000";
    X_L11 <= "000000000000000000000" & DIN & "00000000000";
    X_L16 <= "0000000000000000" & DIN & "0000000000000000";
    X_L18 <= "00000000000000" & DIN & "000000000000000000";
    X_L22 <= "0000000000" & DIN & "0000000000000000000000";
    X_L24 <= "00000000" & DIN & "000000000000000000000000";
    X_L26 <= "000000" & DIN & "00000000000000000000000000";
    X_L29 <= "000" & DIN & "00000000000000000000000000000";
    X_L30 <= "00" & DIN & "000000000000000000000000000000";
    
-- stage 1 -----------------------------------------------------------
    X1_0_in <= X_L1 + X_L3;
    X1_1_in <= X_L11 + X_L22;
    X1_2_in <= X_L29 + X_L30;
    X1_3_in <= X_L8 + X_L16;
    X1_4_in <= X_L18 + X_L24;
    X1_5_in <= X_L26;
-- stage 2 -----------------------------------------------------------
    X2_0_in <= X1_0_out + X1_1_out;
    X2_1_in <= X1_2_out;
    X2_2_in <= X1_3_out + X1_4_out;
    X2_3_in <= X1_5_out;
-- stage 3 -----------------------------------------------------------
    X3_0_in <= X2_0_out + X2_1_out;
    X3_1_in <= X2_2_out + X2_3_out;
-- stage 4 -----------------------------------------------------------
    X4_0 <= X3_0_out - X3_1_out;
--------------------------------
    DOUT <= X4_0 (63 downto 32);

--Reg file 1----------------------------------------------------------
    process (CLK, RST)
    begin
        if RST='1' then
            X1_0_out <= (others => '0');
            X1_1_out <= (others => '0');
            X1_2_out <= (others => '0');
            X1_3_out <= (others => '0');
            X1_4_out <= (others => '0');
            X1_5_out <= (others => '0');
        elsif (CLK'event and CLK='1') then
            X1_0_out <= X1_0_in;
            X1_1_out <= X1_1_in;
            X1_2_out <= X1_2_in;
            X1_3_out <= X1_3_in;
            X1_4_out <= X1_4_in;
            X1_5_out <= X1_5_in;
        end if;
    end process;
--Reg file 2----------------------------------------------------------
    process (CLK, RST)
    begin
        if RST='1' then
            X2_0_out <= (others => '0');
            X2_1_out <= (others => '0');
            X2_2_out <= (others => '0');
            X2_3_out <= (others => '0');
        elsif (CLK'event and CLK='1') then
            X2_0_out <= X2_0_in;
            X2_1_out <= X2_1_in;
            X2_2_out <= X2_2_in;
            X2_3_out <= X2_3_in;
        end if;
    end process;
--Reg file 3----------------------------------------------------------
    process (CLK, RST)
    begin
        if RST='1' then
            X3_0_out <= (others => '0');
            X3_1_out <= (others => '0');
        elsif (CLK'event and CLK='1') then
            X3_0_out <= X3_0_in;
            X3_1_out <= X3_1_in;
        end if;
    end process;

end multiple_conv;