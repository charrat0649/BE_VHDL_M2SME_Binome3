library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
 
entity PWM is
port ( clk :in std_logic;
period, duty : in unsigned (7 downto 0);
numero: out std_logic );
end PWM;
architecture bhv of PWM is
 
signal count: unsigned (7 downto 0) := "00000000";
 
begin

process(clk)

variable cpt : integer range 0 to 50000001;

begin

if(clk'event and clk='1') then
cpt := cpt + 1;
if cpt <= duty then
numero <= '1';
else if (cpt >= duty and cpt < period -1) then
numero <= '0';
else if cpt = period then cpt := 0;
end if;
end if;
end if;
end if;
end process;
end bhv;

