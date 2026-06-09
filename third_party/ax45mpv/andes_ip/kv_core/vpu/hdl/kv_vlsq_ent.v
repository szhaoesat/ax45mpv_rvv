// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vlsq_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    vlsq_req_ready,
    vlsq_enq_valid,
    vlsq_req_valid,
    vlsq_req_grant_last,
    vlsq_cmt_valid,
    vlsq_cmt_kill,
    vlsq_ack_ready,
    vlsq_deq_ready,
    vlsq_enq_ctrl,
    vlsq_enq_op1,
    vlsq_enq_op2,
    vlsq_enq_v0t,
    vlsq_enq_vstart,
    vlsq_enq_vstart_nf,
    vlsq_enq_vstart_byte,
    vlsq_enq_vstart_eew4_lsb,
    vlsq_enq_vl,
    vlsq_enq_vl_nf,
    vlsq_enq_vl_minus1,
    vlsq_enq_vs2_len,
    vlsq_enq_vd_emul_len,
    vlsq_inst_req_mark_valid,
    vlsq_req_cross_4k,
    vlsq_req_cross_4k_d1,
    vlsq_resp_valid,
    vlsq_resp_status,
    vlsq_resp_fault_element,
    vlsq_resp_fault_nf,
    vlsq_resp_tval,
    vlsq_resp_remain_vd_beats,
    vlsq_resp_hit_hvm,
    vlsq_qout_ack_valid,
    vlsq_qout_ack_status,
    vlsq_qout_ack_tval,
    vlsq_qout_ack_element,
    vlsq_qout_ack_nf,
    vlsq_qout_ctrl,
    vlsq_qout_load,
    vlsq_qout_store,
    vlsq_qout_block_cmd,
    vlsq_qout_vstart,
    vlsq_qout_vstart_nf,
    vlsq_qout_vstart_byte,
    vlsq_qout_vstart_eew4_lsb,
    vlsq_qout_vl,
    vlsq_qout_vl_nf,
    vlsq_qout_vl_minus1,
    vlsq_qout_vstart_dlen,
    vlsq_qout_vl_dlen,
    vlsq_qout_vd_beats,
    vlsq_qout_vd_seg_beats,
    vlsq_qout_remain_vd_beats,
    vlsq_qout_vd_emul_len,
    vlsq_qout_op1,
    vlsq_qout_op2,
    vlsq_qout_v0t,
    vlsq_qout_occupied,
    vlsq_qout_valid_pre,
    vlsq_qout_claim_skip,
    vlsq_qout_vlsq2buf_skip,
    vlsq_qout_vlsq2vs3_skip,
    vlsq_qout_req_skip,
    vlsq_qout_vlsq2uop_skip,
    vlsq_qout_vs2_done,
    vlsq_qout_vs2_skip,
    vlsq_qout_alive,
    vlsq_qout_widen_alive,
    vlsq_qout_xcpted,
    vlsq_qout_inst_req_mark,
    vlsq_qout_start_buf_num,
    vlsq_qout_start_buf_ptr,
    vlsq_qout_deq_valid,
    vlsq_qout_deq_kill_buf,
    vlsq_qout_deq_kill_size,
    vlsq_enq_check_cnt,
    vlsq_qout_check_cnt,
    vlsq_qout_check_done,
    vlsq2uop_cmt_done_valid,
    vlsq2uop_qout_valid,
    vlsq2uop_qout_buf_ready,
    vlsq_qout_cmtted,
    vlsq_qout_killed,
    vlsq2buf_req_done_valid,
    vlsq2buf_qout_req_valid,
    vlsq2buf_qout_req_vl,
    vlsq2vs3_qout_rready,
    vlsq2vs3_req_done_valid,
    vlsq_qout_claim_buf_valid,
    vlsq_qout_claim_buf_reset,
    vlsq_qout_claim_buf_last,
    vlsq_qout_claim_buf_adj,
    vlsq_qout_claim_buf_size,
    vlsq_qout_claim_buf_cnt,
    vlsq_claim_buf_ready,
    vlsq_qout_hit_hvm,
    vlsq_claim_mark_valid,
    vlsq_claim_resp_buf_num,
    vlsq_claim_resp_buf_ptr,
    vlsu_vs2_rgrant_last
);
parameter XLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 32;
parameter VALEN = 39;
parameter EXTVALEN = 39;
parameter VRF_LW = 3;
parameter SEW8_DLEN_WIDTH = $clog2(DLEN / 8);
parameter SEW16_DLEN_WIDTH = $clog2(DLEN / 16);
parameter SEW32_DLEN_WIDTH = $clog2(DLEN / 32);
parameter SEW64_DLEN_WIDTH = $clog2(DLEN / 64);
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter VS2Q_DEPTH_LOG2 = 1;
parameter ELE_CNT_WIDTH = $clog2(VLEN);
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter MAX_BYTE_WIDTH = 7;
parameter SEG_PRESYNC = 0;
localparam VLSQ_FSM_BITS = 4;
localparam VLSQ_FSM_INVALID = 0;
localparam VLSQ_FSM_WAIT_CMT = 1;
localparam VLSQ_FSM_COMMITTED = 2;
localparam VLSQ_FSM_KILLED = 3;
localparam VS2Q_DEPTH_LOG2_ = (VS2Q_DEPTH_LOG2 == 0) ? 1 : VS2Q_DEPTH_LOG2;
localparam VLSQ_REQ_FSM_BITS = 4;
localparam VLSQ_REQ_FSM_INVALID = 0;
localparam VLSQ_REQ_FSM_ONGOING = 1;
localparam VLSQ_REQ_FSM_DONE = 2;
localparam VLSQ_REQ_FSM_SKIP = 3;
input vpu_vlsu_clk;
input vpu_reset_n;
input vlsq_req_ready;
input vlsq_enq_valid;
input vlsq_req_valid;
input vlsq_req_grant_last;
input vlsq_cmt_valid;
input vlsq_cmt_kill;
input vlsq_ack_ready;
input vlsq_deq_ready;
input [28 - 1:0] vlsq_enq_ctrl;
input [XLEN - 1:0] vlsq_enq_op1;
input [XLEN - 1:0] vlsq_enq_op2;
input [VLEN - 1:0] vlsq_enq_v0t;
input [ELE_CNT_WIDTH - 1:0] vlsq_enq_vstart;
input [ELE_CNT_WIDTH - 1:0] vlsq_enq_vstart_nf;
input [MAX_BYTE_WIDTH - 1:0] vlsq_enq_vstart_byte;
input vlsq_enq_vstart_eew4_lsb;
input [ELE_CNT_WIDTH:0] vlsq_enq_vl;
input [ELE_CNT_WIDTH:0] vlsq_enq_vl_nf;
input [ELE_CNT_WIDTH - 1:0] vlsq_enq_vl_minus1;
input [VRF_LW - 1:0] vlsq_enq_vs2_len;
input [VRF_LW - 1:0] vlsq_enq_vd_emul_len;
input vlsq_inst_req_mark_valid;
input vlsq_req_cross_4k;
input vlsq_req_cross_4k_d1;
input vlsq_resp_valid;
input [22 - 1:0] vlsq_resp_status;
input [ELE_CNT_WIDTH - 1:0] vlsq_resp_fault_element;
input [2:0] vlsq_resp_fault_nf;
input [EXTVALEN - 1:0] vlsq_resp_tval;
input [VRF_LW - 1:0] vlsq_resp_remain_vd_beats;
input vlsq_resp_hit_hvm;
output vlsq_qout_ack_valid;
output [22 - 1:0] vlsq_qout_ack_status;
output [EXTVALEN - 1:0] vlsq_qout_ack_tval;
output [ELE_CNT_WIDTH - 1:0] vlsq_qout_ack_element;
output [2:0] vlsq_qout_ack_nf;
output [28 - 1:0] vlsq_qout_ctrl;
output vlsq_qout_load;
output vlsq_qout_store;
output vlsq_qout_block_cmd;
output [ELE_CNT_WIDTH - 1:0] vlsq_qout_vstart;
output [ELE_CNT_WIDTH - 1:0] vlsq_qout_vstart_nf;
output [MAX_BYTE_WIDTH - 1:0] vlsq_qout_vstart_byte;
output vlsq_qout_vstart_eew4_lsb;
output [ELE_CNT_WIDTH:0] vlsq_qout_vl;
output [ELE_CNT_WIDTH:0] vlsq_qout_vl_nf;
output [ELE_CNT_WIDTH - 1:0] vlsq_qout_vl_minus1;
output [VRF_LW - 1:0] vlsq_qout_vstart_dlen;
output [VRF_LW - 1:0] vlsq_qout_vl_dlen;
output [VRF_LW - 1:0] vlsq_qout_vd_beats;
output [VRF_LW - 1:0] vlsq_qout_vd_seg_beats;
output [VRF_LW - 1:0] vlsq_qout_remain_vd_beats;
output [VRF_LW - 1:0] vlsq_qout_vd_emul_len;
output [XLEN - 1:0] vlsq_qout_op1;
output [XLEN - 1:0] vlsq_qout_op2;
output [VLEN - 1:0] vlsq_qout_v0t;
output vlsq_qout_occupied;
output vlsq_qout_valid_pre;
output vlsq_qout_claim_skip;
output vlsq_qout_vlsq2buf_skip;
output vlsq_qout_vlsq2vs3_skip;
output vlsq_qout_req_skip;
output vlsq_qout_vlsq2uop_skip;
output vlsq_qout_vs2_done;
output vlsq_qout_vs2_skip;
output vlsq_qout_alive;
output vlsq_qout_widen_alive;
output vlsq_qout_xcpted;
output vlsq_qout_inst_req_mark;
output [BUF_DEPTH_LOG2 - 1:0] vlsq_qout_start_buf_num;
output [BUF_DEPTH - 1:0] vlsq_qout_start_buf_ptr;
output vlsq_qout_deq_valid;
output vlsq_qout_deq_kill_buf;
output [VRF_LW:0] vlsq_qout_deq_kill_size;
input [ELE_CNT_WIDTH - 1:0] vlsq_enq_check_cnt;
output [ELE_CNT_WIDTH - 1:0] vlsq_qout_check_cnt;
output vlsq_qout_check_done;
input vlsq2uop_cmt_done_valid;
output vlsq2uop_qout_valid;
output vlsq2uop_qout_buf_ready;
output vlsq_qout_cmtted;
output vlsq_qout_killed;
input vlsq2buf_req_done_valid;
output vlsq2buf_qout_req_valid;
output [ELE_CNT_WIDTH:0] vlsq2buf_qout_req_vl;
output vlsq2vs3_qout_rready;
input vlsq2vs3_req_done_valid;
output vlsq_qout_claim_buf_valid;
output vlsq_qout_claim_buf_reset;
output vlsq_qout_claim_buf_last;
output vlsq_qout_claim_buf_adj;
output [VRF_LW - 1:0] vlsq_qout_claim_buf_size;
output [VRF_LW:0] vlsq_qout_claim_buf_cnt;
input vlsq_claim_buf_ready;
output vlsq_qout_hit_hvm;
input vlsq_claim_mark_valid;
input [BUF_DEPTH_LOG2 - 1:0] vlsq_claim_resp_buf_num;
input [BUF_DEPTH - 1:0] vlsq_claim_resp_buf_ptr;
input vlsu_vs2_rgrant_last;





