----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2026 08:59:01
-- Design Name: 
-- Module Name: Reg_Decalage - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_Decalage is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Reg_Decalage;

architecture Behavioral of Reg_Decalage is
    signal tmp : STD_LOGIC_VECTOR(3 downto 0);
begin
    process(CLK, Reset)
    begin
        if Reset = '1' then
            tmp <= "0000";
        elsif rising_edge(CLK) then
            if A(0) = '0' then
                tmp <= tmp(2 downto 0) & A(1);
            else
                tmp <= A(1) & tmp(3 downto 1);
            end if;
        end if;
    end process;
    S <= "0000" & tmp;
end Behavioral;
