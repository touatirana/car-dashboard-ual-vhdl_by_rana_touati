----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2026 01:53:51
-- Design Name: 
-- Module Name: Decodeur_UAL - Behavioral
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

entity Decodeur_UAL is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Decodeur_UAL;

architecture Behavioral of Decodeur_UAL is
begin
    process(A)
    begin
        S <= (others => '0');
        case A(1 downto 0) is
            when "00" => S(3 downto 0) <= "0001";
            when "01" => S(3 downto 0) <= "0010";
            when "10" => S(3 downto 0) <= "0100";
            when "11" => S(3 downto 0) <= "1000";
            when others => S <= (others => '0');
        end case;
    end process;
end Behavioral;