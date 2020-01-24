
module first_nios2_system (
	clk_clk,
	led_gpioz_export,
	reset_reset_n,
	sw_input_export,
	uart_external_connection_rxd,
	uart_external_connection_txd);	

	input		clk_clk;
	output	[7:0]	led_gpioz_export;
	input		reset_reset_n;
	input		sw_input_export;
	input		uart_external_connection_rxd;
	output		uart_external_connection_txd;
endmodule
