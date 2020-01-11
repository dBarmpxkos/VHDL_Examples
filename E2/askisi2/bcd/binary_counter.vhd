library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity binary_counter is 
port (
	i_EN	: in std_logic;
	i_LOAD	: in std_logic;
	i_CLK	: in std_logic;
	i_RST	: in std_logic;
	i_D		 : in std_logic_vector(3 downto 0);
	o_CARRY	 : out std_logic;
	o_OUTS	 : out std_logic_vector(3 downto 0)
);
end binary_counter;

architecture structural of binary_counter is

	component mux_2x1 is
	port ( 	i_A, i_B : in std_logic;
			i_muxSEL : in std_logic;
			o_muxO   : out std_logic
	); end component;
	
	component D_FF is
	port (	i_D   : in std_logic;
			i_CKL_ff : in std_logic;
			i_RST_n	 : in std_logic;
			o_Q   : out std_logic
	); end component;
	
	signal w_ANDs_o : std_logic_vector(3 downto 0) := (others => '0');	-- maps to AND outs
	signal w_XORs_o : std_logic_vector(3 downto 0) := (others => '0');	-- maps to XOR outs
	signal w_MUXs_o : std_logic_vector(3 downto 0) := (others => '0');	-- maps to mux outs
	signal w_outs_o : std_logic_vector(3 downto 0) := (others => '0'); 	-- maps to output
	
begin

	GEN_BLOX: for i in 0 to 3 generate -- generate 2x1 Multiplexers & D-FFs
		MUXx : mux_2x1 port map (w_XORs_o(i), i_D(i), i_LOAD, w_MUXs_o(i)); -- mux pins: [A, B, SEL, OUT]
		DFFx : D_FF port map (w_MUXs_o(i), i_CLK, i_RST, w_outs_o(i));		  -- DFF pins: [D, CLK, RST, Q]
	end generate GEN_BLOX; -- ---------------------------------------------
		
	w_ANDs_o(0) <= i_EN AND w_outs_o(0); -- generate ANDs & XORs 
	w_XORs_o(0) <= i_EN XOR w_outs_o(0);                      --
	GEN_LOGIC : for i in 1 to 3 generate                      --
		w_ANDs_o(i) <= w_ANDs_o(i-1) AND w_outs_o(i);          --
		w_XORs_o(i) <= w_ANDs_o(i-1) XOR w_outs_o(i);          --
	end generate GEN_LOGIC; ------------------------------------
	
	o_CARRY <= w_ANDs_o(3);
	o_OUTS <= w_outs_o;
	
end structural;
		

