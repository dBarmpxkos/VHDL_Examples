-------------------------------------------------------
-- Design Name : Askisi_2 [ 4bit binary counter ]
-- File Name   : counter4_struct.vhd
-- Function    : 4bit binary counter using 
--				 structural design
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity counter4_struct is
port (
	CLK, RST : in std_logic;
	Output   : out std_logic_vector(7 downto 0);
	D, notD	 : out std_logic_vector(3 downto 0)
);
end counter4_struct;
-- /entity --------------------------------------------

architecture dff_struct of counter4_struct is
	
	component D_FlipFlop_struc is
	port 
		(
			CLK, RST, D	: in std_logic;
			Q, notQ		: out std_logic
		);
	end component;
	
	signal Qs, notQs : std_logic_vector(3 downto 0) := (others => '0');
	signal Outputs : std_logic_vector(7 downto 0) := (others => '0');
	
begin 

	-- DFF structural
	-- port mapping is CLK, RST, D, Q, Qbar
	dff_inst0: D_FlipFlop_struc port map(CLK, RST, notQs(3), Qs(0), notQs(0));
	dff_inst1: D_FlipFlop_struc port map(CLK, RST, Qs(0), 	Qs(1), notQs(1));
	dff_inst2: D_FlipFlop_struc port map(CLK, RST, Qs(1),	Qs(2), notQs(2));
	dff_inst3: D_FlipFlop_struc port map(CLK, RST, Qs(2),	Qs(3), notQs(3));
	
	Outputs(0) <= (NOT Qs(3)) 	AND (NOT Qs(0));
	Outputs(1) <= (NOT notQs(0)) AND (NOT Qs(1));
	Outputs(2) <= (NOT notQs(1)) AND (NOT Qs(2));
	Outputs(3) <= (NOT notQs(2)) AND (NOT Qs(3));
	
	Outputs(4) <= (NOT notQs(3)) AND (NOT notQs(0));
	Outputs(5) <= (NOT notQs(1)) AND (NOT Qs(0));
	Outputs(6) <= (NOT notQs(2)) AND (NOT Qs(1));
	Outputs(7) <= (NOT notQs(3)) AND (NOT Qs(2));

	Output <= Outputs;
	-- /logic -----------------------------------------

end dff_struct;
-- /architecture --------------------------------------
