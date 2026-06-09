// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_stub (
    vpu_vfdiv_clk,
    vpu_reset_n,
    vfdiv_standby_ready,
    vfdiv_cmt_kill,
    vfdiv_cmt_valid,
    vfdiv_cmt_op1,
    vfdiv_dispatch_frm,
    vfdiv_dispatch_ctrl,
    vfdiv_dispatch_vd_len,
    vfdiv_dispatch_vs1_len,
    vfdiv_dispatch_vs2_len,
    vfdiv_dispatch_op1,
    vfdiv_dispatch_op1_hazard,
    vfdiv_dispatch_ready,
    vfdiv_dispatch_v0t,
    vfdiv_dispatch_valid,
    vfdiv_vs1_rdata,
    vfdiv_vs1_rready,
    vfdiv_vs1_rvalid,
    vfdiv_vs2_rdata,
    vfdiv_vs2_rready,
    vfdiv_vs2_rvalid,
    vfdiv_fflags_set,
    vfdiv_vd_wdata,
    vfdiv_vd_wmask,
    vfdiv_vd_wready,
    vfdiv_vd_wvalid
);
parameter ELEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter FLEN = 64;
parameter VFDIV_DLEN = 512;
parameter VRF_LW = 4;
localparam XLEN = 64;
input vpu_vfdiv_clk;
input vpu_reset_n;
output vfdiv_standby_ready;
input vfdiv_cmt_kill;
input vfdiv_cmt_valid;
input [(XLEN - 1):0] vfdiv_cmt_op1;
input [(39 - 1):0] vfdiv_dispatch_ctrl;
input [(VRF_LW - 1):0] vfdiv_dispatch_vd_len;
input [(VRF_LW - 1):0] vfdiv_dispatch_vs1_len;
input [(VRF_LW - 1):0] vfdiv_dispatch_vs2_len;
input [(XLEN - 1):0] vfdiv_dispatch_op1;
input vfdiv_dispatch_op1_hazard;
output vfdiv_dispatch_ready;
input [(VLEN - 1):0] vfdiv_dispatch_v0t;
input vfdiv_dispatch_valid;
input [2:0] vfdiv_dispatch_frm;
input [(DLEN - 1):0] vfdiv_vs1_rdata;
output vfdiv_vs1_rready;
input vfdiv_vs1_rvalid;
input [(DLEN - 1):0] vfdiv_vs2_rdata;
output vfdiv_vs2_rready;
input vfdiv_vs2_rvalid;
output [4:0] vfdiv_fflags_set;
output [(DLEN - 1):0] vfdiv_vd_wdata;
output [(DLEN / 8) - 1:0] vfdiv_vd_wmask;
input vfdiv_vd_wready;
output vfdiv_vd_wvalid;





// c14f182f rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign vfdiv_dispatch_ready = 1'b0;
assign vfdiv_vs1_rready = 1'b0;
assign vfdiv_vs2_rready = 1'b0;
assign vfdiv_fflags_set = 5'b0;
assign vfdiv_vd_wdata = {DLEN{1'b0}};
assign vfdiv_vd_wmask = {DLEN / 8{1'b0}};
assign vfdiv_vd_wvalid = 1'b0;
assign vfdiv_standby_ready = 1'b1;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

