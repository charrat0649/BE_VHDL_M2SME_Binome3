-- avalon_pwm_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity avalon_pwm_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		address    : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .address
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		out_pwm    : out std_logic                                         --    conduit_end.export
	);
end entity avalon_pwm_0;

architecture rtl of avalon_pwm_0 is
	component avalon_pwm is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			address    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			out_pwm    : out std_logic                                         -- export
		);
	end component avalon_pwm;

begin

	avalon_pwm_0 : component avalon_pwm
		port map (
			clk        => clk,        --          clock.clk
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			writedata  => writedata,  --               .writedata
			readdata   => readdata,   --               .readdata
			address    => address,    --               .address
			reset_n    => reset_n,    --          reset.reset_n
			out_pwm    => out_pwm     --    conduit_end.export
		);

end architecture rtl; -- of avalon_pwm_0
