-------------------------------------------------------
-- Design Name : Askisi_2 [ 4bit binary counter ]
-- File Name   : counter4_tb.vhd
-- Function    : tests binary 4bit counter with clock pulses and rst
-- whois       : Dimitris BARMPAKOS (VHDL)
-- 
-- I have implemented the question both with package and with structural design.
-- Comment / Uncomment the appropriate lines for testing
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
library work;
	use work.all;
	use work.my_package.all;
-- /libraries -----------------------------------------

entity counter4_tb is 
end counter4_tb;
-- /entity --------------------------------------------

architecture counter4_tb_arch of counter4_tb is 

	-- uncomment below for structural
	-- component counter4_struct is
	component counter4
	port (
		CLK, RST : in std_logic;
		Output   : out std_logic_vector(7 downto 0)
	);
	end component; 
	
	constant clk_hp : time := 3000 ps;
	signal CLK, RST : std_logic := '0';
	signal Output	: std_logic_vector(7 downto 0) := (others => '0');
	
begin 
	
	-- uncomment below for structural 
	-- counter_instance : counter4_struct port map(CLK, RST, Output);
	counter_instance : counter4 port map(CLK, RST, Output);
	-- clk generator ----------------------------------
	clock_gen_proc : process is
	begin
		clk <= '1';
		wait for clk_hp/2; 	-- 50% duty cycle
		clk <= '0';
		wait for clk_hp/2;	-- 50% duty cycle
	end process clock_gen_proc;
	---------------------------------------------------
	
	-- rst issue 
	trig: process is
	begin
		wait for clk_hp*15;
		rst <= '0';
		wait for clk_hp*2;
		rst <= '1';
		wait for clk_hp*30;
	end process trig;
	-- /rst issue 

	-- /logic -----------------------------------------

end counter4_tb_arch;
-- /architecture --------------------------------------

	