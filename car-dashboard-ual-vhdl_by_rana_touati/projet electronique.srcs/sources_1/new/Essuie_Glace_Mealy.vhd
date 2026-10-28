----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2026 09:30:20
-- Design Name: 
-- Module Name: Essuie_Glace_Mealy - Behavioral
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

entity Essuie_Glace_UAL is
    Port ( CLK : in STD_LOGIC;
           Reset : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end Essuie_Glace_UAL;

architecture Behavioral of Essuie_Glace_UAL is
    type state is (ST_OFF, ST_LENT, ST_RAPIDE);
    signal current_s, next_s : state;
begin
    process(CLK, Reset)
    begin
        if Reset = '1' then
            current_s <= ST_OFF;
        elsif rising_edge(CLK) then
            current_s <= next_s;
        end if;
    end process;

    process(current_s, A)
    begin
        S <= (others => '0');
        case current_s is
            when ST_OFF =>
                S(1 downto 0) <= "00";
                if A(1 downto 0) = "01" then next_s <= ST_LENT;
                elsif A(1 downto 0) = "10" then next_s <= ST_RAPIDE;
                else next_s <= ST_OFF; end if;
            when ST_LENT =>
                S(1 downto 0) <= "01";
                if A(1 downto 0) = "00" then next_s <= ST_OFF;
                elsif A(1 downto 0) = "10" then next_s <= ST_RAPIDE;
                else next_s <= ST_LENT; end if;
            when ST_RAPIDE =>
                S(1 downto 0) <= "10";
                if A(1 downto 0) = "00" then next_s <= ST_OFF;
                elsif A(1 downto 0) = "01" then next_s <= ST_LENT;
                else next_s <= ST_RAPIDE; end if;
        end case;
    end process;
end Behavioral;