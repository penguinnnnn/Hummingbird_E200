module cnn_tp();

	reg [16*9-1:0] a,b;
	reg clk;
	initial begin
		a<=16*9'b00_0001;
		b<=16*9'b00_0001;
		clk=0;
		forever #10 clk=~clk;
	end
	
	initial begin
		forever #10 a=a+16'b00_0001;
	end
	wire [15:0] out;
	kernel3 core(a,b,out,clk);
endmodule