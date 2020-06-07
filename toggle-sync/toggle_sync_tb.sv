/*
	testbench for the toggle synchrinizer
*/

`timescale 1ps / 1ps
module toggle_sync_tb();

	logic clk_domain_a;
	logic clk_domain_b;
	logic rstb_domain_a;
	logic rstb_domain_b;
	logic pulse_in;
	logic pulse_out;
	
	toggle_sync toggle_sync_DUT (.clk_a(clk_domain_a),
								 .clk_b(clk_domain_b),
								 .rstb_a(rstb_domain_a),
								 .rstb_b(rstb_domain_b),
								 .pulse_in(pulse_in),
								 .pulse_out(pulse_out));
								 
	always
	begin
		#5ns
		clk_domain_a = ~clk_domain_a;
	end
	
	always
	begin
		#10ns
		clk_domain_b = ~clk_domain_b;
	end
	
	initial
	begin
		{clk_domain_b, clk_domain_a, rstb_domain_a, rstb_domain_b, pulse_in} = 1'b0;
		#12ns;
		
		@ (posedge clk_domain_a)
			rstb_domain_a = 1'b1;
		
		@ (posedge clk_domain_b)
			rstb_domain_b = 1'b1;
		#50ns;
		
		@ (posedge clk_domain_a)
			pulse_in = 1'b1;
		 
		@ (posedge clk_domain_a)
			pulse_in = 1'b0;
	end
endmodule
