// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp (
    vsp_standby_ready,
    vsp_vd_wlast,
    ace_streaming_data_in,
    ace_streaming_data_in_ready,
    ace_streaming_data_in_valid,
    cp_cpu_rdata,
    cp_cpu_rdata_ready,
    cp_cpu_rdata_valid,
    vpu_reset_n,
    vpu_vsp_clk,
    vpu_sp_ex_done,
    vpu_sp_ex_error,
    vpu_sp_ex_store,
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
localparam ACE_FSP_FP64_SUPPORT = 0;
localparam ACE_FSP_FP16_SUPPORT = 0;
localparam ACE_FSP_BF16_SUPPORT = 0;
output vsp_standby_ready;
input vsp_vd_wlast;
input [(VSP_DATA_WIDTH - 1):0] ace_streaming_data_in;
output ace_streaming_data_in_ready;
input ace_streaming_data_in_valid;
input [(VSP_DATA_WIDTH - 1):0] cp_cpu_rdata;
output cp_cpu_rdata_ready;
input cp_cpu_rdata_valid;
input vpu_reset_n;
input vpu_vsp_clk;
input vpu_sp_ex_done;
input vpu_sp_ex_error;
input vpu_sp_ex_store;
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





// d7656bfd rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(VSP_DATA_WIDTH - 1):0] cp2srf_rdata;
wire cp2srf_rvalid;
wire cp2vrf_dummy_ex_done;
wire [(VSP_DATA_WIDTH - 1):0] cp2vrf_rdata;
wire cp2vrf_rvalid;
wire vsp_cp_ctrl_standby_ready;
wire cp2srf_rlast;
wire cp2srf_rready;
wire veq2srf_ld_ctrl_cp_grant;
wire veq2srf_ld_ctrl_rf_grant;
wire vsp_srf_ld_ctrl_standby_ready;
wire veq2st_ctrl_cp_grant;
wire veq2st_ctrl_rf_grant;
wire vs3_wready;
wire vsp_st_ctrl_standby_ready;
wire nds_unused_vd_wready;
wire nds_unused_vsp_vd_wvalid;
wire vd_wready;
wire veq2srf_ld_cp_last;
wire [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_cp2rf_element;
wire [2:0] veq2srf_ld_ctrl_cp_eew;
wire [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_emask;
wire veq2srf_ld_ctrl_frf;
wire [(VEQ_DEPTH - 1):0] veq2srf_ld_ctrl_idx;
wire [(OFFSET_BITS - 1):0] veq2srf_ld_ctrl_offset;
wire [1:0] veq2srf_ld_ctrl_rf_eew;
wire veq2srf_ld_ctrl_sext;
wire [4:0] veq2srf_ld_ctrl_srf_idx;
wire veq2srf_ld_ctrl_valid;
wire veq2srf_ld_destination_srf;
wire veq2srf_ld_partial_cp;
wire veq2srf_ld_path_bypass;
wire veq2srf_ld_path_merge;
wire veq2srf_ld_source_cp;
wire veq2st_cp_last;
wire veq2st_ctrl_cmted;
wire [2:0] veq2st_ctrl_cp_eew;
wire [(DLEN / 8) - 1:0] veq2st_ctrl_emask;
wire veq2st_ctrl_error;
wire [(VEQ_DEPTH - 1):0] veq2st_ctrl_idx;
wire veq2st_ctrl_kill;
wire [(OFFSET_BITS - 1):0] veq2st_ctrl_offset;
wire [(XLEN - 1):0] veq2st_ctrl_op1;
wire veq2st_ctrl_op1_hazard;
wire [3:0] veq2st_ctrl_ratio;
wire [1:0] veq2st_ctrl_rf_eew;
wire veq2st_ctrl_valid;
wire veq2st_destination_cp;
wire veq2st_drop_vs;
wire veq2st_path_bypass;
wire veq2st_path_merge;
wire veq2st_source_dummy_end;
wire veq2st_source_dummy_start;
wire veq2st_source_op1;
wire veq2st_source_vs;
wire veq2vrf_ld_cp_last;
wire veq2vrf_ld_ctrl_bf16;
wire [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_cp2rf_element;
wire [2:0] veq2vrf_ld_ctrl_cp_eew;
wire [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_emask;
wire veq2vrf_ld_ctrl_fcvt;
wire [(VEQ_DEPTH - 1):0] veq2vrf_ld_ctrl_idx;
wire [(OFFSET_BITS - 1):0] veq2vrf_ld_ctrl_offset;
wire [1:0] veq2vrf_ld_ctrl_rf_eew;
wire veq2vrf_ld_ctrl_sext;
wire veq2vrf_ld_ctrl_valid;
wire veq2vrf_ld_destination_vrf;
wire veq2vrf_ld_dummy_all;
wire veq2vrf_ld_dummy_vd;
wire veq2vrf_ld_partial_cp;
wire veq2vrf_ld_path_bypass;
wire veq2vrf_ld_path_merge;
wire veq2vrf_ld_source_cp;
wire veq2vrf_ld_vrf_last;
wire veq_cmt_cp2ld_dummy;
wire veq_cmt_cp2ld_grant;
wire veq_cmt_cp2ld_type;
wire veq_cmt_vs2st_grant;
wire [(VEQ_DEPTH - 1):0] veq_cmt_vs2st_idx;
wire veq_cmt_vs2st_kill;
wire veq_dispatch_vs2st_grant;
wire [(VEQ_DEPTH - 1):0] veq_dispatch_vs2st_idx;
wire vsp_veq_standby_ready;
wire cp2vrf_dummy_ex_ready;
wire cp2vrf_rlast;
wire cp2vrf_rready;
wire [(DLEN - 1):0] vd_wdata;
wire [(DLEN / 8) - 1:0] vd_wmask;
wire vd_wvalid;
wire veq2vrf_ld_ctrl_cp_grant;
wire veq2vrf_ld_ctrl_rf_grant;
wire vsp_vrf_ld_ctrl_standby_ready;
wire [(DLEN - 1):0] vs3_wdata;
wire [(VEQ_DEPTH - 1):0] vs3_widx;
wire vs3_wlast;
wire vs3_wvalid;
wire vsp_vs_ctrl_standby_ready;
assign vsp_standby_ready = vsp_veq_standby_ready & vsp_vs_ctrl_standby_ready & vsp_st_ctrl_standby_ready & vsp_srf_ld_ctrl_standby_ready & vsp_vrf_ld_ctrl_standby_ready & vsp_cp_ctrl_standby_ready & ~vsp_vd_wvalid;
wire nds_unused_vsp_vd_wlast = vsp_vd_wlast;
kv_vsp_veq #(
    .ACE_SP_MODE(ACE_SP_MODE),
    .DLEN(DLEN),
    .OFFSET_BITS(OFFSET_BITS),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .VSP_DATA_WIDTH(VSP_DATA_WIDTH),
    .XLEN(XLEN)
) u_veq (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .vsp_dispatch_valid(vsp_dispatch_valid),
    .vsp_dispatch_op1(vsp_dispatch_op1),
    .vsp_dispatch_op1_hazard(vsp_dispatch_op1_hazard),
    .vsp_dispatch_op2(vsp_dispatch_op2),
    .vsp_dispatch_ctrl(vsp_dispatch_ctrl),
    .vsp_dispatch_v0t(vsp_dispatch_v0t),
    .vsp_dispatch_vs3_len(vsp_dispatch_vs3_len),
    .vsp_dispatch_vd_len(vsp_dispatch_vd_len),
    .vsp_dispatch_ready(vsp_dispatch_ready),
    .vsp_cmt_valid(vsp_cmt_valid),
    .vsp_cmt_op1(vsp_cmt_op1),
    .vsp_cmt_kill(vsp_cmt_kill),
    .veq_dispatch_vs2st_grant(veq_dispatch_vs2st_grant),
    .veq_dispatch_vs2st_idx(veq_dispatch_vs2st_idx),
    .veq_cmt_vs2st_grant(veq_cmt_vs2st_grant),
    .veq_cmt_vs2st_kill(veq_cmt_vs2st_kill),
    .veq_cmt_vs2st_idx(veq_cmt_vs2st_idx),
    .veq_cmt_cp2ld_grant(veq_cmt_cp2ld_grant),
    .veq_cmt_cp2ld_type(veq_cmt_cp2ld_type),
    .veq_cmt_cp2ld_dummy(veq_cmt_cp2ld_dummy),
    .veq2st_ctrl_valid(veq2st_ctrl_valid),
    .veq2st_ctrl_cmted(veq2st_ctrl_cmted),
    .veq2st_ctrl_error(veq2st_ctrl_error),
    .veq2st_ctrl_kill(veq2st_ctrl_kill),
    .veq2st_ctrl_idx(veq2st_ctrl_idx),
    .veq2st_ctrl_op1(veq2st_ctrl_op1),
    .veq2st_ctrl_op1_hazard(veq2st_ctrl_op1_hazard),
    .veq2st_ctrl_offset(veq2st_ctrl_offset),
    .veq2st_ctrl_cp_eew(veq2st_ctrl_cp_eew),
    .veq2st_ctrl_rf_eew(veq2st_ctrl_rf_eew),
    .veq2st_ctrl_emask(veq2st_ctrl_emask),
    .veq2st_ctrl_ratio(veq2st_ctrl_ratio),
    .veq2st_source_op1(veq2st_source_op1),
    .veq2st_source_vs(veq2st_source_vs),
    .veq2st_source_dummy_start(veq2st_source_dummy_start),
    .veq2st_source_dummy_end(veq2st_source_dummy_end),
    .veq2st_destination_cp(veq2st_destination_cp),
    .veq2st_drop_vs(veq2st_drop_vs),
    .veq2st_cp_last(veq2st_cp_last),
    .veq2st_path_bypass(veq2st_path_bypass),
    .veq2st_path_merge(veq2st_path_merge),
    .veq2st_ctrl_rf_grant(veq2st_ctrl_rf_grant),
    .veq2st_ctrl_cp_grant(veq2st_ctrl_cp_grant),
    .vpu_sp_ex_done(vpu_sp_ex_done),
    .vpu_sp_ex_store(vpu_sp_ex_store),
    .vpu_sp_ex_error(vpu_sp_ex_error),
    .veq2srf_ld_ctrl_valid(veq2srf_ld_ctrl_valid),
    .veq2srf_ld_ctrl_idx(veq2srf_ld_ctrl_idx),
    .veq2srf_ld_ctrl_offset(veq2srf_ld_ctrl_offset),
    .veq2srf_ld_ctrl_cp_eew(veq2srf_ld_ctrl_cp_eew),
    .veq2srf_ld_ctrl_rf_eew(veq2srf_ld_ctrl_rf_eew),
    .veq2srf_ld_ctrl_emask(veq2srf_ld_ctrl_emask),
    .veq2srf_ld_ctrl_cp2rf_element(veq2srf_ld_ctrl_cp2rf_element),
    .veq2srf_ld_ctrl_sext(veq2srf_ld_ctrl_sext),
    .veq2srf_ld_ctrl_frf(veq2srf_ld_ctrl_frf),
    .veq2srf_ld_ctrl_srf_idx(veq2srf_ld_ctrl_srf_idx),
    .veq2srf_ld_source_cp(veq2srf_ld_source_cp),
    .veq2srf_ld_destination_srf(veq2srf_ld_destination_srf),
    .veq2srf_ld_partial_cp(veq2srf_ld_partial_cp),
    .veq2srf_ld_cp_last(veq2srf_ld_cp_last),
    .veq2srf_ld_path_bypass(veq2srf_ld_path_bypass),
    .veq2srf_ld_path_merge(veq2srf_ld_path_merge),
    .veq2srf_ld_ctrl_rf_grant(veq2srf_ld_ctrl_rf_grant),
    .veq2srf_ld_ctrl_cp_grant(veq2srf_ld_ctrl_cp_grant),
    .veq2vrf_ld_ctrl_valid(veq2vrf_ld_ctrl_valid),
    .veq2vrf_ld_ctrl_idx(veq2vrf_ld_ctrl_idx),
    .veq2vrf_ld_ctrl_offset(veq2vrf_ld_ctrl_offset),
    .veq2vrf_ld_ctrl_cp_eew(veq2vrf_ld_ctrl_cp_eew),
    .veq2vrf_ld_ctrl_rf_eew(veq2vrf_ld_ctrl_rf_eew),
    .veq2vrf_ld_ctrl_emask(veq2vrf_ld_ctrl_emask),
    .veq2vrf_ld_ctrl_cp2rf_element(veq2vrf_ld_ctrl_cp2rf_element),
    .veq2vrf_ld_ctrl_sext(veq2vrf_ld_ctrl_sext),
    .veq2vrf_ld_ctrl_fcvt(veq2vrf_ld_ctrl_fcvt),
    .veq2vrf_ld_ctrl_bf16(veq2vrf_ld_ctrl_bf16),
    .veq2vrf_ld_source_cp(veq2vrf_ld_source_cp),
    .veq2vrf_ld_destination_vrf(veq2vrf_ld_destination_vrf),
    .veq2vrf_ld_partial_cp(veq2vrf_ld_partial_cp),
    .veq2vrf_ld_cp_last(veq2vrf_ld_cp_last),
    .veq2vrf_ld_dummy_vd(veq2vrf_ld_dummy_vd),
    .veq2vrf_ld_dummy_all(veq2vrf_ld_dummy_all),
    .veq2vrf_ld_vrf_last(veq2vrf_ld_vrf_last),
    .veq2vrf_ld_path_bypass(veq2vrf_ld_path_bypass),
    .veq2vrf_ld_path_merge(veq2vrf_ld_path_merge),
    .veq2vrf_ld_ctrl_rf_grant(veq2vrf_ld_ctrl_rf_grant),
    .veq2vrf_ld_ctrl_cp_grant(veq2vrf_ld_ctrl_cp_grant),
    .vsp_veq_standby_ready(vsp_veq_standby_ready)
);
kv_vsp_vs_ctrl #(
    .DLEN(DLEN),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VS3_DEPTH(VS3_DEPTH)
) u_vs_ctrl (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .veq_dispatch_vs2st_grant(veq_dispatch_vs2st_grant),
    .veq_dispatch_vs2st_idx(veq_dispatch_vs2st_idx),
    .veq_cmt_vs2st_grant(veq_cmt_vs2st_grant),
    .veq_cmt_vs2st_kill(veq_cmt_vs2st_kill),
    .veq_cmt_vs2st_idx(veq_cmt_vs2st_idx),
    .vsp_vs3_rvalid(vsp_vs3_rvalid),
    .vsp_vs3_rready(vsp_vs3_rready),
    .vsp_vs3_rdata(vsp_vs3_rdata),
    .vsp_vs3_rlast(vsp_vs3_rlast),
    .vs3_wvalid(vs3_wvalid),
    .vs3_wready(vs3_wready),
    .vs3_wdata(vs3_wdata),
    .vs3_wlast(vs3_wlast),
    .vs3_widx(vs3_widx),
    .vsp_vs_ctrl_standby_ready(vsp_vs_ctrl_standby_ready)
);
kv_vsp_st_ctrl #(
    .ACE_SP_MODE(ACE_SP_MODE),
    .DLEN(DLEN),
    .OFFSET_BITS(OFFSET_BITS),
    .RAR_SUPPORT(RAR_SUPPORT),
    .ST_BUF_DEPTH(ST_BUF_DEPTH),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VSP_DATA_WIDTH(VSP_DATA_WIDTH),
    .XLEN(XLEN)
) u_st_ctrl (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .veq2st_ctrl_valid(veq2st_ctrl_valid),
    .veq2st_ctrl_cmted(veq2st_ctrl_cmted),
    .veq2st_ctrl_error(veq2st_ctrl_error),
    .veq2st_ctrl_kill(veq2st_ctrl_kill),
    .veq2st_ctrl_idx(veq2st_ctrl_idx),
    .veq2st_ctrl_op1(veq2st_ctrl_op1),
    .veq2st_ctrl_op1_hazard(veq2st_ctrl_op1_hazard),
    .veq2st_ctrl_offset(veq2st_ctrl_offset),
    .veq2st_ctrl_cp_eew(veq2st_ctrl_cp_eew),
    .veq2st_ctrl_rf_eew(veq2st_ctrl_rf_eew),
    .veq2st_ctrl_emask(veq2st_ctrl_emask),
    .veq2st_ctrl_ratio(veq2st_ctrl_ratio),
    .veq2st_source_op1(veq2st_source_op1),
    .veq2st_source_vs(veq2st_source_vs),
    .veq2st_source_dummy_start(veq2st_source_dummy_start),
    .veq2st_source_dummy_end(veq2st_source_dummy_end),
    .veq2st_destination_cp(veq2st_destination_cp),
    .veq2st_drop_vs(veq2st_drop_vs),
    .veq2st_cp_last(veq2st_cp_last),
    .veq2st_path_bypass(veq2st_path_bypass),
    .veq2st_path_merge(veq2st_path_merge),
    .veq2st_ctrl_rf_grant(veq2st_ctrl_rf_grant),
    .veq2st_ctrl_cp_grant(veq2st_ctrl_cp_grant),
    .vs3_wvalid(vs3_wvalid),
    .vs3_wready(vs3_wready),
    .vs3_wdata(vs3_wdata),
    .vs3_wlast(vs3_wlast),
    .vs3_widx(vs3_widx),
    .cpu_cp_wdata_valid(cpu_cp_wdata_valid),
    .cpu_cp_wdata_ready(cpu_cp_wdata_ready),
    .cpu_cp_wdata(cpu_cp_wdata),
    .cpu_cp_wdata_bwe(cpu_cp_wdata_bwe),
    .ace_streaming_data_out_valid(ace_streaming_data_out_valid),
    .ace_streaming_data_out_ready(ace_streaming_data_out_ready),
    .ace_streaming_data_out(ace_streaming_data_out),
    .ace_streaming_data_out_bwe(ace_streaming_data_out_bwe),
    .vsp_st_ctrl_standby_ready(vsp_st_ctrl_standby_ready)
);
kv_vsp_cp_ctrl #(
    .ACE_SP_MODE(ACE_SP_MODE),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VSP_DATA_WIDTH(VSP_DATA_WIDTH)
) u_cp_ctrl (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .cp_cpu_rdata_valid(cp_cpu_rdata_valid),
    .cp_cpu_rdata_ready(cp_cpu_rdata_ready),
    .cp_cpu_rdata(cp_cpu_rdata),
    .ace_streaming_data_in(ace_streaming_data_in),
    .ace_streaming_data_in_ready(ace_streaming_data_in_ready),
    .ace_streaming_data_in_valid(ace_streaming_data_in_valid),
    .cp2srf_rvalid(cp2srf_rvalid),
    .cp2srf_rready(cp2srf_rready),
    .cp2srf_rlast(cp2srf_rlast),
    .cp2srf_rdata(cp2srf_rdata),
    .cp2vrf_rvalid(cp2vrf_rvalid),
    .cp2vrf_rready(cp2vrf_rready),
    .cp2vrf_rlast(cp2vrf_rlast),
    .cp2vrf_rdata(cp2vrf_rdata),
    .cp2vrf_dummy_ex_done(cp2vrf_dummy_ex_done),
    .cp2vrf_dummy_ex_ready(cp2vrf_dummy_ex_ready),
    .veq_cmt_cp2ld_grant(veq_cmt_cp2ld_grant),
    .veq_cmt_cp2ld_type(veq_cmt_cp2ld_type),
    .veq_cmt_cp2ld_dummy(veq_cmt_cp2ld_dummy),
    .vsp_cp_ctrl_standby_ready(vsp_cp_ctrl_standby_ready),
    .vpu_sp_ex_done(vpu_sp_ex_done),
    .vpu_sp_ex_store(vpu_sp_ex_store),
    .vpu_sp_ex_error(vpu_sp_ex_error)
);
kv_vsp_srf_ld_ctrl #(
    .ACE_SP_MODE(ACE_SP_MODE),
    .DLEN(DLEN),
    .OFFSET_BITS(OFFSET_BITS),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VSP_DATA_WIDTH(VSP_DATA_WIDTH)
) u_srf_ld_ctrl (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .cp2srf_rvalid(cp2srf_rvalid),
    .cp2srf_rready(cp2srf_rready),
    .cp2srf_rdata(cp2srf_rdata),
    .cp2srf_rlast(cp2srf_rlast),
    .vsp_srf_wvalid(vsp_srf_wvalid),
    .vsp_srf_wready(vsp_srf_wready),
    .vsp_srf_waddr(vsp_srf_waddr),
    .vsp_srf_wdata(vsp_srf_wdata),
    .vsp_srf_wfrf(vsp_srf_wfrf),
    .veq2srf_ld_ctrl_valid(veq2srf_ld_ctrl_valid),
    .veq2srf_ld_ctrl_idx(veq2srf_ld_ctrl_idx),
    .veq2srf_ld_ctrl_offset(veq2srf_ld_ctrl_offset),
    .veq2srf_ld_ctrl_cp_eew(veq2srf_ld_ctrl_cp_eew),
    .veq2srf_ld_ctrl_rf_eew(veq2srf_ld_ctrl_rf_eew),
    .veq2srf_ld_ctrl_emask(veq2srf_ld_ctrl_emask),
    .veq2srf_ld_ctrl_cp2rf_element(veq2srf_ld_ctrl_cp2rf_element),
    .veq2srf_ld_ctrl_sext(veq2srf_ld_ctrl_sext),
    .veq2srf_ld_ctrl_frf(veq2srf_ld_ctrl_frf),
    .veq2srf_ld_ctrl_srf_idx(veq2srf_ld_ctrl_srf_idx),
    .veq2srf_ld_source_cp(veq2srf_ld_source_cp),
    .veq2srf_ld_destination_srf(veq2srf_ld_destination_srf),
    .veq2srf_ld_partial_cp(veq2srf_ld_partial_cp),
    .veq2srf_ld_cp_last(veq2srf_ld_cp_last),
    .veq2srf_ld_path_bypass(veq2srf_ld_path_bypass),
    .veq2srf_ld_path_merge(veq2srf_ld_path_merge),
    .veq2srf_ld_ctrl_rf_grant(veq2srf_ld_ctrl_rf_grant),
    .veq2srf_ld_ctrl_cp_grant(veq2srf_ld_ctrl_cp_grant),
    .vsp_srf_ld_ctrl_standby_ready(vsp_srf_ld_ctrl_standby_ready)
);
kv_vsp_vrf_ld_ctrl #(
    .ACE_FSP_BF16_SUPPORT(ACE_FSP_BF16_SUPPORT),
    .ACE_FSP_FP16_SUPPORT(ACE_FSP_FP16_SUPPORT),
    .ACE_FSP_FP64_SUPPORT(ACE_FSP_FP64_SUPPORT),
    .ACE_SP_MODE(ACE_SP_MODE),
    .DLEN(DLEN),
    .LD_BUF_DEPTH(LD_BUF_DEPTH),
    .OFFSET_BITS(OFFSET_BITS),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VD_DEPTH(VD_DEPTH),
    .VEQ_DEPTH(VEQ_DEPTH),
    .VSP_DATA_WIDTH(VSP_DATA_WIDTH)
) u_vrf_ld_ctrl (
    .vpu_vsp_clk(vpu_vsp_clk),
    .vpu_reset_n(vpu_reset_n),
    .cp2vrf_rvalid(cp2vrf_rvalid),
    .cp2vrf_rready(cp2vrf_rready),
    .cp2vrf_rdata(cp2vrf_rdata),
    .cp2vrf_rlast(cp2vrf_rlast),
    .cp2vrf_dummy_ex_done(cp2vrf_dummy_ex_done),
    .cp2vrf_dummy_ex_ready(cp2vrf_dummy_ex_ready),
    .vd_wvalid(vd_wvalid),
    .vd_wready(vd_wready),
    .vd_wdata(vd_wdata),
    .vd_wmask(vd_wmask),
    .veq2vrf_ld_ctrl_valid(veq2vrf_ld_ctrl_valid),
    .veq2vrf_ld_ctrl_idx(veq2vrf_ld_ctrl_idx),
    .veq2vrf_ld_ctrl_offset(veq2vrf_ld_ctrl_offset),
    .veq2vrf_ld_ctrl_cp_eew(veq2vrf_ld_ctrl_cp_eew),
    .veq2vrf_ld_ctrl_rf_eew(veq2vrf_ld_ctrl_rf_eew),
    .veq2vrf_ld_ctrl_emask(veq2vrf_ld_ctrl_emask),
    .veq2vrf_ld_ctrl_cp2rf_element(veq2vrf_ld_ctrl_cp2rf_element),
    .veq2vrf_ld_ctrl_sext(veq2vrf_ld_ctrl_sext),
    .veq2vrf_ld_ctrl_fcvt(veq2vrf_ld_ctrl_fcvt),
    .veq2vrf_ld_ctrl_bf16(veq2vrf_ld_ctrl_bf16),
    .veq2vrf_ld_source_cp(veq2vrf_ld_source_cp),
    .veq2vrf_ld_destination_vrf(veq2vrf_ld_destination_vrf),
    .veq2vrf_ld_partial_cp(veq2vrf_ld_partial_cp),
    .veq2vrf_ld_cp_last(veq2vrf_ld_cp_last),
    .veq2vrf_ld_dummy_vd(veq2vrf_ld_dummy_vd),
    .veq2vrf_ld_dummy_all(veq2vrf_ld_dummy_all),
    .veq2vrf_ld_vrf_last(veq2vrf_ld_vrf_last),
    .veq2vrf_ld_path_bypass(veq2vrf_ld_path_bypass),
    .veq2vrf_ld_path_merge(veq2vrf_ld_path_merge),
    .veq2vrf_ld_ctrl_rf_grant(veq2vrf_ld_ctrl_rf_grant),
    .veq2vrf_ld_ctrl_cp_grant(veq2vrf_ld_ctrl_cp_grant),
    .vsp_vrf_ld_ctrl_standby_ready(vsp_vrf_ld_ctrl_standby_ready)
);
kv_eb_full_o #(
    .DW(DLEN),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_vd_wdata (
    .clk(vpu_vsp_clk),
    .resetn(vpu_reset_n),
    .clk_en(1'b1),
    .i_valid(vd_wvalid),
    .i_ready(vd_wready),
    .din(vd_wdata),
    .o_valid(vsp_vd_wvalid),
    .o_ready(vsp_vd_wready),
    .dout(vsp_vd_wdata)
);
kv_eb_full_o #(
    .DW(DLEN / 8),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_vd_wmask (
    .clk(vpu_vsp_clk),
    .resetn(vpu_reset_n),
    .clk_en(1'b1),
    .i_valid(vd_wvalid),
    .i_ready(nds_unused_vd_wready),
    .din(vd_wmask),
    .o_valid(nds_unused_vsp_vd_wvalid),
    .o_ready(vsp_vd_wready),
    .dout(vsp_vd_wmask)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

