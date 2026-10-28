----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2026 22:06:40
-- Design Name: 
-- Module Name: UAL - Behavioral
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

entity UAL is
    Port ( clk : in STD_LOGIC;
           RESET : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           SEL : in STD_LOGIC_VECTOR (3 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0));
end UAL;

architecture Behavioral of UAL is


    signal s_mult      : STD_LOGIC_VECTOR(7 downto 0);
    signal s_cpt_sync  : STD_LOGIC_VECTOR(7 downto 0);
    signal s_cpt_async : STD_LOGIC_VECTOR(7 downto 0);
    signal s_reg_dec   : STD_LOGIC_VECTOR(7 downto 0);
    signal s_lfsr      : STD_LOGIC_VECTOR(7 downto 0);
    signal s_decodeur  : STD_LOGIC_VECTOR(7 downto 0);
    signal s_mealy     : STD_LOGIC_VECTOR(7 downto 0);
    signal s_aff_7seg  : STD_LOGIC_VECTOR(7 downto 0);


    component Multiplication_4bit is 
        Port ( A, B : in STD_LOGIC_VECTOR(3 downto 0); 
               Res : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;

    component Compteur_Synchrone is 
    Port ( CLK, Reset : in STD_LOGIC; A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component Compteur_Asynchrone is 
    Port ( CLK, Reset : in STD_LOGIC; A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component Reg_Decalage is 
    Port ( CLK, Reset : in STD_LOGIC; A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component LFSR_UAL is 
    Port ( CLK, Reset : in STD_LOGIC; A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component Decodeur_UAL is 
    Port ( A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component Essuie_Glace_UAL is 
    Port ( CLK, Reset : in STD_LOGIC; A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;
    
    component Affichage_UAL is 
    Port ( A, B : in STD_LOGIC_VECTOR(3 downto 0); S : out STD_LOGIC_VECTOR(7 downto 0)); 
    end component;

begin

   
U1: Multiplication_4bit port map (A => A, B => B, Res => s_mult);
U2: Compteur_Synchrone  port map (CLK => clk, Reset => RESET, A => A, B => B, S => s_cpt_sync);
U3: Compteur_Asynchrone port map (CLK => clk, Reset => RESET, A => A, B => B, S => s_cpt_async);
U4: Reg_Decalage        port map (CLK => clk, Reset => RESET, A => A, B => B, S => s_reg_dec);
U5: LFSR_UAL            port map (CLK => clk, Reset => RESET, A => A, B => B, S => s_lfsr);
U6: Decodeur_UAL        port map (A => A, B => B, S => s_decodeur);
U7: Essuie_Glace_UAL    port map (CLK => clk, Reset => RESET, A => A, B => B, S => s_mealy);
U8: Affichage_UAL       port map (A => A, B => B, S => s_aff_7seg);

   
    process (SEL, s_mult, s_cpt_sync, s_cpt_async, s_reg_dec, s_lfsr, s_decodeur, s_mealy, s_aff_7seg)
    begin
        case SEL is
            when "0000" => S <= s_mult;
            when "0001" => S <= s_cpt_sync;
            when "0010" => S <= s_cpt_async;
            when "0011" => S <= s_reg_dec;
            when "0100" => S <= s_lfsr;
            when "0101" => S <= s_decodeur;
            when "0110" => S <= s_mealy;
            when "0111" => S <= s_aff_7seg;
            when others => S <= "00000000"; 
        end case;
    end process;

end Behavioral;