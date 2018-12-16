`include define.v

module eai (
	input eai_req_valid,
	output eai_req_ready,
	input [INSTR_WIDTH-1:0]eai_req_instr,
	input [DATA_WIDTH-1:0]eai_req_rs1,
	input [DATA_WIDTH-1:0]eai_req_rs2,
	input [DISP_ITAG_WIDTH-1:0]eai_req_itag,

	output eai_rsp_valid,
	input eai_rsp_ready,
	output [DATA_WIDTH-1:0]eai_rsp_wdat,
	output [DISP_ITAG_WIDTH-1:0]eai_rsp_itag,
	output eai_rsp_err,
	
	output eai_icb_cmd_valid,
	input eai_icb_cmd_ready,
	output [DATA_WIDTH-1:0]eai_icb_cmd_addr,
	output eai_icb_cmd_read,
	output [DATA_WIDTH-1:0]eai_icb_cmd_wdata,
	output [3:0]eai_icb_cmd_wmask,
	
	input eai_icb_rsp_valid,
	output eai_icb_rsp_ready,
	input [DATA_WIDTH-1:0]eai_icb_rsp_rdata,
	input eai_icb_rsp_err,
	
	output eai_mem_holdup,
	
	input clk
)

	assign eai_icb_cmd_valid = eai_req_valid & eai_icb_cmd_ready;
	
	wire complete;
	reg [7*7*16-1:0] x;
	reg [3*3*16-1:0] kernel;
	reg [5*5*16-1:0] y;
	//get addr from rs1 and rs2
	reg [DATA_WIDTH-1:0] addr_x;
	reg [DATA_WIDTH-1:0] addr_k;
	//reg [DATA_WIDTH-1:0] addr_y;
	
	initial 
	begin
		x = 7*7*16'b0;
		kernel = 3*3*16'b0;
		y = 5*5*16'b0;
		addr_x = eai_req_rs1;//addr of x
		addr_k = eai_req_rs2;//addr of kernel
		//addr_y = 32'b0;
	end
	
	
	genvar i;
	genvar j;
	wire [DATA_WIDTH-1:0]temp_rdata;//get data from memory
		
	generate	
	for(i = 0; i < 7*7; )
	begin
		assign eai_icb_cmd_addr = addr_x;//get x from the address stored in rs1
		assign temp_rdata = eai_icb_rsp_rdata;//32bit data ,2 numbers
		
		always @(*)
		begin
			x[(7*7-7*i)*16-1:(7*7-7*i-2)*16] <= temp_rdata;
		end
		
		i = i + 2;
		if(i == 46)begin
			i = i-1;
		end
		
		addr_x = addr_x + 4;
	end
	
	for(j = 0; j<3*3;)
	begin
		assign eai_icb_cmd_addr = addr_k;
		assign temp_rdata = eai_icb_rsp_rdata;
		
		always @ (*)
		begin	
			kernel[(3*3-3*i)*16-1:(3*3-3*i-2)*16] <= temp_rdata;
		end
		
		j = j + 2;
		if(j == 8)begin
			j = j - 1;
		end
			
		addr_k = addr_k + 4;
	end
		
	endgenerate
	
	assign complete = eai_icb_rsp_ready && eai_icb_cmd_valid;
	
	conv_op eai_core(
	.i_valid(1'b1), 
	.i_ready(complete),
	.clk(clk),
	.rst_n(1'b0), 
	.X(x), 
	.kernel(kernel), 
	.out(y),
	)
	