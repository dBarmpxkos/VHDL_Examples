-------------------------------------------------------
-- Design Name : Askisi_1 [ Skip-carry full adder ]
-- File Name   : FA1bit.vhd
-- Function    : 1bit full adder structural design
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity FA1bit is 
port (
	A_1bitFA, B_1bitFA, Cin_1bitFA	: in std_logic;
	Sum_1bitFA, Cout_1bitFA			: out std_logic
);
end FA1bit;
-- /entity --------------------------------------------

architecture structure of FA1bit is
	-- one signal for each NOR2 output
	signal io : std_logic_vector(9 downto 0) := (others => '0');
	
begin

	io(0)	<= A_1bitFA NOR A_1bitFA;
	io(1)	<= A_1bitFA NOR B_1bitFA;
	io(2)	<= B_1bitFA NOR B_1bitFA;
	io(3)	<= io(0) NOR io(2);
	io(4)	<= io(3) NOR io(1);
	io(5)	<= io(4) NOR io(4);
	io(6)	<= io(4) NOR Cin_1bitFA;
	io(7)	<= Cin_1bitFA NOR Cin_1bitFA;
	io(8)	<= io(5) NOR io(7);
	io(9)	<= io(3) NOR io(8);
	Sum_1bitFA	<= io(8) NOR io(6);
	Cout_1bitFA	<= io(9) NOR io(9);
	-- /logic -----------------------------------------

end structure;
-- /architecture --------------------------------------
