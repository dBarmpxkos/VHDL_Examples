library ieee;
	use ieee.std_logic_1164.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity alarm_fsm is
port ( 
	i_remote	: in std_logic;
	i_sensors	: in std_logic;
	i_reset		: in std_logic;
	i_clock		: in std_logic;
	-- -------------------------
	o_siren		 : out std_logic;
	debug_states : out string (1 to 4)
);
end alarm_fsm;
-- /entity --------------------------------------------

architecture fsm of alarm_fsm is

	-- signals / variables ----------------------------
	type state is (ST_DISARMED, ST_ARMED, ST_INTRUSION);
	signal pr_state, nx_state : state;
	
begin
	
	process(i_reset, i_clock, nx_state) begin
		if (i_reset = '1') then pr_state <= ST_DISARMED;
		elsif (i_clock'event AND i_clock = '1') then pr_state <= nx_state;
		end if;
	end process;
	
	process(pr_state, i_remote, i_sensors) 
	begin
		case pr_state is
		
			when ST_DISARMED =>
				o_siren <= '0';
				if (i_remote = '1') then nx_state <= ST_ARMED;
				else nx_state <= ST_DISARMED;
				end if;
				
			when ST_ARMED =>
				o_siren <= '0';
				if (i_remote = '1') then nx_state <= ST_DISARMED;
				elsif (i_sensors = '1') then nx_state <= ST_INTRUSION;
				else nx_state <= ST_ARMED;
				end if;
				
			when ST_INTRUSION =>
				o_siren <= '1';
				if (i_remote = '1') then nx_state <= ST_DISARMED;
				else nx_state <= ST_INTRUSION;
				end if;
				
			when others =>
				o_siren <= '0';
				nx_state <= ST_DISARMED;
				
		end case;
	end process;
	
	-- debug_states, brutal 4 char string...
	with pr_state select
		debug_states <= "DSMD" when ST_DISARMED,
						"ARMD" when ST_ARMED,
						"ALRT" when ST_INTRUSION,
						"ERRO" when others;
end architecture;
				