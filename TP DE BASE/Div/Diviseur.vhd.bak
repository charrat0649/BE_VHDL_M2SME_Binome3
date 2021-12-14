library	IEEE;
	use	IEEE.std_logic_1164.all;
entity	Diviseur is
Port(clk50	:in STD_LOGIC;
	clk25	:	out  STD_LOGIC);
end	Diviseur;
architecture Behavioral of	Diviseur	is
begin
process(clk50)
variable cpt :integer range 0 to 2;
begin
if(clk50'event and clk50= '1')then
cpt:= cpt+1;
if cpt<1 then clk25 <= '1';
	else if(cpt>=1 and cpt<2) then clk25<='0';
		else if cpt=2	then	cpt:=0;
				end	if;
				end	if;
				end	if;
				end	if;

end process;
end Behavioral;