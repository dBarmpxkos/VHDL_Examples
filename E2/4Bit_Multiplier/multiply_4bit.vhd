library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all ; 
    use ieee.std_logic_arith.all ;

entity multiply_4bit is 
port (
	i_GPIO_2	: inout std_logic_vector(7 downto 0);
	o_LEDA	: out std_logic_vector(7 downto 0)
); end multiply_4bit;

architecture struct of multiply_4bit is

	component FA is
	port (
		i_a, i_b, i_carry	: in std_logic;
		o_carry, o_sum		: out std_logic
	); end component;
	
	component HA is
	port (
		i_a, i_b		: in std_logic;
		o_carry, o_sum	: out std_logic
	); end component;
	
	signal s_A 		: std_logic_vector(3 downto 0) := (others => '0');
	signal s_B		: std_logic_vector(3 downto 0) := (others => '0');
	signal s_sums	: std_logic_vector(11 downto 0) := (others => '0');
	signal s_carries: std_logic_vector(11 downto 0) := (others => '0');

begin -- architecture begin

	s_A <= i_GPIO_2(3 downto 0); -- A_inputs
	s_B <= i_GPIO_2(7 downto 4); -- B_inputs
	
	-- HA: [i_A, i_B, o_carry, o_sum]
	-- FA: [i_A, i_B, i_carry, o_carry, o_sum]

	-- ------------------------- first row
	HA0 : HA port map (s_A(1) AND s_B(0), s_A(0) AND s_B(1), s_carries(0), s_sums(0));
	FA0 : FA port map (s_A(2) AND s_B(0), s_A(1) AND s_B(1), s_carries(0), s_carries(1), s_sums(1));
	FA1 : FA port map (s_A(3) AND s_B(0), s_A(2) AND s_B(1), s_carries(1), s_carries(2), s_sums(2));
	HA1 : HA port map (s_A(3) AND s_B(1), s_carries(2), s_carries(3), s_sums(3));
	-- ------------------------- first row
	
	-- ------------------------- second row 
	HA2 : HA port map (s_A(0) AND s_B(2), s_sums(1), s_carries(4), s_sums(4));
	FA3 : FA port map (s_A(1) AND s_B(2), s_sums(2), s_carries(4), s_carries(5), s_sums(5));
	FA4 : FA port map (s_A(2) AND s_B(2), s_sums(3), s_carries(5), s_carries(6), s_sums(6));
	FA5 : FA port map (s_A(3) AND s_B(2), s_carries(3), s_carries(6), s_carries(7), s_sums(7));
	-- ------------------------- second row 
	
	-- ------------------------- third row 
	HA3 : HA port map (s_A(0) AND s_B(3), s_sums(5), s_carries(8), s_sums(8));
	FA6 : FA port map (s_A(1) AND s_B(3), s_sums(6), s_carries(8), s_carries(9), s_sums(9));
	FA7 : FA port map (s_A(2) AND s_B(3), s_sums(7), s_carries(9), s_carries(10), s_sums(10));
	FA8 : FA port map (s_A(3) AND s_B(3), s_carries(7), s_carries(10), s_carries(11), s_sums(11));
	-- ------------------------- third row 

	o_LEDA(0) <= s_A(0) AND s_B(0);
	o_LEDA(1) <= s_sums(0);
	o_LEDA(2) <= s_sums(4);
	o_LEDA(3) <= s_sums(8);
	o_LEDA(4) <= s_sums(9);
	o_LEDA(5) <= s_sums(10);
	o_LEDA(6) <= s_sums(11);
	o_LEDA(7) <= s_carries(11);
	
END struct;

