-------------------------------------------------------
-- Design Name : Askisi_2 [ 4bit binary counter ]
-- File Name   : counter4.vhd
-- Function    : 4bit binary counter using 
-- 				 custom D FlipFlop package
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
library work;
	use work.all;
	use work.my_package.all;
-- /libraries -----------------------------------------

entity counter4 is
port (
	CLK, RST : in std_logic;
	Output   : out std_logic_vector(7 downto 0)
);
end counter4;
-- /entity --------------------------------------------

architecture struct of counter4 is
	
	signal Qs, notQs : std_logic_vector(3 downto 0) := (others => '0');
	signal Outputs : std_logic_vector(7 downto 0) := (others => '0');
	
begin 

	-- DFF is defined in my_package
	DFF(CLK, RST, notQs(3), Qs(0), notQs(0));
	DFF(CLK, RST, Qs(0), 	Qs(1), notQs(1));
	DFF(CLK, RST, Qs(1),	Qs(2), notQs(2));
	DFF(CLK, RST, Qs(2),	Qs(3), notQs(3));
	
	process (CLK, RST, Qs, notQs) is
	begin
	
		Outputs(0) <= (NOT Qs(3)) 	AND (NOT Qs(0));
		Outputs(1) <= (NOT notQs(0)) AND (NOT Qs(1));
		Outputs(2) <= (NOT notQs(1)) AND (NOT Qs(2));
		Outputs(3) <= (NOT notQs(2)) AND (NOT Qs(3));
		
		Outputs(4) <= (NOT notQs(3)) AND (NOT notQs(0));
		Outputs(5) <= (NOT notQs(1)) AND (NOT Qs(0));
		Outputs(6) <= (NOT notQs(2)) AND (NOT Qs(1));
		Outputs(7) <= (NOT notQs(3)) AND (NOT Qs(2));

	end process;
	
	Output <= Outputs;
	-- /logic -----------------------------------------

end struct;
-- /architecture --------------------------------------
