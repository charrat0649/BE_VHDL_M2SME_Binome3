LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY gestion_anemometre IS 
	PORT
	(
		clk, chipselect, write_n, reset_n : in std_logic;
		writedata : in std_logic_vector (31 downto 0);
		readdata : out std_logic_vector (31 downto 0);
		address: std_logic_vector (1 downto 0);
		internal_reset : out std_logic;
		in_freq_anemometre :  IN  STD_LOGIC
	);
END gestion_anemometre;


ARCHITECTURE bdf_type OF gestion_anemometre IS 

COMPONENT counter
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 counter : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT div_frq_1hz
	PORT(clk : IN STD_LOGIC;
		 clk_1hz : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT choix_mode
	PORT(clk : IN STD_LOGIC;
		 continu : IN STD_LOGIC;
		 start_stop : IN STD_LOGIC;
		 internal_reset : IN STD_LOGIC;
		 data_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 data_valid : OUT STD_LOGIC;
		 data_anemometre : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT edge_detect
	PORT(clk : IN STD_LOGIC;
		 f_in : IN STD_LOGIC;
		 reset : OUT STD_LOGIC
	);
END COMPONENT;


SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL   config : std_logic_vector (31 downto 0);
SIGNAL   start_stop_tmp, continu_tmp, raz_n_tmp, data_valid : std_logic;
Signal   data_anem : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN 
internal_reset <= SYNTHESIZED_WIRE_6;

b2v_inst : counter
PORT MAP(clk => in_freq_anemometre,
		 reset => SYNTHESIZED_WIRE_0,
		 counter => SYNTHESIZED_WIRE_2);
b2v_inst1 : div_frq_1hz

PORT MAP(clk => clk,
		 clk_1hz => SYNTHESIZED_WIRE_5);
b2v_inst4 : choix_mode

PORT MAP(clk => clk,
		 continu => continu_tmp,
		 start_stop => start_stop_tmp,
		 internal_reset => SYNTHESIZED_WIRE_6,
		 data_in => SYNTHESIZED_WIRE_2,
		 data_valid => data_valid,
		 data_anemometre => data_anem);
		 
SYNTHESIZED_WIRE_0 <= SYNTHESIZED_WIRE_3 OR SYNTHESIZED_WIRE_6;

b2v_inst6 : edge_detect
PORT MAP(clk => clk,
		 f_in => SYNTHESIZED_WIRE_5,
		 reset => SYNTHESIZED_WIRE_6);
SYNTHESIZED_WIRE_3 <= NOT(raz_n_tmp);


-- écriture registres
process_write: process (clk, reset_n)
begin
	if reset_n = '0' then
	elsif clk'event and clk = '1' then
		if chipselect ='1' and write_n = '0' then
			config <= writedata;
			start_stop_tmp <= config(2);
			continu_tmp <= config(1);
			raz_n_tmp <= config(0);
		end if;
	end if;
end process;


-- lecture registres
process_Read:
PROCESS(data_valid, data_anem)
BEGIN
	readdata <= "0000000000000000000000"& data_valid & '0' & data_anem;
END PROCESS process_Read ;



END bdf_type;