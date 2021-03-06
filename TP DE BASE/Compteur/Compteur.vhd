library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.all;
use IEEE.numeric_std.ALL;

entity compteur is 

port (
		clk,in_freq,raz : in std_logic;
		q : out std_logic_vector( 7 downto 0));
end compteur;

architecture arch_compteur of compteur is 
signal compteur: std_logic_vector (7 downto 0);
begin 

process(clk, in_freq) begin 

if rising_edge(clk) then 
	if raz='0' then 
compteur<=(others=>'0');
	else 
	if in_freq='1' then 
		compteur <= compteur + 1;
	end if;
	end if;
end if ;
end process;

q<=compteur;
end arch_compteur;