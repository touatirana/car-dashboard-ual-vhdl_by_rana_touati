----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2026 08:57:47
-- Design Name: 
-- Module Name: Compteur_Asynchrone - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Compteur_Asynchrone is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Compteur_Asynchrone;

architecture Behavioral of Compteur_Asynchrone is
    signal q_int : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(CLK, Reset)
    begin
        if Reset = '1' then q_int(0) <= '0';
        elsif falling_edge(CLK) then q_int(0) <= not q_int(0);
        end if;
    end process;

    process(q_int(0), Reset)
    begin
        if Reset = '1' then q_int(1) <= '0';
        elsif falling_edge(q_int(0)) then q_int(1) <= not q_int(1);
        end if;
    end process;

    process(q_int(1), Reset)
    begin
        if Reset = '1' then q_int(2) <= '0';
        elsif falling_edge(q_int(1)) then q_int(2) <= not q_int(2);
        end if;
    end process;

    process(q_int(2), Reset)
    begin
        if Reset = '1' then q_int(3) <= '0';
        elsif falling_edge(q_int(2)) then q_int(3) <= not q_int(3);
        end if;
    end process;

    S <= "0000" & q_int;
end Behavioral;