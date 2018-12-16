`include "define.v"

module e203_eai_conv_op(
    input i_valid,
    output i_ready, input clk,
    input rst_n,
    input[`INPUT_BIT-1:0] X,
    input[`KERNEL_BIT-1:0] kernel,
    output[`OUTPUT_BITWIDTH-1:0] out
    );
    
    reg [`COORD_BIT-1:0] x, y;
    reg complete;
    assign i_ready=complete;
    // coordinate control
    always @(posedge(clk)) begin
        // reset
        if (rst_n == 1) begin
            x <= `COORD_BIT'b0;
            y <= `COORD_BIT'b0;
        end
        else
            if (x == `COORD_BIT'd4) begin
                x  <= `COORD_BIT'b0;
                if (y == `COORD_BIT'd4) begin
                    y <= `COORD_BIT'b0;
                    complete <= 1'b1;
                end
                else begin
                    y <= y + `COORD_BIT'b1;
                    complete <= 1'b0;
                end
            end
            else begin
                x <= x + `COORD_BIT'b1;
                complete <= 1'b0;
            end
    end
    // fetch the 3x3 data from the X register
    // generate window selectors
    genvar i;
    genvar j;
    wire [`INPUT_PIXEL_BITWITH-1:0] window_wire [`KERNEL_H-1:0][`KERNEL_W-1:0];
    generate
    for (j = 0; j < `KERNEL_H; j = j + 1) begin : selector_height_loop
      for (i = 0; i < `KERNEL_W; i = i + 1) begin : selector_width_loop
        e203_eai_conv_value_selector u_e203_eai_conv_selector(
          .clk(clk),
          .X(X),
          .x(x + i),
          .y(y + j),
          .value_out(window_wire[j][i])
        );
      end // for i
    end // for j
    endgenerate
    wire [`WINDOW_BIT-1:0]window_out;
    genvar n;
    genvar m;
    generate
    for (n = 0; n < `KERNEL_H; n = n + 1) begin : kernel_h_loop
      for (m = 0; m < `KERNEL_W; m = m + 1) begin : kernel_w_loop
        assign window_out[(n * `KERNEL_W + m + 1) * `INPUT_PIXEL_BITWITH-1:(n * `KERNEL_W + m) * `INPUT_PIXEL_BITWITH] = window_wire[n][m];
      end // for m
    end // for n
    endgenerate
    
    e203_eai_conv_kernel3 u_e203_eai_conv_kernel3(.x(window_out), .kernel(kernel), .out(out), .clk(clk));
endmodule
