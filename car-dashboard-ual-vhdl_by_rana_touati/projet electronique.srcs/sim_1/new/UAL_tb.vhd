library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UAL_tb is
end UAL_tb;

architecture sim of UAL_tb is
    signal clk   : std_logic := '0';
    signal RESET : std_logic := '1';
    signal A, B  : std_logic_vector(3 downto 0) := (others => '0');
    signal SEL   : std_logic_vector(3 downto 0) := (others => '0');
    signal S     : std_logic_vector(7 downto 0);
    signal done  : boolean := false;
begin
    uut : entity work.UAL
        port map (clk => clk, RESET => RESET, A => A, B => B, SEL => SEL, S => S);

    clk <= not clk after 5 ns when not done;

    stim : process
        procedure check(exp : std_logic_vector(7 downto 0); msg : string) is
        begin
            assert S = exp report "FAIL: " & msg severity error;
        end procedure;
    begin
        wait for 22 ns;  RESET <= '0';

        -- SEL=0000 multiplier
        SEL <= "0000"; A <= "0011"; B <= "0100"; wait for 10 ns;
        check("00001100", "3 x 4");
        A <= "1111"; B <= "1111"; wait for 10 ns;
        check("11100001", "15 x 15");

        -- SEL=0101 decoder
        SEL <= "0101";
        A <= "0000"; wait for 10 ns; check("00000001", "decoder P");
        A <= "0001"; wait for 10 ns; check("00000010", "decoder R");
        A <= "0010"; wait for 10 ns; check("00000100", "decoder N");
        A <= "0011"; wait for 10 ns; check("00001000", "decoder D");

        -- SEL=0111 7-segment
        SEL <= "0111";
        A <= "0000"; wait for 10 ns; check("10001100", "7seg P");
        A <= "0001"; wait for 10 ns; check("10101111", "7seg r");
        A <= "0010"; wait for 10 ns; check("10101011", "7seg n");
        A <= "0011"; wait for 10 ns; check("10100001", "7seg d");

        -- SEL others
        SEL <= "1000"; wait for 10 ns; check("00000000", "unused SEL");

        -- SEL=0001 synchronous counter: 0,5,10,3,15,0
        SEL <= "0001"; RESET <= '1'; wait for 12 ns; RESET <= '0';
        check("00000000", "sync reset");
        wait until rising_edge(clk); wait for 1 ns; check("00000101", "sync 5");
        wait until rising_edge(clk); wait for 1 ns; check("00001010", "sync 10");
        wait until rising_edge(clk); wait for 1 ns; check("00000011", "sync 3");
        wait until rising_edge(clk); wait for 1 ns; check("00001111", "sync 15");
        wait until rising_edge(clk); wait for 1 ns; check("00000000", "sync wrap");

        -- SEL=0011 shift register, shift left feeding 1 (A="0010")
        SEL <= "0011"; A <= "0010"; RESET <= '1'; wait for 12 ns; RESET <= '0';
        wait until rising_edge(clk); wait for 1 ns; check("00000001", "shift 1");
        wait until rising_edge(clk); wait for 1 ns; check("00000011", "shift 2");
        wait until rising_edge(clk); wait for 1 ns; check("00000111", "shift 3");
        wait until rising_edge(clk); wait for 1 ns; check("00001111", "shift 4");

        -- SEL=0110 wipers
        SEL <= "0110"; A <= "0000"; RESET <= '1'; wait for 12 ns; RESET <= '0';
        wait for 1 ns; check("00000000", "wiper OFF");
        A <= "0001"; wait until rising_edge(clk); wait for 1 ns; check("00000001", "wiper LENT");
        A <= "0010"; wait until rising_edge(clk); wait for 1 ns; check("00000010", "wiper RAPIDE");
        A <= "0000"; wait until rising_edge(clk); wait for 1 ns; check("00000000", "wiper back OFF");

        -- SEL=0100 LFSR first states
        SEL <= "0100"; RESET <= '1'; wait for 12 ns; RESET <= '0';
        check("00000001", "lfsr seed");
        wait until rising_edge(clk); wait for 1 ns; check("00000010", "lfsr 02");
        wait until rising_edge(clk); wait for 1 ns; check("00000100", "lfsr 04");
        wait until rising_edge(clk); wait for 1 ns; check("00001001", "lfsr 09");

        report "Testbench finished" severity note;
        done <= true;
        wait;
    end process;
end sim;
