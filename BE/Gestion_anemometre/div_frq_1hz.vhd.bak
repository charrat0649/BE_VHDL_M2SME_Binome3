library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity div_frq_1hz is
port ( clk: in std_logic;
clk_1hz : out std_logic);
end div_frq_1hz;
  
architecture bhv of div_frq_1hz is
  
  
begin
  
process(clk)
variable cpt : integer range 0 to 50000001;
begin

if(clk'event and clk='1') then
cpt := cpt + 1;
if cpt < 25000000 then clk_1hz <= '1';
		else if (cpt >= 25000000 and cpt < 50000000) then clk_1hz <= '0';
			 else if cpt = 50000000 then cpt := 0;
				  end if;
			 end if;
		end if;
end if;
end process;
  
end bhv;