-- verin_test_0.vhd

-- This file was auto-generated as part of a SOPC Builder generate operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity verin_test_0 is
	port (
		clk        : in  std_logic                     := '0';             --          clock.clk
		chipselect : in  std_logic                     := '0';             -- avalon_slave_0.chipselect
		write_n    : in  std_logic                     := '0';             --               .write_n
		address    : in  std_logic_vector(3 downto 0)  := (others => '0'); --               .address
		writedata  : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		readdata   : out std_logic_vector(31 downto 0);                    --               .readdata
		reset_n    : in  std_logic                     := '0';             --          reset.reset_n
		out_sens   : out std_logic;                                        --    conduit_end.export
		out_pwm    : out std_logic;                                        --  conduit_end_1.export
		cs_n       : out std_logic;                                        --  conduit_end_2.export
		clk_adc    : out std_logic;                                        --  conduit_end_3.export
		data_in    : in  std_logic                     := '0'              --  conduit_end_4.export
	);
end entity verin_test_0;

architecture rtl of verin_test_0 is
	component verin_test is
		port (
			clk        : in  std_logic                     := 'X';             -- clk
			chipselect : in  std_logic                     := 'X';             -- chipselect
			write_n    : in  std_logic                     := 'X';             -- write_n
			address    : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- address
			writedata  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			readdata   : out std_logic_vector(31 downto 0);                    -- readdata
			reset_n    : in  std_logic                     := 'X';             -- reset_n
			out_sens   : out std_logic;                                        -- export
			out_pwm    : out std_logic;                                        -- export
			cs_n       : out std_logic;                                        -- export
			clk_adc    : out std_logic;                                        -- export
			data_in    : in  std_logic                     := 'X'              -- export
		);
	end component verin_test;

begin

	verin_test_0 : component verin_test
		port map (
			clk        => clk,        --          clock.clk
			chipselect => chipselect, -- avalon_slave_0.chipselect
			write_n    => write_n,    --               .write_n
			address    => address,    --               .address
			writedata  => writedata,  --               .writedata
			readdata   => readdata,   --               .readdata
			reset_n    => reset_n,    --          reset.reset_n
			out_sens   => out_sens,   --    conduit_end.export
			out_pwm    => out_pwm,    --  conduit_end_1.export
			cs_n       => cs_n,       --  conduit_end_2.export
			clk_adc    => clk_adc,    --  conduit_end_3.export
			data_in    => data_in     --  conduit_end_4.export
		);

end architecture rtl; -- of verin_test_0
