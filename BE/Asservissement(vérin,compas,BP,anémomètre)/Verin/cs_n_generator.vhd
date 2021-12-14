Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cs_n_generator is
	port(
		clk_1mhz : in std_logic;
		cs_n : out std_logic);
end cs_n_generator;

architecture arc of cs_n_generator is
begin 

process(clk_1mhz) is
	variable cpt : integer range 0 to 100000;
begin	

	if(clk_1mhz'event and clk_1mhz='1') then
		cpt := cpt + 1;
		if cpt < 99995 then 
			cs_n <= '0';
		else 
			cs_n <= '1';
			cpt := 0;
			end if;
		end if;

end process;

end arc;
