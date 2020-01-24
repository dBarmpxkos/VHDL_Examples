-------------------------------------------------------
-- Design Name : Askisi_3 [ function generator ]
-- File Name   : funFSM.vhd
-- Function    : State Machine with HIGH/LOW (3To/4To)
-- whois       : Dimitris BARMPAKOS (VHDL)
-------------------------------------------------------
library ieee;
    use ieee.std_logic_1164.all;
	use IEEE.std_logic_arith.all;
library work;
	use work.all;
-- /libraries -----------------------------------------

entity funFSM is 
port (
	CLK, RST : in std_logic;
	OUTPUT   : out std_logic;
	Y		 : out std_logic_vector(1 downto 0) -- state output
);
end funFSM;
-- /entity --------------------------------------------

architecture funFSM_arch of funFSM is

	type state_type is (OUT_HIGH, OUT_LOW);
	signal present_state, next_state : state_type;
	signal fsm_output : std_logic;
	signal counter : integer := 0;
	
begin

	sync_proc : process(CLK, RST, next_state, counter)
	begin
	
	if (rising_edge(CLK)) then 
		present_state <= next_state;
		counter <= counter + 1;
		
		case present_state is 
		when OUT_HIGH =>
			fsm_output <= '1';
		when OUT_LOW =>
			fsm_output <= '0';
		if (counter = 6) then
			counter <= 0;
		end if;
		when others =>
			fsm_output <= fsm_output;
		end case;
	else 
	if (RST = '1') then
		present_state <= OUT_HIGH;
		counter <= 0;
	end if;
	end if;
	
	end process sync_proc;
	
	comb_proc : process(counter, present_state)
	begin
		case present_state is
		when OUT_HIGH => 
			if  (counter = 2) then 
				next_state <= OUT_LOW;
			else next_state <= present_state;
			end if;
		when OUT_LOW =>
			if (counter = 6) then 
				next_state <= OUT_HIGH;
			else next_state <= present_state;
			end if;
		end case;
	end process comb_proc;
	
-- state encoding
	with present_state select
		Y <= 	"00" when OUT_HIGH,	
				"01" when OUT_LOW,
				"00" when others;
-- /state encoding

	OUTPUT <= fsm_output;
	-- /logic -----------------------------------------

end funFSM_arch;
-- /architecture --------------------------------------
