-------------------------------------------------------
-- Design Name : Askisi_1 [ Skip-carry full adder ]
-- File Name   : adderBypass4.vhd
-- Function    : Structural 4bit adder with skip-carry
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity adderBypass4 is 
port (
	A_In, B_In	: in std_logic_vector(3 downto 0);
	Cin  		: in std_logic;
	S    		: out std_logic_vector(3 downto 0);
	Cout 		: out std_logic
	);
end adderBypass4;
-- /entity --------------------------------------------

architecture structural of adderBypass4 is 
	
	component FA1bit is 
	port (
		A_1bitFA, B_1bitFA, Cin_1bitFA : in std_logic;
		Sum_1bitFA, Cout_1bitFA : out std_logic
	); 
	end component;
	
	component carryMux2t1 is
	port (
		A_cMux2t1, B_cMux2t1, Sel_cMux2t1 : in std_logic;
		Z_cMux2t1 : out std_logic
	); 
	end component;
-- /components ------------------
	
	-- P is XOR results, carryTemp is FAs'1bit results
	signal P, carryTemp : std_logic_vector(3 downto 0);
	signal and_out      : std_logic;

begin 

	P(3) <= A_In(3) XOR B_In(3);
	P(2) <= A_In(2) XOR B_In(2);
	P(1) <= A_In(1) XOR B_In(1);
	P(0) <= A_In(0) XOR B_In(0);
	
	and_out <= (P(0) AND P(1) AND P(2) AND P(3));
	
	carryMux2t1_0 : carryMux2t1 port map (
		A_cMux2t1 => carryTemp(3),
		B_cMux2t1 => Cin,
		Sel_cMux2t1 => and_out,
		Z_cMux2t1 => Cout
	);

	FA1bit_0 : FA1bit port map (
		A_1bitFA => A_In(3),
		B_1bitFA => B_In(3),
		Cin_1bitFA => Cin,
		Sum_1bitFA => S(3),
		Cout_1bitFA => carryTemp(0)
	);
	
	FA1bit_1 : FA1bit port map (
		A_1bitFA => A_In(2),
		B_1bitFA => B_In(2),
		Cin_1bitFA => carryTemp(0),
		Sum_1bitFA => S(2),
		Cout_1bitFA => carryTemp(1)
	);
	
	FA1bit_2 : FA1bit port map (
		A_1bitFA => A_In(1),
		B_1bitFA => B_In(1),
		Cin_1bitFA => carryTemp(1),
		Sum_1bitFA => S(1),
		Cout_1bitFA => carryTemp(2)
	);
	
	FA1bit_3 : FA1bit port map (
		A_1bitFA => A_In(0),
		B_1bitFA => B_In(0),
		Cin_1bitFA => carryTemp(2),
		Sum_1bitFA => S(0),
		Cout_1bitFA => carryTemp(3)
	);
	-- /logic -----------------------------------------

end structural;
-- /architecture --------------------------------------