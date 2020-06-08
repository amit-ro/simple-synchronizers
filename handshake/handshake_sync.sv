/*
	module for the handshake synchronizer, this synchonizer can deal with multiple situations.
	especially when the relation between the clocks is unknown.
	input:
	clk_a - clock from domain 'a'
	clk_b - clock from domain 'b'
	rstb_a - reset signal from domain 'a'
	rstb_b - reset signal from domain 'b'
	pulse_in - pulse to be synchronized
	output: pulse_out - synchronized pulse 
*/
`timescale 1ps / 1ps
module handshake_sync(
			input logic clk_a,
			input logic clk_b, 
			input logic rstb_a,
			input logic rstb_b,
			input logic pulse_in,
			output logic pulse_out);

	// inner variables deleration
	logic q1;
	logic sync_out_a_to_b;
	logic sync_out_b_to_a;
	logic deriv_ff;
	
	// signal extension
	always_ff @ (posedge clk_a or negedge rstb_a)
		if (~rstb_a)
			q1 <= 1'b0;
		else
			q1 <= pulse_in | ((~sync_out_b_to_a)&q1);
	
	// synchronizers domain a to domain b and vice versa
	dff_sync sync_a_to_b (.clk(clk_b), .resetb(rstb_b), .d(q1), .q(sync_out_a_to_b));
	
	dff_sync sync_b_to_a (.clk(clk_a), .resetb(rstb_a), .d(sync_out_a_to_b), .q(sync_out_b_to_a));
	
	// posedge deriver
	always_ff @ (posedge clk_b or negedge rstb_b)
		if (~rstb_b)
			deriv_ff <= 1'b0;
		else
			deriv_ff <= sync_out_a_to_b;
			
	assign pulse_out = (~deriv_ff) & sync_out_a_to_b;
endmodule

