// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_stub (
    vsp_standby_ready,
    vsp_vd_wlast,
    ace_streaming_data_in,
    ace_streaming_data_in_ready,
    ace_streaming_data_in_valid,
    cp_cpu_rdata,
    cp_cpu_rdata_ready,
    cp_cpu_rdata_valid,
    vpu_vsp_clk,
    vpu_reset_n,
    vsp_srf_waddr,
    vsp_srf_wdata,
    vsp_srf_wfrf,
    vsp_srf_wready,
    vsp_srf_wvalid,
    ace_streaming_data_out,
    ace_streaming_data_out_bwe,
    ace_streaming_data_out_ready,
    ace_streaming_data_out_valid,
    cpu_cp_wdata,
    cpu_cp_wdata_bwe,
    cpu_cp_wdata_ready,
    cpu_cp_wdata_valid,
    vsp_vd_wready,
    vsp_vd_wdata,
    vsp_vd_wvalid,
    vsp_vd_wmask,
    vpu_sp_ex_done,
    vpu_sp_ex_store,
    vpu_sp_ex_error,
    vsp_cmt_kill,
    vsp_cmt_op1,
    vsp_cmt_valid,
    vsp_dispatch_ctrl,
    vsp_dispatch_op1,
    vsp_dispatch_op1_hazard,
    vsp_dispatch_op2,
    vsp_dispatch_ready,
    vsp_dispatch_v0t,
    vsp_dispatch_valid,
    vsp_dispatch_vd_len,
    vsp_dispatch_vs3_len,
    vsp_vs3_rdata,
    vsp_vs3_rlast,
    vsp_vs3_rready,
    vsp_vs3_rvalid
);
parameter XLEN = 64;
parameter DLEN = 512;
parameter VLEN = 512;
parameter VSP_DATA_WIDTH = 512;
parameter VEQ_DEPTH = 4;
parameter VRF_LW = 3;
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
localparam VS3_DEPTH = 2;
localparam ST_BUF_DEPTH = 2;
localparam LD_BUF_DEPTH = 2;
localparam VD_DEPTH = 2;
localparam OFFSET_BITS = $clog2(DLEN / 8);
output vsp_standby_ready;
input vsp_vd_wlast;
input [(VSP_DATA_WIDTH - 1):0] ace_streaming_data_in;
output ace_streaming_data_in_ready;
input ace_streaming_data_in_valid;
input [(VSP_DATA_WIDTH - 1):0] cp_cpu_rdata;
output cp_cpu_rdata_ready;
input cp_cpu_rdata_valid;
input vpu_vsp_clk;
input vpu_reset_n;
output [4:0] vsp_srf_waddr;
output [63:0] vsp_srf_wdata;
output vsp_srf_wfrf;
input vsp_srf_wready;
output vsp_srf_wvalid;
output [(VSP_DATA_WIDTH - 1):0] ace_streaming_data_out;
output [(VSP_DATA_WIDTH / 8) - 1:0] ace_streaming_data_out_bwe;
input ace_streaming_data_out_ready;
output ace_streaming_data_out_valid;
output [(VSP_DATA_WIDTH - 1):0] cpu_cp_wdata;
output [(VSP_DATA_WIDTH / 8) - 1:0] cpu_cp_wdata_bwe;
input cpu_cp_wdata_ready;
output cpu_cp_wdata_valid;
input vsp_vd_wready;
output [(DLEN - 1):0] vsp_vd_wdata;
output vsp_vd_wvalid;
output [(DLEN / 8) - 1:0] vsp_vd_wmask;
input vpu_sp_ex_done;
input vpu_sp_ex_store;
input vpu_sp_ex_error;
input vsp_cmt_kill;
input [(XLEN - 1):0] vsp_cmt_op1;
input vsp_cmt_valid;
input [(30 - 1):0] vsp_dispatch_ctrl;
input [(XLEN - 1):0] vsp_dispatch_op1;
input vsp_dispatch_op1_hazard;
input [(XLEN - 1):0] vsp_dispatch_op2;
output vsp_dispatch_ready;
input [(VLEN - 1):0] vsp_dispatch_v0t;
input vsp_dispatch_valid;
input [(VRF_LW - 1):0] vsp_dispatch_vd_len;
input [(VRF_LW - 1):0] vsp_dispatch_vs3_len;
input [(DLEN - 1):0] vsp_vs3_rdata;
input vsp_vs3_rlast;
output vsp_vs3_rready;
input vsp_vs3_rvalid;





