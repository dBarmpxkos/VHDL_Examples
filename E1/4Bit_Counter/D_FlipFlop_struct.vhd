-------------------------------------------------------
-- Design Name : Askisi_2 [ 4bit binary counter ]
-- File Name   : D_FlipFlop_struc.vhd
-- Function    : D_FlipFlop structural block
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity D_FlipFlop_struc is
port 
	(
		CLK, RST, D	: in std_logic;
		Q, notQ		: out std_logic
	);
end D_FlipFlop_struc;
-- /entity --------------------------------------------

architecture D_FlipFlop_struc_arch of D_FlipFlop_struc is
begin
	
	process (CLK, RST) is
	begin
		if RST = '0' then 
			Q <= '0';  
			notQ <= '1';
		elsif (CLK'event and CLK='1') then 
			Q <= D;
			notQ <= NOT D;
		end if;
	end process;
	-- /logic -----------------------------------------
		
end D_FlipFlop_struc_arch;
-- /architecture --------------------------------------
