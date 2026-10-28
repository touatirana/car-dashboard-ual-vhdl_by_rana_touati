----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2026 08:56:40
-- Design Name: 
-- Module Name: Compteur_Synchrone - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Compteur_Synchrone is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Compteur_Synchrone;

architecture Behavioral of Compteur_Synchrone is
    signal temp: STD_LOGIC_VECTOR(3 downto 0) := "0000";
begin
    process(CLK, Reset)
    begin
        if Reset = '1' then 
            temp <= "0000";
        elsif rising_edge(CLK) then
            case temp is
                when "0000" => temp <= "0101";
                when "0101" => temp <= "1010";
                when "1010" => temp <= "0011";
                when "0011" => temp <= "1111";
                when others => temp <= temp + 1;
            end case;
        end if;
    end process;
    S <= "0000" & temp;
end Behavioral;