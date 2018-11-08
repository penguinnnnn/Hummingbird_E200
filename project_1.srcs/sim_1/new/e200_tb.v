`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/04 17:18:09
// Design Name: 
// Module Name: e200_tb
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


module e200_tb(

    );
    
     reg clk;
     reg rst_n; 
   
     wire led_0;
     wire led_1;
     wire led_2;
     wire led_3;
   
     // RGB LEDs, 3 pins each
      wire led0_r;
      wire led0_g;
      wire led0_b;
      wire led1_r;
      wire led1_g;
      wire led1_b;
      wire led2_r;
      wire led2_g;
      wire led2_b;
      wire ck_miso;
      wire ck_mosi;
      wire ck_ss;
      wire ck_sck;
      wire jd_0;
      wire jd_1;
      wire jd_2;
      wire jd_4;
      wire jd_5;
      wire jd_6; 
      wire qspi_cs;
      wire qspi_sck;
      wire [3:0] qspi_dq;


   system e200_tb(
        .CLK100MHZ(clk),
        .ck_rst(rst_n),
      /*
        .led_0(led_0),
        .led_1(led_1),
        .led_2(led_2),
        .led_3(led_3),
        
          // RGB LEDs, 3 pins each
         .led0_r(led_r),
         .led0_g(led0_g),
         .led0_b(led0_b),
         .led1_r(led1_r),
         .led1_g(led1_g),
         .led1_b(led1_b),
         .led2_r(led2_r),
         .led2_g(led2_g),
         .led2_b(led2_b),
         */
         .ck_miso(ck_miso),
         .ck_mosi(ck_misi),
         .ck_ss(ck_ss),
         .ck_sck(ck_sck),
         .jd_0(jd_0),
         .jd_1(jd_1),
         .jd_2(jd_2),
         .jd_4(jd_4),
         .jd_5(jd_5),
         .jd_6(jd_6),
         .qspi_cs(qspi_cs),
         .qspi_sck(qspi_sck),
         .qspi_dq(qspi_dq)

         

   );
 initial begin
            clk = 1;
            rst_n =0;
            #801 rst_n = 1;
        
 end
        
 always # 100 clk = ~clk;   
    
endmodule
