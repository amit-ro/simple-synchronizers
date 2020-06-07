/*
	Toggle synchronizer, this design is a robust pulse synchronizer. It can be used in various situations
	input:
	clk_a - clock from domain 'a'
	clk_b - clock from domain 'b'
	rstb_a - reset signal from domain 'a'
	rstb_b - reset signal from domain 'b'
	pulse_in - pulse to be synchronized
	output: pulse_out - synchronized pulse 
	
*/
`timescale 1ps / 1ps
module toggle_sync(
			input logic clk_a,
			input logic clk_b,
			input logic rstb_a,
			input logic rstb_b,
			input logic pulse_in,
			output logic pulse_out);
			
	// inner variables for the flip flops
	logic d1_clka;
	logic q1_clka;
	logic q3_clkb;
	logic q4_clkb;
	
	assign d1_clka = q1_clka ^ pulse_in;
	
	// first flip flop
	always_ff @ (posedge clk_a or negedge rstb_a)
	begin
		if(~rstb_a)
			q1_clka <= 1'b0;
		else
			q1_clka <= d1_clka;
	end
	
	// double flip flop synchronizer
	dff_sync sync_domains(.clk(clk_b), .resetb(rstb_b), .d(q1_clka), .q(q3_clkb));
	
	// fourth flip flop 
	always_ff @(posedge clk_b or negedge rstb_b)
	begin
		if(~rstb_b)
			q4_clkb <= 1'b0;
		else
			q4_clkb <= q3_clkb;
	end
	
	assign pulse_out = q3_clkb ^ q4_clkb;	
endmodule
