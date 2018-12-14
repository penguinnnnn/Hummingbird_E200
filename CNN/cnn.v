module selector(
input [16*49-1:0] i,
input x,
input y,
output reg[15:0] o
);

wire [15:0] buffer_wire [6:0][6:0];
reg [15:0]width_selector_wire[6:0];

genvar j;
genvar i;
generate
for(j=0;j<7;j=j+1) begin : buffer_h_loop
	for(i=0;i<7;i=i+1) begin : buffer_l_loop
		assign buffer_wire[j][i]=i[(7*j+i+1)*16-1:(7*j+i)*16];
	end
end

endgenerate

genvar m;
generate
for(m=0;m<7;m=m+1)begin:w_selector
	always @(*) begin	
	o = buffer_wire[x][y];
	end
endmodule
		



	
