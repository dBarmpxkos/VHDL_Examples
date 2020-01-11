library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity HA is
	port
	(
		i_a, i_b		: in std_logic;
		o_carry, o_sum	: out std_logic
	);
end HA;

architecture HA_arch of HA is
begin
	o_sum 	<= i_a XOR i_b;
	o_carry <= i_a AND i_b;	
end HA_arch;