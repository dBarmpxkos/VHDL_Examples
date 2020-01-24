library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity D_FF is
port (
	i_D   : in std_logic;
	i_CKL_ff : in std_logic;
	i_RST_n : in std_logic;
	o_Q   : out std_logic
);
end D_FF;

architecture behavioral of D_FF is  
signal counter : integer := 1;
signal tmp 	   : std_logic := '0';

begin
	process(i_CKL_ff, i_RST_n) begin 
	
		-- with delay so we can see output
		if (i_CKL_ff'event AND i_CKL_ff='1') then
		
			if (i_RST_n = '1') then tmp <= '0';
			else counter <= counter + 1;	
			end if;							
			
			if (counter = 25000000) then 	
				tmp <= i_D;
				counter <= 1;				
			end if;
			
		end if;
		----------------------------------

		-- no delay (for next question) 
		-- if (i_CKL_ff'event AND i_CKL_ff='1') then
			-- if (i_RST_n = '1') then tmp <= '0';
			-- else tmp <= i_D;
			-- end if;
		-- end if;
		----------------------------------
	end process; 
	
	o_Q <= tmp;

end behavioral;