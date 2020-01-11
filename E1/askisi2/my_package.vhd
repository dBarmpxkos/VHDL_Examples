-------------------------------------------------------
-- Design Name : Askisi_2 [ 4bit binary counter ]
-- File Name   : my_package.vhd
-- Function    : D-FlipFlop Package
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

package my_package is
	procedure DFF
	(
		signal CLK, RST, D	: in std_logic;
		signal Q, notQ		: out std_logic
	);

end package;
-- /package header ------------------------------------

package body my_package is
	
	procedure DFF
	(
		signal CLK, RST, D	: in std_logic;
		signal Q, notQ		: out std_logic
	) is
	begin
	
		if RST = '0' then 
			Q <= '0';  
			notQ <= '1';
		elsif (CLK'event and CLK='1') then 
			Q <= D;
			notQ <= NOT D;
		end if;
		
	end DFF;
	-- /logic -----------------------------------------

end my_package;
-- /package body --------------------------------------
