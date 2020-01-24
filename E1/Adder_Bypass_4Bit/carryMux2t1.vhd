-------------------------------------------------------
-- Design Name : Askisi_1 [ Skip-carry full adder ]
-- File Name   : carryMux2t1.vhd
-- Function    : 2x1 Multiplexer block for adderBypass4
--				 Sel_cMux2t1 is controlled by carry AND result
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity carryMux2t1 is
port (
	A_cMux2t1, B_cMux2t1, Sel_cMux2t1 : in std_logic;
	Z_cMux2t1 : out std_logic
	);
end carryMux2t1;
-- /entity --------------------------------------------

architecture struct of carryMux2t1 is
	
	signal A_io, B_io : std_logic;

begin 

	A_io <= A_cMux2t1 AND (NOT (Sel_cMux2t1));
	B_io <= B_cMux2t1 AND Sel_cMux2t1;
	Z_cMux2t1 <= A_io OR B_io;
	-- /logic -----------------------------------------

end struct;
-- /architecture --------------------------------------