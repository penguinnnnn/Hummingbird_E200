module e203_eai_conv_kernel3(
input [16*9-1:0] x,
input [16*9-1:0] kernel,
output [15:0] out,
input clk
);

	wire[16*9-1:0]psum;
	reg [15:0]sum;
	genvar i;
	generate
	for (i=0;i<9;i=i+1)
	begin
	    assign psum[16*(i+1)-1:16*i] = x[16*(i+1)-1:16*i] * kernel[16*(i+1)-1:16*i];
	end
	endgenerate
	
	e203_eai_conv_binary_adder_tree u_e203_eai_conv_binary_adder_tree(psum[15:0],
	                                                                  psum[16*2-1:16*1],
	                                                                  psum[16*3-1:16*2],
	                                                                  psum[16*4-1:16*3],
	                                                                  psum[16*5-1:16*4],
	                                                                  psum[16*6-1:16*5],
	                                                                  psum[16*7-1:16*6],
	                                                                  psum[16*8-1:16*7],
	                                                                  psum[16*9-1:16*8],
	                                                                  clk,
	                                                                  out);
endmodule	