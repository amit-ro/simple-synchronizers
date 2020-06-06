`timescale 1ps / 1ps
/*
	Module for a simple double flip flop pulse synchronizer.
	input:
	clk - clock for the system.
	resetb - reset signal for the system.
	pulse_in - input pulse to synchronized with the input clock.
	pulse_out - synchronized pulse (synchronized with the input clock.
*/
module dff(
			input logic clk,
			input logic resetb,
			input logic pulse_in,
			output logic pulse_out);
			
	logic sync_out; // dff_sync output
	logic deriv_ff_out; // flip flop output
	
	// double flip flop synchronizer instance.
	dff_sync sync(.clk(clk), .resetb(resetb), .d(pulse_in), .q(sync_out));
	
	// rise deriver
	always_ff @ (posedge clk or negedge resetb)
		if (~resetb)
			deriv_ff_out <= 1'b0;
		else
			deriv_ff_out <= sync_out;
			
	assign pulse_out = (~deriv_ff_out) & sync_out;
endmodule