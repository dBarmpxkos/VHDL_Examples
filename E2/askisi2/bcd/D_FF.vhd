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
signal tmp : std_logic := '0';

begin
	process(i_CKL_ff, i_RST_n) begin 

		if (i_CKL_ff'event AND i_CKL_ff='1') then
			if (i_RST_n = '1') then tmp <= '0';
			else tmp <= i_D;
			end if;
		end if;
		----------------------------------		
	end process; 
	o_Q <= tmp;

end behavioral;