// 62681f7d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign vsp_standby_ready = 1'b1;
wire nds_unused_vsp_vd_wlast = vsp_vd_wlast;
wire [(VSP_DATA_WIDTH - 1):0] nds_unused_ace_streaming_data_in = ace_streaming_data_in;
assign ace_streaming_data_in_ready = 1'b0;
wire nds_unused_ace_streaming_data_in_valid = ace_streaming_data_in_valid;
wire [(VSP_DATA_WIDTH - 1):0] nds_unused_cp_cpu_rdata = cp_cpu_rdata;
assign cp_cpu_rdata_ready = 1'b0;
wire nds_unused_cp_cpu_rdata_valid = cp_cpu_rdata_valid;
wire nds_unused_vpu_vsp_clk = vpu_vsp_clk;
wire nds_unused_vpu_reset_n = vpu_reset_n;
assign vsp_srf_waddr = 5'b0;
assign vsp_srf_wdata = 64'b0;
assign vsp_srf_wfrf = 1'b0;
wire nds_unused_vsp_srf_wready = vsp_srf_wready;
assign vsp_srf_wvalid = 1'b0;
assign ace_streaming_data_out = {((VSP_DATA_WIDTH - 1) + 1){1'b0}};
assign ace_streaming_data_out_bwe = {(VSP_DATA_WIDTH / 8){1'b0}};
wire nds_unused_ace_streaming_data_out_ready = ace_streaming_data_out_ready;
assign ace_streaming_data_out_valid = 1'b0;
assign cpu_cp_wdata = {((VSP_DATA_WIDTH - 1) + 1){1'b0}};
assign cpu_cp_wdata_bwe = {(VSP_DATA_WIDTH / 8){1'b0}};
wire nds_unused_cpu_cp_wdata_ready = cpu_cp_wdata_ready;
assign cpu_cp_wdata_valid = 1'b0;
wire nds_unused_vsp_vd_wready = vsp_vd_wready;
assign vsp_vd_wdata = {((DLEN - 1) + 1){1'b0}};
assign vsp_vd_wvalid = 1'b0;
assign vsp_vd_wmask = {(DLEN / 8){1'b0}};
wire nds_unused_vpu_sp_ex_done = vpu_sp_ex_done;
wire nds_unused_vpu_sp_ex_store = vpu_sp_ex_store;
wire nds_unused_vpu_sp_ex_error = vpu_sp_ex_error;
wire nds_unused_vsp_cmt_kill = vsp_cmt_kill;
wire [(XLEN - 1):0] nds_unused_vsp_cmt_op1 = vsp_cmt_op1;
wire nds_unused_vsp_cmt_valid = vsp_cmt_valid;
wire [(30 - 1):0] nds_unused_vsp_dispatch_ctrl = vsp_dispatch_ctrl;
wire [(XLEN - 1):0] nds_unused_vsp_dispatch_op1 = vsp_dispatch_op1;
wire nds_unused_vsp_dispatch_op1_hazard = vsp_dispatch_op1_hazard;
wire [(XLEN - 1):0] nds_unused_vsp_dispatch_op2 = vsp_dispatch_op2;
assign vsp_dispatch_ready = 1'b0;
wire [(VLEN - 1):0] nds_unused_vsp_dispatch_v0t = vsp_dispatch_v0t;
wire nds_unused_vsp_dispatch_valid = vsp_dispatch_valid;
wire [(VRF_LW - 1):0] nds_unused_vsp_dispatch_vd_len = vsp_dispatch_vd_len;
wire [(VRF_LW - 1):0] nds_unused_vsp_dispatch_vs3_len = vsp_dispatch_vs3_len;
wire [(DLEN - 1):0] nds_unused_vsp_vs3_rdata = vsp_vs3_rdata;
wire nds_unused_vsp_vs3_rlast = vsp_vs3_rlast;
assign vsp_vs3_rready = 1'b0;
wire nds_unused_vsp_vs3_rvalid = vsp_vs3_rvalid;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

