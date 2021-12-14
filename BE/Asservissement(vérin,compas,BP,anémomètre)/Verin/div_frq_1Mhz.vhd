library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity div_frq_1Mhz is
port ( clk: in std_logic;
clk_1Mhz : out std_logic);
end div_frq_1Mhz;
  
architecture bhv of div_frq_1Mhz is
  
  
begin
  
process(clk)
variable cpt : integer range 0 to 51;
begin

if(clk'event and clk='1') then
cpt := cpt + 1;
	if cpt < 25 then clk_1Mhz <= '1';

	else 
		if (cpt >= 25 and cpt < 50) then 
				clk_1Mhz <= '0';
		else if cpt = 50 then 
			cpt := 0;
			end if;
		end if;
	end if;
end if;
end process;
  
end bhv;