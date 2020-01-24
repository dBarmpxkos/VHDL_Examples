	component first_nios2_system is
		port (
			clk_clk                      : in  std_logic                    := 'X'; -- clk
			led_gpioz_export             : out std_logic_vector(7 downto 0);        -- export
			reset_reset_n                : in  std_logic                    := 'X'; -- reset_n
			sw_input_export              : in  std_logic                    := 'X'; -- export
			uart_external_connection_rxd : in  std_logic                    := 'X'; -- rxd
			uart_external_connection_txd : out std_logic                            -- txd
		);
	end component first_nios2_system;

	u0 : component first_nios2_system
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --                      clk.clk
			led_gpioz_export             => CONNECTED_TO_led_gpioz_export,             --                led_gpioz.export
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --                    reset.reset_n
			sw_input_export              => CONNECTED_TO_sw_input_export,              --                 sw_input.export
			uart_external_connection_rxd => CONNECTED_TO_uart_external_connection_rxd, -- uart_external_connection.rxd
			uart_external_connection_txd => CONNECTED_TO_uart_external_connection_txd  --                         .txd
		);

