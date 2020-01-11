library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity mux_2x1 is
port (
	i_A, i_B : in std_logic;
	i_muxSEL : in std_logic;
	o_muxO   : out std_logic
);
end mux_2x1;

architecture behavioral of mux_2x1 is

begin
	process (i_A, i_B, i_muxSEL) begin
		if i_muxSEL = '0' then o_muxO <= i_A;
		else o_muxO <= i_B;
		end if;
	end process;
end behavioral;

