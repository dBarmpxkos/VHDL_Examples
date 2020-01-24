	first_nios2_system u0 (
		.clk_clk                      (<connected-to-clk_clk>),                      //                      clk.clk
		.led_gpioz_export             (<connected-to-led_gpioz_export>),             //                led_gpioz.export
		.reset_reset_n                (<connected-to-reset_reset_n>),                //                    reset.reset_n
		.sw_input_export              (<connected-to-sw_input_export>),              //                 sw_input.export
		.uart_external_connection_rxd (<connected-to-uart_external_connection_rxd>), // uart_external_connection.rxd
		.uart_external_connection_txd (<connected-to-uart_external_connection_txd>)  //                         .txd
	);

