-------------------------------------------------------
-- Design Name : Askisi_3 [ function generator ]
-- File Name   : funFSM_tb.vhd
-- Function    : State Machine with HIGH/LOW (3To/4To)
--				 Tests RST issuing and 3To/4To output
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library IEEE;
   use IEEE.std_logic_1164.all;
library work;
   use work.all;
-- /libraries -----------------------------------------

entity funFSM_tb is
end funFSM_tb;
-- /entity --------------------------------------------

architecture funFSM_arch_tb of funFSM_tb is

	component funFSM is 
	port (
		CLK, RST : in std_logic;
		OUTPUT   : out std_logic;
		Y		 : out std_logic_vector(1 downto 0) -- state output
	);
	end component;   
	
	-- signals / variables ----------------------------
	signal clock, outPutz: std_logic;
	signal rst			 : std_logic :='0';
	signal states_encoded : std_logic_vector(1 downto 0) := (others => '0');
	constant clk_period   : time := 10 ns;
	-- /signals / variables ---------------------------

begin   

	dut : funFSM port map (clock, rst, outPutz, states_encoded);
		
	-- clock generator 
	clk_gen: process is
	begin
        clock <= '1';
        wait for clk_period/2;
        clock <= '0';
        wait for clk_period/2;
		
end process clk_gen;
	-- /clock generator 

	-- rst issue 
	trig: process is
	begin
		wait for clk_period*15;
		rst <= '1';
		wait for clk_period*2;
		rst <= '0';
		wait for clk_period*30;
	end process trig;
	-- /rst issue 
	-- /logic -----------------------------------------

end funFSM_arch_tb;
-- /architecture --------------------------------------