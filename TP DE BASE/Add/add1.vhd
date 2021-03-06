Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity add1 is 
  port ( A,B,Cin : in std_logic;
         S,Cout  : out std_logic); 
end entity ;
  
architecture rb of add1 is 
   signal resultat : unsigned (1 downto 0);
   
begin 

      resultat <= ('0' & A)+('0' & Cin)+('0' & B);
      S <= resultat(0);
      Cout <= resultat(1);
      end rb;