-------------------------------------------------------
-- Design Name : Askisi_1 [ Skip-carry full adder ]
-- File Name   : AdderBypass4_tb.vhd
-- Function    : Tests four cases of addition for 
--				 4bit adder with skip-carry function
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity adderBypass4_tb is
end adderBypass4_tb;
-- /entity --------------------------------------------

architecture adderBypass4_testbench of adderBypass4_tb is
  
    component adderBypass4 is
	port (
		A_In, B_In : in std_logic_vector(3 downto 0);
		Cin  : in std_logic;
		S    : out std_logic_vector(3 downto 0);
		Cout : out std_logic
    );
    end component;

   signal A, B, S : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin, Cout : std_logic := '0';

begin
 
	uut	: adderBypass4 port map (
		A, B, Cin, S, Cout
	);

	stim_proc: process
	begin
		
		Cin <= '0';
		A	<= "0000";
		B	<= "1111";
		wait for 100 ns;
		
		A	<= "0101";
		B	<= "0000";
		wait for 100 ns;
		
		A	<= "0011";
		B	<= "1110";
		wait for 100 ns;
		
		A	<= "1111";
		B	<= "1001";
		wait for 100 ns;
		
		A	<= "0000";
		B	<= "0000";
		wait for 100 ns;
		
		wait;
	
	end process;
  	-- /logic -----------------------------------------

end adderBypass4_testbench;
-- /architecture --------------------------------------
