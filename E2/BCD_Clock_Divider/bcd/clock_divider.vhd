library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
  
entity clock_divider is
port ( 
	i_clk	: in std_logic;
	o_clk	: out std_logic
);
end clock_divider;
  
architecture arch of clock_divider is
  
signal counter : integer   := 1;
signal s_out   : std_logic := '0';
  
begin
  
	process(i_clk)
	begin
	if(i_clk'event and i_clk='1') then
		counter <= counter + 1;
		if (counter = 25000000) then -- (50 MHz / target clk * 50% duty cycle)
			s_out <= NOT s_out;
			counter <= 1;
		end if;
	end if;
	end process;
	
	o_clk <= s_out;

end arch;