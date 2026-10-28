----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2026 01:55:08
-- Design Name: 
-- Module Name: LFSR_UAL - Behavioral
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

entity LFSR_UAL is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end LFSR_UAL;

architecture Behavioral of LFSR_UAL is
    signal reg : STD_LOGIC_VECTOR(7 downto 0) := "00000001";
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            if Reset = '1' then
                reg <= "00000001";
            else
                reg <= reg(6 downto 0) & (reg(7) xor reg(2));
            end if;
        end if;
    end process;
    S <= reg;
end Behavioral;