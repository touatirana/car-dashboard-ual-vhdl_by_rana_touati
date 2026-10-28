----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2026 01:51:28
-- Design Name: 
-- Module Name: Affichage_UAL - Behavioral
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

entity Affichage_UAL is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Affichage_UAL;

architecture Behavioral of Affichage_UAL is
begin
    process(A)
    begin
        S <= (others => '1');
        case A(1 downto 0) is
            when "00" => S(6 downto 0) <= "0001100";
            when "01" => S(6 downto 0) <= "0101111";
            when "10" => S(6 downto 0) <= "0101011";
            when "11" => S(6 downto 0) <= "0100001";
            when others => S(6 downto 0) <= "1111111";
        end case;
    end process;
end Behavioral;