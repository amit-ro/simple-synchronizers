/*
	module for signal extender synchronizer, in this case the input pulse's clock is 2 times 
	faster than the required clock (clk_b) the pulse is extended with a simple configuration 
	consisting of flip flops and OR gates. Note that the signal can be also extended using counters, 
	I will go through that configuration in the near future.
	input:
	clk_a - clock from domain 'a'
	clk_b - clock from domain 'b'
	rstb_a - reset signal from domain 'a'
	rstb_b - reset signal from domain 'b'
	pulse_in - pulse to be synchronized
	output: pulse_out - synchronized pulse 
*/
`timescale 1ps / 1ps
module signal_extender_sync(
			input logic clk_a,
			input logic rstb_a,
			input logic clk_b, 
			input logic rstb_b,
			input logic pulse_in,
			output logic pulse_out);
	
	// inner variables for the flip flops
	logic [2:0] extended_pulse;
	logic sync_out;
	logic deriv_ff;
	
	// signal extension 
	always_ff @ (posedge clk_a or negedge rstb_a)
		if (~rstb_a)
			extended_pulse <= 3'b000;
		else if (pulse_in) 
			extended_pulse <= 3'b111;
		else
			extended_pulse <= {extended_pulse[1:0], 1'b0};
	
	// double flip flop synchronizer
	dff_sync sync_domains(.clk(clk_b), .resetb(rstb_b), .d(extended_pulse[2]), .q(sync_out));
	
	// rise deriver
	always_ff @ (posedge clk_b or negedge rstb_b)
		if (~rstb_b)
			deriv_ff <= 1'b0;
		else
			deriv_ff <= sync_out;
			
	assign pulse_out = sync_out & (~deriv_ff);
endmodule
