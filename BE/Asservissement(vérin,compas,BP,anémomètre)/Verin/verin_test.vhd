library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;


ENTITY verin_test IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		chipselect :  IN  STD_LOGIC;
		write_n :  IN  STD_LOGIC;
		reset_n :  IN  STD_LOGIC;
		data_in :  IN  STD_LOGIC;
		address :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		writedata :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		out_pwm :  OUT  STD_LOGIC;
		out_sens :  OUT  STD_LOGIC;
		cs_n :  OUT  STD_LOGIC;
		clk_adc :  OUT  STD_LOGIC;
		readdata :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END verin_test;

ARCHITECTURE bdf_type OF verin_test IS 
	signal cpt : std_logic_vector (15 downto 0);
	signal pwm, enable_pwm : std_logic;

	signal butee_g, butee_d , angle_barre: std_logic_vector (11 downto 0);
	signal sens, fin_course_d, fin_course_g : std_logic;

	signal raz_compteur, fin, s_clk_adc, clk_1M, start_conv : std_logic;
	signal compt_front : integer range 0 to 15;
	signal s_data :  std_logic_vector (11 downto 0);

	signal raz_n : std_logic;
	signal s_config : std_logic_vector (4 downto 0);
	signal s_freq, s_duty : std_logic_vector (15 downto 0);
BEGIN

--PWM----------------------------------------------------------------
divide: process (clk, raz_n)
	begin
	if raz_n = '0' then
	cpt <= (others => '0');
	elsif clk'event and clk = '1' then
		if cpt >= s_freq then
		cpt <= (others => '0');
		else
		cpt <= cpt + 1;
		end if;
	end if;
end process divide;	

compare: process (clk, raz_n)
	begin
	if raz_n = '0' then
	pwm <= '0';
	elsif clk'event and clk = '1' then
		if cpt >= s_duty then
		pwm <= '0';
		else
		pwm <= '1';
		end if;
	end if;
end process compare;

--Butées-------------------------------------------------------------
controle_butes: process (sens, butee_g, butee_d, angle_barre, pwm)
	begin
	if angle_barre >= butee_d then
		fin_course_d <= '1';
	else 
		fin_course_d <= '0';
	end if;
	if  angle_barre <= butee_g then
		fin_course_g <= '1';
	else 
		fin_course_g <= '0';
	end if;
end process controle_butes;
	out_pwm <= enable_pwm and pwm and (((not fin_course_g) and (not sens)) or ((not fin_course_d) and sens)) ;
	out_sens <= sens;

--Machine d'état-----------------------------------------------------
pilote_adc:	process (raz_n, clk_1M)
	variable etat_pilote:integer range 0 to 4;
	begin
	if raz_n='0' then
		etat_pilote:=0;
		cs_n<= '1';
		s_clk_adc <= '0';
		raz_compteur <= '1';
		angle_barre <= X"000";
	elsif clk_1M'event and clk_1M='1' then
		case etat_pilote is
		when 0 =>
			if start_conv='1' then 
				etat_pilote:=1;	
				cs_n <= '0';
				raz_compteur <= '0';
			end if;
		when 1 =>	
			etat_pilote:=2;
			s_clk_adc <= '1'; 
		when 2 =>	
			etat_pilote:=3;
			s_clk_adc <= '0';
		when 3 =>
			if fin='1' then 
				etat_pilote:=4;
				s_clk_adc <= '0';
				cs_n <= '1';
				angle_barre <= s_data;
			else etat_pilote := 2;
				s_clk_adc <= '1';	
			end if;	
		when 4 =>	
			if start_conv='0' then 
				etat_pilote:=0	;	
				cs_n <= '1';
				s_clk_adc <= '0';
				raz_compteur <= '1';
			end if;
		when others =>	
			etat_pilote :=0;
			s_clk_adc <= '0';
			cs_n <= '1';
		end case;
	end if;
	end process pilote_adc;
---------------------------------------------------------------------
compt_fronts: process (s_clk_adc, raz_compteur)
	begin
	if raz_compteur = '1' then
		compt_front <=0;
	elsif s_clk_adc'event and s_clk_adc='1' then
		if compt_front=14 then
			compt_front <= 0;
			fin <= '1';
		else
			compt_front <= compt_front +1;
			fin <= '0';
		end if;
	end if;
	end process compt_fronts;
---------------------------------------------------------------------
shift_reg: process (s_clk_adc)
	variable i: integer ;
	begin
	if s_clk_adc'event and s_clk_adc='1' then
	s_data(0) <= data_in ;
		For i in 1 to 11 loop
		s_data(i) <= s_data(i-1);
		end loop;
	End if ;
end process shift_reg;
---------------------------------------------------------------------
gene_1M:	process(clk,reset_n)
	variable count_gene_1M : integer range 0 to 25;	
	BEGIN
		if raz_n= '0' then
			count_gene_1M:=0;
		elsif clk'event and clk='1' then
			count_gene_1M:= count_gene_1M +1;
			if count_gene_1M =  24 then
				clk_1M <= not(clk_1M);
				count_gene_1M:= 0;
			end if;
		end if;	
	end process gene_1M;
---------------------------------------------------------------------	
gene_start_conv:	process(clk_1M,reset_n)
	variable count_conv : integer range 0 to 50000;	
	BEGIN
		if raz_n= '0' then
			count_conv:=0;
		elsif clk_1M'event and clk_1M='1' then
			count_conv:= count_conv +1;
			if count_conv =  49999 then
				start_conv <= not start_conv;
				count_conv:= 0;
			end if;
		end if;	
	end process gene_start_conv;
---------------------------------------------------------------------
	clk_adc <= s_clk_adc;
---------------------------------------------------------------------
process_write: process (clk, reset_n)
begin
	if reset_n = '0' then
		s_freq <= (others => '0');
		s_duty <= (others => '0');
		s_config <= (others => '0');
		butee_g <= (others => '0');
		butee_d <= (others => '0');
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			if address = "0000" then
				s_freq <= writedata(15 downto 0);
				s_duty <= writedata(31 downto 16);
			end if;
			if address = "0001" then
				butee_g <= writedata (11 downto 0);
				butee_d <= writedata (27 downto 16);
			end if;
			if address = "0010" then
				s_config(2 downto 0) <=  writedata(2 downto 0);
				s_config(3) <= fin_course_d;
				s_config(4) <= fin_course_g;
				raz_n <= s_config(0);
				enable_pwm <= s_config(1);
				sens <= s_config(2);

		end if;
	end if;
  end if;
end process;
-------------------------------------------------------------------------
precess_read: process(address, angle_barre, s_freq, s_duty, butee_g, butee_d, s_config)

BEGIN
	case address is
		when "0000" => readdata <= s_duty & s_freq ;
		when "0001" => readdata <= "0000" & butee_d & "0000" & butee_g ;
		when "0010" => readdata <= "000000000000000000000000000" & s_config ;
		when "0101" => readdata <= "00000000000000000000" & Angle_barre ;
		when others => readdata <= (others => '0');
	end case;

END PROCESS precess_read ;

END architecture ;