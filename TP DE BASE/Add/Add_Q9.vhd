Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity add_Q9 is
       port ( A,B,Cin : in std_logic;
             S,Cout: out std_logic;
             );
             end entity;


arichtecture arc of add_Q9 is
   singal res :unsigned(1 downto 0);
 
 begin 
  
 res <=('0' & a)+('0'& b)+ ('0' &cin);
 s   <=res(0);
 cout <=res(1);
 
 end arc;

 