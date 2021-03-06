library IEEE;
	use IEEE.std_logic_1164.all;
-- affectation des sorties d?codeur 7 segments
-- segment   a b c d e f g
-- bit data    0 1 2 3 4 5 6

-- Description du bo?tier "bcd_7s"
ENTITY aff7seg IS
port(
			ad: in std_logic_vector (3 downto 0); 
			data : out std_logic_vector (6 downto 0)
			);
end aff7seg;

-- description de l'architecture
ARCHITECTURE arch_aff7seg of aff7seg is
begin 		
process (ad)
begin
		case ad is
		when "0000" =>	data <= "1000000"; -- affichage de 0
		when "0001" => 	data <= "1111001"; -- affichage de 1
		when "0010" =>	data <= "0100100"; -- affichage de 2
		when "0011" =>	data <= "0110000"; -- affichage de 3
		when "0100" =>	data <= "0011001"; -- affichage de 4
		when "0101" =>	data <= "0010010"; -- affichage de 5
		when "0110" =>	data <= "0000010"; -- affichage de 6
		when "0111" =>	data <= "1111000"; -- affichage de 7
		when "1000" =>	data <= "0000000"; -- affichage de 8
		when "1001" =>	data <= "0010000"; -- affichage de 9
		when others =>	data <= "1111111";
		end case;
end process;
END arch_aff7seg;	