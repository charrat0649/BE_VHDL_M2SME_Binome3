library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity pwm_nano is
port (
clk, reset_n : in std_logic;
freq, duty : in std_logic_vector (15 downto 0);
out_pwm_nano : out std_logic
);
end entity;
ARCHITECTURE arch_pwm_nano of pwm_nano IS
-- signaux relatifs au circuit gestion pwm_nano
signal counter : std_logic_vector (15 downto 0);
signal pwm_nano_on : std_logic;
BEGIN
--0000000000000000000000000000000000000000000000000000
-- circuit de gestion de la pwm_nano
--****************************************************
-- fixe la fréquence de la pwm_nano
--*****************************************************
divide: process (clk, reset_n)
begin
if reset_n = '0' then
counter <= (others => '0');
elsif clk'event and clk = '1' then
if counter >= freq then
counter <= (others => '0');
else
counter <= counter + 1;
end if;
end if;
end process divide;
--******************************************************
--******************************************************
--génère le rapport cyclique
--******************************************************
compare: process (clk, reset_n)
begin
if reset_n = '0' then
pwm_nano_on <= '0';
elsif clk'event and clk = '1' then
if counter >= duty then
pwm_nano_on <= '0';
else
pwm_nano_on <= '1';
end if;
end if;
end process compare;
--*******************************************************
--0000000000000000000000000000000000000000000000000000000
out_pwm_nano <= pwm_nano_on;
--**************************************************************
END arch_pwm_nano ;