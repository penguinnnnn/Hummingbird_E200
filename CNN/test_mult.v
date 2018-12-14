`include "define.v"
module test_mult();
    reg clk;
    wire [`OUTPUT_BITWIDTH-1:0] out;
    reg [`INPUT_BIT-1:0] X;
    wire [15:0] x11, x12, x13, x21, x22, x23, x31, x32, x33;
    assign x11 = core.PE.x[15:0];
    assign x12 = core.PE.x[16 * 2 - 1:16 * 1];
    assign x13 = core.PE.x[16 * 3 - 1:16 * 2];
    assign x21 = core.PE.x[16 * 4 - 1:16 * 3];
    assign x22 = core.PE.x[16 * 5 - 1:16 * 4];
    assign x23 = core.PE.x[16 * 6 - 1:16 * 5];
    assign x31 = core.PE.x[16 * 7 - 1:16 * 6];
    assign x32 = core.PE.x[16 * 8 - 1:16 * 7];
    assign x33 = core.PE.x[16 * 9 - 1:16 * 8];
    reg [`KERNEL_BIT-1:0] kernel;
    wire complete;
    reg rst_n;
    conv_op core(1'b1, complete, clk, rst_n, X, kernel, out); // our module
    // fill some data into the kernel and X
    genvar i;
    generate
    for (i = 0; i < 9; i = i + 1) begin
        initial begin
            kernel[(i + 1) * 16 - 1:i * 16] = 16'b0000_0000_0001_0000;
        end
    end
    for (i = 0; i < 3; i = i + 1) begin
        initial begin
            # 30
            X[(i + 1) * 16 - 1:i * 16] = 16'b0000_0000_0001_0000;
            X[16 * 7 + (i + 1) * 16 - 1: 16 * 7 + i * 16] = 16'b0000_0000_0001_0000;
            //X[16 * 14 + (i + 1) * 16 - 1: 16 * 14 + i * 16] = 16'b0000_0000_0001_0000;
        end
    end
    endgenerate
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    initial begin
        X = 0;
        rst_n = 0;
        #20 rst_n = 1;
        #20 rst_n = 0;
    end
    always @(posedge clk) begin
        if (complete == 1'b1)
            $finish;
    end
endmodule
