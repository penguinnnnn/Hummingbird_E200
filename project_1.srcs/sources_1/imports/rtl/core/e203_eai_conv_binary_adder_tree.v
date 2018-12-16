module e203_eai_conv_binary_adder_tree(A,B,C,D,E,F,G,H,I,clk,out);
	input [15:0]A,B,C,D,E,F,G,H,I;
	input clk;
	output [15:0] out;
	wire [15:0] sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8;
	reg [15:0] sumreg1,sumreg2,sumreg3,sumreg4,sumreg5,sumreg6,sumreg7,sumreg8;
	
	always @ (posedge clk)
		begin
			sumreg1<= sum1;
			sumreg2<= sum2;
			sumreg3<= sum3;
			sumreg4<= sum4;
			sumreg5<= sum5;
			sumreg6<= sum6;
			sumreg7<= sum7;
			sumreg8<= sum8;
		end
	
	assign sum1=A+B;
	assign sum2=C+D;
	assign sum3=E+F;
	assign sum4=G+H;
	assign sum5=sumreg1 + sumreg2;
	assign sum6=sumreg3 + sumreg4;
	assign sum7=sumreg5 + sumreg6;
	assign sum8=sumreg7 + I;
	assign out = sumreg8;

endmodule