// d9befe96 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [28 - 1:0] vlsq_ctrl;
reg [XLEN - 1:0] vlsq_op1;
reg [XLEN - 1:0] vlsq_op2;
reg [ELE_CNT_WIDTH - 1:0] vlsq_vstart;
reg [ELE_CNT_WIDTH - 1:0] vlsq_vstart_nf;
reg [MAX_BYTE_WIDTH - 1:0] vlsq_vstart_byte;
reg vlsq_vstart_eew4_lsb;
reg [VRF_LW - 1:0] vlsq_vs2_len;
reg [VRF_LW - 1:0] vlsq_vd_emul_len;
wire vlsq_killing;
wire vlsq_kill;
wire [VRF_LW - 1:0] vlsq_vstart_dlen;
wire [VRF_LW - 1:0] vlsq_vl_dlen;
wire [VRF_LW - 1:0] vlsq_vd_beats;
wire [VRF_LW:0] vlsq_vd_beats_add1;
wire [VRF_LW:0] vlsq_vd_seg_beats;
wire [VRF_LW:0] vlsq_vd_seg_beats_add1;
wire [VLEN - 1:0] vlsq_v0t_sel;
wire vlsq_v0t_en;
wire [VLEN - 1:0] vlsq_v0t_nx;
reg [VLEN - 1:0] vlsq_v0t;
reg [ELE_CNT_WIDTH:0] vlsq_vl;
reg [ELE_CNT_WIDTH:0] vlsq_vl_nf;
reg [ELE_CNT_WIDTH - 1:0] vlsq_vl_minus1;
wire vlsq_widen;
wire vlsq_load;
wire vlsq_store;
wire vlsq_buf_ill;
wire vlsq_vd_beats_ill;
wire vlsq_reserve_buf_size2;
wire vlsq_reserve_buf_size1;
wire vlsq_claim_buf_trig;
wire vlsq_claim_buf_cnt_en;
wire vlsq_claim_buf_grant;
wire vlsq_claim_buf_first;
wire [VRF_LW:0] vlsq_claim_buf_cnt_add1;
wire [VRF_LW:0] vlsq_claim_buf_cnt_nx;
reg [VRF_LW:0] vlsq_claim_buf_cnt;
wire vlsq_claim_start_buf_en;
wire vlsq_buf_ready_clr0;
wire vlsq_buf_ready_set0;
wire vlsq_buf_ready_en0;
wire vlsq_buf_ready_clr1;
wire vlsq_buf_ready_set1;
wire vlsq_buf_ready_en1;
wire [1:0] vlsq_buf_ready_nx;
reg [1:0] vlsq_buf_ready;
reg [BUF_DEPTH_LOG2 - 1:0] vlsq_start_buf_num;
reg [BUF_DEPTH - 1:0] vlsq_start_buf_ptr;
wire vs3_done_set;
wire vs3_done_clr;
wire vs3_done_en;
wire vs3_done_nx;
reg vs3_done;
wire vs2_done_set;
wire vs2_done_clr;
wire vs2_done_en;
wire vs2_done_nx;
reg vs2_done;
wire vlsq_check_cnt_en;
wire [ELE_CNT_WIDTH - 1:0] vlsq_check_cnt_nx;
reg [ELE_CNT_WIDTH - 1:0] vlsq_check_cnt;
wire inst_req_mark_set;
wire inst_req_mark_clr;
wire inst_req_mark_en;
wire inst_req_mark_nx;
reg inst_req_mark;
wire vlsq_ack_mark_set;
wire vlsq_ack_mark_clr;
wire vlsq_ack_mark_en;
wire vlsq_ack_mark_nx;
reg vlsq_ack_mark;
wire vlsq2uop_cmt_done_set;
wire vlsq2uop_cmt_done_clr;
wire vlsq2uop_cmt_done_en;
wire vlsq2uop_cmt_done_nx;
reg vlsq2uop_cmt_done;
reg vlsq2buf_req_done;
wire vlsq2buf_req_done_en;
wire vlsq2buf_req_done_set;
wire vlsq2buf_req_done_clr;
wire vlsq2buf_req_done_nx;
wire [2:0] vlsq_nf;
wire vlsq_ustride;
wire vlsq_indexed;
wire vlsq_element;
wire vlsq_element_nseg;
wire vlsq_seg;
wire vlsq_non_zero_element;
wire vlsq_fault_status_set;
wire vlsq_fault_status_clr;
wire vlsq_fault_status_en;
wire [22 - 1:0] vlsq_fault_status_nx;
reg [22 - 1:0] vlsq_fault_status;
reg [EXTVALEN - 1:0] vlsq_fault_tval;
reg [ELE_CNT_WIDTH - 1:0] vlsq_fault_element;
reg [2:0] vlsq_fault_nf;
reg [VRF_LW - 1:0] vlsq_remain_vd_beats;
wire vlsq_hit_hvm_en;
wire vlsq_hit_hvm_nx;
reg vlsq_hit_hvm;
wire vlsq_committed;
wire vlsq_killed;
wire vlsq_wait_cmt;
reg vlsq_fsm_en;
reg [VLSQ_FSM_BITS - 1:0] vlsq_fsm;
reg [VLSQ_FSM_BITS - 1:0] vlsq_fsm_nx;
wire vlsq_req_ongoing;
wire vlsq_req_done;
wire vlsq_req_skip;
wire vlsq_req_fsm_ongoing_en;
reg vlsq_req_fsm_en;
reg [VLSQ_REQ_FSM_BITS - 1:0] vlsq_req_fsm_nx;
reg [VLSQ_REQ_FSM_BITS - 1:0] vlsq_req_fsm;
wire vlsq_deq_valid;
wire vlsq_deq_grant;
wire vlsq_ack_valid;
wire vlsq_ack_grant;
wire [VRF_LW - 1:0] nds_unused_vlsq_vs2_len;
kv_vls_element_dec #(
    .VLEN(VLEN),
    .DLEN(DLEN),
    .ELEN(ELEN),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .VRF_LW(VRF_LW),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH)
) u_vls_vd_element_dec (
    .en(vlsq_qout_occupied),
    .eew(vlsq_ctrl[22 +:3]),
    .vstart_element(vlsq_vstart),
    .vl_element(vlsq_vl_minus1),
    .vstart_dlen(vlsq_vstart_dlen),
    .vl_dlen(vlsq_vl_dlen),
    .vrf_beat(vlsq_vd_beats)
);
kv_vls_seg_num #(
    .WIDTH(VRF_LW + 1)
) u_vls_vd_beat_seg (
    .data_in(vlsq_vd_beats_add1),
    .nf(vlsq_nf),
    .data_out(vlsq_vd_seg_beats_add1)
);
assign nds_unused_vlsq_vs2_len = vlsq_vs2_len;
assign vlsq_qout_occupied = ~vlsq_fsm[VLSQ_FSM_INVALID];
assign vlsq_qout_valid_pre = (vlsq_committed | vlsq_wait_cmt) & ~vlsq_req_done & ~vlsq_killed;
assign vlsq_qout_ctrl = vlsq_ctrl;
assign vlsq_qout_vd_emul_len = vlsq_vd_emul_len;
assign vlsq_qout_vstart = vlsq_vstart;
assign vlsq_qout_vstart_nf = vlsq_vstart_nf;
assign vlsq_qout_vstart_byte = vlsq_vstart_byte;
assign vlsq_qout_vstart_eew4_lsb = vlsq_vstart_eew4_lsb;
assign vlsq_qout_vl = vlsq_vl;
assign vlsq_qout_vl_nf = vlsq_vl_nf;
assign vlsq_qout_vl_minus1 = vlsq_vl_minus1;
assign vlsq_qout_load = vlsq_qout_occupied & vlsq_qout_ctrl[4];
assign vlsq_qout_store = vlsq_qout_occupied & vlsq_qout_ctrl[17];
assign vlsq_qout_block_cmd = vlsq_qout_occupied & (vlsq_qout_ctrl[18] | vlsq_qout_ctrl[3]);
assign vlsq_qout_op1 = vlsq_op1;
assign vlsq_qout_op2 = vlsq_op2;
assign vlsq_qout_v0t = vlsq_v0t_sel;
assign vlsq_qout_start_buf_num = vlsq_start_buf_num;
assign vlsq_qout_start_buf_ptr = vlsq_start_buf_ptr;
assign vlsq_qout_ack_valid = vlsq_ack_valid;
assign vlsq_qout_check_done = vlsq_req_done;
assign vlsq_qout_vstart_dlen = vlsq_vstart_dlen;
assign vlsq_qout_vl_dlen = vlsq_vl_dlen;
assign vlsq_qout_vd_beats = vlsq_vd_beats;
assign vlsq_qout_vd_seg_beats = vlsq_vd_seg_beats[VRF_LW - 1:0];
assign vlsq_qout_remain_vd_beats = vlsq_remain_vd_beats;
assign vlsq_qout_claim_skip = vlsq_qout_occupied & (vlsq_killed | vlsq_buf_ill | vlsq_vd_beats_ill) & ~vlsq_buf_ready[1];
assign vlsq_qout_vlsq2buf_skip = vlsq_qout_occupied & (vlsq_killed | vlsq_element | vlsq_store) & ~vlsq2buf_req_done;
assign vlsq_qout_vlsq2vs3_skip = vlsq_qout_occupied & (vlsq_killed | vlsq_load) & ~vs3_done;
assign vlsq_qout_vlsq2uop_skip = vlsq_qout_occupied & vlsq_kill & vlsq_req_skip;
assign vlsq_qout_req_skip = vlsq_qout_occupied & vlsq_kill & ~(vlsq_req_done | vlsq_req_skip);
assign vlsq_qout_vs2_done = vs2_done;
assign vlsq_qout_vs2_skip = vlsq_qout_occupied & vlsq_kill & ~vs2_done;
assign vlsq_qout_xcpted = vlsq_qout_ack_status[21];
assign vlsq_qout_hit_hvm = vlsq_hit_hvm;
assign vlsq_qout_deq_valid = vlsq_deq_valid;
assign vlsq_deq_valid = vlsq_ack_mark & vlsq_qout_inst_req_mark & vlsq2buf_req_done & vlsq2uop_cmt_done & vs3_done & vlsq_buf_ready[1];
assign vlsq_deq_grant = vlsq_deq_valid & vlsq_deq_ready;
assign vlsq_qout_deq_kill_buf = vlsq_deq_valid & vlsq_buf_ready[0] & ((vs3_done & vlsq_store & vlsq_seg) | vlsq_killed);
assign vlsq_qout_deq_kill_size = vlsq_claim_buf_cnt;
assign vlsq_nf = vlsq_ctrl[9 +:3];
assign vlsq_element = vlsq_qout_ctrl[3] | vlsq_qout_ctrl[18];
assign vlsq_ustride = vlsq_qout_ctrl[20];
assign vlsq_indexed = vlsq_qout_ctrl[3];
assign vlsq_seg = vlsq_qout_ctrl[15];
assign vlsq_non_zero_element = vlsq_qout_ctrl[12];
assign vlsq_element_nseg = vlsq_element & ~vlsq_seg;
assign vlsq_vd_beats_add1 = {1'b0,vlsq_vd_beats} + {{VRF_LW{1'b0}},1'b1};
assign vlsq_vd_seg_beats = vlsq_vd_seg_beats_add1 - {{VRF_LW{1'b0}},1'b1};
assign vlsq_kill = vlsq_killing | vlsq_killed;
assign vlsq_req_ongoing = vlsq_req_fsm[VLSQ_REQ_FSM_ONGOING];
assign vlsq_req_done = vlsq_req_fsm[VLSQ_REQ_FSM_DONE];
assign vlsq_req_skip = vlsq_req_fsm[VLSQ_REQ_FSM_SKIP];
assign vlsq_check_cnt_en = (vlsq_req_valid & ((vlsq_element & ~vlsq_req_cross_4k_d1) | vlsq_ustride)) | vlsq_deq_grant;
assign vlsq_check_cnt_nx = vlsq_deq_grant ? {ELE_CNT_WIDTH{1'b0}} : vlsq_enq_check_cnt;
assign vlsq_qout_check_cnt = vlsq_check_cnt;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_check_cnt <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq_check_cnt_en) begin
        vlsq_check_cnt <= vlsq_check_cnt_nx;
    end
end

assign vlsq_req_fsm_ongoing_en = (vlsq_req_valid & vlsq_req_grant_last) | vlsq_kill;
always @* begin
    vlsq_req_fsm_nx = {VLSQ_REQ_FSM_BITS{1'b0}};
    case (1'b1)
        vlsq_req_fsm[VLSQ_REQ_FSM_INVALID]: begin
            vlsq_req_fsm_en = vlsq_req_valid;
            if (vlsq_kill) begin
                vlsq_req_fsm_nx[VLSQ_REQ_FSM_SKIP] = 1'b1;
            end
            else begin
                vlsq_req_fsm_nx[VLSQ_REQ_FSM_ONGOING] = ~vlsq_req_grant_last;
                vlsq_req_fsm_nx[VLSQ_REQ_FSM_DONE] = vlsq_req_grant_last;
            end
        end
        vlsq_req_fsm[VLSQ_REQ_FSM_ONGOING]: begin
            vlsq_req_fsm_en = vlsq_req_fsm_ongoing_en;
            vlsq_req_fsm_nx[VLSQ_REQ_FSM_DONE] = 1'b1;
        end
        vlsq_req_fsm[VLSQ_REQ_FSM_DONE]: begin
            vlsq_req_fsm_en = vlsq_deq_grant;
            vlsq_req_fsm_nx[VLSQ_REQ_FSM_INVALID] = 1'b1;
        end
        vlsq_req_fsm[VLSQ_REQ_FSM_SKIP]: begin
            vlsq_req_fsm_en = vlsq_deq_grant;
            vlsq_req_fsm_nx[VLSQ_REQ_FSM_INVALID] = 1'b1;
        end
        default: begin
            vlsq_req_fsm_en = 1'b0;
            vlsq_req_fsm_nx = {VLSQ_REQ_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_req_fsm <= {{VLSQ_REQ_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (vlsq_req_fsm_en) begin
        vlsq_req_fsm <= vlsq_req_fsm_nx;
    end
end

assign vlsq_qout_inst_req_mark = inst_req_mark;
assign inst_req_mark_set = vlsq_inst_req_mark_valid;
assign inst_req_mark_clr = vlsq_deq_grant;
assign inst_req_mark_en = inst_req_mark_set | inst_req_mark_clr;
assign inst_req_mark_nx = inst_req_mark_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        inst_req_mark <= 1'b0;
    end
    else if (inst_req_mark_en) begin
        inst_req_mark <= inst_req_mark_nx;
    end
end

assign vlsq_ack_valid = (vlsq_req_done | vlsq_req_skip | vlsq_qout_xcpted) & ~vlsq_ack_mark;
assign vlsq_ack_grant = vlsq_ack_valid & vlsq_ack_ready;
assign vlsq_ack_mark_set = vlsq_ack_grant;
assign vlsq_ack_mark_clr = vlsq_deq_grant;
assign vlsq_ack_mark_en = vlsq_ack_mark_set | vlsq_ack_mark_clr;
assign vlsq_ack_mark_nx = vlsq_ack_mark_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_ack_mark <= 1'b0;
    end
    else if (vlsq_ack_mark_en) begin
        vlsq_ack_mark <= vlsq_ack_mark_nx;
    end
end

always @* begin
    vlsq_fsm_nx = {VLSQ_FSM_BITS{1'b0}};
    case (1'b1)
        vlsq_fsm[VLSQ_FSM_INVALID]: begin
            vlsq_fsm_en = vlsq_enq_valid;
            vlsq_fsm_nx[VLSQ_FSM_WAIT_CMT] = 1'b1;
        end
        vlsq_fsm[VLSQ_FSM_WAIT_CMT]: begin
            vlsq_fsm_en = vlsq_cmt_valid;
            vlsq_fsm_nx[VLSQ_FSM_COMMITTED] = ~vlsq_cmt_kill;
            vlsq_fsm_nx[VLSQ_FSM_KILLED] = vlsq_cmt_kill;
        end
        vlsq_fsm[VLSQ_FSM_COMMITTED]: begin
            vlsq_fsm_en = vlsq_deq_grant;
            vlsq_fsm_nx[VLSQ_FSM_INVALID] = 1'b1;
        end
        vlsq_fsm[VLSQ_FSM_KILLED]: begin
            vlsq_fsm_en = vlsq_deq_grant;
            vlsq_fsm_nx[VLSQ_FSM_INVALID] = 1'b1;
        end
        default: begin
            vlsq_fsm_en = 1'b0;
            vlsq_fsm_nx = {VLSQ_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_fsm <= {{VLSQ_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (vlsq_fsm_en) begin
        vlsq_fsm <= vlsq_fsm_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_ctrl <= {28{1'b0}};
        vlsq_vs2_len <= {VRF_LW{1'b0}};
        vlsq_vd_emul_len <= {VRF_LW{1'b0}};
        vlsq_op1 <= {XLEN{1'b0}};
        vlsq_op2 <= {XLEN{1'b0}};
        vlsq_vstart <= {ELE_CNT_WIDTH{1'b0}};
        vlsq_vstart_nf <= {ELE_CNT_WIDTH{1'b0}};
        vlsq_vstart_byte <= {MAX_BYTE_WIDTH{1'b0}};
        vlsq_vstart_eew4_lsb <= 1'b0;
        vlsq_vl <= {ELE_CNT_WIDTH + 1{1'b0}};
        vlsq_vl_nf <= {ELE_CNT_WIDTH + 1{1'b0}};
        vlsq_vl_minus1 <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq_enq_valid) begin
        vlsq_ctrl <= vlsq_enq_ctrl;
        vlsq_vs2_len <= vlsq_enq_vs2_len;
        vlsq_vd_emul_len <= vlsq_enq_vd_emul_len;
        vlsq_op1 <= vlsq_enq_op1;
        vlsq_op2 <= vlsq_enq_op2;
        vlsq_vstart <= vlsq_enq_vstart;
        vlsq_vstart_nf <= vlsq_enq_vstart_nf;
        vlsq_vstart_byte <= vlsq_enq_vstart_byte;
        vlsq_vstart_eew4_lsb <= vlsq_enq_vstart_eew4_lsb;
        vlsq_vl <= vlsq_enq_vl;
        vlsq_vl_nf <= vlsq_enq_vl_nf;
        vlsq_vl_minus1 <= vlsq_enq_vl_minus1;
    end
end

assign vlsq_v0t_sel = {VLEN{vlsq_non_zero_element}} & vlsq_v0t;
assign vlsq_widen = vlsq_ctrl[27];
assign vlsq_v0t_nx = vlsq_enq_valid ? vlsq_enq_v0t : vlsq_widen ? {2'b0,vlsq_v0t_sel[VLEN - 1:2]} : {1'b0,vlsq_v0t_sel[VLEN - 1:1]};
assign vlsq_v0t_en = vlsq_enq_valid | (vlsq_req_valid & vlsq_element & ~vlsq_req_cross_4k);
assign vlsq_qout_alive = vlsq_qout_occupied & (vlsq_ustride | (vlsq_element & vlsq_v0t_sel[0])) & ~vlsq_qout_xcpted;
assign vlsq_qout_widen_alive = vlsq_qout_occupied & vlsq_element & vlsq_widen & vlsq_v0t_sel[1] & ~vlsq_qout_xcpted;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_v0t <= {VLEN{1'b0}};
    end
    else if (vlsq_v0t_en) begin
        vlsq_v0t <= vlsq_v0t_nx;
    end
end

assign vlsq_committed = vlsq_fsm[VLSQ_FSM_COMMITTED];
assign vlsq_killed = vlsq_fsm[VLSQ_FSM_KILLED];
assign vlsq_wait_cmt = vlsq_fsm[VLSQ_FSM_WAIT_CMT];
assign vlsq_killing = vlsq_cmt_valid & vlsq_cmt_kill;
assign vlsq_claim_buf_trig = (vlsq_ustride & (vlsq_req_done | vlsq_req_ongoing)) | (~vlsq_ustride & vlsq_qout_occupied);
assign vlsq_qout_claim_buf_valid = vlsq_claim_buf_trig & ~vlsq_buf_ready[1] & ~vlsq_killed & ~vlsq_buf_ill & ~vlsq_vd_beats_ill;
assign vlsq_qout_claim_buf_size = vlsq_reserve_buf_size2 ? {{VRF_LW - 1{1'b0}},1'd1} : vlsq_reserve_buf_size1 ? {{VRF_LW - 1{1'b0}},1'd0} : vlsq_vd_seg_beats[VRF_LW - 1:0];
assign vlsq_qout_claim_buf_reset = vlsq_seg & (SEG_PRESYNC == 1);
assign vlsq_qout_claim_buf_last = vlsq_seg | vlsq_ustride | (vlsq_element_nseg & (vlsq_vd_beats == vlsq_claim_buf_cnt[VRF_LW - 1:0]));
assign vlsq_qout_claim_buf_adj = vlsq_reserve_buf_size2;
assign vlsq_qout_claim_buf_cnt = vlsq_claim_buf_cnt;
assign vlsq_claim_buf_grant = vlsq_qout_claim_buf_valid & ~vlsq_killing & vlsq_claim_buf_ready;
assign vlsq_claim_buf_first = vlsq_claim_buf_cnt == {VRF_LW + 1{1'b0}};
assign vlsq_claim_start_buf_en = vlsq_claim_buf_grant & vlsq_claim_buf_first;
assign vlsq_reserve_buf_size2 = (vlsq_hit_hvm & vlsq_ustride & ~vlsq_seg & ~vlsq_widen) & (vlsq_vd_seg_beats[VRF_LW - 1:0] > {{VRF_LW - 1{1'b0}},1'b1});
assign vlsq_reserve_buf_size1 = vlsq_element_nseg;
assign vlsq_buf_ill = vlsq_ctrl[0];
assign vlsq_vd_beats_ill = (vlsq_vd_beats > vlsq_vd_emul_len);
assign vlsq_buf_ready_clr0 = vlsq_deq_grant;
assign vlsq_buf_ready_set0 = vlsq_claim_buf_grant;
assign vlsq_buf_ready_en0 = vlsq_buf_ready_set0 | vlsq_buf_ready_clr0;
assign vlsq_buf_ready_nx[0] = vlsq_buf_ready_set0;
assign vlsq_buf_ready_clr1 = vlsq_deq_grant;
assign vlsq_buf_ready_set1 = vlsq_claim_mark_valid;
assign vlsq_buf_ready_en1 = vlsq_buf_ready_set1 | vlsq_buf_ready_clr1;
assign vlsq_buf_ready_nx[1] = vlsq_buf_ready_set1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_buf_ready[0] <= 1'b0;
    end
    else if (vlsq_buf_ready_en0) begin
        vlsq_buf_ready[0] <= vlsq_buf_ready_nx[0];
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_buf_ready[1] <= 1'b0;
    end
    else if (vlsq_buf_ready_en1) begin
        vlsq_buf_ready[1] <= vlsq_buf_ready_nx[1];
    end
end

assign vlsq_claim_buf_cnt_en = vlsq_deq_grant | vlsq_claim_buf_grant;
assign vlsq_claim_buf_cnt_add1 = vlsq_claim_buf_cnt + {{VRF_LW{1'b0}},1'b1};
assign vlsq_claim_buf_cnt_nx = vlsq_deq_grant ? {VRF_LW + 1{1'b0}} : vlsq_reserve_buf_size2 ? {{VRF_LW - 1{1'b0}},2'd2} : vlsq_element_nseg ? vlsq_claim_buf_cnt_add1 : vlsq_vd_seg_beats_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_claim_buf_cnt <= {VRF_LW + 1{1'b0}};
    end
    else if (vlsq_claim_buf_cnt_en) begin
        vlsq_claim_buf_cnt <= vlsq_claim_buf_cnt_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_start_buf_num <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (vlsq_claim_start_buf_en) begin
        vlsq_start_buf_num <= vlsq_claim_resp_buf_num;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_start_buf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (vlsq_claim_start_buf_en) begin
        vlsq_start_buf_ptr <= vlsq_claim_resp_buf_ptr;
    end
end

assign vlsq2vs3_qout_rready = vlsq_buf_ready[0] & vlsq_store & ~vs3_done & ~vlsq_killed;
assign vs3_done_set = vlsq2vs3_req_done_valid;
assign vs3_done_clr = vlsq_deq_grant;
assign vs3_done_nx = vs3_done_set;
assign vs3_done_en = vs3_done_set | vs3_done_clr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs3_done <= 1'b0;
    end
    else if (vs3_done_en) begin
        vs3_done <= vs3_done_nx;
    end
end

assign vs2_done_set = (vlsq_indexed & vlsq_req_ready) & (vlsu_vs2_rgrant_last | vlsq_qout_vs2_skip);
assign vs2_done_clr = vlsq_deq_grant;
assign vs2_done_nx = vs2_done_set;
assign vs2_done_en = vs2_done_set | vs2_done_clr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs2_done <= 1'b0;
    end
    else if (vs2_done_en) begin
        vs2_done <= vs2_done_nx;
    end
end

assign vlsq_load = vlsq_ctrl[4];
assign vlsq_store = vlsq_ctrl[17];
assign vlsq2buf_qout_req_valid = (vlsq_buf_ready[0] & vlsq_req_done) & ~vlsq2buf_req_done & ~vlsq_store & ~vlsq_killed & ~vlsq_element;
assign vlsq2buf_qout_req_vl = vlsq_vl;
assign vlsq2buf_req_done_set = vlsq2buf_req_done_valid;
assign vlsq2buf_req_done_clr = vlsq_deq_grant;
assign vlsq2buf_req_done_en = vlsq2buf_req_done_set | vlsq2buf_req_done_clr;
assign vlsq2buf_req_done_nx = vlsq2buf_req_done_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2buf_req_done <= 1'b0;
    end
    else if (vlsq2buf_req_done_en) begin
        vlsq2buf_req_done <= vlsq2buf_req_done_nx;
    end
end

assign vlsq2uop_qout_valid = vlsq_qout_occupied & ~vlsq2uop_cmt_done & ~vlsq_req_skip;
assign vlsq2uop_qout_buf_ready = vlsq_buf_ready[0];
assign vlsq_qout_cmtted = vlsq_committed | vlsq_killed;
assign vlsq_qout_killed = vlsq_killed;
assign vlsq2uop_cmt_done_set = vlsq2uop_cmt_done_valid;
assign vlsq2uop_cmt_done_clr = vlsq_deq_grant;
assign vlsq2uop_cmt_done_en = vlsq2uop_cmt_done_set | vlsq2uop_cmt_done_clr;
assign vlsq2uop_cmt_done_nx = vlsq_deq_grant ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2uop_cmt_done <= 1'b0;
    end
    else if (vlsq2uop_cmt_done_en) begin
        vlsq2uop_cmt_done <= vlsq2uop_cmt_done_nx;
    end
end

assign vlsq_qout_ack_status = vlsq_fault_status;
assign vlsq_qout_ack_element = vlsq_fault_element;
assign vlsq_qout_ack_tval = vlsq_fault_tval;
assign vlsq_qout_ack_nf = vlsq_fault_nf;
assign vlsq_fault_status_set = vlsq_resp_valid;
assign vlsq_fault_status_clr = vlsq_deq_grant;
assign vlsq_fault_status_nx = ({22{vlsq_fault_status_clr}} & {22{1'b0}}) | ({22{vlsq_fault_status_set}} & vlsq_resp_status);
assign vlsq_fault_status_en = vlsq_fault_status_set | vlsq_fault_status_clr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_fault_status <= {22{1'b0}};
        vlsq_fault_tval <= {EXTVALEN{1'b0}};
        vlsq_fault_element <= {ELE_CNT_WIDTH{1'b0}};
        vlsq_fault_nf <= 3'd0;
        vlsq_remain_vd_beats <= {VRF_LW{1'b0}};
    end
    else if (vlsq_fault_status_en) begin
        vlsq_fault_status <= vlsq_fault_status_nx;
        vlsq_fault_tval <= vlsq_resp_tval;
        vlsq_fault_element <= vlsq_resp_fault_element;
        vlsq_fault_nf <= vlsq_resp_fault_nf;
        vlsq_remain_vd_beats <= vlsq_resp_remain_vd_beats;
    end
end

assign vlsq_hit_hvm_en = (vlsq_resp_valid & ~vlsq_req_cross_4k_d1) | vlsq_deq_grant;
assign vlsq_hit_hvm_nx = vlsq_deq_grant ? 1'b0 : vlsq_resp_hit_hvm;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_hit_hvm <= 1'b0;
    end
    else if (vlsq_hit_hvm_en) begin
        vlsq_hit_hvm <= vlsq_hit_hvm_nx;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

