library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity FA is
	port
	(
		i_a, i_b, i_carry	: in std_logic;
		o_carry, o_sum		: out std_logic
	);
end FA;

architecture FA_arch of FA is
begin
	o_sum 	<= i_a XOR i_b XOR i_carry;
	o_carry <= ((i_a XOR i_b) AND i_carry) OR (i_a AND i_b);
end FA_arch;