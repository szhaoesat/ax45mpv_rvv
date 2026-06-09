// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vconn_vs (
    vrf_r_data,
    vrf_r_bypass_sel,
    vrf_w0_data,
    vrf_w0_mask,
    vrf_w1_data,
    vrf_w1_mask,
    vrf_w2_data,
    vrf_w2_mask,
    vrf_w3_data,
    vrf_w3_mask,
    vs_rdata
);
parameter ELEN = 512;
parameter BYPASSW = 4;
input [ELEN - 1:0] vrf_r_data;
input [BYPASSW - 1:0] vrf_r_bypass_sel;
input [ELEN - 1:0] vrf_w0_data;
input [(ELEN / 8) - 1:0] vrf_w0_mask;
input [ELEN - 1:0] vrf_w1_data;
input [(ELEN / 8) - 1:0] vrf_w1_mask;
input [ELEN - 1:0] vrf_w2_data;
input [(ELEN / 8) - 1:0] vrf_w2_mask;
input [ELEN - 1:0] vrf_w3_data;
input [(ELEN / 8) - 1:0] vrf_w3_mask;
output [ELEN - 1:0] vs_rdata;





// 96ffe651 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [ELEN - 1:0] s0;
wire [(ELEN / 8) - 1:0] s1;
wire [ELEN - 1:0] s2;
kv_mux_onehot #(
    .N(BYPASSW),
    .W(ELEN + (ELEN / 8))
) u_bypass (
    .out({s1,s0}),
    .sel(vrf_r_bypass_sel),
    .in({vrf_w3_mask,vrf_w3_data,vrf_w2_mask,vrf_w2_data,vrf_w1_mask,vrf_w1_data,vrf_w0_mask,vrf_w0_data})
);
kv_bit_expand #(
    .N(ELEN / 8),
    .M(8)
) u_bypass_wmask_bit (
    .out(s2),
    .in(s1)
);
assign vs_rdata = (~s2 & vrf_r_data) | (s2 & s0);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

