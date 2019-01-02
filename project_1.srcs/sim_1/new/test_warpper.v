`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/12/21 09:36:03
// Design Name: 
// Module Name: test_warpper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "e203_defines.v"

module test_warpper(

    );
    reg clk;
    reg rst_n;
    //data generation
    reg cmd_valid;
    wire cmd_ready;
    reg [`E203_DTCM_ADDR_WIDTH-1:0] cmd_addr;
    reg cmd_read;
    reg [31:0] cmd_wdata;
    reg [3:0] cmd_wmask;
    wire rsp_valid;
    reg rsp_ready;
    wire rsp_error;
    wire [31:0] rsp_rdata;
    initial begin
        clk=0;
        forever #10 clk=~clk;
    end
    initial begin
        rst_n=0;
        #100 rst_n=1;
    end
    initial begin
        cmd_valid=0;
        rsp_ready=1;
        #150 cmd_valid=1;
        cmd_addr = 16'h20;
        cmd_read=0;
        cmd_wdata=32'h12345678;
        cmd_wmask=4'b0101;
        #300 cmd_valid=1;
        cmd_read=1;
    end
    initial begin
        #800 $stop;
    end
    always @(clk)begin
        if(cmd_ready==1)cmd_valid=0;
    end
//    always @(clk)begin
//        if(rsp_valid==1) begin
//            rsp_ready=1;
//        end else
//            rsp_ready=0;
//    end
    
    // AXI
    wire axi_clk;
    wire axi_resetn;
    wire [3:0]s_axi_awid;
    wire [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_awaddr;
    wire [7:0]s_axi_awlen;
    wire [2:0]s_axi_awsize;
    wire [1:0]s_axi_awburst;
    wire s_axi_awlock;
    wire [3:0]s_axi_awcache;
    wire [2:0]s_axi_awprot;
    wire s_axi_awvalid;
    wire s_axi_awready;
    wire [31:0]s_axi_wdata;
    wire [3:0]s_axi_wstrb;
    wire s_axi_wlast;
    wire s_axi_wvalid;
    wire s_axi_wready;
    wire [3:0]s_axi_bid;
    wire [1:0]s_axi_bresp;
    wire s_axi_bvalid;
    wire s_axi_bready;
    wire [3:0]s_axi_arid;
    wire [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_araddr;
    wire [7:0]s_axi_arlen;
    wire [2:0]s_axi_arsize;
    wire [1:0]s_axi_arburst;
    wire s_axi_arlock;
    wire [3:0]s_axi_arcache;
    wire [2:0]s_axi_arprot;
    wire s_axi_arvalid;
    wire s_axi_arready;
    wire [3:0]s_axi_rid;
    wire [31:0]s_axi_rdata;
    wire [1:0]s_axi_rresp;
    wire s_axi_rlast;
    wire s_axi_rvalid;
    wire s_axi_rready;
    
    wrapper_model u_wrapper_model(
    .lsu2dtcm_icb_cmd_valid(cmd_valid),
    .lsu2dtcm_icb_cmd_ready(cmd_ready),
    .lsu2dtcm_icb_cmd_addr(cmd_addr),
    .lsu2dtcm_icb_cmd_read(cmd_read),
    .lsu2dtcm_icb_cmd_wdata(cmd_wdata),
    .lsu2dtcm_icb_cmd_wmask(cmd_wmask),
    .lsu2dtcm_icb_rsp_valid(rsp_valid),
    .lsu2dtcm_icb_rsp_ready(rsp_ready),
    .lsu2dtcm_icb_rsp_err(rsp_error),
    .lsu2dtcm_icb_rsp_rdata(rsp_rdata),
    
       .axi_clk(axi_clk),
      .axi_resetn(axi_resetn),
      .s_axi_awid(s_axi_awid),
      .s_axi_awaddr(s_axi_awaddr),
      .s_axi_awlen(s_axi_awlen),
      .s_axi_awsize(s_axi_awsize),
      .s_axi_awburst(s_axi_awburst),
      .s_axi_awlock(s_axi_awlock),
      .s_axi_awcache(s_axi_awcache),
      .s_axi_awprot(s_axi_awprot),
      .s_axi_awvalid(s_axi_awvalid),
      .s_axi_awready(s_axi_awready),
      .s_axi_wdata(s_axi_wdata),
      .s_axi_wstrb(s_axi_wstrb),
      .s_axi_wlast(s_axi_wlast),
      .s_axi_wvalid(s_axi_wvalid),
      .s_axi_wready(s_axi_wready),
      .s_axi_bid(s_axi_bid),
      .s_axi_bresp(s_axi_bresp),
      .s_axi_bvalid(s_axi_bvalid),
      .s_axi_bready(s_axi_bready),
      .s_axi_arid(s_axi_arid),
      .s_axi_araddr(s_axi_araddr),
      .s_axi_arlen(s_axi_arlen),
      .s_axi_arsize(s_axi_arsize),
      .s_axi_arburst(s_axi_arburst),
      .s_axi_arlock(s_axi_arlock),
      .s_axi_arcache(s_axi_arcache),
      .s_axi_arprot(s_axi_arprot),
      .s_axi_arvalid(s_axi_arvalid),
      .s_axi_arready(s_axi_arready),
      .s_axi_rid(s_axi_rid),
      .s_axi_rdata(s_axi_rdata),
      .s_axi_rresp(s_axi_rresp),
      .s_axi_rlast(s_axi_rlast),
      .s_axi_rvalid(s_axi_rvalid),
      .s_axi_rready(s_axi_rready),
      .clk(clk),
      .rst_n(rst_n)
       );
    
    axi_bram_ctrl_0 axi_bram(axi_clk, axi_resetn, s_axi_awid, 
      s_axi_awaddr, s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_awlock, s_axi_awcache, 
      s_axi_awprot, s_axi_awvalid, s_axi_awready, s_axi_wdata, s_axi_wstrb, s_axi_wlast, 
      s_axi_wvalid, s_axi_wready, s_axi_bid, s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_arid, 
      s_axi_araddr, s_axi_arlen, s_axi_arsize, s_axi_arburst, s_axi_arlock, s_axi_arcache, 
      s_axi_arprot, s_axi_arvalid, s_axi_arready, s_axi_rid, s_axi_rdata, s_axi_rresp, s_axi_rlast, 
      s_axi_rvalid, s_axi_rready);
endmodule

module wrapper_modelT(

output dtcm_active,
input  lsu2dtcm_icb_cmd_valid, // Handshake valid
output lsu2dtcm_icb_cmd_ready, // Handshake ready
input  [16-1:0]   lsu2dtcm_icb_cmd_addr, // Bus transaction start addr 
input  lsu2dtcm_icb_cmd_read,   // Read or write
input  [32-1:0] lsu2dtcm_icb_cmd_wdata, 
input  [4-1:0] lsu2dtcm_icb_cmd_wmask, 
//    * Bus RSP channel
output lsu2dtcm_icb_rsp_valid, // Response valid 
input  lsu2dtcm_icb_rsp_ready, // Response ready
output lsu2dtcm_icb_rsp_err,   // Response error
output [32-1:0] lsu2dtcm_icb_rsp_rdata, 


output axi_clk,
output axi_resetn,
output [3:0]s_axi_awid,
output [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_awaddr,
output [7:0]s_axi_awlen,
output [2:0]s_axi_awsize,
output [1:0]s_axi_awburst,
output s_axi_awlock,
output [3:0]s_axi_awcache,
output [2:0]s_axi_awprot,
output s_axi_awvalid,
input s_axi_awready,
output [31:0]s_axi_wdata,
output [3:0]s_axi_wstrb,
output s_axi_wlast,
output s_axi_wvalid,
input s_axi_wready,
input [3:0]s_axi_bid,
input [1:0]s_axi_bresp,
input s_axi_bvalid,
output s_axi_bready,
output [3:0]s_axi_arid,
output [`LAB3_AXI_ADDR_WIDTH-1:0]s_axi_araddr,
output [7:0]s_axi_arlen,
output [2:0]s_axi_arsize,
output [1:0]s_axi_arburst,
output s_axi_arlock,
output [3:0]s_axi_arcache,
output [2:0]s_axi_arprot,
output s_axi_arvalid,
input s_axi_arready,
input [3:0]s_axi_rid,
input [31:0]s_axi_rdata,
input [1:0]s_axi_rresp,
input s_axi_rlast,
input s_axi_rvalid,
output s_axi_rready,

input clk,
input rst_n
);

wire axi_active;
wire cmd_en;
wire [2:0] cmd;
wire [7:0] blen;
reg wrdata_vld;
wire wrdata_cmptd;
wire wrdata_rdy;
wire wrdata_sts_vld;
wire rddata_vld;
wire rddata_rdy;
wire rddata_cmptd;
wire cmd_ack;
wire [2:0] ctl; //axi_rsize
wire active; //warpper active 

reg is_read; 

always @(posedge(lsu2dtcm_icb_cmd_valid))begin
    is_read=lsu2dtcm_icb_cmd_read;
end
always @(posedge(clk))begin
    if (wrdata_rdy)
        wrdata_vld=1'b1;
    else
        wrdata_vld=1'b0;
end

assign cmd_en=lsu2dtcm_icb_cmd_valid;
assign cmd=lsu2dtcm_icb_cmd_read?3'b001:3'b101;
assign blen=7'b0; //length=1 // Burst length calculated as blen+1
wire [`LAB3_AXI_ADDR_WIDTH:0] lsu2dtcm_icb_cmd_addr_to_axi;
assign lsu2dtcm_icb_cmd_addr_to_axi={{`LAB3_DTCM2AXI_ADDR_WIDTH_ADD{1'b0}},lsu2dtcm_icb_cmd_addr}; //`LAB3_AXI_ADDR_WIDTH-`E203_DTCM_ADDR_WIDTH
assign ctl=3'b010; //32bit data flow
assign lsu2dtcm_icb_cmd_ready=cmd_ack; //output
//assign wrdata_vld = ~is_read & ~lsu2dtcm_icb_cmd_valid & ~cmd_ack;
assign wrdata_cmptd=wrdata_rdy?1'b1:1'b0; //always the last data now
assign lsu2dtcm_icb_rsp_valid=is_read?rddata_vld:wrdata_rdy;
assign rddata_rdy=lsu2dtcm_icb_rsp_ready;

assign axi_clk=clk;
assign axi_resetn=rst_n;

axi_wrapper#(
    .C_AXI_ID_WIDTH(4),
    .C_AXI_ADDR_WIDTH(`LAB3_AXI_ADDR_WIDTH),
    .C_AXI_DATA_WIDTH(`E203_XLEN),
    .CTL_SIG_WIDTH(3)
)u_axi_warpper(
.active(active),
.aclk(clk),
.aresetn(rst_n),
.cmd_en(cmd_en),
.cmd(cmd),
.blen(blen),
.addr(lsu2dtcm_icb_cmd_addr_to_axi),
.ctl(ctl),
.cmd_ack(cmd_ack),

.wrdata_vld(wrdata_vld),
.wrdata(lsu2dtcm_icb_cmd_wdata),
.wrdata_bvld(lsu2dtcm_icb_cmd_wmask),
.wrdata_cmptd(wrdata_cmptd),
.wrdata_rdy(wrdata_rdy),
.wrdata_sts_vld(wrdata_sts_vld),
.wrdata_sts(),

.rddata_rdy(rddata_rdy),
.rddata_vld(rddata_vld),
.rddata(lsu2dtcm_icb_rsp_rdata),
.rddata_bvld(),
.rddata_cmptd(rddata_cmptd),
.rddata_sts(),

.wdog_mask(1'b0),

// AXI write address channel signals

.axi_wready(s_axi_awready), // Indicates slave is ready to accept a // write address
.axi_wid(s_axi_awid),    // Write ID
.axi_waddr(s_axi_awaddr),  // Write address
.axi_wlen(s_axi_awlen),   // Write Burst Length
.axi_wsize(s_axi_awsize),  // Write Burst size
.axi_wburst(s_axi_awburst), // Write Burst type
.axi_wlock(s_axi_awlock),  // Write lock type
.axi_wcache(s_axi_awcache), // Write Cache type
.axi_wprot(s_axi_awprot),  // Write Protection type
.axi_wvalid(s_axi_awvalid), // Write address valid
// AXI write data channel signals

.axi_wd_wready(s_axi_wready),  // Write data ready
.axi_wd_data(s_axi_wdata),    // Write data
.axi_wd_strb(s_axi_wstrb),    // Write strobes
.axi_wd_last(s_axi_wlast),    // Last write transaction   
.axi_wd_valid(s_axi_wvalid),   // Write valid
// AXI write response channel signals
.axi_wd_bid(s_axi_bid),     // Response ID
.axi_wd_bresp(s_axi_bresp),   // Write response
.axi_wd_bvalid(s_axi_bvalid),  // Write reponse valid
.axi_wd_bready(s_axi_bready),  // Response ready
// AXI read address channel signals
.axi_rready(s_axi_arready),     // Read address ready
.axi_rid(s_axi_arid),        // Read ID
.axi_raddr(s_axi_araddr),      // Read address
.axi_rlen(s_axi_arlen),       // Read Burst Length
.axi_rsize(s_axi_arsize),      // Read Burst size
.axi_rburst(s_axi_arburst),     // Read Burst type
.axi_rlock(s_axi_arlock),      // Read lock type
.axi_rcache(s_axi_arcache),     // Read Cache type
.axi_rprot(s_axi_arprot),      // Read Protection type
.axi_rvalid(s_axi_arvalid),     // Read address valid
// AXI read data channel signals   
.axi_rd_bid(s_axi_bid),     // Response ID
.axi_rd_rresp(s_axi_rresp),   // Read response
.axi_rd_rvalid(s_axi_rvalid),  // Read reponse valid
.axi_rd_data(s_axi_rdata),    // Read data
.axi_rd_last(s_axi_rlast),    // Read last
.axi_rd_rready(s_axi_rready)  // Read Response ready

);

endmodule
