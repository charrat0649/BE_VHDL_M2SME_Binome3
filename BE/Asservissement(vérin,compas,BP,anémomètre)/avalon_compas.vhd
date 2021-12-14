library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity avalon_compas is
port (
clk, chipselect, write_n, address, reset_n : in std_logic;
in_pwm_compas : in std_logic;
writedata : in std_logic_vector (31 downto 0);
readdata : out std_logic_vector (31 downto 0)
);
end entity;

ARCHITECTURE arch_avalon_compas of avalon_compas IS
signal compas : std_logic_vector (8 downto 0);
signal continu, start_stop, rst_n : std_logic;
signal config : std_logic_vector (2 downto 0);
signal clk_10K: std_logic;
signal clk_1Hz, val_compt, valid_data, fin_mesure, pwm_compas: std_logic;
signal sig_duree, valeur_compas : std_logic_vector (8 downto 0);


BEGIN

--*********************************************************************	
-- génération 10KHz (rapport cyclique=50%)
--*********************************************************************
gene_10K:	process(clk,rst_n)
	variable count : integer range 0 to 2500;	
	BEGIN
		if rst_n= '0' then
			count:=0; clk_10K <= '0';
		elsif clk'event and clk='1' then
			count:= count +1;
			if count =  2499 then
				clk_10K <= not clk_10K;
				count:= 0;
			end if;
		end if;	
	end process gene_10K;
--*********************************************************************


--*********************************************************************	
-- synchronisation du signal pwm
--*********************************************************************
synchro_pwm:	process(clk_10K,rst_n)	
	BEGIN
		if rst_n= '0' then
			pwm_compas <= '0';
		elsif clk_10K'event and clk_10K='0' then
				pwm_compas <= in_pwm_compas;
		end if;	
	end process synchro_pwm;
--*********************************************************************


--*******************************************************************	
--génération  du top seconde (rc=50%)
--*******************************************************************
top_1s:	process(clk_10K,rst_n)
    variable count : integer range 0 to 5000;	
	BEGIN
		if rst_n= '0' then
			count:= 0;
		elsif clk_10K'event and clk_10K='1' then
			count:= count +1;
			if count = 4999 then
				clk_1Hz <= not clk_1Hz;
				count:= 0;
			end if;
		end if;	
	end process top_1s;
--*********************************************************************
rst_n <= config(0);
continu <= config(1);
start_stop <= config(2);


--********************************************************************
--séquencement de la mesure compas
--********************************************************************
seq_mes:process (rst_n, clk)
variable etat : integer range 0 to 4;
begin
	if rst_n ='0' then
	etat:= 0;
	val_compt <= '0';valid_data<='0';
	elsif clk'event and clk='1' then
	case etat is
	when 0 =>
		if continu ='0' then 
			if start_stop='1' and pwm_compas='0' then
			etat:=1; val_compt <= '1';
			end if;
		else
			if clk_1Hz = '1' and pwm_compas='0' then 
			etat:=3; val_compt <= '1';
			end if;
		end if;
	when 1 =>
		if fin_mesure='1' then 
		etat:=2; val_compt <= '0'; valid_data<='1';
		end if;
	when 2 =>
		if start_stop='0' then 
		etat:=0; val_compt <= '0'; valid_data<='0';
		end if;
	when 3 =>
		if fin_mesure='1' then 
			etat:=4; val_compt <= '0'; valid_data<='1';
		end if;
	when 4 =>
		if clk_1Hz = '0' then 
			etat:=0; val_compt <= '0'; valid_data<='0';
		end if;
	end case;
	end if;
	end process seq_mes;
--********************************************************************



--*********************************************************************	
-- comptage durée état haut de pwm_compas
--*********************************************************************
duree_pwm:	process(clk_10K,rst_n)	
	BEGIN
		if rst_n= '0' then
		sig_duree <= "000000000";	
		elsif clk_10K'event and clk_10K ='1' then
			if val_compt ='1' then 
				if pwm_compas = '1' then
				sig_duree <= sig_duree + "000000001";
				end if;
			else sig_duree <= "000000000";
			end if;
		end if;	
	end process duree_pwm;
--*********************************************************************



--*********************************************************************	
-- mémorisation des données compas
--*********************************************************************
memo_data:	process(pwm_compas, val_compt, rst_n)	
	BEGIN
		if rst_n= '0' then
		valeur_compas <= "000000000";
		elsif val_compt='0' then 
		fin_mesure <= '0';	
		elsif pwm_compas'event and pwm_compas ='0' then
		valeur_compas <= sig_duree;
		fin_mesure <= '1';
		end if;	
	end process memo_data;
--*********************************************************************


--*********************************************************************
--  interface avalon
--*********************************************************************

registers: process (clk, reset_n)
begin
	if reset_n = '0' then
	config <= (others => '0');
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			if address = '0' then
			config <= (writedata (2 downto 0));
			end if;
		end if;
	end if;
end process registers;
--readdata(2 downto 0) <= config when address = '0' else readdata(9 downto 0) <= valid_data&valeur_compas ;
readdata <= X"0000000"&"0"&config when address = '0' else X"00000"&"00"&valid_data&valeur_compas ;
END arch_avalon_compas;