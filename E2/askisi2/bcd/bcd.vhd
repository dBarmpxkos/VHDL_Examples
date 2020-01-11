library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity bcd is 
port (
	i_CLK_board	: in std_logic;
	i_EN_bcd	: in std_logic;
	i_LOAD_bcd	: in std_logic;
	i_RST_bcd	: in std_logic;
	i_Ds_bcd	: in std_logic_vector(3 downto 0);
	-- ---------------------------------------
	o_CARRY_bcd	: out std_logic;
	o_Qs_bcd	: out std_logic_vector(3 downto 0);
	o_clk_DEBUG : out std_logic;
	o_SEGDRIVER_bcd : out std_logic_vector(7 downto 0)
);
end bcd;

architecture structural of bcd is

	component clock_divider is
	port (	i_clk	: in std_logic;
			o_clk	: out std_logic
	); end component;
	
	component binary_counter is
	port (	i_EN	: in std_logic;
			i_LOAD	: in std_logic;
			i_CLK	: in std_logic;
			i_RST	: in std_logic;
			i_D		: in std_logic_vector(3 downto 0);
			o_CARRY	: out std_logic;
			o_OUTS	: out std_logic_vector(3 downto 0)
	); end component;
	
	
	signal w_LD_OR, w_LD_AND, w_CLK_o : std_logic := '0'; -- temp signals
	signal w_buffer 	: std_logic_vector(3 downto 0) := (others => '0');
	signal w_SEGDRIVER_buffer : std_logic_vector(7 downto 0) := (others => '0');
	
	-- hardcoded values for BCD 
	signal w_Ds 	: std_logic_vector(3 downto 0) := (others => '0');
	signal w_EN 	: std_logic := '1';
	signal w_RST 	: std_logic := '0';
	signal w_LOAD 	: std_logic := '0';
	-- ------------------------
	
begin

	clock_divider_0 : clock_divider port map (i_CLK_board, w_CLK_o);
	binary_counter_0: binary_counter port map (
		w_EN, w_LD_OR, w_CLK_o, w_RST, w_Ds, o_CARRY_bcd, w_buffer);
	
	w_LD_AND <= w_buffer(0) AND w_buffer(3);
	w_LD_OR <= w_LOAD OR w_LD_AND;
		
	with w_buffer select  --.gfedcba
		w_SEGDRIVER_buffer <= "00111111" when "0000",
							  "00000110" when "0001",
							  "01011011" when "0010",
							  "01001111" when "0011",
							  "01100110" when "0100",
							  "01101101" when "0101",
							  "01111101" when "0110",
							  "00000111" when "0111",
							  "01111111" when "1000",
							  "01101111" when "1001",				 
							  "10000000" when others;
	
	-- map to hardware 
	o_Qs_bcd <= w_buffer;
	o_SEGDRIVER_bcd <= w_SEGDRIVER_buffer;
	o_clk_DEBUG <= w_CLK_o;
	
end structural;

	
	
