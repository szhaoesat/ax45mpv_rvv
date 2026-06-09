// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_veq (
    vpu_vsp_clk,
    vpu_reset_n,
    vsp_dispatch_valid,
    vsp_dispatch_op1,
    vsp_dispatch_op1_hazard,
    vsp_dispatch_op2,
    vsp_dispatch_ctrl,
    vsp_dispatch_v0t,
    vsp_dispatch_vs3_len,
    vsp_dispatch_vd_len,
    vsp_dispatch_ready,
    vsp_cmt_valid,
    vsp_cmt_op1,
    vsp_cmt_kill,
    veq_dispatch_vs2st_grant,
    veq_dispatch_vs2st_idx,
    veq_cmt_vs2st_grant,
    veq_cmt_vs2st_kill,
    veq_cmt_vs2st_idx,
    veq_cmt_cp2ld_grant,
    veq_cmt_cp2ld_type,
    veq_cmt_cp2ld_dummy,
    veq2st_ctrl_valid,
    veq2st_ctrl_cmted,
    veq2st_ctrl_error,
    veq2st_ctrl_kill,
    veq2st_ctrl_idx,
    veq2st_ctrl_op1,
    veq2st_ctrl_op1_hazard,
    veq2st_ctrl_offset,
    veq2st_ctrl_cp_eew,
    veq2st_ctrl_rf_eew,
    veq2st_ctrl_emask,
    veq2st_ctrl_ratio,
    veq2st_source_op1,
    veq2st_source_vs,
    veq2st_source_dummy_start,
    veq2st_source_dummy_end,
    veq2st_destination_cp,
    veq2st_drop_vs,
    veq2st_cp_last,
    veq2st_path_bypass,
    veq2st_path_merge,
    veq2st_ctrl_rf_grant,
    veq2st_ctrl_cp_grant,
    vpu_sp_ex_done,
    vpu_sp_ex_store,
    vpu_sp_ex_error,
    veq2srf_ld_ctrl_valid,
    veq2srf_ld_ctrl_idx,
    veq2srf_ld_ctrl_offset,
    veq2srf_ld_ctrl_cp_eew,
    veq2srf_ld_ctrl_rf_eew,
    veq2srf_ld_ctrl_emask,
    veq2srf_ld_ctrl_cp2rf_element,
    veq2srf_ld_ctrl_sext,
    veq2srf_ld_ctrl_frf,
    veq2srf_ld_ctrl_srf_idx,
    veq2srf_ld_source_cp,
    veq2srf_ld_destination_srf,
    veq2srf_ld_partial_cp,
    veq2srf_ld_cp_last,
    veq2srf_ld_path_bypass,
    veq2srf_ld_path_merge,
    veq2srf_ld_ctrl_rf_grant,
    veq2srf_ld_ctrl_cp_grant,
    veq2vrf_ld_ctrl_valid,
    veq2vrf_ld_ctrl_idx,
    veq2vrf_ld_ctrl_offset,
    veq2vrf_ld_ctrl_cp_eew,
    veq2vrf_ld_ctrl_rf_eew,
    veq2vrf_ld_ctrl_emask,
    veq2vrf_ld_ctrl_cp2rf_element,
    veq2vrf_ld_ctrl_sext,
    veq2vrf_ld_ctrl_fcvt,
    veq2vrf_ld_ctrl_bf16,
    veq2vrf_ld_source_cp,
    veq2vrf_ld_destination_vrf,
    veq2vrf_ld_partial_cp,
    veq2vrf_ld_cp_last,
    veq2vrf_ld_dummy_vd,
    veq2vrf_ld_dummy_all,
    veq2vrf_ld_vrf_last,
    veq2vrf_ld_path_bypass,
    veq2vrf_ld_path_merge,
    veq2vrf_ld_ctrl_rf_grant,
    veq2vrf_ld_ctrl_cp_grant,
    vsp_veq_standby_ready
);
parameter XLEN = 64;
parameter DLEN = 512;
parameter VLEN = 512;
parameter VSP_DATA_WIDTH = 512;
parameter VRF_LW = 3;
parameter VEQ_DEPTH = 4;
parameter OFFSET_BITS = $clog2(DLEN / 8);
parameter ACE_SP_MODE = 0;
parameter RAR_SUPPORT = 0;
localparam INVALID = 0;
localparam CALCULATE = 1;
localparam SPECULATIVE = 2;
localparam COMMITTED = 3;
localparam FSM_BITS = 4;
localparam ST_IDLE = 0;
localparam ST_BPS = 1;
localparam ST_INJ_S = 2;
localparam ST_MRG = 3;
localparam ST_INJ_E = 4;
localparam ST_REL = 5;
localparam ST_BITS = 6;
localparam LD_IDLE = 0;
localparam LD_BPS = 1;
localparam LD_PART = 2;
localparam LD_MRG = 3;
localparam LD_REL = 4;
localparam LD_BITS = 5;
localparam DLEN_BYTES = DLEN / 8;
localparam DLEN_2BYTES = DLEN / 16;
localparam DLEN_4BYTES = DLEN / 32;
localparam DLEN_8BYTES = DLEN / 64;
localparam DLEN_16BYTES = DLEN / 128;
localparam DLEN_B_BITS = $clog2(DLEN / 8);
localparam VSP_NB_BITS = $clog2(VSP_DATA_WIDTH / 4);
localparam VSP_OFFSET_BITS = $clog2(VSP_DATA_WIDTH / 8);
input vpu_vsp_clk;
input vpu_reset_n;
input vsp_dispatch_valid;
input [(XLEN - 1):0] vsp_dispatch_op1;
input vsp_dispatch_op1_hazard;
input [(XLEN - 1):0] vsp_dispatch_op2;
input [(30 - 1):0] vsp_dispatch_ctrl;
input [(VLEN - 1):0] vsp_dispatch_v0t;
input [VRF_LW - 1:0] vsp_dispatch_vs3_len;
input [VRF_LW - 1:0] vsp_dispatch_vd_len;
output vsp_dispatch_ready;
input vsp_cmt_valid;
input [(XLEN - 1):0] vsp_cmt_op1;
input vsp_cmt_kill;
output veq_dispatch_vs2st_grant;
output [VEQ_DEPTH - 1:0] veq_dispatch_vs2st_idx;
output veq_cmt_vs2st_grant;
output veq_cmt_vs2st_kill;
output [VEQ_DEPTH - 1:0] veq_cmt_vs2st_idx;
output veq_cmt_cp2ld_grant;
output veq_cmt_cp2ld_type;
output veq_cmt_cp2ld_dummy;
output veq2st_ctrl_valid;
output veq2st_ctrl_cmted;
output veq2st_ctrl_error;
output veq2st_ctrl_kill;
output [VEQ_DEPTH - 1:0] veq2st_ctrl_idx;
output [XLEN - 1:0] veq2st_ctrl_op1;
output veq2st_ctrl_op1_hazard;
output [OFFSET_BITS - 1:0] veq2st_ctrl_offset;
output [2:0] veq2st_ctrl_cp_eew;
output [1:0] veq2st_ctrl_rf_eew;
output [(DLEN / 8) - 1:0] veq2st_ctrl_emask;
output [3:0] veq2st_ctrl_ratio;
output veq2st_source_op1;
output veq2st_source_vs;
output veq2st_source_dummy_start;
output veq2st_source_dummy_end;
output veq2st_destination_cp;
output veq2st_drop_vs;
output veq2st_cp_last;
output veq2st_path_bypass;
output veq2st_path_merge;
input veq2st_ctrl_rf_grant;
input veq2st_ctrl_cp_grant;
input vpu_sp_ex_done;
input vpu_sp_ex_store;
input vpu_sp_ex_error;
output veq2srf_ld_ctrl_valid;
output [VEQ_DEPTH - 1:0] veq2srf_ld_ctrl_idx;
output [OFFSET_BITS - 1:0] veq2srf_ld_ctrl_offset;
output [2:0] veq2srf_ld_ctrl_cp_eew;
output [1:0] veq2srf_ld_ctrl_rf_eew;
output [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_emask;
output [(DLEN / 8) - 1:0] veq2srf_ld_ctrl_cp2rf_element;
output veq2srf_ld_ctrl_sext;
output veq2srf_ld_ctrl_frf;
output [4:0] veq2srf_ld_ctrl_srf_idx;
output veq2srf_ld_source_cp;
output veq2srf_ld_destination_srf;
output veq2srf_ld_partial_cp;
output veq2srf_ld_cp_last;
output veq2srf_ld_path_bypass;
output veq2srf_ld_path_merge;
input veq2srf_ld_ctrl_rf_grant;
input veq2srf_ld_ctrl_cp_grant;
output veq2vrf_ld_ctrl_valid;
output [VEQ_DEPTH - 1:0] veq2vrf_ld_ctrl_idx;
output [OFFSET_BITS - 1:0] veq2vrf_ld_ctrl_offset;
output [2:0] veq2vrf_ld_ctrl_cp_eew;
output [1:0] veq2vrf_ld_ctrl_rf_eew;
output [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_emask;
output [(DLEN / 8) - 1:0] veq2vrf_ld_ctrl_cp2rf_element;
output veq2vrf_ld_ctrl_sext;
output veq2vrf_ld_ctrl_fcvt;
output veq2vrf_ld_ctrl_bf16;
output veq2vrf_ld_source_cp;
output veq2vrf_ld_destination_vrf;
output veq2vrf_ld_partial_cp;
output veq2vrf_ld_cp_last;
output veq2vrf_ld_dummy_vd;
output veq2vrf_ld_dummy_all;
output veq2vrf_ld_vrf_last;
output veq2vrf_ld_path_bypass;
output veq2vrf_ld_path_merge;
input veq2vrf_ld_ctrl_rf_grant;
input veq2vrf_ld_ctrl_cp_grant;
output vsp_veq_standby_ready;





// 26cce652 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VEQ_DEPTH - 1:0] veq_dispatch_idx;
wire [VEQ_DEPTH - 1:0] veq_dispatch_grant;
wire [2:0] dispatch_ctrl_cp_eew = vsp_dispatch_ctrl[0 +:3];
wire dispatch_ctrl_load = vsp_dispatch_ctrl[3];
wire dispatch_ctrl_op_fcvt = vsp_dispatch_ctrl[5];
wire dispatch_ctrl_op_bf16 = vsp_dispatch_ctrl[4];
wire dispatch_ctrl_op_sext = vsp_dispatch_ctrl[6];
wire [1:0] dispatch_ctrl_rf_eew = vsp_dispatch_ctrl[7 +:2];
wire [4:0] dispatch_ctrl_rf_idx = vsp_dispatch_ctrl[9 +:5];
wire [1:0] dispatch_ctrl_rf_type = vsp_dispatch_ctrl[14 +:2];
wire dispatch_ctrl_vrf = dispatch_ctrl_rf_type == 2'b10;
wire dispatch_ctrl_frf = dispatch_ctrl_rf_type == 2'b01;
wire dispatch_ctrl_xrf = dispatch_ctrl_rf_type == 2'b00;
wire dispatch_ctrl_store = vsp_dispatch_ctrl[16];
wire dispatch_ctrl_una = vsp_dispatch_ctrl[17];
wire [10:0] dispatch_ctrl_vl = vsp_dispatch_ctrl[18 +:11];
wire dispatch_ctrl_vm = vsp_dispatch_ctrl[29];
wire [63:0] vsp_dispatch_id = 64'b0;
wire [(VEQ_DEPTH * 1) - 1:0] veq_invalid;
wire [(VEQ_DEPTH * 1) - 1:0] veq_calculate;
wire [(VEQ_DEPTH * 1) - 1:0] veq_speculative;
wire [(VEQ_DEPTH * 1) - 1:0] veq_committed;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ld_busy;
wire [(VEQ_DEPTH * 1) - 1:0] veq_st_busy;
wire [(VEQ_DEPTH * 3) - 1:0] veq_ctrl_cp_eew;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_load;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_op_bf16;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_op_fcvt;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_op_sext;
wire [(VEQ_DEPTH * 2) - 1:0] veq_ctrl_rf_eew;
wire [(VEQ_DEPTH * (DLEN / 8)) - 1:0] veq_ctrl_emask;
wire [(VEQ_DEPTH * 4) - 1:0] veq_ctrl_ratio;
wire [(VEQ_DEPTH * VLEN) - 1:0] veq_ctrl_v0t;
wire [(VEQ_DEPTH * 5) - 1:0] veq_ctrl_rf_idx;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_vrf;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_frf;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_xrf;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_store;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_una;
wire [(VEQ_DEPTH * 11) - 1:0] veq_ctrl_vl;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_vm;
wire [(VEQ_DEPTH * VRF_LW) - 1:0] veq_ctrl_veq_vrf_len;
wire [(VEQ_DEPTH * 16) - 1:0] veq_ctrl_vrf_len;
wire [(VEQ_DEPTH * 16) - 1:0] veq_ctrl_vrf_dummy_len;
wire [(VEQ_DEPTH * 33) - 1:0] veq_ctrl_cp_len;
wire [(VEQ_DEPTH * OFFSET_BITS) - 1:0] veq_ctrl_offset;
wire [(VEQ_DEPTH * XLEN) - 1:0] veq_ctrl_op1;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_op1_hazard;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_drop_vs;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_cp_last;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_cp_done;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_dummy_vd;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_dummy_all;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_vrf_last;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_vrf_done;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_source_op1;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_source_vs;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_source_dummy_start;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_source_dummy_end;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_source_cp;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_destination_cp;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_destination_srf;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_destination_vrf;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_path_bypass;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_path_merge;
wire [(VEQ_DEPTH * (DLEN / 8)) - 1:0] veq_ctrl_cp2rf_element;
wire [(VEQ_DEPTH * 1) - 1:0] veq_ctrl_partial_cp;
wire [(VEQ_DEPTH * 64) - 1:0] veq_ctrl_veq_id;
wire [VRF_LW - 1:0] sel_cal_veq_vrf_len;
wire [10:0] sel_cal_veq_vl;
wire [1:0] sel_cal_veq_rf_eew;
wire [2:0] sel_cal_veq_cp_eew;
wire sel_cal_veq_vrf;
wire sel_cal_veq_una;
wire [OFFSET_BITS - 1:0] sel_cal_veq_offset;
wire [VLEN - 1:0] sel_cal_veq_v0t;
wire sel_cal_veq_vm;
wire [15:0] cal_veq_vrf_len;
wire [15:0] cal_veq_vrf_dummy_len;
wire [32:0] cal_veq_cp_len;
wire [VLEN - 1:0] cal_veq_v0t;
wire cal_veq_eew_1v1;
wire cal_veq_eew_2v1;
wire cal_veq_eew_4v1;
wire cal_veq_eew_8v1;
wire cal_veq_eew_16v1;
wire [VEQ_DEPTH - 1:0] veq_cmt_idx;
wire [VEQ_DEPTH - 1:0] veq_cmt_grant;
wire [VEQ_DEPTH - 1:0] veq_cmt_kill;
wire [VEQ_DEPTH - 1:0] veq_st_retire;
wire [VEQ_DEPTH - 1:0] veq_ld_retire;
wire wait_cmt_wvalid;
wire nds_unused_wait_cmt_wready;
wire [VEQ_DEPTH - 1:0] wait_cmt_widx;
wire nds_unused_wait_cmt_rvalid;
wire wait_cmt_rready;
wire [VEQ_DEPTH - 1:0] wait_cmt_ridx;
wire wait_cmt_st_wvalid;
wire nds_unused_wait_cmt_st_wready;
wire [VEQ_DEPTH - 1:0] wait_cmt_st_widx;
wire wait_cmt_st_rvalid;
wire wait_cmt_st_rready;
wire [VEQ_DEPTH - 1:0] wait_cmt_st_ridx;
wire cmted_st_wvalid;
wire nds_unused_cmted_st_wready;
wire [VEQ_DEPTH - 1:0] cmted_st_widx;
wire cmted_st_rvalid;
wire cmted_st_rready;
wire [VEQ_DEPTH - 1:0] cmted_st_ridx;
wire wait_cmt_ld_wvalid;
wire nds_unused_wait_cmt_ld_wready;
wire [VEQ_DEPTH - 1:0] wait_cmt_ld_widx;
wire wait_cmt_ld_rvalid;
wire wait_cmt_ld_rready;
wire [VEQ_DEPTH - 1:0] wait_cmt_ld_ridx;
wire cmted_srf_ld_wvalid;
wire nds_unused_cmted_srf_ld_wready;
wire [VEQ_DEPTH - 1:0] cmted_srf_ld_widx;
wire cmted_srf_ld_rvalid;
wire cmted_srf_ld_rready;
wire [VEQ_DEPTH - 1:0] cmted_srf_ld_ridx;
wire cmted_vrf_ld_wvalid;
wire nds_unused_cmted_vrf_ld_wready;
wire [VEQ_DEPTH - 1:0] cmted_vrf_ld_widx;
wire cmted_vrf_ld_rvalid;
wire cmted_vrf_ld_rready;
wire [VEQ_DEPTH - 1:0] cmted_vrf_ld_ridx;
wire ace_store_done;
wire ace_store_error;
kv_ffs #(
    .WIDTH(VEQ_DEPTH)
) u_dispatch_idx (
    .out(veq_dispatch_idx),
    .in(veq_invalid)
);
assign vsp_dispatch_ready = |veq_invalid;
assign wait_cmt_wvalid = |veq_dispatch_grant;
assign wait_cmt_widx = veq_dispatch_idx;
assign veq_dispatch_vs2st_grant = (|veq_dispatch_grant) & dispatch_ctrl_store & dispatch_ctrl_vrf;
assign veq_dispatch_vs2st_idx = veq_dispatch_idx;
assign wait_cmt_rready = vsp_cmt_valid;
assign veq_cmt_idx = wait_cmt_ridx;
assign veq_cmt_vs2st_grant = |(veq_cmt_grant & veq_ctrl_store & veq_ctrl_vrf & ~veq_ctrl_vrf_done);
assign veq_cmt_vs2st_kill = |(veq_cmt_kill & veq_ctrl_store & veq_ctrl_vrf & ~veq_ctrl_vrf_done);
assign veq_cmt_vs2st_idx = veq_cmt_idx;
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_wait_cmt_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(wait_cmt_wvalid),
    .wready(nds_unused_wait_cmt_wready),
    .wdata(wait_cmt_widx),
    .rvalid(nds_unused_wait_cmt_rvalid),
    .rready(wait_cmt_rready),
    .rdata(wait_cmt_ridx)
);
assign wait_cmt_st_wvalid = |veq_dispatch_grant & dispatch_ctrl_store;
assign wait_cmt_st_widx = veq_dispatch_idx;
assign wait_cmt_st_rready = |(veq_cmt_grant & veq_ctrl_store);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_wait_cmt_st_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(wait_cmt_st_wvalid),
    .wready(nds_unused_wait_cmt_st_wready),
    .wdata(wait_cmt_st_widx),
    .rvalid(wait_cmt_st_rvalid),
    .rready(wait_cmt_st_rready),
    .rdata(wait_cmt_st_ridx)
);
assign cmted_st_wvalid = |(veq_cmt_grant & veq_ctrl_store & ~veq_cmt_kill & ~veq_st_retire);
assign cmted_st_widx = wait_cmt_st_ridx;
assign cmted_st_rready = |(veq_st_retire & veq_ctrl_store);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_cmted_st_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(cmted_st_wvalid),
    .wready(nds_unused_cmted_st_wready),
    .wdata(cmted_st_widx),
    .rvalid(cmted_st_rvalid),
    .rready(cmted_st_rready),
    .rdata(cmted_st_ridx)
);
assign veq2st_ctrl_valid = cmted_st_rvalid | wait_cmt_st_rvalid;
assign veq2st_ctrl_cmted = ace_store_done & (cmted_st_rvalid | (|(veq_cmt_grant & veq_ctrl_store & ~veq_cmt_kill)));
assign veq2st_ctrl_error = ace_store_error & (cmted_st_rvalid | (|(veq_cmt_grant & veq_ctrl_store & ~veq_cmt_kill)));
assign veq2st_ctrl_kill = ~cmted_st_rvalid & (|(veq_cmt_grant & veq_ctrl_store & veq_cmt_kill));
assign veq2st_ctrl_idx = cmted_st_rvalid ? (cmted_st_ridx & veq_st_busy) : wait_cmt_st_rvalid ? (wait_cmt_st_ridx & veq_st_busy) : {VEQ_DEPTH{1'b0}};
assign wait_cmt_ld_wvalid = |veq_dispatch_grant & dispatch_ctrl_load;
assign wait_cmt_ld_widx = veq_dispatch_idx;
assign wait_cmt_ld_rready = |(veq_cmt_grant & veq_ctrl_load);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_wait_cmt_ld_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(wait_cmt_ld_wvalid),
    .wready(nds_unused_wait_cmt_ld_wready),
    .wdata(wait_cmt_ld_widx),
    .rvalid(wait_cmt_ld_rvalid),
    .rready(wait_cmt_ld_rready),
    .rdata(wait_cmt_ld_ridx)
);
assign cmted_srf_ld_wvalid = |(veq_cmt_grant & veq_ctrl_load & ~veq_ctrl_vrf & ~veq_cmt_kill);
assign cmted_srf_ld_widx = wait_cmt_ld_ridx;
assign cmted_srf_ld_rready = |(veq_ld_retire & veq_ctrl_load & ~veq_ctrl_vrf);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_cmted_srf_ld_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(cmted_srf_ld_wvalid),
    .wready(nds_unused_cmted_srf_ld_wready),
    .wdata(cmted_srf_ld_widx),
    .rvalid(cmted_srf_ld_rvalid),
    .rready(cmted_srf_ld_rready),
    .rdata(cmted_srf_ld_ridx)
);
assign veq2srf_ld_ctrl_valid = cmted_srf_ld_rvalid;
assign veq2srf_ld_ctrl_idx = cmted_srf_ld_rvalid ? (cmted_srf_ld_ridx & veq_ld_busy) : {VEQ_DEPTH{1'b0}};
assign cmted_vrf_ld_wvalid = |(veq_cmt_grant & veq_ctrl_load & veq_ctrl_vrf & ~veq_cmt_kill);
assign cmted_vrf_ld_widx = wait_cmt_ld_ridx;
assign cmted_vrf_ld_rready = |(veq_ld_retire & veq_ctrl_load & veq_ctrl_vrf);
kv_fifo #(
    .DEPTH(VEQ_DEPTH),
    .WIDTH(VEQ_DEPTH),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_cmted_vrf_ld_idx (
    .clk(vpu_vsp_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(cmted_vrf_ld_wvalid),
    .wready(nds_unused_cmted_vrf_ld_wready),
    .wdata(cmted_vrf_ld_widx),
    .rvalid(cmted_vrf_ld_rvalid),
    .rready(cmted_vrf_ld_rready),
    .rdata(cmted_vrf_ld_ridx)
);
assign veq2vrf_ld_ctrl_valid = cmted_vrf_ld_rvalid;
assign veq2vrf_ld_ctrl_idx = cmted_vrf_ld_rvalid ? (cmted_vrf_ld_ridx & veq_ld_busy) : {VEQ_DEPTH{1'b0}};
assign veq_cmt_cp2ld_grant = |(veq_cmt_grant & veq_ctrl_load & ~veq_cmt_kill);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq_cmt_cp2ld_type (
    .out(veq_cmt_cp2ld_type),
    .sel(wait_cmt_ld_ridx),
    .in(veq_ctrl_vrf)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq_cmt_cp2ld_dummy (
    .out(veq_cmt_cp2ld_dummy),
    .sel(wait_cmt_ld_ridx),
    .in(veq_ctrl_cp_done)
);
generate
    if (ACE_SP_MODE == 0) begin:gen_fsp
        wire store_sent_cnt_wvalid = vpu_sp_ex_done & vpu_sp_ex_store;
        wire nds_unused_store_sent_cnt_wready;
        wire store_sent_cnt_wdata = vpu_sp_ex_error;
        wire store_sent_cnt_rvalid;
        wire store_sent_cnt_rready = cmted_st_rready;
        wire store_sent_cnt_rdata;
        kv_fifo #(
            .DEPTH(VEQ_DEPTH + 6),
            .WIDTH(1),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_store_sent_cnt (
            .clk(vpu_vsp_clk),
            .reset_n(vpu_reset_n),
            .flush(1'b0),
            .wvalid(store_sent_cnt_wvalid),
            .wready(nds_unused_store_sent_cnt_wready),
            .wdata(store_sent_cnt_wdata),
            .rvalid(store_sent_cnt_rvalid),
            .rready(store_sent_cnt_rready),
            .rdata(store_sent_cnt_rdata)
        );
        assign ace_store_done = store_sent_cnt_rvalid;
        assign ace_store_error = store_sent_cnt_rvalid & store_sent_cnt_rdata;
    end
    if (ACE_SP_MODE == 1) begin:gen_asp
        wire nds_unused_vpu_sp_ex_done = vpu_sp_ex_done;
        wire nds_unused_vpu_sp_ex_store = vpu_sp_ex_store;
        wire nds_unused_vpu_sp_ex_error = vpu_sp_ex_error;
        assign ace_store_done = 1'b1;
        assign ace_store_error = 1'b0;
    end
endgenerate
genvar i;
generate
    for (i = 0; i < VEQ_DEPTH; i = i + 1) begin:gen_veq
        reg [FSM_BITS - 1:0] veq_cs;
        reg [FSM_BITS - 1:0] veq_ns;
        reg veq_en;
        reg [ST_BITS - 1:0] fsm_st_cs;
        reg [ST_BITS - 1:0] fsm_st_ns;
        reg fsm_st_en;
        reg [LD_BITS - 1:0] fsm_ld_cs;
        reg [LD_BITS - 1:0] fsm_ld_ns;
        reg fsm_ld_en;
        wire dispatch_grant;
        wire cmt_grant;
        wire cmt_kill;
        wire veq_st_done;
        wire veq_ld_done;
        reg [2:0] veq_cp_eew;
        reg veq_load;
        reg veq_op_fcvt;
        reg veq_op_bf16;
        reg veq_op_sext;
        reg [1:0] veq_rf_eew;
        reg [4:0] veq_rf_idx;
        reg veq_vrf;
        reg veq_frf;
        reg veq_xrf;
        wire veq_srf = veq_frf | veq_xrf;
        reg veq_store;
        reg veq_una;
        reg [10:0] veq_vl;
        reg veq_vm;
        reg [(XLEN - 1):0] veq_op1;
        reg veq_op1_hazard;
        reg [(OFFSET_BITS - 1):0] veq_offset;
        wire [(OFFSET_BITS - 1):0] veq_offset_init;
        wire [OFFSET_BITS:0] veq_offset_next;
        reg [(VLEN - 1):0] veq_v0t;
        reg [(DLEN / 8) - 1:0] veq_cp2rf_element;
        wire [(2 * (DLEN / 8)) - 1:0] veq_cp2rf_element_cal_init;
        wire [(2 * (DLEN / 8)) - 1:0] veq_cp2rf_element_cal_next;
        wire [(DLEN / 8) - 1:0] veq_cp2rf_element_init;
        wire [(DLEN / 8) - 1:0] veq_cp2rf_element_next;
        reg [15:0] veq_vrf_len;
        reg [15:0] veq_vrf_dummy_len;
        reg [32:0] veq_cp_len;
        wire veq_st_rf_grant;
        wire veq_st_cp_grant;
        wire veq_ld_rf_grant;
        wire veq_ld_cp_grant;
        wire veq_vrf_this_last;
        wire veq_vrf_this_done;
        wire veq_vrf_this_dummy;
        wire veq_vrf_next_dummy;
        reg veq_vrf_all_dummy;
        wire veq_cp_this_last;
        wire veq_cp_this_done;
        reg veq_eew_1v1;
        reg veq_eew_2v1;
        reg veq_eew_4v1;
        reg veq_eew_8v1;
        reg veq_eew_16v1;
        wire veq_offset_this_align;
        wire veq_offset_next_align;
        wire fsm_st_ns_idle2bps;
        wire fsm_st_ns_idle2injs;
        wire fsm_st_ns_idle2mrg;
        wire fsm_st_ns_idle2rel;
        wire fsm_st_ns_bps2idle;
        wire fsm_st_ns_bps2rel;
        wire fsm_st_ns_injs2mrg;
        wire fsm_st_ns_mrg2inje;
        wire fsm_st_ns_mrg2rel;
        wire fsm_st_ns_inje2rel;
        wire fsm_st_ns_rel2idle;
        wire fsm_ld_ns_idle2bps;
        wire fsm_ld_ns_idle2part;
        wire fsm_ld_ns_idle2mrg;
        wire fsm_ld_ns_idle2rel;
        wire fsm_ld_ns_bps2idle;
        wire fsm_ld_ns_bps2rel;
        wire fsm_ld_ns_part2mrg;
        wire fsm_ld_ns_part2rel;
        wire fsm_ld_ns_mrg2rel;
        wire fsm_ld_ns_rel2idle;
        wire [63:0] nds_unused_dispatch_id = vsp_dispatch_id;
        assign veq_ctrl_veq_id[i * 64 +:64] = 64'b0;
        assign dispatch_grant = veq_cs[INVALID] & veq_dispatch_idx[i] & vsp_dispatch_valid;
        assign cmt_grant = (veq_cs[CALCULATE] | veq_cs[SPECULATIVE]) & veq_cmt_idx[i] & vsp_cmt_valid;
        assign cmt_kill = (veq_cs[CALCULATE] | veq_cs[SPECULATIVE]) & veq_cmt_idx[i] & vsp_cmt_valid & vsp_cmt_kill;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                veq_cs <= {{(FSM_BITS - 1){1'b0}},1'b1};
            end
            else if (veq_en) begin
                veq_cs <= veq_ns;
            end
        end

        always @* begin
            veq_ns = {FSM_BITS{1'b0}};
            veq_en = 1'b0;
            case (1'b1)
                veq_cs[INVALID]: begin
                    if (dispatch_grant) begin
                        veq_ns[CALCULATE] = 1'b1;
                        veq_en = 1'b1;
                    end
                end
                veq_cs[CALCULATE]: begin
                    if (cmt_grant) begin
                        if (cmt_kill) begin
                            veq_ns[INVALID] = 1'b1;
                            veq_en = 1'b1;
                        end
                        else begin
                            veq_ns[COMMITTED] = 1'b1;
                            veq_en = 1'b1;
                        end
                    end
                    else begin
                        veq_ns[SPECULATIVE] = 1'b1;
                        veq_en = 1'b1;
                    end
                end
                veq_cs[SPECULATIVE]: begin
                    if (cmt_grant) begin
                        if (veq_st_done | cmt_kill) begin
                            veq_ns[INVALID] = 1'b1;
                            veq_en = 1'b1;
                        end
                        else begin
                            veq_ns[COMMITTED] = 1'b1;
                            veq_en = 1'b1;
                        end
                    end
                end
                veq_cs[COMMITTED]: begin
                    if (veq_st_done | veq_ld_done) begin
                        veq_ns[INVALID] = 1'b1;
                        veq_en = 1'b1;
                    end
                end
            endcase
        end

        if (RAR_SUPPORT) begin:gen_veq_ctrl_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_cp_eew <= 3'b0;
                    veq_load <= 1'b0;
                    veq_op_fcvt <= 1'b0;
                    veq_op_bf16 <= 1'b0;
                    veq_op_sext <= 1'b0;
                    veq_rf_eew <= 2'b0;
                    veq_rf_idx <= 5'b0;
                    veq_vrf <= 1'b0;
                    veq_frf <= 1'b0;
                    veq_xrf <= 1'b0;
                    veq_store <= 1'b0;
                    veq_una <= 1'b0;
                    veq_vl <= 1'b0;
                    veq_vm <= 1'b0;
                end
                else if (dispatch_grant) begin
                    veq_cp_eew <= dispatch_ctrl_cp_eew;
                    veq_load <= dispatch_ctrl_load;
                    veq_op_fcvt <= dispatch_ctrl_op_fcvt;
                    veq_op_bf16 <= dispatch_ctrl_op_bf16;
                    veq_op_sext <= dispatch_ctrl_op_sext;
                    veq_rf_eew <= dispatch_ctrl_rf_eew;
                    veq_rf_idx <= dispatch_ctrl_rf_idx;
                    veq_vrf <= dispatch_ctrl_vrf;
                    veq_frf <= dispatch_ctrl_frf;
                    veq_xrf <= dispatch_ctrl_xrf;
                    veq_store <= dispatch_ctrl_store;
                    veq_una <= dispatch_ctrl_una;
                    veq_vl <= dispatch_ctrl_vl;
                    veq_vm <= dispatch_ctrl_vm;
                end
            end

        end
        else begin:gen_veq_ctrl_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_cp_eew <= dispatch_ctrl_cp_eew;
                    veq_load <= dispatch_ctrl_load;
                    veq_op_fcvt <= dispatch_ctrl_op_fcvt;
                    veq_op_bf16 <= dispatch_ctrl_op_bf16;
                    veq_op_sext <= dispatch_ctrl_op_sext;
                    veq_rf_eew <= dispatch_ctrl_rf_eew;
                    veq_rf_idx <= dispatch_ctrl_rf_idx;
                    veq_vrf <= dispatch_ctrl_vrf;
                    veq_frf <= dispatch_ctrl_frf;
                    veq_xrf <= dispatch_ctrl_xrf;
                    veq_store <= dispatch_ctrl_store;
                    veq_una <= dispatch_ctrl_una;
                    veq_vl <= dispatch_ctrl_vl;
                    veq_vm <= dispatch_ctrl_vm;
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_v0t_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_v0t <= {VLEN{1'b0}};
                end
                else if (dispatch_grant) begin
                    veq_v0t <= vsp_dispatch_v0t;
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_v0t <= cal_veq_v0t;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_v0t <= {{(DLEN / 8){1'b0}},veq_v0t[(VLEN - 1):(DLEN / 8)]};
                end
            end

        end
        else begin:gen_veq_v0t_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_v0t <= vsp_dispatch_v0t;
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_v0t <= cal_veq_v0t;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_v0t <= {{(DLEN / 8){1'b0}},veq_v0t[(VLEN - 1):(DLEN / 8)]};
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_op1_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_op1 <= {XLEN{1'b0}};
                end
                else if (dispatch_grant) begin
                    veq_op1 <= vsp_dispatch_op1;
                end
                else if (cmt_grant & veq_op1_hazard) begin
                    veq_op1 <= vsp_cmt_op1;
                end
            end

        end
        else begin:gen_veq_op1_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_op1 <= vsp_dispatch_op1;
                end
                else if (cmt_grant & veq_op1_hazard) begin
                    veq_op1 <= vsp_cmt_op1;
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_offset_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_offset <= {OFFSET_BITS{1'b0}};
                end
                else if (dispatch_grant) begin
                    veq_offset <= veq_offset_init;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_offset <= veq_offset_next[OFFSET_BITS - 1:0];
                end
            end

        end
        else begin:gen_veq_offset_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_offset <= veq_offset_init;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_offset <= veq_offset_next[OFFSET_BITS - 1:0];
                end
            end

        end
        if (OFFSET_BITS == VSP_OFFSET_BITS) begin:gen_veq_offset_dlen_eq_vsp
            assign veq_offset_init = {VSP_OFFSET_BITS{vsp_dispatch_ctrl[17]}} & vsp_dispatch_op2[(VSP_OFFSET_BITS - 1):0];
        end
        else begin:gen_veq_offset_dlen_neq_vsp
            assign veq_offset_init = {1'b0,{VSP_OFFSET_BITS{vsp_dispatch_ctrl[17]}} & vsp_dispatch_op2[(VSP_OFFSET_BITS - 1):0]};
        end
        if (OFFSET_BITS == 4) begin:gen_offset_nx_eq4
            assign veq_offset_next = ({(OFFSET_BITS + 1){veq_vrf}} & {1'b0,veq_offset} + {1'b0,veq_eew_2v1,veq_eew_4v1,veq_eew_8v1,veq_eew_16v1}) | ({(OFFSET_BITS + 1){veq_srf}} & {1'b0,veq_offset} + {1'b0,veq_eew_1v1,veq_eew_2v1,veq_eew_4v1,veq_eew_8v1});
        end
        else begin:gen_offset_nx_gt4
            assign veq_offset_next = ({(OFFSET_BITS + 1){veq_vrf}} & {1'b0,veq_offset} + {1'b0,veq_eew_2v1,veq_eew_4v1,veq_eew_8v1,veq_eew_16v1,{(OFFSET_BITS - 4){1'b0}}}) | ({(OFFSET_BITS + 1){veq_srf}} & {1'b0,veq_offset} + {{(OFFSET_BITS + 1 - 4){1'b0}},veq_eew_1v1,veq_eew_2v1,veq_eew_4v1,veq_eew_8v1});
        end
        if (RAR_SUPPORT) begin:gen_veq_cp2rf_element_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_cp2rf_element <= {(DLEN / 8){1'b0}};
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_cp2rf_element <= veq_cp2rf_element_init[(DLEN / 8) - 1:0];
                end
                else if (veq_ld_rf_grant) begin
                    veq_cp2rf_element <= veq_cp2rf_element_next[(DLEN / 8) - 1:0];
                end
            end

        end
        else begin:gen_veq_cp2rf_element_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (veq_cs[CALCULATE]) begin
                    veq_cp2rf_element <= veq_cp2rf_element_init[(DLEN / 8) - 1:0];
                end
                else if (veq_ld_rf_grant) begin
                    veq_cp2rf_element <= veq_cp2rf_element_next[(DLEN / 8) - 1:0];
                end
            end

        end
        assign veq_cp2rf_element_cal_init = ({{(1 * DLEN_BYTES){1'b0}},{DLEN_BYTES{cal_veq_eew_1v1 & veq_vrf}}} << veq_offset) | ({{(3 * DLEN_2BYTES){1'b0}},{DLEN_2BYTES{cal_veq_eew_2v1 & veq_vrf}}} << veq_offset) | ({{(7 * DLEN_4BYTES){1'b0}},{DLEN_4BYTES{cal_veq_eew_4v1 & veq_vrf}}} << veq_offset) | ({{(15 * DLEN_8BYTES){1'b0}},{DLEN_8BYTES{cal_veq_eew_8v1 & veq_vrf}}} << veq_offset) | ({{(31 * DLEN_16BYTES){1'b0}},{DLEN_16BYTES{cal_veq_eew_16v1 & veq_vrf}}} << veq_offset) | ({{(2 * DLEN_BYTES - 8){1'b0}},{8{cal_veq_eew_1v1 & veq_srf}}} << veq_offset) | ({{(2 * DLEN_BYTES - 4){1'b0}},{4{cal_veq_eew_2v1 & veq_srf}}} << veq_offset) | ({{(2 * DLEN_BYTES - 2){1'b0}},{2{cal_veq_eew_4v1 & veq_srf}}} << veq_offset) | ({{(2 * DLEN_BYTES - 1){1'b0}},{1{cal_veq_eew_8v1 & veq_srf}}} << veq_offset) | ({{(2 * DLEN_BYTES - 1){1'b0}},{1{cal_veq_eew_16v1 & veq_srf}}} << veq_offset);
        assign veq_cp2rf_element_init = veq_cp2rf_element_cal_init[0 +:(DLEN / 8)] | veq_cp2rf_element_cal_init[(DLEN / 8) +:(DLEN / 8)];
        assign veq_cp2rf_element_cal_next = ({{(1 * DLEN_BYTES){1'b0}},{DLEN_BYTES{veq_eew_1v1 & veq_vrf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(3 * DLEN_2BYTES){1'b0}},{DLEN_2BYTES{veq_eew_2v1 & veq_vrf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(7 * DLEN_4BYTES){1'b0}},{DLEN_4BYTES{veq_eew_4v1 & veq_vrf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(15 * DLEN_8BYTES){1'b0}},{DLEN_8BYTES{veq_eew_8v1 & veq_vrf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(31 * DLEN_16BYTES){1'b0}},{DLEN_16BYTES{veq_eew_16v1 & veq_vrf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(2 * DLEN_BYTES - 8){1'b0}},{8{veq_eew_1v1 & veq_srf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(2 * DLEN_BYTES - 4){1'b0}},{4{veq_eew_2v1 & veq_srf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(2 * DLEN_BYTES - 2){1'b0}},{2{veq_eew_4v1 & veq_srf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(2 * DLEN_BYTES - 1){1'b0}},{1{veq_eew_8v1 & veq_srf}}} << veq_offset_next[OFFSET_BITS - 1:0]) | ({{(2 * DLEN_BYTES - 1){1'b0}},{1{veq_eew_16v1 & veq_srf}}} << veq_offset_next[OFFSET_BITS - 1:0]);
        assign veq_cp2rf_element_next = veq_cp2rf_element_cal_next[0 +:(DLEN / 8)] | veq_cp2rf_element_cal_next[(DLEN / 8) +:(DLEN / 8)];
        if (RAR_SUPPORT) begin:gen_veq_op1_hazard_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_op1_hazard <= 1'b0;
                end
                else if (dispatch_grant) begin
                    veq_op1_hazard <= vsp_dispatch_op1_hazard;
                end
                else if (cmt_grant) begin
                    veq_op1_hazard <= 1'b0;
                end
            end

        end
        else begin:gen_veq_op1_hazard_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_op1_hazard <= vsp_dispatch_op1_hazard;
                end
                else if (cmt_grant) begin
                    veq_op1_hazard <= 1'b0;
                end
            end

        end
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                veq_vrf_all_dummy <= 1'b0;
            end
            else if (dispatch_grant) begin
                veq_vrf_all_dummy <= 1'b0;
            end
            else if (veq_cs[CALCULATE]) begin
                veq_vrf_all_dummy <= (veq_vl == 11'b0);
            end
        end

        if (RAR_SUPPORT) begin:gen_veq_vrf_len_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_vrf_len <= 16'b0;
                end
                else if (dispatch_grant) begin
                    veq_vrf_len <= {{(16 - VRF_LW){1'b0}},(dispatch_ctrl_load ? vsp_dispatch_vd_len : vsp_dispatch_vs3_len)};
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_vrf_len <= cal_veq_vrf_len;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_vrf_len <= {1'b0,veq_vrf_len[15:1]};
                end
            end

        end
        else begin:gen_veq_vrf_len_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_vrf_len <= {{(16 - VRF_LW){1'b0}},(dispatch_ctrl_load ? vsp_dispatch_vd_len : vsp_dispatch_vs3_len)};
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_vrf_len <= cal_veq_vrf_len;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_vrf_len <= {1'b0,veq_vrf_len[15:1]};
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_vrf_dummy_len_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_vrf_dummy_len <= 16'b0;
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_vrf_dummy_len <= cal_veq_vrf_dummy_len;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_vrf_dummy_len <= {1'b0,veq_vrf_dummy_len[15:1]};
                end
            end

        end
        else begin:gen_veq_vrf_dummy_len_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (veq_cs[CALCULATE]) begin
                    veq_vrf_dummy_len <= cal_veq_vrf_dummy_len;
                end
                else if (veq_st_rf_grant & ~fsm_st_cs[ST_INJ_S] | veq_ld_rf_grant) begin
                    veq_vrf_dummy_len <= {1'b0,veq_vrf_dummy_len[15:1]};
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_cp_len_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_cp_len <= 33'b0;
                end
                else if (dispatch_grant) begin
                    veq_cp_len <= {32'b0,~(dispatch_ctrl_vrf & (dispatch_ctrl_vl == 11'b0))};
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_cp_len <= cal_veq_cp_len;
                end
                else if (veq_st_cp_grant | veq_ld_cp_grant) begin
                    veq_cp_len <= {1'b0,veq_cp_len[32:1]};
                end
            end

        end
        else begin:gen_veq_cp_len_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (dispatch_grant) begin
                    veq_cp_len <= {32'b0,~(dispatch_ctrl_vrf & (dispatch_ctrl_vl == 11'b0))};
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_cp_len <= cal_veq_cp_len;
                end
                else if (veq_st_cp_grant | veq_ld_cp_grant) begin
                    veq_cp_len <= {1'b0,veq_cp_len[32:1]};
                end
            end

        end
        if (RAR_SUPPORT) begin:gen_veq_eew_ratio_w_reset
            always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    veq_eew_1v1 <= 1'b0;
                    veq_eew_2v1 <= 1'b0;
                    veq_eew_4v1 <= 1'b0;
                    veq_eew_8v1 <= 1'b0;
                    veq_eew_16v1 <= 1'b0;
                end
                else if (veq_cs[CALCULATE]) begin
                    veq_eew_1v1 <= cal_veq_eew_1v1;
                    veq_eew_2v1 <= cal_veq_eew_2v1;
                    veq_eew_4v1 <= cal_veq_eew_4v1;
                    veq_eew_8v1 <= cal_veq_eew_8v1;
                    veq_eew_16v1 <= cal_veq_eew_16v1;
                end
            end

        end
        else begin:gen_veq_eew_ratio_wo_reset
            always @(posedge vpu_vsp_clk) begin
                if (veq_cs[CALCULATE]) begin
                    veq_eew_1v1 <= cal_veq_eew_1v1;
                    veq_eew_2v1 <= cal_veq_eew_2v1;
                    veq_eew_4v1 <= cal_veq_eew_4v1;
                    veq_eew_8v1 <= cal_veq_eew_8v1;
                    veq_eew_16v1 <= cal_veq_eew_16v1;
                end
            end

        end
        assign veq_invalid[i] = veq_cs[INVALID];
        assign veq_calculate[i] = veq_cs[CALCULATE];
        assign veq_speculative[i] = veq_cs[SPECULATIVE];
        assign veq_committed[i] = veq_cs[COMMITTED];
        assign veq_dispatch_grant[i] = dispatch_grant;
        assign veq_cmt_grant[i] = cmt_grant;
        assign veq_cmt_kill[i] = cmt_kill;
        assign veq_st_retire[i] = veq_st_done;
        assign veq_ld_retire[i] = veq_ld_done;
        assign veq_ctrl_cp_eew[i * 3 +:3] = veq_cp_eew;
        assign veq_ctrl_load[i * 1 +:1] = veq_load;
        assign veq_ctrl_op_fcvt[i * 1 +:1] = veq_op_fcvt;
        assign veq_ctrl_op_bf16[i * 1 +:1] = veq_op_bf16;
        assign veq_ctrl_op_sext[i * 1 +:1] = veq_op_sext;
        assign veq_ctrl_rf_eew[i * 2 +:2] = veq_rf_eew;
        assign veq_ctrl_rf_idx[i * 5 +:5] = veq_rf_idx;
        assign veq_ctrl_vrf[i * 1 +:1] = veq_vrf;
        assign veq_ctrl_frf[i * 1 +:1] = veq_frf;
        assign veq_ctrl_xrf[i * 1 +:1] = veq_xrf;
        assign veq_ctrl_store[i * 1 +:1] = veq_store;
        assign veq_ctrl_una[i * 1 +:1] = veq_una;
        assign veq_ctrl_vl[i * 11 +:11] = veq_vl;
        assign veq_ctrl_vm[i * 1 +:1] = veq_vm;
        assign veq_ctrl_veq_vrf_len[i * VRF_LW +:VRF_LW] = veq_vrf_len[VRF_LW - 1:0];
        assign veq_ctrl_vrf_len[i * 16 +:16] = veq_vrf_len;
        assign veq_ctrl_vrf_dummy_len[i * 16 +:16] = veq_vrf_dummy_len;
        assign veq_ctrl_cp_len[i * 33 +:33] = veq_cp_len;
        assign veq_ctrl_offset[i * OFFSET_BITS +:OFFSET_BITS] = veq_offset;
        assign veq_ctrl_op1[i * XLEN +:XLEN] = (cmt_grant & veq_op1_hazard) ? vsp_cmt_op1 : veq_op1;
        assign veq_ctrl_op1_hazard[i * 1 +:1] = ~(veq_cs[COMMITTED] | (cmt_grant & ~vsp_cmt_kill)) & veq_op1_hazard;
        assign veq_ctrl_drop_vs[i * 1 +:1] = veq_vrf_this_dummy;
        assign veq_ctrl_cp_last[i * 1 +:1] = veq_cp_this_last;
        assign veq_ctrl_cp_done[i * 1 +:1] = veq_cp_this_done;
        assign veq_ctrl_dummy_vd[i * 1 +:1] = veq_vrf_this_dummy;
        assign veq_ctrl_dummy_all[i * 1 +:1] = veq_vrf_all_dummy;
        assign veq_ctrl_vrf_last[i * 1 +:1] = veq_vrf_this_last;
        assign veq_ctrl_vrf_done[i * 1 +:1] = ~veq_cs[CALCULATE] & veq_vrf_this_done;
        assign veq_st_rf_grant = (veq2st_ctrl_idx[i] & veq2st_ctrl_rf_grant);
        assign veq_st_cp_grant = (veq2st_ctrl_idx[i] & veq2st_ctrl_cp_grant);
        assign veq_ld_rf_grant = (veq2srf_ld_ctrl_idx[i] & veq2srf_ld_ctrl_rf_grant) | (veq2vrf_ld_ctrl_idx[i] & veq2vrf_ld_ctrl_rf_grant);
        assign veq_ld_cp_grant = (veq2srf_ld_ctrl_idx[i] & veq2srf_ld_ctrl_cp_grant) | (veq2vrf_ld_ctrl_idx[i] & veq2vrf_ld_ctrl_cp_grant);
        assign veq_ctrl_emask[i * (DLEN / 8) +:(DLEN / 8)] = veq_v0t[(DLEN / 8) - 1:0];
        assign veq_ctrl_v0t[i * VLEN +:VLEN] = veq_v0t;
        assign veq_ctrl_ratio[i * 4 +:4] = {veq_eew_8v1,veq_eew_4v1,veq_eew_2v1,veq_eew_1v1};
        assign veq_ctrl_cp2rf_element[i * (DLEN / 8) +:(DLEN / 8)] = veq_cp2rf_element;
        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_st_cs <= {{(ST_BITS - 1){1'b0}},1'b1};
            end
            else if (fsm_st_en) begin
                fsm_st_cs <= fsm_st_ns;
            end
        end

        always @* begin
            fsm_st_en = 1'b0;
            fsm_st_ns = {ST_BITS{1'b0}};
            case (1'b1)
                fsm_st_cs[ST_IDLE]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else if ((veq_cs[SPECULATIVE] | veq_cs[COMMITTED]) & veq_store) begin
                        fsm_st_ns[ST_BPS] = fsm_st_ns_idle2bps;
                        fsm_st_ns[ST_INJ_S] = fsm_st_ns_idle2injs;
                        fsm_st_ns[ST_MRG] = fsm_st_ns_idle2mrg;
                        fsm_st_ns[ST_REL] = fsm_st_ns_idle2rel;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
                fsm_st_cs[ST_BPS]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else if (veq_st_rf_grant) begin
                        fsm_st_ns[ST_IDLE] = fsm_st_ns_bps2idle;
                        fsm_st_ns[ST_REL] = fsm_st_ns_bps2rel;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
                fsm_st_cs[ST_INJ_S]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else if (veq_st_rf_grant) begin
                        fsm_st_ns[ST_MRG] = fsm_st_ns_injs2mrg;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
                fsm_st_cs[ST_MRG]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else if (veq_st_rf_grant) begin
                        fsm_st_ns[ST_INJ_E] = fsm_st_ns_mrg2inje;
                        fsm_st_ns[ST_REL] = fsm_st_ns_mrg2rel;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
                fsm_st_cs[ST_INJ_E]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else if (veq_st_rf_grant) begin
                        fsm_st_ns[ST_REL] = fsm_st_ns_inje2rel;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
                fsm_st_cs[ST_REL]: begin
                    if (cmt_kill) begin
                        fsm_st_ns[ST_IDLE] = 1'b1;
                        fsm_st_en = 1'b1;
                    end
                    else begin
                        fsm_st_ns[ST_IDLE] = fsm_st_ns_rel2idle;
                        fsm_st_en = |fsm_st_ns;
                    end
                end
            endcase
        end

        always @(posedge vpu_vsp_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                fsm_ld_cs <= {{(LD_BITS - 1){1'b0}},1'b1};
            end
            else if (fsm_ld_en) begin
                fsm_ld_cs <= fsm_ld_ns;
            end
        end

        always @* begin
            fsm_ld_en = 1'b0;
            fsm_ld_ns = {LD_BITS{1'b0}};
            case (1'b1)
                fsm_ld_cs[LD_IDLE]: begin
                    if (cmt_kill) begin
                        fsm_ld_ns[LD_IDLE] = 1'b1;
                        fsm_ld_en = 1'b1;
                    end
                    else if (((cmt_grant & veq_cs[SPECULATIVE]) | veq_cs[COMMITTED]) & veq_load) begin
                        fsm_ld_ns[LD_BPS] = fsm_ld_ns_idle2bps;
                        fsm_ld_ns[LD_PART] = fsm_ld_ns_idle2part;
                        fsm_ld_ns[LD_MRG] = fsm_ld_ns_idle2mrg;
                        fsm_ld_ns[LD_REL] = fsm_ld_ns_idle2rel;
                        fsm_ld_en = |fsm_ld_ns;
                    end
                end
                fsm_ld_cs[LD_BPS]: begin
                    if (veq_ld_cp_grant) begin
                        fsm_ld_ns[LD_IDLE] = fsm_ld_ns_bps2idle;
                        fsm_ld_ns[LD_REL] = fsm_ld_ns_bps2rel;
                        fsm_ld_en = |fsm_ld_ns;
                    end
                end
                fsm_ld_cs[LD_PART]: begin
                    if (veq_ld_cp_grant) begin
                        fsm_ld_ns[LD_MRG] = fsm_ld_ns_part2mrg;
                        fsm_ld_ns[LD_REL] = fsm_ld_ns_part2rel;
                        fsm_ld_en = |fsm_ld_ns;
                    end
                end
                fsm_ld_cs[LD_MRG]: begin
                    if (veq_ld_cp_grant) begin
                        fsm_ld_ns[LD_REL] = fsm_ld_ns_mrg2rel;
                        fsm_ld_en = |fsm_ld_ns;
                    end
                end
                fsm_ld_cs[LD_REL]: begin
                    if (veq_ld_rf_grant) begin
                        fsm_ld_ns[LD_IDLE] = fsm_ld_ns_rel2idle;
                        fsm_ld_en = |fsm_ld_ns;
                    end
                end
            endcase
        end

        assign veq_vrf_this_last = (veq_vrf_len[1:0] == 2'b01);
        assign veq_vrf_this_done = (veq_vrf_len[0] == 1'b0);
        assign veq_vrf_this_dummy = (veq_vrf_len[0] == 1'b1) & (veq_vrf_dummy_len[0] == 1'b1);
        assign veq_vrf_next_dummy = (veq_vrf_len[1] == 1'b1) & (veq_vrf_dummy_len[1] == 1'b1);
        assign veq_cp_this_last = (veq_cp_len[1:0] == 2'b01);
        assign veq_cp_this_done = (veq_cp_len[0] == 1'b0);
        assign veq_offset_this_align = (veq_offset == {OFFSET_BITS{1'b0}});
        assign veq_offset_next_align = (veq_offset_next[(OFFSET_BITS - 1):0] == {OFFSET_BITS{1'b0}});
        if (DLEN == VSP_DATA_WIDTH) begin:gen_st_w_bypass
            assign fsm_st_ns_idle2bps = (veq_vrf & veq_offset_this_align & veq_vrf_this_last & ~veq_vrf_this_dummy) | (veq_vrf & veq_offset_this_align & veq_eew_1v1 & ~veq_vrf_this_dummy) | (veq_srf & veq_offset_this_align) | (veq_vrf & veq_cp_this_last & veq_vrf_this_last & ~veq_vrf_this_dummy) | (veq_srf & veq_cp_this_last);
            assign fsm_st_ns_idle2mrg = (veq_vrf & veq_offset_this_align & ~veq_eew_1v1 & ~veq_vrf_this_last & ~veq_vrf_this_dummy);
            assign fsm_st_ns_idle2injs = (veq_vrf & ~veq_offset_this_align & ~veq_vrf_this_dummy & ~veq_cp_this_last) | (veq_vrf & ~veq_offset_this_align & ~veq_vrf_this_dummy & veq_cp_this_last & ~veq_vrf_this_last) | (veq_srf & ~veq_offset_this_align & ~veq_cp_this_last);
        end
        else begin:gen_st_wo_bypass
            assign fsm_st_ns_idle2bps = 1'b0;
            assign fsm_st_ns_idle2mrg = (veq_vrf & veq_offset_this_align & ~veq_vrf_this_dummy) | (veq_srf & veq_offset_this_align);
            assign fsm_st_ns_idle2injs = (veq_vrf & ~veq_offset_this_align & ~veq_vrf_this_dummy) | (veq_srf & ~veq_offset_this_align);
        end
        assign fsm_st_ns_idle2rel = (veq_vrf & veq_vrf_this_dummy);
        assign fsm_st_ns_bps2idle = (veq_vrf & veq_vrf_this_last & ~veq_vrf_next_dummy) | veq_srf;
        assign fsm_st_ns_bps2rel = (veq_vrf & veq_vrf_next_dummy);
        assign fsm_st_ns_injs2mrg = 1'b1;
        assign fsm_st_ns_mrg2inje = (veq_vrf & ~veq_offset_next_align & veq_vrf_this_last & ~veq_cp_this_done) | (veq_vrf & ~veq_offset_next_align & ~veq_vrf_this_last & veq_vrf_next_dummy) | (veq_srf & ~veq_offset_next_align);
        assign fsm_st_ns_mrg2rel = (veq_vrf & ~veq_offset_next_align & veq_vrf_this_last & veq_cp_this_done) | (veq_vrf & veq_offset_next_align & (veq_vrf_this_last | veq_vrf_next_dummy)) | (veq_srf & veq_offset_next_align);
        assign fsm_st_ns_inje2rel = 1'b1;
        assign fsm_st_ns_rel2idle = ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_vrf & veq_vrf_this_last & veq_st_rf_grant & veq_cp_this_done) | ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_vrf & veq_vrf_this_done & veq_cp_this_last & veq_st_cp_grant) | ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_vrf & veq_vrf_this_last & veq_st_rf_grant & veq_cp_this_last & veq_st_cp_grant) | ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_vrf & veq_vrf_this_done & veq_cp_this_done) | ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_srf & veq_cp_this_last & veq_st_cp_grant) | ((veq_cs[COMMITTED] | (veq_cs[SPECULATIVE] & cmt_grant)) & ace_store_done & veq_srf & veq_cp_this_done);
        if (DLEN == VSP_DATA_WIDTH) begin:gen_ld_w_bypass
            assign fsm_ld_ns_idle2bps = (veq_vrf & veq_offset_this_align & veq_eew_1v1 & ~veq_op_fcvt & ~veq_cp_this_done) | (veq_vrf & veq_offset_this_align & veq_vrf_this_last & ~veq_op_fcvt & ~veq_cp_this_done) | (veq_srf & veq_offset_this_align) | (veq_srf & ~veq_offset_this_align & veq_cp_this_last);
            assign fsm_ld_ns_idle2mrg = (veq_vrf & veq_offset_this_align & ~veq_eew_1v1 & ~veq_vrf_this_last & ~veq_cp_this_done) | (veq_vrf & veq_offset_this_align & veq_op_fcvt & ~veq_cp_this_done);
        end
        else begin:gen_ld_wo_bypass
            assign fsm_ld_ns_idle2bps = 1'b0;
            assign fsm_ld_ns_idle2mrg = (veq_vrf & veq_offset_this_align & ~veq_cp_this_done) | (veq_srf & veq_offset_this_align) | (veq_srf & ~veq_offset_this_align & veq_cp_this_last);
        end
        assign fsm_ld_ns_idle2part = (veq_vrf & ~veq_offset_this_align & ~veq_cp_this_done) | (veq_srf & ~veq_offset_this_align & ~veq_cp_this_last);
        assign fsm_ld_ns_idle2rel = veq_cp_this_done;
        assign fsm_ld_ns_bps2idle = (veq_vrf & veq_cp_this_last & veq_vrf_this_last) | (veq_srf & veq_cp_this_last);
        assign fsm_ld_ns_bps2rel = veq_vrf & veq_cp_this_last & veq_vrf_next_dummy;
        assign fsm_ld_ns_part2mrg = ~veq_cp_this_last;
        assign fsm_ld_ns_part2rel = veq_cp_this_last;
        assign fsm_ld_ns_mrg2rel = veq_cp_this_last;
        assign fsm_ld_ns_rel2idle = (veq_vrf & veq_vrf_this_last) | veq_srf;
        assign veq_ctrl_source_op1[i] = (fsm_st_cs[ST_BPS] | fsm_st_cs[ST_MRG]) & veq_srf;
        assign veq_ctrl_source_vs[i] = (fsm_st_cs[ST_BPS] | fsm_st_cs[ST_MRG] | fsm_st_cs[ST_INJ_E] | fsm_st_cs[ST_REL]) & veq_vrf & ~veq_vrf_this_done;
        assign veq_ctrl_source_dummy_start[i] = fsm_st_cs[ST_INJ_S];
        assign veq_ctrl_source_dummy_end[i] = fsm_st_cs[ST_INJ_E];
        assign veq_ctrl_destination_cp[i] = ~veq_cp_this_done;
        assign veq_ctrl_path_bypass[i] = fsm_st_cs[ST_BPS] | fsm_ld_cs[LD_BPS];
        assign veq_ctrl_path_merge[i] = (fsm_st_cs[ST_INJ_S] | fsm_st_cs[ST_MRG] | fsm_st_cs[ST_INJ_E]) | (fsm_ld_cs[LD_PART] | fsm_ld_cs[LD_MRG]);
        assign veq_ctrl_source_cp[i] = fsm_ld_cs[LD_PART] | fsm_ld_cs[LD_MRG] | fsm_ld_cs[LD_BPS];
        assign veq_ctrl_destination_srf[i] = veq_srf;
        assign veq_ctrl_destination_vrf[i] = veq_vrf & ~veq_vrf_this_done;
        assign veq_ctrl_partial_cp[i] = fsm_ld_cs[LD_PART];
        assign veq_ld_busy[i] = ~fsm_ld_cs[LD_IDLE];
        assign veq_st_busy[i] = ~fsm_st_cs[ST_IDLE];
        assign veq_st_done = (veq_cs[COMMITTED] & ~fsm_st_cs[ST_IDLE] & fsm_st_en & fsm_st_ns[ST_IDLE]) | (veq_cs[SPECULATIVE] & cmt_grant & ~cmt_kill & ~fsm_st_cs[ST_IDLE] & fsm_st_en & fsm_st_ns[ST_IDLE]);
        assign veq_ld_done = (veq_cs[COMMITTED] & ~fsm_ld_cs[LD_IDLE] & fsm_ld_en & fsm_ld_ns[LD_IDLE]);
    end
endgenerate
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(VRF_LW)
) u_sel_cal_veq_vrf_len (
    .out(sel_cal_veq_vrf_len),
    .sel(veq_calculate),
    .in(veq_ctrl_veq_vrf_len)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(11)
) u_sel_cal_veq_vl (
    .out(sel_cal_veq_vl),
    .sel(veq_calculate),
    .in(veq_ctrl_vl)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(2)
) u_sel_cal_veq_rf_eew (
    .out(sel_cal_veq_rf_eew),
    .sel(veq_calculate),
    .in(veq_ctrl_rf_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(3)
) u_sel_cal_veq_cp_eew (
    .out(sel_cal_veq_cp_eew),
    .sel(veq_calculate),
    .in(veq_ctrl_cp_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_sel_cal_veq_vrf (
    .out(sel_cal_veq_vrf),
    .sel(veq_calculate),
    .in(veq_ctrl_vrf)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_sel_cal_veq_una (
    .out(sel_cal_veq_una),
    .sel(veq_calculate),
    .in(veq_ctrl_una)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(OFFSET_BITS)
) u_sel_cal_veq_offset (
    .out(sel_cal_veq_offset),
    .sel(veq_calculate),
    .in(veq_ctrl_offset)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(VLEN)
) u_sel_cal_veq_v0t (
    .out(sel_cal_veq_v0t),
    .sel(veq_calculate),
    .in(veq_ctrl_v0t)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_sel_cal_veq_vm (
    .out(sel_cal_veq_vm),
    .sel(veq_calculate),
    .in(veq_ctrl_vm)
);
assign cal_veq_eew_1v1 = ((sel_cal_veq_rf_eew == 2'b00) & (sel_cal_veq_cp_eew == 3'b000)) | ((sel_cal_veq_rf_eew == 2'b01) & (sel_cal_veq_cp_eew == 3'b001)) | ((sel_cal_veq_rf_eew == 2'b10) & (sel_cal_veq_cp_eew == 3'b010)) | ((sel_cal_veq_rf_eew == 2'b11) & (sel_cal_veq_cp_eew == 3'b011));
assign cal_veq_eew_2v1 = ((sel_cal_veq_rf_eew == 2'b00) & (sel_cal_veq_cp_eew == 3'b100)) | ((sel_cal_veq_rf_eew == 2'b01) & (sel_cal_veq_cp_eew == 3'b000)) | ((sel_cal_veq_rf_eew == 2'b10) & (sel_cal_veq_cp_eew == 3'b001)) | ((sel_cal_veq_rf_eew == 2'b11) & (sel_cal_veq_cp_eew == 3'b010));
assign cal_veq_eew_4v1 = ((sel_cal_veq_rf_eew == 2'b01) & (sel_cal_veq_cp_eew == 3'b100)) | ((sel_cal_veq_rf_eew == 2'b10) & (sel_cal_veq_cp_eew == 3'b000)) | ((sel_cal_veq_rf_eew == 2'b11) & (sel_cal_veq_cp_eew == 3'b001));
assign cal_veq_eew_8v1 = ((sel_cal_veq_rf_eew == 2'b10) & (sel_cal_veq_cp_eew == 3'b100)) | ((sel_cal_veq_rf_eew == 2'b11) & (sel_cal_veq_cp_eew == 3'b000));
assign cal_veq_eew_16v1 = ((sel_cal_veq_rf_eew == 2'b11) & (sel_cal_veq_cp_eew == 3'b100));
generate
    wire rf_eew8 = (sel_cal_veq_rf_eew == 2'b00);
    wire rf_eew16 = (sel_cal_veq_rf_eew == 2'b01);
    wire rf_eew32 = (sel_cal_veq_rf_eew == 2'b10);
    wire rf_eew64 = (sel_cal_veq_rf_eew == 2'b11);
    wire [VRF_LW:0] rf_eew8_vl = sel_cal_veq_vl[DLEN_B_BITS +:(VRF_LW + 1)];
    wire [VRF_LW:0] rf_eew16_vl = sel_cal_veq_vl[(DLEN_B_BITS - 1) +:(VRF_LW + 1)];
    wire [VRF_LW:0] rf_eew32_vl = sel_cal_veq_vl[(DLEN_B_BITS - 2) +:(VRF_LW + 1)];
    wire [VRF_LW:0] rf_eew64_vl = sel_cal_veq_vl[(DLEN_B_BITS - 3) +:(VRF_LW + 1)];
    wire rf_eew8_vl_unalign = |sel_cal_veq_vl[0 +:DLEN_B_BITS];
    wire rf_eew16_vl_unalign = |sel_cal_veq_vl[0 +:(DLEN_B_BITS - 1)];
    wire rf_eew32_vl_unalign = |sel_cal_veq_vl[0 +:(DLEN_B_BITS - 2)];
    wire rf_eew64_vl_unalign = |sel_cal_veq_vl[0 +:(DLEN_B_BITS - 3)];
    wire rf_eew8_vl_align = ~rf_eew8_vl_unalign;
    wire rf_eew16_vl_align = ~rf_eew16_vl_unalign;
    wire rf_eew32_vl_align = ~rf_eew32_vl_unalign;
    wire rf_eew64_vl_align = ~rf_eew64_vl_unalign;
    wire [VRF_LW:0] rf_eewn_vl = ({(VRF_LW + 1){rf_eew8}} & rf_eew8_vl) | ({(VRF_LW + 1){rf_eew16}} & rf_eew16_vl) | ({(VRF_LW + 1){rf_eew32}} & rf_eew32_vl) | ({(VRF_LW + 1){rf_eew64}} & rf_eew64_vl);
    wire rf_eewn_vl_align = (rf_eew8 & rf_eew8_vl_align) | (rf_eew16 & rf_eew16_vl_align) | (rf_eew32 & rf_eew32_vl_align) | (rf_eew64 & rf_eew64_vl_align);
    wire cp_eew4 = (sel_cal_veq_cp_eew == 3'b100);
    wire cp_eew8 = (sel_cal_veq_cp_eew == 3'b000);
    wire cp_eew16 = (sel_cal_veq_cp_eew == 3'b001);
    wire cp_eew32 = (sel_cal_veq_cp_eew == 3'b010);
    wire cp_eew64 = (sel_cal_veq_cp_eew == 3'b011);
    wire [14:0] cp_tsize_nb = ({15{cp_eew4 & sel_cal_veq_vrf}} & {4'b0,sel_cal_veq_vl[10:0]}) | ({15{cp_eew8 & sel_cal_veq_vrf}} & {3'b0,sel_cal_veq_vl[10:0],1'b0}) | ({15{cp_eew16 & sel_cal_veq_vrf}} & {2'b0,sel_cal_veq_vl[10:0],2'b0}) | ({15{cp_eew32 & sel_cal_veq_vrf}} & {1'b0,sel_cal_veq_vl[10:0],3'b0}) | ({15{cp_eew64 & sel_cal_veq_vrf}} & {sel_cal_veq_vl[10:0],4'b0}) | ({15{cp_eew4 & ~sel_cal_veq_vrf}} & 15'b1) | ({15{cp_eew8 & ~sel_cal_veq_vrf}} & 15'b10) | ({15{cp_eew16 & ~sel_cal_veq_vrf}} & 15'b100) | ({15{cp_eew32 & ~sel_cal_veq_vrf}} & 15'b1000) | ({15{cp_eew64 & ~sel_cal_veq_vrf}} & 15'b10000);
    wire cp_nop = (sel_cal_veq_vrf & (sel_cal_veq_vl[10:0] == 11'b0));
    wire [14:0] cp_offset_nb = (sel_cal_veq_una & (~cp_nop)) ? {{(15 - VSP_NB_BITS){1'b0}},sel_cal_veq_offset[VSP_NB_BITS - 2:0],1'b0} : 15'b0;
    wire [VSP_NB_BITS:0] cp_beat_low_part = cp_tsize_nb[VSP_NB_BITS - 1:0] + cp_offset_nb[VSP_NB_BITS - 1:0];
    wire [1:0] cp_beat_add_cross = cp_beat_low_part[VSP_NB_BITS] + |cp_beat_low_part[VSP_NB_BITS - 1:0];
    wire [(15 - VSP_NB_BITS + 1):0] cp_beat = cp_tsize_nb[14:VSP_NB_BITS] + cp_offset_nb[14:VSP_NB_BITS] + {{(15 - VSP_NB_BITS - 2){1'b0}},cp_beat_add_cross[1:0]};
    if (VRF_LW == 3) begin:gen_vlen_dlen_1v1
        assign cal_veq_vrf_len[15:8] = 8'b0;
        assign cal_veq_vrf_len[7:4] = {4{sel_cal_veq_vrf_len[VRF_LW - 1]}};
        assign cal_veq_vrf_len[3:2] = {2{sel_cal_veq_vrf_len[VRF_LW - 2]}};
        assign cal_veq_vrf_len[1] = {1{sel_cal_veq_vrf_len[VRF_LW - 3]}};
        assign cal_veq_vrf_len[0] = 1'b1;
        assign cal_veq_vrf_dummy_len[15:8] = 8'b0;
        assign cal_veq_vrf_dummy_len[7] = ((rf_eewn_vl < 4'd7) | ((rf_eewn_vl == 4'd7) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[6] = ((rf_eewn_vl < 4'd6) | ((rf_eewn_vl == 4'd6) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[5] = ((rf_eewn_vl < 4'd5) | ((rf_eewn_vl == 4'd5) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[4] = ((rf_eewn_vl < 4'd4) | ((rf_eewn_vl == 4'd4) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[3] = ((rf_eewn_vl < 4'd3) | ((rf_eewn_vl == 4'd3) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[2] = ((rf_eewn_vl < 4'd2) | ((rf_eewn_vl == 4'd2) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[1] = ((rf_eewn_vl < 4'd1) | ((rf_eewn_vl == 4'd1) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 3];
        assign cal_veq_vrf_dummy_len[0] = ((rf_eewn_vl == 4'd0) & rf_eewn_vl_align);
    end
    if (VRF_LW == 4) begin:gen_vlen_dlen_2v1
        assign cal_veq_vrf_len[15:8] = {8{sel_cal_veq_vrf_len[VRF_LW - 1]}};
        assign cal_veq_vrf_len[7:4] = {4{sel_cal_veq_vrf_len[VRF_LW - 2]}};
        assign cal_veq_vrf_len[3:2] = {2{sel_cal_veq_vrf_len[VRF_LW - 3]}};
        assign cal_veq_vrf_len[1:0] = 2'b11;
        assign cal_veq_vrf_dummy_len[15] = ((rf_eewn_vl < 5'd15) | ((rf_eewn_vl == 5'd15) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[14] = ((rf_eewn_vl < 5'd14) | ((rf_eewn_vl == 5'd14) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[13] = ((rf_eewn_vl < 5'd13) | ((rf_eewn_vl == 5'd13) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[12] = ((rf_eewn_vl < 5'd12) | ((rf_eewn_vl == 5'd12) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[11] = ((rf_eewn_vl < 5'd11) | ((rf_eewn_vl == 5'd11) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[10] = ((rf_eewn_vl < 5'd10) | ((rf_eewn_vl == 5'd10) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[9] = ((rf_eewn_vl < 5'd9) | ((rf_eewn_vl == 5'd9) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[8] = ((rf_eewn_vl < 5'd8) | ((rf_eewn_vl == 5'd8) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 1];
        assign cal_veq_vrf_dummy_len[7] = ((rf_eewn_vl < 5'd7) | ((rf_eewn_vl == 5'd7) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[6] = ((rf_eewn_vl < 5'd6) | ((rf_eewn_vl == 5'd6) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[5] = ((rf_eewn_vl < 5'd5) | ((rf_eewn_vl == 5'd5) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[4] = ((rf_eewn_vl < 5'd4) | ((rf_eewn_vl == 5'd4) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 2];
        assign cal_veq_vrf_dummy_len[3] = ((rf_eewn_vl < 5'd3) | ((rf_eewn_vl == 5'd3) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 3];
        assign cal_veq_vrf_dummy_len[2] = ((rf_eewn_vl < 5'd2) | ((rf_eewn_vl == 5'd2) & rf_eewn_vl_align)) & sel_cal_veq_vrf_len[VRF_LW - 3];
        assign cal_veq_vrf_dummy_len[1] = ((rf_eewn_vl < 5'd1) | ((rf_eewn_vl == 5'd1) & rf_eewn_vl_align));
        assign cal_veq_vrf_dummy_len[0] = ((rf_eewn_vl == 5'd0) & rf_eewn_vl_align);
    end
    assign cal_veq_cp_len[32] = (cp_beat[5:0] > 6'd32);
    assign cal_veq_cp_len[31] = (cp_beat[5:0] > 6'd31);
    assign cal_veq_cp_len[30] = (cp_beat[5:0] > 6'd30);
    assign cal_veq_cp_len[29] = (cp_beat[5:0] > 6'd29);
    assign cal_veq_cp_len[28] = (cp_beat[5:0] > 6'd28);
    assign cal_veq_cp_len[27] = (cp_beat[5:0] > 6'd27);
    assign cal_veq_cp_len[26] = (cp_beat[5:0] > 6'd26);
    assign cal_veq_cp_len[25] = (cp_beat[5:0] > 6'd25);
    assign cal_veq_cp_len[24] = (cp_beat[5:0] > 6'd24);
    assign cal_veq_cp_len[23] = (cp_beat[5:0] > 6'd23);
    assign cal_veq_cp_len[22] = (cp_beat[5:0] > 6'd22);
    assign cal_veq_cp_len[21] = (cp_beat[5:0] > 6'd21);
    assign cal_veq_cp_len[20] = (cp_beat[5:0] > 6'd20);
    assign cal_veq_cp_len[19] = (cp_beat[5:0] > 6'd19);
    assign cal_veq_cp_len[18] = (cp_beat[5:0] > 6'd18);
    assign cal_veq_cp_len[17] = (cp_beat[5:0] > 6'd17);
    assign cal_veq_cp_len[16] = (cp_beat[5:0] > 6'd16);
    assign cal_veq_cp_len[15] = (cp_beat[5:0] > 6'd15);
    assign cal_veq_cp_len[14] = (cp_beat[5:0] > 6'd14);
    assign cal_veq_cp_len[13] = (cp_beat[5:0] > 6'd13);
    assign cal_veq_cp_len[12] = (cp_beat[5:0] > 6'd12);
    assign cal_veq_cp_len[11] = (cp_beat[5:0] > 6'd11);
    assign cal_veq_cp_len[10] = (cp_beat[5:0] > 6'd10);
    assign cal_veq_cp_len[9] = (cp_beat[5:0] > 6'd9);
    assign cal_veq_cp_len[8] = (cp_beat[5:0] > 6'd8);
    assign cal_veq_cp_len[7] = (cp_beat[5:0] > 6'd7);
    assign cal_veq_cp_len[6] = (cp_beat[5:0] > 6'd6);
    assign cal_veq_cp_len[5] = (cp_beat[5:0] > 6'd5);
    assign cal_veq_cp_len[4] = (cp_beat[5:0] > 6'd4);
    assign cal_veq_cp_len[3] = (cp_beat[5:0] > 6'd3);
    assign cal_veq_cp_len[2] = (cp_beat[5:0] > 6'd2);
    assign cal_veq_cp_len[1] = (cp_beat[5:0] > 6'd1);
    assign cal_veq_cp_len[0] = (cp_beat[5:0] > 6'd0);
    wire [VLEN - 1:0] v0t_mask;
    wire [VLEN - 1:0] vl_mask;
    wire [15:0] tail_idx;
    wire [(DLEN / 8) - 1:0] tail_mask;
    kv_vsp_sizeup #(
        .IW(VLEN),
        .OW(VLEN),
        .EW(1)
    ) u_v0t_mask (
        .src_eew(3'b000),
        .dst_eew(sel_cal_veq_rf_eew),
        .sext(1'b1),
        .din(sel_cal_veq_v0t),
        .dout(v0t_mask)
    );
    assign tail_idx = (cal_veq_vrf_len & ~cal_veq_vrf_dummy_len) & {1'b1,~(cal_veq_vrf_len[15:1] & ~cal_veq_vrf_dummy_len[15:1])};
    assign tail_mask = ({(DLEN / 8){rf_eew8 & rf_eew8_vl_unalign}} << sel_cal_veq_vl[DLEN_B_BITS - 1:0]) | ({(DLEN / 8){rf_eew16 & rf_eew16_vl_unalign}} << {sel_cal_veq_vl[DLEN_B_BITS - 2:0],1'b0}) | ({(DLEN / 8){rf_eew32 & rf_eew32_vl_unalign}} << {sel_cal_veq_vl[DLEN_B_BITS - 3:0],2'b0}) | ({(DLEN / 8){rf_eew64 & rf_eew64_vl_unalign}} << {sel_cal_veq_vl[DLEN_B_BITS - 4:0],3'b0});
    for (i = 0; i < 8 * (VLEN / DLEN); i = i + 1) begin:gen_vl_mask
        assign vl_mask[i * (DLEN / 8) +:(DLEN / 8)] = {(DLEN / 8){~tail_idx[i] & ~cal_veq_vrf_dummy_len[i]}} | ({(DLEN / 8){tail_idx[i]}} & ~tail_mask);
    end
    assign cal_veq_v0t = ({VLEN{sel_cal_veq_vrf}} & ({VLEN{sel_cal_veq_vm}} | v0t_mask) & vl_mask) | ({VLEN{~sel_cal_veq_vrf & (sel_cal_veq_rf_eew == 2'b11)}} & {{(VLEN - 8){1'b0}},8'hff}) | ({VLEN{~sel_cal_veq_vrf & (sel_cal_veq_rf_eew == 2'b10)}} & {{(VLEN - 8){1'b0}},8'h0f}) | ({VLEN{~sel_cal_veq_vrf & (sel_cal_veq_rf_eew == 2'b01)}} & {{(VLEN - 8){1'b0}},8'h03});
endgenerate
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(XLEN)
) u_veq2st_ctrl_op1 (
    .out(veq2st_ctrl_op1),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_op1)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_ctrl_op1_hazard (
    .out(veq2st_ctrl_op1_hazard),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_op1_hazard)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(OFFSET_BITS)
) u_veq2st_ctrl_offset (
    .out(veq2st_ctrl_offset),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_offset)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(3)
) u_veq2st_ctrl_cp_eew (
    .out(veq2st_ctrl_cp_eew),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_cp_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(2)
) u_veq2st_ctrl_rf_eew (
    .out(veq2st_ctrl_rf_eew),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_rf_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(DLEN / 8)
) u_veq2st_ctrl_emask (
    .out(veq2st_ctrl_emask),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_emask)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(4)
) u_veq2st_ctrl_ratio (
    .out(veq2st_ctrl_ratio),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_ratio)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_drop_vs (
    .out(veq2st_drop_vs),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_drop_vs)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_cp_last (
    .out(veq2st_cp_last),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_cp_last)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_source_op1 (
    .out(veq2st_source_op1),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_source_op1)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_source_vs (
    .out(veq2st_source_vs),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_source_vs)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_source_dummy_start (
    .out(veq2st_source_dummy_start),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_source_dummy_start)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_source_dummy_end (
    .out(veq2st_source_dummy_end),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_source_dummy_end)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_destination_cp (
    .out(veq2st_destination_cp),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_destination_cp)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_path_bypass (
    .out(veq2st_path_bypass),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_path_bypass)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2st_path_merge (
    .out(veq2st_path_merge),
    .sel(veq2st_ctrl_idx),
    .in(veq_ctrl_path_merge)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(OFFSET_BITS)
) u_veq2srf_ld_ctrl_offset (
    .out(veq2srf_ld_ctrl_offset),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_offset)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(3)
) u_veq2srf_ld_ctrl_cp_eew (
    .out(veq2srf_ld_ctrl_cp_eew),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_cp_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(2)
) u_veq2srf_ld_ctrl_rf_eew (
    .out(veq2srf_ld_ctrl_rf_eew),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_rf_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(DLEN / 8)
) u_veq2srf_ld_ctrl_emask (
    .out(veq2srf_ld_ctrl_emask),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_emask)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(DLEN / 8)
) u_veq2srf_ld_ctrl_cp2rf_element (
    .out(veq2srf_ld_ctrl_cp2rf_element),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_cp2rf_element)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_ctrl_sext (
    .out(veq2srf_ld_ctrl_sext),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_op_sext)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_ctrl_frf (
    .out(veq2srf_ld_ctrl_frf),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_frf)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(5)
) u_veq2srf_ld_ctrl_srf_idx (
    .out(veq2srf_ld_ctrl_srf_idx),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_rf_idx)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_source_cp (
    .out(veq2srf_ld_source_cp),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_source_cp)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_destination_srf (
    .out(veq2srf_ld_destination_srf),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_destination_srf)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_partial_cp (
    .out(veq2srf_ld_partial_cp),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_partial_cp)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_cp_last (
    .out(veq2srf_ld_cp_last),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_cp_last)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_path_bypass (
    .out(veq2srf_ld_path_bypass),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_path_bypass)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2srf_ld_path_merge (
    .out(veq2srf_ld_path_merge),
    .sel(veq2srf_ld_ctrl_idx),
    .in(veq_ctrl_path_merge)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(OFFSET_BITS)
) u_veq2vrf_ld_ctrl_offset (
    .out(veq2vrf_ld_ctrl_offset),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_offset)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(3)
) u_veq2vrf_ld_ctrl_cp_eew (
    .out(veq2vrf_ld_ctrl_cp_eew),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_cp_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(2)
) u_veq2vrf_ld_ctrl_rf_eew (
    .out(veq2vrf_ld_ctrl_rf_eew),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_rf_eew)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(DLEN / 8)
) u_veq2vrf_ld_ctrl_emask (
    .out(veq2vrf_ld_ctrl_emask),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_emask)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(DLEN / 8)
) u_veq2vrf_ld_ctrl_cp2rf_element (
    .out(veq2vrf_ld_ctrl_cp2rf_element),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_cp2rf_element)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_ctrl_sext (
    .out(veq2vrf_ld_ctrl_sext),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_op_sext)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_ctrl_fcvt (
    .out(veq2vrf_ld_ctrl_fcvt),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_op_fcvt)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_ctrl_bf16 (
    .out(veq2vrf_ld_ctrl_bf16),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_op_bf16)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_source_cp (
    .out(veq2vrf_ld_source_cp),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_source_cp)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_destination_vrf (
    .out(veq2vrf_ld_destination_vrf),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_destination_vrf)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_partial_cp (
    .out(veq2vrf_ld_partial_cp),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_partial_cp)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_cp_last (
    .out(veq2vrf_ld_cp_last),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_cp_last)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_dummy_vd (
    .out(veq2vrf_ld_dummy_vd),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_dummy_vd)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_dummy_all (
    .out(veq2vrf_ld_dummy_all),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_dummy_all)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_vrf_last (
    .out(veq2vrf_ld_vrf_last),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_vrf_last)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_path_bypass (
    .out(veq2vrf_ld_path_bypass),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_path_bypass)
);
kv_mux_onehot #(
    .N(VEQ_DEPTH),
    .W(1)
) u_veq2vrf_ld_path_merge (
    .out(veq2vrf_ld_path_merge),
    .sel(veq2vrf_ld_ctrl_idx),
    .in(veq_ctrl_path_merge)
);
generate
    if (ACE_SP_MODE == 0) begin:gen_fsp_standby
        assign vsp_veq_standby_ready = &veq_invalid & ~ace_store_done;
    end
    if (ACE_SP_MODE == 1) begin:gen_asp_standby
        assign vsp_veq_standby_ready = &veq_invalid;
    end
endgenerate
wire nds_unused_debug_signals = wait_cmt_ld_rvalid | (|veq_ctrl_veq_id) | (|veq_speculative) | (|veq_committed) | (|veq_ctrl_xrf) | (|veq_ctrl_vrf_len) | (|veq_ctrl_vrf_dummy_len) | (|veq_ctrl_cp_len);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

