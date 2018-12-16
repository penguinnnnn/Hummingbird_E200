`include "define.v"

module e203_eai_conv_value_selector( // select value from X using (x, y) coordinate
  input clk,
  input [`INPUT_BIT-1:0] X,
  input [`COORD_BIT-1:0] x,
  input [`COORD_BIT-1:0] y,
  output reg[`INPUT_PIXEL_BITWITH-1:0] value_out
);
wire [`INPUT_PIXEL_BITWITH-1:0] buffer_wire [`INPUT_H-1:0][`INPUT_W-1:0];
reg [`INPUT_PIXEL_BITWITH-1:0] width_selector_wire [`INPUT_H-1:0];
//fill wire with input data
genvar j;
genvar i;
generate
for (j = 0; j < `INPUT_H; j = j + 1) begin : buffer_height_loop
  for (i = 0; i < `INPUT_W; i = i + 1) begin : buffer_width_loop
    assign buffer_wire[j][i] = X[(j * `INPUT_W + i + 1) * `INPUT_PIXEL_BITWITH-1:(j * `INPUT_PIXEL_BITWITH)];
  end // for i
end // for j
endgenerate
// width selector
genvar m;
generate
for (m = 0; m < `INPUT_H; m = m + 1) begin : width_selector
  always @(*) begin
    case(y)
      `COORD_BIT'd0: width_selector_wire[m] = buffer_wire[0][m];
      `COORD_BIT'd1: width_selector_wire[m] = buffer_wire[1][m];
      `COORD_BIT'd2: width_selector_wire[m] = buffer_wire[2][m];
      `COORD_BIT'd3: width_selector_wire[m] = buffer_wire[3][m];
      `COORD_BIT'd4: width_selector_wire[m] = buffer_wire[4][m];
      `COORD_BIT'd5: width_selector_wire[m] = buffer_wire[5][m];
      `COORD_BIT'd6: width_selector_wire[m] = buffer_wire[6][m];
      default: width_selector_wire[m] = `INPUT_PIXEL_BITWITH'd0;
    endcase
  end // always
end // for
endgenerate

always @(*) begin
  case(x)
    `COORD_BIT'd0: value_out = width_selector_wire[0];
    `COORD_BIT'd1: value_out = width_selector_wire[1];
    `COORD_BIT'd2: value_out = width_selector_wire[2];
    `COORD_BIT'd3: value_out = width_selector_wire[3];
    `COORD_BIT'd4: value_out = width_selector_wire[4];
    `COORD_BIT'd5: value_out = width_selector_wire[5];
    `COORD_BIT'd6: value_out = width_selector_wire[6];
    default: value_out = `INPUT_PIXEL_BITWITH'd0;
  endcase
end // always
endmodule
