// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vscb_vx_cmp (
    addr,
    vx_pending,
    vx_addr,
    vx_len,
    hit
);
parameter VRF_AW = 5;
parameter VRF_LW = 3;
input [VRF_AW - 1:0] addr;
input vx_pending;
input [VRF_AW - 1:0] vx_addr;
input [VRF_LW - 1:0] vx_len;
output hit;





// 22c60333 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VRF_AW:0] s0;
wire s1 = addr >= vx_addr;
wire s2 = {1'b0,addr} <= s0;
assign s0 = vx_addr[VRF_AW - 1:0] + {{(VRF_AW - VRF_LW){1'b0}},vx_len[VRF_LW - 1:0]};
assign hit = vx_pending & s1 & s2;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

