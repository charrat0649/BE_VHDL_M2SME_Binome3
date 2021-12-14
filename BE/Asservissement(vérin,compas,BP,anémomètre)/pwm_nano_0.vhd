-- pwm_nano_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_nano_0 is
	port (
		clk          : in  std_logic                     := '0';             --          clock.clk
		reset_n      : in  std_logic                     := '0';             --          reset.reset_n
		freq         : in  std_logic_vector(15 downto 0) := (others => '0'); -- avalon_slave_0.writebyteenable_n
		duty         : in  std_logic_vector(15 downto 0) := (others => '0'); --               .writebyteenable_n
		out_pwm_nano : out std_logic                                         --    conduit_end.export
	);
end entity pwm_nano_0;

architecture rtl of pwm_nano_0 is
	component pwm_nano is
		port (
			clk          : in  std_logic                     := 'X';             -- clk
			reset_n      : in  std_logic                     := 'X';             -- reset_n
			freq         : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writebyteenable_n
			duty         : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writebyteenable_n
			out_pwm_nano : out std_logic                                         -- export
		);
	end component pwm_nano;

begin

	pwm_nano_0 : component pwm_nano
		port map (
			clk          => clk,          --          clock.clk
			reset_n      => reset_n,      --          reset.reset_n
			freq         => open,         -- avalon_slave_0.writebyteenable_n
			duty         => open,         --               .writebyteenable_n
			out_pwm_nano => out_pwm_nano  --    conduit_end.export
		);

end architecture rtl; -- of pwm_nano_0
