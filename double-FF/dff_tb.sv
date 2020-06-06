/*
	testbench for the most simple double FF pulse synchronizer
*/
`timescale 1ps / 1ps
module dff_tb();

	logic clk_domain_b;
	logic clk_domain_a;
	logic resetb;
	logic pulse_in;
	logic pulse_out;
	
	dff dff_DUT(.clk(clk_domain_b),
				.resetb(resetb), 
				.pulse_in(pulse_in), 
				.pulse_out(pulse_out));
				
				
	always
	begin
		#10ns
		clk_domain_a = ~clk_domain_a;
	end
	
	always
	begin
		#5ns
		clk_domain_b = ~clk_domain_b;
	end
	
	initial
	begin
		{clk_domain_b, clk_domain_a, resetb, pulse_in, pulse_out} = 1'b0;
		#12ns;
		
		@ (posedge clk_domain_b)
			resetb = 1'b1;
		#15ns;
		
		@ (posedge clk_domain_a)
			pulse_in = 1'b1;
		 
		@ (negedge clk_domain_a)
			pulse_in = 1'b0;
	end
endmodule
	

