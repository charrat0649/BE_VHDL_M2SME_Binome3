library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_register is
	Port (
		reg : out std_logic_vector(11 downto 0);
		sig : in std_logic;
		cs_n : in std_logic;
		clk_1mhz : in std_logic
	);
end shift_register;

architecture behavioral of shift_register is
	signal shift_reg, shift_next : std_logic_vector(11 downto 0);
	signal adc_data_reg : std_logic_vector(11 downto 0);

	
begin
	
	------ A/D shift register
	process(clk_1mhz)
	begin            -- clocked on falling edge bclk - middle of data bit
		if (clk_1mhz'event and clk_1mhz='0') then
			shift_reg <= shift_next;
		end if;
	end process;
	shift_next <= shift_reg(10 downto 0) & sig;
	
	------ A/D data holding register
	process(clk_1mhz, cs_n)
	begin
		if (clk_1mhz'event and clk_1mhz='1') then
				if cs_n = '1' then
				adc_data_reg <= shift_reg;
				end if;
		end if;
	end process;
	reg <= adc_data_reg;
end behavioral;