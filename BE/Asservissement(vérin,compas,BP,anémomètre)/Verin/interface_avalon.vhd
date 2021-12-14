library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity interface_avalon is
port ( 	clk, chipselect, write_n, reset_n, fd, fg: in std_logic;
			writedata : in std_logic_vector (31 downto 0);
			address: std_logic_vector (3 downto 0);
			readdata : out std_logic_vector (31 downto 0);
			butee_d, butee_g, freq, duty : out std_logic_vector (15 downto 0);
			angle_barre : in std_logic_vector (11 downto 0);
			raz_n, enable_pwm, sens : out std_logic
			);
end interface_avalon;
  
architecture bhv of interface_avalon is
  
  signal s_freq, s_duty, s_bg, s_bd : std_logic_vector (15 downto 0);
  signal s_config : std_logic_vector (4 downto 0);
begin
  
process_write: process (clk, reset_n)
begin
	if reset_n = '0' then
		freq <= (others => '0');
		duty <= (others => '0');
		s_config <= (others => '0');
		butee_g <= (others => '0');
		butee_d <= (others => '0');
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			if address = "0000" then
				freq <= writedata(15 downto 0);
				s_freq <=  writedata(15 downto 0);
				duty <= writedata(31 downto 16);
				s_duty <=  writedata(31 downto 16);
			end if;
			if address = "0001" then
				butee_g <= writedata (15 downto 0);
				s_bg <=  writedata(15 downto 0);
				butee_d <= writedata (31 downto 16);
				s_bd <=  writedata(31 downto 16);
			end if;
			if address = "0010" then
				s_config(2 downto 0) <=  writedata(2 downto 0);
				s_config(3) <= fd;
				s_config(4) <= fg;
				raz_n <= s_config(0);
				enable_pwm <= s_config(1);
				sens <= s_config(2);

		end if;
	end if;
  end if;
end process;
  
  
  
  
process_Read:
PROCESS(address, angle_barre, s_freq, s_duty, s_bg, s_bd, s_config)

BEGIN
	case address is
		when "0000" => readdata <= s_duty & s_freq ;
		when "0001" => readdata <= s_bd & s_bg ;
		when "0010" => readdata <= "000000000000000000000000000" & s_config ;
		when "0101" => readdata <= "00000000000000000000" & Angle_barre ;
		when others => readdata <= (others => '0');
	end case;

END PROCESS process_Read ;
  
end bhv;