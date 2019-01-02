-makelib ies_lib/xil_defaultlib -sv \
  "F:/software/xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "F:/software/xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/mmcm_1/mmcm_clk_wiz.v" \
  "../../../../project_1.srcs/sources_1/ip/mmcm_1/mmcm.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

