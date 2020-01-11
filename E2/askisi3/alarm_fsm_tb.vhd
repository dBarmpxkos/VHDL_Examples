library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;

entity alarm_fsm_tb is 
end alarm_fsm_tb;

architecture alarm_fsm_tb_arch of alarm_fsm_tb is
	
	component alarm_fsm is
	port ( 
		i_remote	: in std_logic;
		i_sensors	: in std_logic;
		i_reset		: in std_logic;
		i_clock		: in std_logic;
		-- -------------------------
		o_siren		: out std_logic;
		debug_states : out string (1 to 4)
	); end component;

	-- signals / variables ----------------------------
	signal clock : std_logic;
	signal rst   : std_logic := '0';
	signal remote, sensors, siren : std_logic := '0';
	signal states_encoded  : string (1 to 4);
	constant clk_period    : time := 1 ns;
begin
	
	dut : alarm_fsm port map (remote, sensors, rst, clock, siren, states_encoded);
	
	-- clock generator -------
	clk_gen: process is
	begin
        clock <= '1';
        wait for clk_period/2;
        clock <= '0';
        wait for clk_period/2;
	end process clk_gen;
	-- -----------------------
	
	scenario: process is
	begin
		-- 1: test if reset works
		wait for clk_period*4;
		rst <= '1';
		wait for clk_period*4;
		rst <= '0'; -- go live
		
	    -- 2. check if alarm arms and disarms 
		-- disarmed -> armed -> disarmed -> armed
		wait for clk_period*1;
		remote <= '1';
		wait for clk_period*1;
		remote <= '0'; 
		wait for clk_period*1;
		remote <= '1';
		wait for clk_period*1;
		remote <= '0';
		wait for clk_period*1;
		remote <= '1';
		wait for clk_period*1;
		remote <= '0'; -- leave the alarm waiting for sensor trigger
		
		-- 3. sensor activated 
		-- wait some time until user hears the siren
		-- and presses the key to disable the alarm 
		wait for clk_period*1;
		sensors <= '1';			
		wait for clk_period*5; 
		remote <= '1';			
		wait for clk_period*1;
		remote <= '0';
		sensors <= '0';
		wait for clk_period*50;
	end process scenario;

end alarm_fsm_tb_arch;
		
	