library	IEEE;
	use	IEEE.std_logic_1164.all;
entity	divis is
Port(clk50M	:in STD_LOGIC;
	clk1hz	:	out  STD_LOGIC);
end	divis;
architecture Behavioral of	divis	is
begin
process(clk50M)
variable cpt :integer range 0 to 2;
begin
if(clk50M'event and clk50M= '1')then
cpt:= cpt+1;
if cpt<1 then clk1hz <= '1';
	else if(cpt>=1 and cpt<2) then clk1hz<='0';
		else if cpt=2	then	cpt:=0;
				end	if;
				end	if;
				end	if;
				end	if;

end process;
end Behavioral;