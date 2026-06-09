// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vlsq (
    vpu_vlsu_clk,
    vpu_reset_n,
    vlsq_load_pending,
    vlsq_store_pending,
    vlsq_block_cmd,
    vlsu_dispatch_valid,
    vlsu_dispatch_ready,
    vlsu_dispatch_ctrl,
    vlsu_dispatch_op1,
    vlsu_dispatch_op2,
    vlsu_dispatch_v0t,
    vlsu_dispatch_vs2_len,
    vlsu_dispatch_vs3_len,
    vlsu_dispatch_vd_len,
    vlsu_vs3_rvalid,
    vlsu_vs3_rdata,
    vlsu_vs3_rlast,
    vlsu_vs3_rready,
    vlsu_cmt_valid,
    vlsu_cmt_kill,
    vlsu_ack_valid,
    vlsu_ack_status,
    vlsu_ack_tval,
    vlsu_ack_element,
    vlsq_req_valid,
    vlsq_req_ready,
    vlsq_req_first,
    vlsq_req_last,
    vlsq_req_ctrl,
    vlsq_req_vd_emul_len,
    vlsq_req_vd_beats,
    vlsq_req_vd_seg_beats,
    vlsq_req_byte,
    vlsq_req_total_byte,
    vlsq_req_element_num_dlen,
    vlsq_req_alive,
    vlsq_req_widen_alive,
    vlsq_req_dlen_last,
    vlsq_req_pa,
    vlsq_req_base_offset,
    vlsq_req_vstart_byte,
    vlsq_req_prestart_cross,
    vlsq_req_mtype,
    vlsq_req_shareable,
    vlsq_req_hvm,
    vlsq2uop_cmt_valid,
    vlsq2uop_cmt_grant,
    vlsq2uop_cmt_buf_valid,
    vlsq2uop_cmt_kill,
    vlsq2uop_cmt_start_buf_num,
    vlsq_req_cross_4k,
    vlsq_req_cross_4k_d1,
    vlsq_req_cross_4k_d1_kill,
    vlsq_vs2_accept,
    vs2q_not_full,
    vlsq_vs2_dummy_rready,
    vlsq_req_vs2_rready,
    vlsq_req_vs2_addr,
    vlsq_req_vs2_kill,
    vlsq_req_vs2_dlen_last,
    vlsq_req_vs2_ptr,
    vlsq_req_vs2_shift_valid,
    vlsq_req_vs2_shift_value,
    vlsu_vs2_rvalid,
    vlsu_vs2_rready,
    vlsu_vs2_rlast,
    claim_vbuf_valid,
    claim_vbuf_size,
    claim_vbuf_cnt,
    claim_vbuf_ready,
    claim_buf_reset,
    claim_buf_resp_num,
    claim_buf_resp_ptr,
    vlsbuf_vs3_wsel,
    vlsbuf_vs3_wdata,
    vlsbuf_ent_occupied,
    packed_req_en,
    packed_req_kill,
    packed_resp_finish,
    packed_vd_beats,
    packed_ctrl,
    packed_vl_minus1,
    packed_start_buf_ptr,
    vlsbuf_kill_sel,
    vlsbuf_ent_mask_ready,
    vlsq2buf_req_valid,
    vlsq2buf_byte_mask_wptr,
    vlsq2buf_byte_mask,
    vlsq2vtlb_req_valid,
    vlsq2vtlb_req_ready,
    vlsq2vtlb_req_va,
    vlsq2vtlb_req_va2pa_en,
    vlsq2vtlb_cmt_valid,
    vlsq2vtlb_cmt_kill,
    vlsq2vtlb_resp_ppn,
    vlsq2vtlb_resp_data
);
parameter XLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
parameter DMLEN = 64;
parameter VALEN = 39;
parameter EXTVALEN = 39;
parameter PALEN = 38;
parameter VRF_LW = 3;
parameter SEG_PRESYNC = 1;
parameter VLSQ_DEPTH = 4;
parameter VS2Q_DEPTH = 1;
parameter VS2Q_DEPTH_LOG2 = $clog2(VS2Q_DEPTH);
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter BUF_UCNT_WIDTH = 2;
parameter ELE_DLEN_WIDTH = 6;
parameter ELE_CNT_WIDTH = $clog2(VLEN);
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
parameter MAX_BYTE_WIDTH = 10;
parameter ILM_BASE = 64'h0000_0000;
parameter DLM_BASE = 64'h0020_0000;
parameter HVM_BASE = 64'h0030_0000;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter HVM_SIZE_KB = 0;
parameter PPN_WIDTH = PALEN - 12;
parameter MMU_SCHEME_INT = 0;
parameter HR_OFFSET_WIDTH = 10;
localparam VS2Q_DEPTH_LOG2_ = (VS2Q_DEPTH_LOG2 == 0) ? 1 : VS2Q_DEPTH_LOG2;
localparam UNIT_STRIDE = 2'b00;
localparam CONST_STRIDE = 2'b10;
localparam INDEXED_UNORDER = 2'b01;
localparam INDEXED_ORDER = 2'b11;
localparam VLEN_DLEN_RATIO = $unsigned(VLEN / DLEN);
localparam DLEN_LMUL = (VLEN == DLEN) ? 8 : 16;
localparam FOURK_OFFSET_WIDTH = $clog2(4096);
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam ILM_MASK_BITS = $clog2(ILM_SIZE_KB) + 10;
localparam DLM_MASK_BITS = $clog2(DLM_SIZE_KB) + 10;
localparam HVM_MASK_BITS = $clog2(HVM_SIZE_KB) + 10;
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
input vpu_vlsu_clk;
input vpu_reset_n;
output vlsq_load_pending;
output vlsq_store_pending;
output vlsq_block_cmd;
input vlsu_dispatch_valid;
output vlsu_dispatch_ready;
input [55 - 1:0] vlsu_dispatch_ctrl;
input [XLEN - 1:0] vlsu_dispatch_op1;
input [XLEN - 1:0] vlsu_dispatch_op2;
input [VLEN - 1:0] vlsu_dispatch_v0t;
input [VRF_LW - 1:0] vlsu_dispatch_vs2_len;
input [VRF_LW - 1:0] vlsu_dispatch_vs3_len;
input [VRF_LW - 1:0] vlsu_dispatch_vd_len;
input vlsu_vs3_rvalid;
input [DLEN - 1:0] vlsu_vs3_rdata;
input vlsu_vs3_rlast;
output vlsu_vs3_rready;
input vlsu_cmt_valid;
input vlsu_cmt_kill;
output vlsu_ack_valid;
output [22 - 1:0] vlsu_ack_status;
output [63:0] vlsu_ack_tval;
output [10:0] vlsu_ack_element;
output vlsq_req_valid;
input vlsq_req_ready;
output vlsq_req_first;
output vlsq_req_last;
output [28 - 1:0] vlsq_req_ctrl;
output [VRF_LW - 1:0] vlsq_req_vd_emul_len;
output [VRF_LW - 1:0] vlsq_req_vd_beats;
output [VRF_LW - 1:0] vlsq_req_vd_seg_beats;
output [MAX_BYTE_WIDTH - 1:0] vlsq_req_byte;
output [MAX_BYTE_WIDTH - 1:0] vlsq_req_total_byte;
output [ELE_DLEN_WIDTH - 1:0] vlsq_req_element_num_dlen;
output vlsq_req_alive;
output vlsq_req_widen_alive;
output vlsq_req_dlen_last;
output [PALEN - 1:0] vlsq_req_pa;
output [11:0] vlsq_req_base_offset;
output [MAX_BYTE_WIDTH - 1:0] vlsq_req_vstart_byte;
output vlsq_req_prestart_cross;
output [3:0] vlsq_req_mtype;
output vlsq_req_shareable;
output vlsq_req_hvm;
output vlsq2uop_cmt_valid;
input vlsq2uop_cmt_grant;
output vlsq2uop_cmt_buf_valid;
output vlsq2uop_cmt_kill;
output [BUF_DEPTH_LOG2 - 1:0] vlsq2uop_cmt_start_buf_num;
output vlsq_req_cross_4k;
output vlsq_req_cross_4k_d1;
output vlsq_req_cross_4k_d1_kill;
output vlsq_vs2_accept;
input vs2q_not_full;
output vlsq_vs2_dummy_rready;
input vlsq_req_vs2_rready;
input [DLEN - 1:0] vlsq_req_vs2_addr;
output vlsq_req_vs2_kill;
output vlsq_req_vs2_dlen_last;
output [VS2Q_DEPTH - 1:0] vlsq_req_vs2_ptr;
output vlsq_req_vs2_shift_valid;
output [1:0] vlsq_req_vs2_shift_value;
input vlsu_vs2_rvalid;
output vlsu_vs2_rready;
input vlsu_vs2_rlast;
output claim_vbuf_valid;
output [BUF_DEPTH_LOG2 - 1:0] claim_vbuf_size;
output [BUF_DEPTH * BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt;
input claim_vbuf_ready;
output claim_buf_reset;
input [BUF_DEPTH_LOG2 - 1:0] claim_buf_resp_num;
input [BUF_DEPTH - 1:0] claim_buf_resp_ptr;
output [BUF_DEPTH - 1:0] vlsbuf_vs3_wsel;
output [DLEN - 1:0] vlsbuf_vs3_wdata;
input [BUF_DEPTH - 1:0] vlsbuf_ent_occupied;
output packed_req_en;
output packed_req_kill;
input packed_resp_finish;
output [VRF_LW - 1:0] packed_vd_beats;
output [11 - 1:0] packed_ctrl;
output [ELE_CNT_WIDTH - 1:0] packed_vl_minus1;
output [BUF_DEPTH - 1:0] packed_start_buf_ptr;
output [BUF_DEPTH - 1:0] vlsbuf_kill_sel;
input [BUF_DEPTH - 1:0] vlsbuf_ent_mask_ready;
output vlsq2buf_req_valid;
output [BUF_DEPTH - 1:0] vlsq2buf_byte_mask_wptr;
output [DMLEN - 1:0] vlsq2buf_byte_mask;
output vlsq2vtlb_req_valid;
input vlsq2vtlb_req_ready;
output [VALEN - 1:0] vlsq2vtlb_req_va;
output vlsq2vtlb_req_va2pa_en;
output vlsq2vtlb_cmt_valid;
output vlsq2vtlb_cmt_kill;
input [PPN_WIDTH - 1:0] vlsq2vtlb_resp_ppn;
input [35 - 1:0] vlsq2vtlb_resp_data;





// 71e5ac3a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire elen64;
wire vlsu_dispatch_grant;
wire vlsq_req_grant;
wire vlsq_full;
wire vlsq_not_full;
wire vlsq_req_cmt_killing;
wire vlsq_enq_ptr_en;
wire vlsq_req_ptr_en;
wire vlsq_cmt_ptr_en;
wire vlsq_ack_ptr_en;
wire vlsq_claim_ptr_en;
wire vlsq2uop_cmt_ptr_en;
wire vlsq2buf_req_ptr_en;
wire vlsq_deq_ptr_en;
wire [VLSQ_DEPTH - 1:0] vlsq_enq_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_req_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_cmt_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_ack_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_claim_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq2uop_cmt_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq2buf_req_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_deq_ptr;
wire vlsq_enq_valid;
wire [VLSQ_DEPTH - 1:0] vlsq_enq_sel;
wire vlsq_req_sel_en;
wire vlsq_resp_sel_en;
wire [VLSQ_DEPTH - 1:0] vlsq_req_sel;
wire [VLSQ_DEPTH - 1:0] vlsq_cmt_sel;
wire [VLSQ_DEPTH - 1:0] vlsq_resp_sel;
wire [VLSQ_DEPTH - 1:0] vlsq_inst_req_mark_sel;
wire [VLSQ_DEPTH - 1:0] claim_vbuf_ready_sel;
wire vlsq_cmt_kill;
wire [9:0] vlsu_vstart;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x1;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x2;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x3;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x4;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x5;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x6;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x7;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_x8;
wire [10:0] vlsu_vl;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x1;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x2;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x3;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x4;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x5;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x6;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x7;
wire [ELE_CNT_WIDTH:0] vlsu_vl_x8;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_adj;
wire [ELE_CNT_WIDTH - 1:0] vlsu_vstart_adj_div2;
wire [ELE_CNT_WIDTH:0] vlsu_vl_adj;
wire vlsu_vm;
wire [1:0] vlsu_mop;
wire [2:0] vlsu_nf;
wire vlsu_nf0;
wire vlsu_nf1;
wire vlsu_nf2;
wire vlsu_nf3;
wire vlsu_nf4;
wire vlsu_nf5;
wire vlsu_nf6;
wire vlsu_nf7;
wire vlsu_buf_ill;
wire [2:0] vlsu_vd_eew;
wire vlsu_vd_eew4;
wire vlsu_vd_eew8;
wire vlsu_vd_eew16;
wire vlsu_vd_eew32;
wire vlsu_vd_eew64;
wire vlsu_zero_element;
wire [2:0] vlsu_vd_emul;
wire [2:0] vlsu_vd_emul_len;
wire vlsu_vd_emul_len1;
wire vlsu_vd_emul_len2;
wire vlsu_vd_emul_len4;
wire vlsu_vd_emul_len8;
wire [6:0] vlsq_ustride_op2;
wire [6:0] vlsq_ustride_seg_op2;
wire vlsq_enq_ustride;
wire vlsq_enq_useg;
wire [28 - 1:0] vlsq_enq_ctrl;
wire [XLEN - 1:0] vlsq_enq_op1;
wire [XLEN - 1:0] vlsq_enq_op2;
wire [VLEN - 1:0] vlsq_enq_v0t;
wire [ELE_CNT_WIDTH - 1:0] vlsq_enq_vstart;
wire [ELE_CNT_WIDTH - 1:0] vlsq_enq_useg_vstart;
wire [ELE_CNT_WIDTH - 1:0] vlsq_enq_vstart_nf_pre;
wire [ELE_CNT_WIDTH - 1:0] vlsq_enq_vstart_nf;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_enq_vstart_byte;
wire vlsq_enq_vstart_eew4_lsb;
wire [ELE_CNT_WIDTH:0] vlsq_enq_vl;
wire [ELE_CNT_WIDTH:0] vlsq_enq_useg_vl;
wire [ELE_CNT_WIDTH:0] vlsq_enq_vl_nf;
wire [ELE_CNT_WIDTH:0] vlsq_enq_vl_minus1;
wire [ELE_CNT_WIDTH:0] vlsq_enq_vl_adj;
wire [ELE_CNT_WIDTH:0] vlsq_enq_vl_adj_minus1;
wire [VRF_LW - 1:0] vlsq_enq_vs2_len;
wire [VRF_LW - 1:0] vlsq_enq_vd_emul_len;
wire [(VLSQ_DEPTH * 28) - 1:0] vlsq_ent_ctrl;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_load;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_store;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_block_cmd;
wire [(VLSQ_DEPTH * XLEN) - 1:0] vlsq_ent_op1;
wire [(VLSQ_DEPTH * XLEN) - 1:0] vlsq_ent_op2;
wire [(VLSQ_DEPTH * VLEN) - 1:0] vlsq_ent_v0t;
wire [(VLSQ_DEPTH * ELE_CNT_WIDTH) - 1:0] vlsq_ent_vstart;
wire [(VLSQ_DEPTH * ELE_CNT_WIDTH) - 1:0] vlsq_ent_vstart_nf;
wire [(VLSQ_DEPTH * MAX_BYTE_WIDTH) - 1:0] vlsq_ent_vstart_byte;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vstart_eew4_lsb;
wire [(VLSQ_DEPTH * (ELE_CNT_WIDTH + 1)) - 1:0] vlsq_ent_vl;
wire [(VLSQ_DEPTH * (ELE_CNT_WIDTH + 1)) - 1:0] vlsq_ent_vl_nf;
wire [(VLSQ_DEPTH * ELE_CNT_WIDTH) - 1:0] vlsq_ent_vl_minus1;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_vstart_dlen;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_vl_dlen;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_vd_beats;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_vd_seg_beats;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_remain_vd_beats;
wire [(VLSQ_DEPTH * VRF_LW) - 1:0] vlsq_ent_vd_emul_len;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_alive;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_widen_alive;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_inst_req_mark;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_occupied;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_valid_pre;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_claim_skip;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vlsq2buf_skip;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vlsq2vs3_skip;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_req_skip;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vlsq2uop_skip;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vs2_done;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_vs2_skip;
wire [(VLSQ_DEPTH * BUF_DEPTH_LOG2) - 1:0] vlsq_ent_start_buf_num;
wire [(VLSQ_DEPTH * BUF_DEPTH) - 1:0] vlsq_ent_start_buf_ptr;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_xcpted;
wire [(VLSQ_DEPTH * 22) - 1:0] vlsq_ent_ack_status;
wire [(VLSQ_DEPTH * EXTVALEN) - 1:0] vlsq_ent_ack_tval;
wire [(VLSQ_DEPTH * ELE_CNT_WIDTH) - 1:0] vlsq_ent_ack_element;
wire [(VLSQ_DEPTH * 3) - 1:0] vlsq_ent_ack_nf;
wire vlsq_valid_pre;
wire vlsq_valid;
wire vlsq_alive;
wire vlsq_alive_sel;
wire vlsq_widen_alive;
wire vlsq_widen_alive_with_vl;
wire vlsq_alive_with_vstart;
wire vlsq_widen_alive_cond;
wire vlsq_inst_req_mark;
wire [28 - 1:0] vlsq_ctrl;
wire [XLEN - 1:0] vlsq_op1;
wire [XLEN - 1:0] vlsq_op2;
wire [XLEN - 1:0] vlsq_ustride_offset;
wire [XLEN - 1:0] vlsq_strided_offset;
wire [XLEN - 1:0] vlsq_indexed_offset;
wire vlsq_load;
wire vlsq_store;
wire vlsq_fof;
wire [2:0] vlsq_nf;
wire [3:0] vlsq_nf_add1;
wire vlsq_seg;
wire vlsq_useg;
wire vlsq_eseg;
wire vlsq_widen;
wire vlsq_ewiden;
wire vlsq_widen_first;
wire vlsq_widen_last;
wire vlsq_ustride;
wire vlsq_strided;
wire vlsq_indexed;
wire vlsq_element;
wire vlsq_milmb_ien;
wire vlsq_mdlmb_den;
wire vlsq_ustride_second_cmd;
wire [2:0] vlsq_vd_eew;
wire [VRF_LW - 1:0] vlsq_vd_emul_len;
wire [VRF_LW - 1:0] vlsq_vd_seg_beats;
wire [VRF_LW - 1:0] vlsq_vd_beats;
wire [VRF_LW - 1:0] vlsq_vd_beats_minus1;
wire [VRF_LW - 1:0] vlsq_remain_vd_beats;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vstart;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vstart_nf;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vstart_nf_sel;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_vstart_byte;
wire vlsq_vstart_eew4_lsb;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_vstart_byte_sel;
wire [ELE_CNT_WIDTH:0] vlsq_vl;
wire [ELE_CNT_WIDTH:0] vlsq_vl_nf;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vl_minus1;
wire vlsq_vd_eew4;
wire vlsq_vd_eew8;
wire vlsq_vd_eew16;
wire vlsq_vd_eew32;
wire vlsq_vd_eew64;
wire [3:0] vlsq_vd_eew_onehot;
wire [ELE_DLEN_WIDTH - 1:0] cur_vd_element_num_dlen;
wire [VRF_LW - 1:0] vlsq_vd_beat_cnt;
wire [VRF_LW - 1:0] vlsq_vd_beat_cnt_eew8;
wire [VRF_LW - 1:0] vlsq_vd_beat_cnt_eew16;
wire [VRF_LW - 1:0] vlsq_vd_beat_cnt_eew32;
wire [VRF_LW - 1:0] vlsq_vd_beat_cnt_eew64;
wire vlsq_skip;
wire vlsq_xcpted;
wire vlsq_cmtted;
wire vlsq_killed;
wire vlsq_xcpt_dlen_last;
wire vlsq_req_done;
wire [ELE_DLEN_WIDTH - 1:0] vlsq_element_num_dlen;
wire [ELE_CNT_WIDTH - 1:0] vlsq_widen_fault_element;
wire vlsq_eew4_lsb_sel;
wire [ELE_CNT_WIDTH - 1:0] vlsq_eew4_fault_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq_resp_fault_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq_resp_fault_element_seg;
wire vlsq_resp_hit_hvm;
wire [EXTVALEN - 1:0] vlsq_resp_tval;
wire vlsq_resp_extvalen;
wire [2:0] vlsq_resp_fault_nf;
wire [VRF_LW - 1:0] vlsq_resp_remain_vd_beats;
wire [VRF_LW - 1:0] vlsq_vd_beats_sel;
wire vlsq_nfield2;
wire vlsq_nfield3;
wire vlsq_nfield4;
wire vlsq_nfield5;
wire vlsq_nfield6;
wire vlsq_nfield7;
wire vlsq_nfield8;
wire vlsq_fault_element_seg_en;
wire [ELE_CNT_WIDTH - 1:0] vlsq_fault_element_seg_nx;
wire [ELE_CNT_WIDTH - 1:0] vlsq_fault_element_seg_add;
reg [ELE_CNT_WIDTH - 1:0] vlsq_fault_element_seg;
wire [ELE_CNT_WIDTH - 1:0] vlsq_resp_fault_element_dict;
wire [2:0] vlsq_resp_fault_nf_dict;
wire vlsq_req_in_4k_grant;
wire vlsq_req_element_en;
wire [ELE_CNT_WIDTH - 1:0] vlsq_req_element_nx;
wire vlsq_req_rvv_dlen_last;
wire vlsq_req_widen_dlen_last;
wire [ELE_CNT_WIDTH - 1:0] vlsq_req_element_add;
wire [ELE_CNT_WIDTH - 1:0] vlsq_req_element_offset;
wire [ELE_CNT_WIDTH:0] vlsq_req_byte2element;
reg [ELE_CNT_WIDTH - 1:0] vlsq_req_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq_req_element_sel;
wire [ELE_CNT_WIDTH - 1:0] vlsq_ustride_check_cnt;
wire vlsq_req_element_zero;
wire vlsq_ele_widen_last;
wire vlsq_ele_rvv_last;
wire vlsq_ele_last;
wire [VRF_LW - 1:0] vlsq_req_xcpt_cnt_nx;
wire [VRF_LW - 1:0] vlsq_req_xcpt_cnt_add1;
reg [VRF_LW - 1:0] vlsq_req_xcpt_cnt;
wire vlsq_req_xcpt_cnt_en;
wire vlsq_req_xcpt_last;
wire vlsq_ustride_prestart_valid;
wire vlsq_useg_prestart_valid;
wire [XLEN - 1:0] vlsq_base_sel;
wire [XLEN - 1:0] vlsq_offset;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_vl_byte;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_total_check_byte;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_remain_byte_nx;
reg [MAX_BYTE_WIDTH - 1:0] vlsq_remain_byte;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_avaliable_byte;
wire [MAX_BYTE_WIDTH - 1:0] vlsq_avaliable_byte_vstart;
wire [ELE_CNT_WIDTH:0] vlsq_vl_sel;
wire [ELE_CNT_WIDTH:0] vlsq_vl_widen;
wire vlsq_req_cross_4k;
wire vlsq_bad_va;
wire vlsq_bad_va39_pre;
wire vlsq_bad_va48_pre;
wire [XLEN - 1:0] vlsq_addr_out;
wire [XLEN - 1:0] vlsq_req_cross_addr_nx;
wire vlsq_prestart;
wire vlsq_body;
wire vlsq_va_ready;
wire vlsq_xcpt_check_pre;
wire vlsq_xcpt_check_en;
wire vlsq_cross_check_en;
wire vlsq_req_last_grant;
wire [2:0] vlsq_pa_mask;
wire [XLEN - 1:0] vlsq_req_xlen_addr;
wire [XLEN - 1:0] vlsq_req_addr;
wire vlsq_addr_en;
wire [XLEN - 1:0] vlsq_addr_nx;
reg [XLEN - 1:0] vlsq_addr;
wire vlsq_cross_4k_d1_nx;
reg vlsq_cross_4k_d1;
reg [XLEN - 1:0] vlsq_cross_4k_addr;
wire [63:0] vlsq_ilm_mask_bits;
wire [63:0] vlsq_dlm_mask_bits;
wire [63:0] vlsq_hvm_mask_bits;
wire [ELE_CNT_WIDTH - 1:0] vlsq_enq_check_cnt;
wire [ELE_CNT_WIDTH - 1:0] vlsq_ele_check_cnt;
wire [ELE_CNT_WIDTH - 1:0] vlsq_ele_check_cnt_minus1;
wire [ELE_CNT_WIDTH - 1:0] vlsq_ele_widen_check_cnt;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_ack_valid;
wire [(VLSQ_DEPTH * ELE_CNT_WIDTH) - 1:0] vlsq_ent_check_cnt;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_check_done;
wire vlsq_req_ustride_last;
wire vlsq_req_strided_last;
wire vlsq_req_indexed_last;
wire vlsq2uop_cmt_done;
wire [VLSQ_DEPTH - 1:0] vlsq2uop_cmt_done_sel;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_deq_valid;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_deq_kill_buf;
wire [(VLSQ_DEPTH * (VRF_LW + 1)) - 1:0] vlsq_ent_deq_kill_size;
wire [BUF_DEPTH - 1:0] vlsq_deq_start_buf_ptr;
wire vlsq_deq_kill_buf;
wire [VRF_LW:0] vlsq_deq_kill_size;
wire [BUF_DEPTH_LOG2:0] vlsq_deq_kill_size_zext;
wire [BUF_DEPTH - 1:0] kill_buf_ptr;
wire vlsu_vs2_rgrant;
wire vlsq_req_vs2_rvalid;
wire vlsq_req_vs2_rgrant;
wire vlsq_xcpt_vs2_dlen_last;
wire vlsq_vs2_dlen_last;
wire vlsq_vs2_last;
wire vlsq_vs2_element_en;
reg [ELE_CNT_WIDTH - 1:0] vlsq_vs2_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vs2_element_nx;
wire [ELE_CNT_WIDTH - 1:0] vlsq_vs2_element_add1;
wire [ELE_DLEN_WIDTH - 1:0] vlsq_vs2_element_num_dlen;
wire vlsq_vs2_dummy_rready_set0;
wire vlsq_vs2_dummy_rready_set1;
wire vlsq_vs2_dummy_rready_set;
wire vlsq_vs2_dummy_rready_clr;
wire vlsq_vs2_dummy_rready_en;
wire vlsq_vs2_dummy_rready_nx;
reg vlsq_vs2_dummy_rready;
wire vlsq_vs2_addr_valid_set;
wire vlsq_vs2_addr_valid_clr;
wire vlsq_vs2_addr_valid_en;
wire vlsq_vs2_addr_valid_nx;
reg vlsq_vs2_addr_valid;
wire [1:0] vlsq_vs2_eew;
wire vlsq_vs2_done;
wire vlsq_vs2_skip;
wire [7:0] vlsq_vs2_addr_eew8;
wire [15:0] vlsq_vs2_addr_eew16;
wire [31:0] vlsq_vs2_addr_eew32;
wire [63:0] vlsq_vs2_addr_eew64;
wire [XLEN - 1:0] vlsq_vs2_addr_eew8_zext;
wire [XLEN - 1:0] vlsq_vs2_addr_eew16_zext;
wire [XLEN - 1:0] vlsq_vs2_addr_eew32_zext;
wire vlsq_vs2_eew8;
wire vlsq_vs2_eew16;
wire vlsq_vs2_eew32;
wire vlsq_vs2_eew64;
wire [3:0] vlsq_vs2_eew_onehot;
wire [ELE_DLEN_WIDTH - 1:0] cur_vs2_element_num_dlen;
wire vlsq_vs2_done_valid;
wire vlsu_vs2_rgrant_last;
wire vlsq_vs2_cmd_valid;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_claim_buf_valid;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_claim_buf_reset;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_claim_buf_last;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_claim_buf_adj;
wire [VLSQ_DEPTH * VRF_LW - 1:0] vlsq_ent_claim_buf_size;
wire [(VLSQ_DEPTH * (VRF_LW + 1)) - 1:0] vlsq_ent_claim_buf_cnt;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_hit_hvm;
wire [BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt_init;
wire [BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt_last;
wire claim_buf_adj;
reg [BUF_DEPTH * BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt_adj;
wire [BUF_DEPTH_LOG2 - 1:0] claim_buf_num_add1;
wire claim_buf_valid;
wire claim_buf_killing;
wire claim_buf_kill;
wire claim_buf_last;
wire claim_vbuf_grant;
wire [VRF_LW - 1:0] claim_buf_vd_seg_beats;
wire [VRF_LW - 1:0] claim_buf_size;
wire claim_buf_skip;
wire [BUF_DEPTH - 1:0] claim_buf_resp_ptr;
wire [VLSQ_DEPTH - 1:0] claim_buf_mark_sel;
wire [BUF_DEPTH_LOG2 - 1:0] claim_buf_num;
wire vlsu_cmt_grant;
wire [EXTVALEN - 1:0] vlsu_ack_tval_pre;
wire [ELE_CNT_WIDTH - 1:0] vlsu_ack_element_pre;
wire [VLSQ_DEPTH - 1:0] vlsq2uop_ent_valid;
wire [VLSQ_DEPTH - 1:0] vlsq2uop_ent_buf_ready;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_cmtted;
wire [VLSQ_DEPTH - 1:0] vlsq_ent_killed;
wire vlsq2uop_valid;
wire vlsq2uop_buf_ready_pre;
wire vlsq2uop_buf_ready;
wire vlsq2uop_cmtted;
wire vlsq2uop_killed;
wire vlsq2uop_cmt_bypass;
wire vlsq2uop_cmt_grant;
wire vlsq2uop_cmt_last;
wire vlsq2uop_cmt_stop;
wire vlsq2uop_cmt_skip;
wire vlsq2uop_cmt_cnt_en;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_cmt_cnt_nx;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_cmt_cnt_add1;
reg [ELE_CNT_WIDTH - 1:0] vlsq2uop_cmt_cnt;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_check_cnt;
wire [VRF_LW:0] vlsq2uop_claim_buf_cnt;
wire vlsq2uop_check_done;
wire [28 - 1:0] vlsq2uop_ctrl;
wire vlsq2uop_widen;
wire [2:0] vlsq2uop_eew;
wire vlsq2uop_eew8;
wire vlsq2uop_eew16;
wire vlsq2uop_eew32;
wire vlsq2uop_eew64;
wire vlsq2uop_enseg;
wire vlsq2uop_enseg_buf_ready;
wire vlsq2uop_xcpted;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_fault_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_cmt_cnt_sel;
wire [ELE_CNT_WIDTH - 1:0] vlsq2uop_cmt_cnt_nx_sel;
wire vlsq2uop_dlen_num_en;
wire vlsq2uop_dlen_num_inc;
wire [VRF_LW - 1:0] vlsq2uop_dlen_num_nx;
wire [VRF_LW - 1:0] vlsq2uop_dlen_num_normal;
wire [VRF_LW - 1:0] vlsq2uop_dlen_num_normal_nx;
wire [VRF_LW - 1:0] vlsq2uop_dlen_num_add1;
reg [VRF_LW - 1:0] vlsq2uop_dlen_num;
wire [VLSQ_DEPTH - 1:0] vlsq2buf_ent_req_valid;
wire [VLSQ_DEPTH * (ELE_CNT_WIDTH + 1) - 1:0] vlsq2buf_ent_req_vl;
wire [VLSQ_DEPTH - 1:0] vlsq2buf_req_done_sel;
wire vlsq2buf_req_valid;
wire vlsq2buf_req_ready;
wire vlsq2buf_req_grant;
wire vlsq2buf_req_skip;
wire vlsq2buf_req_killing;
wire vlsq2buf_req_kill;
wire vlsq2buf_req_first;
wire vlsq2buf_req_last;
wire vlsq2buf_req_alive_last;
wire [28 - 1:0] vlsq2buf_ctrl;
wire vlsq2buf_hvm;
wire [BUF_DEPTH - 1:0] vlsq2buf_start_buf_ptr;
wire [BUF_DEPTH - 1:0] vlsq2buf_req_buf_ptr;
wire vlsq2buf_buf_ptr_en;
wire vlsq2buf_buf_ptr_revert;
wire [BUF_DEPTH - 1:0] vlsq2buf_buf_ptr_add1;
wire [BUF_DEPTH - 1:0] vlsq2buf_buf_ptr_sub1;
wire [BUF_DEPTH - 1:0] vlsq2buf_buf_ptr_nx;
reg [BUF_DEPTH - 1:0] vlsq2buf_buf_ptr;
wire vlsq2buf_nf_first;
wire vlsq2buf_nf_last;
wire vlsq2buf_emul_len_pre;
wire vlsq2buf_emul_len_vstart;
wire vlsq2buf_emul_len_first;
wire vlsq2buf_emul_len_last;
wire vlsq2buf_nf_cnt_en;
wire [2:0] vlsq2buf_nf_cnt_add1;
wire [2:0] vlsq2buf_nf_cnt_nx;
reg [2:0] vlsq2buf_nf_cnt;
wire [VLEN - 1:0] vlsq2buf_v0t;
wire [VLEN - 1:0] vlsq2buf_v0t_final;
wire vlsq2buf_v0t_zero_en;
wire vlsq2buf_seg;
wire vlsq2buf_widen;
wire vlsq2buf_ustride;
wire vlsq2buf_ustride_nseg;
wire [2:0] vlsq2buf_nf;
wire [2:0] vlsq2buf_vd_eew;
wire vlsq2buf_vd_eew4;
wire vlsq2buf_vd_eew8;
wire vlsq2buf_vd_eew16;
wire vlsq2buf_vd_eew32;
wire vlsq2buf_vd_eew64;
wire [3:0] vlsq2buf_vd_eew_onehot;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_vstart;
wire [VRF_LW - 1:0] vlsq2buf_vstart_dlen;
wire [VRF_LW - 1:0] vlsq2buf_vl_dlen;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vstart_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vstart_byte_remap;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_fault_element;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_fault_element_sel;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_fault_element_minus1;
wire [ELE_CNT_WIDTH:0] vlsq2buf_fault_element_add1;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_fault_element_final;
wire [ELE_CNT_WIDTH - 1:0] vlsq2buf_req_vstart;
wire [ELE_CNT_WIDTH:0] vlsq2buf_req_vl;
wire vlsq2buf_req_keep_vl;
wire vlsq2buf_req_vl_inc;
wire [2:0] vlsq2buf_fault_nf;
wire [ELE_CNT_WIDTH:0] vlsq2buf_vl;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl_byte_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl_byte_remap_minus1;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl8_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl16_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl32_remap;
wire [ELE_DLEN_WIDTH - 1:0] vlsq2buf_vl64_remap;
wire [VRF_LW - 1:0] vlsq2buf_vd_beats;
wire vlsq2buf_beat_cnt_en;
wire [VRF_LW - 1:0] vlsq2buf_beat_cnt_nx;
wire [VRF_LW - 1:0] vlsq2buf_beat_cnt_add1;
reg [VRF_LW - 1:0] vlsq2buf_beat_cnt;
wire [VRF_LW - 1:0] vlsq2buf_v0t_sel;
reg [VRF_LW - 1:0] vlsq2buf_v0t_sel_cur;
wire [VRF_LW - 1:0] vlsq2buf_v0t_sel_nx;
wire [VRF_LW - 1:0] vlsq2buf_v0t_sel_add1;
wire vlsq2buf_hit_same_dlen;
wire [DMLEN - 1:0] vlsq2buf_v0t_byte;
wire [(DLEN / 8) - 1:0] vlsq2buf_eew8_v0t;
wire [(DLEN / 16) - 1:0] vlsq2buf_eew16_v0t;
wire [(DLEN / 32) - 1:0] vlsq2buf_eew32_v0t;
wire [(DLEN / 64) - 1:0] vlsq2buf_eew64_v0t;
wire [DMLEN - 1:0] vlsq2buf_eew8_byte_mask;
wire [DMLEN - 1:0] vlsq2buf_eew16_byte_mask;
wire [DMLEN - 1:0] vlsq2buf_eew32_byte_mask;
wire [DMLEN - 1:0] vlsq2buf_eew64_byte_mask;
wire [DMLEN - 1:0] vlsq2buf_v0t_first_dlen;
wire [DMLEN - 1:0] vlsq2buf_v0t_last_dlen;
wire [DMLEN - 1:0] vlsq2buf_v0t_same_dlen;
wire vlsq2buf_byte_mask_xcpt_nf;
wire vlsq2buf_xcpted;
wire [VRF_LW - 1:0] vlsq2buf_fault_element_dlen;
wire vlsq2buf_fault_dlen_en;
wire vlsq2buf_fault_element_zero;
wire vlsq2buf_fault_nf_zero;
wire vlsu_vs3_rgrant;
wire vlsbuf_vs3_wvalid;
wire vlsbuf_vs3_wr_dummy;
wire vlsq2vs3_req_ptr_en;
wire [VLSQ_DEPTH - 1:0] vlsq2vs3_req_ptr;
wire vlsq2vs3_rready_pre;
wire [VLSQ_DEPTH - 1:0] vlsq2vs3_ent_rready;
wire vlsq2vs3_req_skip;
wire vlsq2vs3_req_kill;
wire vlsq2vs3_req_killing;
wire vlsq2vs3_req_first;
wire vlsq2vs3_req_last;
wire [VLSQ_DEPTH - 1:0] vlsq2vs3_req_done_sel;
wire vlsq2vs3_hvm;
wire [28 - 1:0] vlsq2vs3_ctrl;
wire [ELE_CNT_WIDTH - 1:0] vlsq2vs3_vl_minus1;
wire [VRF_LW - 1:0] vlsq2vs3_vd_beats;
wire [VRF_LW - 1:0] vlsq2vs3_vd_emul_len;
wire [BUF_DEPTH - 1:0] vlsq2vs3_start_buf_ptr;
wire vlsq2vs3_buf_ready_cond;
wire [VRF_LW:0] vlsq2vs3_claim_buf_cnt;
wire [2:0] vlsq2vs3_eew;
wire vlsq2vs3_eew64;
wire vlsq2vs3_eew32;
wire vlsq2vs3_eew16;
wire vlsq2vs3_eew8;
wire vlsq2vs3_seg;
wire vlsq2vs3_widen;
wire vlsq2vs3_ustride;
wire vlsq2vs3_element;
wire vlsq2vs3_ustride_nseg;
wire vlsq2vs3_element_nseg;
wire vlsq2vs3_buf_ptr_en;
wire vlsq2vs3_buf_ptr_revert;
wire [BUF_DEPTH - 1:0] vlsq2vs3_buf_ptr_nx;
wire [BUF_DEPTH - 1:0] vlsq2vs3_buf_ptr_add1;
wire [BUF_DEPTH - 1:0] vlsq2vs3_buf_ptr_sub1;
reg [BUF_DEPTH - 1:0] vlsq2vs3_buf_ptr;
wire [BUF_DEPTH - 1:0] vlsq2vs3_req_buf_ptr;
wire vs3_emul_cnt_en;
wire [VRF_LW - 1:0] vs3_emul_cnt_nx;
reg [VRF_LW - 1:0] vs3_emul_cnt;
wire vs3_emul_rlast;
wire vs3_nf_cnt_en;
wire [2:0] vs3_nf_cnt_nx;
reg [2:0] vs3_nf_cnt;
wire packed_req_trig;
wire packed_req_pending_en;
wire packed_req_pending_nx;
reg packed_req_pending;
wire vlsq_va2pa_en;
wire vlsq_sv39;
wire vlsq_mstatus_mxr;
wire vlsq_mstatus_sum;
wire [8:0] vlsq_xcpt_status;
wire vlsq_resp_xcpt;
wire vlsq_resp_xcpt_trig;
wire [22 - 1:0] vlsq_resp_status;
wire vlsq_addr_misalign;
wire mtype_check_set;
wire mtype_check_clr;
wire mtype_check_en;
wire mtype_check_valid_nx;
reg mtype_check_valid;
reg [3:0] mtype_check_data;
reg nosh_check_data;
reg hvm_check_data;
wire mtype_check_inconsistent;
wire [63:0] vlsq_ilm_mask;
wire [63:0] vlsq_dlm_mask;
wire [63:0] vlsq_hvm_mask;
wire vlsq_hit_ilm;
wire vlsq_hit_dlm;
wire vlsq_hit_hvm;
wire [PALEN - 1:0] vlsq2vtlb_resp_pa;
wire vlsq2vtlb_req_grant;
wire vlsq2vtlb_req_priv;
wire vlsq2vtlb_req_priv_u;
wire vlsq2vtlb_req_unpriv;
wire vlsq2vtlb_req_store;
wire vlsq2vtlb_req_load;
wire vlsq2vtlb_req_priv_r;
wire vlsq2vtlb_req_priv_w;
wire vlsq2vtlb_req_unpriv_r;
wire vlsq2vtlb_req_unpriv_w;
wire [3:0] vlsq2vtlb_req_permission;
wire vlsq2vtlb_resp_pmp_fault;
wire [3:0] vlsq2vtlb_resp_pmp_permission;
wire vlsq2vtlb_resp_pma_fault;
wire [3:0] vlsq2vtlb_resp_pma_mtype;
wire vlsq2vtlb_resp_pma_nosh;
wire vlsq2vtlb_resp_pma_device;
wire vlsq2vtlb_resp_page_fault;
wire vlsq2vtlb_resp_page_v;
wire vlsq2vtlb_resp_page_r;
wire vlsq2vtlb_resp_page_w;
wire vlsq2vtlb_resp_page_x;
wire vlsq2vtlb_resp_page_u;
wire vlsq2vtlb_resp_page_a;
wire vlsq2vtlb_resp_page_d;
wire vlsq2vtlb_resp_page_fault_ptw;
wire vlsq2vtlb_resp_page_access_fault;
wire [2:0] vlsq2vtlb_resp_page_dcause;
wire [7:0] vlsq2vtlb_resp_page_ecc_code;
wire vlsq2vtlb_resp_page_ecc_corr;
wire [3:0] vlsq2vtlb_resp_page_ecc_ramid;
wire page_access_fault;
wire page_dirty_fault;
wire page_readable_fault;
wire page_writable_fault;
wire page_userpage_fault;
wire nds_unused_co1;
wire nds_unused_co4;
wire nds_unused_co5;
wire nds_unused_co6;
wire nds_unused_co7;
wire nds_unused_co8;
wire nds_unused_co9;
wire nds_unused_vstart_x3_ov;
wire nds_unused_vstart_x5_ov;
wire nds_unused_vstart_x6_ov;
wire nds_unused_vstart_x7_ov;
wire nds_unused_vl_x3_ov;
wire nds_unused_vl_x5_ov;
wire nds_unused_vl_x6_ov;
wire nds_unused_vl_x7_ov;
wire [XLEN - 1:0] nds_unused_vlsq_req_cross_addr_nx;
wire [MAX_BYTE_WIDTH - 1:0] nds_unused_vlsq_remain_byte_nx;
wire nds_unused_vlsq_req_cross_4k;
wire [VRF_LW - 1:0] nds_unused_vlsu_dispatch_vd_len = vlsu_dispatch_vd_len;
wire [VRF_LW - 1:0] nds_unused_vlsu_dispatch_vs3_len = vlsu_dispatch_vs3_len;
kv_vls_seg_num #(
    .WIDTH(7)
) u_vlsq_ustride_seg_op2 (
    .data_in(vlsq_ustride_op2),
    .nf(vlsu_nf),
    .data_out(vlsq_ustride_seg_op2)
);
genvar i;
generate
    for (i = 0; i < VLSQ_DEPTH; i = i + 1) begin:gen_vlsq_ent
        kv_vlsq_ent #(
            .XLEN(XLEN),
            .VLEN(VLEN),
            .DLEN(DLEN),
            .ELEN(ELEN),
            .VALEN(VALEN),
            .EXTVALEN(EXTVALEN),
            .VRF_LW(VRF_LW),
            .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
            .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
            .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
            .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
            .BUF_DEPTH(BUF_DEPTH),
            .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
            .VS2Q_DEPTH_LOG2(VS2Q_DEPTH_LOG2),
            .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
            .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
            .MAX_BYTE_WIDTH(MAX_BYTE_WIDTH),
            .SEG_PRESYNC(SEG_PRESYNC)
        ) u_vlsq_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .vlsq_req_ready(vlsq_req_ptr[i]),
            .vlsq_enq_valid(vlsq_enq_sel[i]),
            .vlsq_req_valid(vlsq_req_sel[i]),
            .vlsq_req_grant_last(vlsq_req_last),
            .vlsq_cmt_valid(vlsq_cmt_sel[i]),
            .vlsq_cmt_kill(vlsq_cmt_kill),
            .vlsq_deq_ready(vlsq_deq_ptr[i]),
            .vlsq_ack_ready(vlsq_ack_ptr[i]),
            .vlsq_enq_ctrl(vlsq_enq_ctrl),
            .vlsq_enq_op1(vlsq_enq_op1),
            .vlsq_enq_op2(vlsq_enq_op2),
            .vlsq_enq_v0t(vlsq_enq_v0t),
            .vlsq_enq_vstart(vlsq_enq_vstart),
            .vlsq_enq_vstart_nf(vlsq_enq_vstart_nf),
            .vlsq_enq_vstart_byte(vlsq_enq_vstart_byte),
            .vlsq_enq_vstart_eew4_lsb(vlsq_enq_vstart_eew4_lsb),
            .vlsq_enq_vl(vlsq_enq_vl),
            .vlsq_enq_vl_nf(vlsq_enq_vl_nf),
            .vlsq_enq_vl_minus1(vlsq_enq_vl_minus1[ELE_CNT_WIDTH - 1:0]),
            .vlsq_enq_vs2_len(vlsq_enq_vs2_len),
            .vlsq_enq_vd_emul_len(vlsq_enq_vd_emul_len),
            .vlsq_inst_req_mark_valid(vlsq_inst_req_mark_sel[i]),
            .vlsq_req_cross_4k(vlsq_req_cross_4k),
            .vlsq_req_cross_4k_d1(vlsq_cross_4k_d1),
            .vlsq_resp_valid(vlsq_resp_sel[i]),
            .vlsq_resp_status(vlsq_resp_status),
            .vlsq_resp_fault_element(vlsq_resp_fault_element),
            .vlsq_resp_tval(vlsq_resp_tval),
            .vlsq_resp_fault_nf(vlsq_resp_fault_nf),
            .vlsq_resp_remain_vd_beats(vlsq_resp_remain_vd_beats),
            .vlsq_resp_hit_hvm(vlsq_resp_hit_hvm),
            .vlsq_qout_ack_valid(vlsq_ent_ack_valid[i]),
            .vlsq_qout_ack_status(vlsq_ent_ack_status[i * 22 +:22]),
            .vlsq_qout_ack_tval(vlsq_ent_ack_tval[i * EXTVALEN +:EXTVALEN]),
            .vlsq_qout_ack_element(vlsq_ent_ack_element[i * ELE_CNT_WIDTH +:ELE_CNT_WIDTH]),
            .vlsq_qout_ack_nf(vlsq_ent_ack_nf[i * 3 +:3]),
            .vlsq_qout_ctrl(vlsq_ent_ctrl[i * 28 +:28]),
            .vlsq_qout_load(vlsq_ent_load[i]),
            .vlsq_qout_store(vlsq_ent_store[i]),
            .vlsq_qout_block_cmd(vlsq_ent_block_cmd[i]),
            .vlsq_qout_op1(vlsq_ent_op1[i * XLEN +:XLEN]),
            .vlsq_qout_op2(vlsq_ent_op2[i * XLEN +:XLEN]),
            .vlsq_qout_v0t(vlsq_ent_v0t[i * VLEN +:VLEN]),
            .vlsq_qout_vstart(vlsq_ent_vstart[i * ELE_CNT_WIDTH +:ELE_CNT_WIDTH]),
            .vlsq_qout_vstart_nf(vlsq_ent_vstart_nf[i * ELE_CNT_WIDTH +:ELE_CNT_WIDTH]),
            .vlsq_qout_vstart_byte(vlsq_ent_vstart_byte[i * MAX_BYTE_WIDTH +:MAX_BYTE_WIDTH]),
            .vlsq_qout_vstart_eew4_lsb(vlsq_ent_vstart_eew4_lsb[i]),
            .vlsq_qout_vl(vlsq_ent_vl[i * (ELE_CNT_WIDTH + 1) +:(ELE_CNT_WIDTH + 1)]),
            .vlsq_qout_vl_nf(vlsq_ent_vl_nf[i * (ELE_CNT_WIDTH + 1) +:(ELE_CNT_WIDTH + 1)]),
            .vlsq_qout_vl_minus1(vlsq_ent_vl_minus1[i * ELE_CNT_WIDTH +:ELE_CNT_WIDTH]),
            .vlsq_qout_vstart_dlen(vlsq_ent_vstart_dlen[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_vl_dlen(vlsq_ent_vl_dlen[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_vd_beats(vlsq_ent_vd_beats[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_vd_seg_beats(vlsq_ent_vd_seg_beats[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_remain_vd_beats(vlsq_ent_remain_vd_beats[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_vd_emul_len(vlsq_ent_vd_emul_len[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_alive(vlsq_ent_alive[i]),
            .vlsq_qout_widen_alive(vlsq_ent_widen_alive[i]),
            .vlsq_qout_inst_req_mark(vlsq_ent_inst_req_mark[i]),
            .vlsq_qout_occupied(vlsq_ent_occupied[i]),
            .vlsq_qout_valid_pre(vlsq_ent_valid_pre[i]),
            .vlsq_qout_claim_skip(vlsq_ent_claim_skip[i]),
            .vlsq_qout_vlsq2buf_skip(vlsq_ent_vlsq2buf_skip[i]),
            .vlsq_qout_vlsq2vs3_skip(vlsq_ent_vlsq2vs3_skip[i]),
            .vlsq_qout_req_skip(vlsq_ent_req_skip[i]),
            .vlsq_qout_vlsq2uop_skip(vlsq_ent_vlsq2uop_skip[i]),
            .vlsq_qout_vs2_done(vlsq_ent_vs2_done[i]),
            .vlsq_qout_vs2_skip(vlsq_ent_vs2_skip[i]),
            .vlsq_qout_start_buf_num(vlsq_ent_start_buf_num[i * BUF_DEPTH_LOG2 +:BUF_DEPTH_LOG2]),
            .vlsq_qout_start_buf_ptr(vlsq_ent_start_buf_ptr[i * BUF_DEPTH +:BUF_DEPTH]),
            .vlsq_qout_xcpted(vlsq_ent_xcpted[i]),
            .vlsq_qout_hit_hvm(vlsq_ent_hit_hvm[i]),
            .vlsq_qout_claim_buf_valid(vlsq_ent_claim_buf_valid[i]),
            .vlsq_qout_claim_buf_reset(vlsq_ent_claim_buf_reset[i]),
            .vlsq_qout_claim_buf_last(vlsq_ent_claim_buf_last[i]),
            .vlsq_qout_claim_buf_adj(vlsq_ent_claim_buf_adj[i]),
            .vlsq_qout_claim_buf_size(vlsq_ent_claim_buf_size[i * VRF_LW +:VRF_LW]),
            .vlsq_qout_claim_buf_cnt(vlsq_ent_claim_buf_cnt[i * (VRF_LW + 1) +:(VRF_LW + 1)]),
            .vlsq_claim_buf_ready(claim_vbuf_ready_sel[i]),
            .vlsq_claim_mark_valid(claim_buf_mark_sel[i]),
            .vlsq_claim_resp_buf_num(claim_buf_resp_num),
            .vlsq_claim_resp_buf_ptr(claim_buf_resp_ptr),
            .vlsu_vs2_rgrant_last(vlsu_vs2_rgrant_last),
            .vlsq2uop_qout_valid(vlsq2uop_ent_valid[i]),
            .vlsq2uop_qout_buf_ready(vlsq2uop_ent_buf_ready[i]),
            .vlsq_qout_cmtted(vlsq_ent_cmtted[i]),
            .vlsq_qout_killed(vlsq_ent_killed[i]),
            .vlsq2uop_cmt_done_valid(vlsq2uop_cmt_done_sel[i]),
            .vlsq2buf_req_done_valid(vlsq2buf_req_done_sel[i]),
            .vlsq2buf_qout_req_valid(vlsq2buf_ent_req_valid[i]),
            .vlsq2buf_qout_req_vl(vlsq2buf_ent_req_vl[i * (ELE_CNT_WIDTH + 1) +:(ELE_CNT_WIDTH + 1)]),
            .vlsq2vs3_qout_rready(vlsq2vs3_ent_rready[i]),
            .vlsq2vs3_req_done_valid(vlsq2vs3_req_done_sel[i]),
            .vlsq_enq_check_cnt(vlsq_enq_check_cnt),
            .vlsq_qout_check_done(vlsq_ent_check_done[i]),
            .vlsq_qout_check_cnt(vlsq_ent_check_cnt[i * ELE_CNT_WIDTH +:ELE_CNT_WIDTH]),
            .vlsq_qout_deq_valid(vlsq_ent_deq_valid[i]),
            .vlsq_qout_deq_kill_buf(vlsq_ent_deq_kill_buf[i]),
            .vlsq_qout_deq_kill_size(vlsq_ent_deq_kill_size[i * (VRF_LW + 1) +:(VRF_LW + 1)])
        );
    end
endgenerate
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_valid_pre (
    .out(vlsq_valid_pre),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_valid_pre)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(28)
) u_vlsq_ctrl (
    .out(vlsq_ctrl),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_ctrl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(XLEN)
) u_vlsq_op1 (
    .out(vlsq_op1),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_op1)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(XLEN)
) u_vlsq_op2 (
    .out(vlsq_op2),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_op2)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq_vstart (
    .out(vlsq_vstart),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vstart)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq_vstart_nf (
    .out(vlsq_vstart_nf),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vstart_nf)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(MAX_BYTE_WIDTH)
) u_vlsq_vstart_byte (
    .out(vlsq_vstart_byte),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vstart_byte)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_vstart_eew4_lsb (
    .out(vlsq_vstart_eew4_lsb),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vstart_eew4_lsb)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH + 1)
) u_vlsq_vl (
    .out(vlsq_vl),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH + 1)
) u_vlsq_vl_nf (
    .out(vlsq_vl_nf),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vl_nf)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq_vl_minus1 (
    .out(vlsq_vl_minus1),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vl_minus1)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_vs2_done (
    .out(vlsq_vs2_done),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vs2_done)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_vs2_skip (
    .out(vlsq_vs2_skip),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vs2_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq_vd_emul_len (
    .out(vlsq_vd_emul_len),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vd_emul_len)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq_vd_beats (
    .out(vlsq_vd_beats),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vd_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq_vd_seg_beats (
    .out(vlsq_vd_seg_beats),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_vd_seg_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq_remain_vd_beats (
    .out(vlsq_remain_vd_beats),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_remain_vd_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_skip (
    .out(vlsq_skip),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_req_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_req_done (
    .out(vlsq_req_done),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_check_done)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_alive (
    .out(vlsq_alive),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_alive)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_widen_alive (
    .out(vlsq_widen_alive),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_widen_alive)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_inst_req_mark (
    .out(vlsq_inst_req_mark),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_inst_req_mark)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_xcpted (
    .out(vlsq_xcpted),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_xcpted)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_cmtted (
    .out(vlsq_cmtted),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_cmtted)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_killed (
    .out(vlsq_killed),
    .sel(vlsq_req_ptr),
    .in(vlsq_ent_killed)
);
kv_zero_ext #(
    .OW(XLEN),
    .IW(8)
) u_vlsq_vs2_eew8_zext (
    .out(vlsq_vs2_addr_eew8_zext),
    .in(vlsq_vs2_addr_eew8)
);
kv_zero_ext #(
    .OW(XLEN),
    .IW(16)
) u_vlsq_vs2_eew16_zext (
    .out(vlsq_vs2_addr_eew16_zext),
    .in(vlsq_vs2_addr_eew16)
);
kv_zero_ext #(
    .OW(XLEN),
    .IW(32)
) u_vlsq_vs2_eew32_zext (
    .out(vlsq_vs2_addr_eew32_zext),
    .in(vlsq_vs2_addr_eew32)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_claim_buf_valid (
    .out(claim_buf_valid),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_buf_valid)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_claim_buf_reset (
    .out(claim_buf_reset),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_buf_reset)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_claim_buf_last (
    .out(claim_buf_last),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_buf_last)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_claim_buf_adj (
    .out(claim_buf_adj),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_buf_adj)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_claim_buf_vd_seg_beats (
    .out(claim_buf_vd_seg_beats),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_vd_seg_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_claim_buf_size (
    .out(claim_buf_size),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_buf_size)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_claim_buf_skip (
    .out(claim_buf_skip),
    .sel(vlsq_claim_ptr),
    .in(vlsq_ent_claim_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2vs3_rready_pre (
    .out(vlsq2vs3_rready_pre),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq2vs3_ent_rready)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2vs3_req_skip (
    .out(vlsq2vs3_req_skip),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_vlsq2vs3_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2vs3_hvm (
    .out(vlsq2vs3_hvm),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_hit_hvm)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(28)
) u_vlsq2vs3_ctrl (
    .out(vlsq2vs3_ctrl),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_ctrl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq2vs3_vl_minus1 (
    .out(vlsq2vs3_vl_minus1),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_vl_minus1)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq2vs3_vd_beats (
    .out(vlsq2vs3_vd_beats),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_vd_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq2vs3_vd_emul_len (
    .out(vlsq2vs3_vd_emul_len),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_vd_emul_len)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW + 1)
) u_vlsq2vs3_claim_buf_cnt (
    .out(vlsq2vs3_claim_buf_cnt),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_claim_buf_cnt)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(BUF_DEPTH)
) u_vlsq2vs3_start_buf_ptr (
    .out(vlsq2vs3_start_buf_ptr),
    .sel(vlsq2vs3_req_ptr),
    .in(vlsq_ent_start_buf_ptr)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsu_ack_valid (
    .out(vlsu_ack_valid),
    .sel(vlsq_ack_ptr),
    .in(vlsq_ent_ack_valid)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(22)
) u_vlsu_ack_status (
    .out(vlsu_ack_status),
    .sel(vlsq_ack_ptr),
    .in(vlsq_ent_ack_status)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(EXTVALEN)
) u_vlsu_ack_tval_pre (
    .out(vlsu_ack_tval_pre),
    .sel(vlsq_ack_ptr),
    .in(vlsq_ent_ack_tval)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsu_ack_element_pre (
    .out(vlsu_ack_element_pre),
    .sel(vlsq_ack_ptr),
    .in(vlsq_ent_ack_element)
);
kv_vls_xcpt_dec u_vls_xcpt_dec(
    .load(vlsq_load),
    .store(vlsq_store),
    .fof(vlsq_fof),
    .xcpt_status(vlsq_xcpt_status),
    .xcpt_page_dcause(vlsq2vtlb_resp_page_dcause),
    .xcpt_ecc_code(vlsq2vtlb_resp_page_ecc_code),
    .xcpt_ecc_corr(vlsq2vtlb_resp_page_ecc_corr),
    .xcpt_ecc_ramid(vlsq2vtlb_resp_page_ecc_ramid),
    .vls_status(vlsq_resp_status)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_valid (
    .out(vlsq2uop_valid),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq2uop_ent_valid)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(28)
) u_vlsq2uop_ctrl (
    .out(vlsq2uop_ctrl),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_ctrl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_buf_ready_pre (
    .out(vlsq2uop_buf_ready_pre),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq2uop_ent_buf_ready)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_cmtted (
    .out(vlsq2uop_cmtted),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_cmtted)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_killed (
    .out(vlsq2uop_killed),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_killed)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq2uop_cmt_cnt (
    .out(vlsq2uop_check_cnt),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_check_cnt)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_cmt_check_done (
    .out(vlsq2uop_check_done),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_check_done)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(BUF_DEPTH_LOG2)
) u_vlsq2uop_cmt_start_buf_num (
    .out(vlsq2uop_cmt_start_buf_num),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_start_buf_num)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_cmt_skip (
    .out(vlsq2uop_cmt_skip),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_vlsq2uop_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW + 1)
) u_vlsq2uop_claim_buf_cnt (
    .out(vlsq2uop_claim_buf_cnt),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_claim_buf_cnt)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2uop_xcpted (
    .out(vlsq2uop_xcpted),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_xcpted)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq2uop_fault_element (
    .out(vlsq2uop_fault_element),
    .sel(vlsq2uop_cmt_ptr),
    .in(vlsq_ent_ack_element)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2buf_req_valid (
    .out(vlsq2buf_req_valid),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq2buf_ent_req_valid)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2buf_req_skip (
    .out(vlsq2buf_req_skip),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_vlsq2buf_skip)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(28)
) u_vlsq2buf_ctrl (
    .out(vlsq2buf_ctrl),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_ctrl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq2buf_vstart (
    .out(vlsq2buf_vstart),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_vstart)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH + 1)
) u_vlsq2buf_vl (
    .out(vlsq2buf_vl),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq2buf_ent_req_vl)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2buf_xcpted (
    .out(vlsq2buf_xcpted),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_xcpted)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(ELE_CNT_WIDTH)
) u_vlsq2buf_fault_element (
    .out(vlsq2buf_fault_element),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_ack_element)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(3)
) u_vlsq2buf_fault_nf (
    .out(vlsq2buf_fault_nf),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_ack_nf)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq2buf_vd_beats (
    .out(vlsq2buf_vd_beats),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_vd_beats)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq2buf_vstart_dlen (
    .out(vlsq2buf_vstart_dlen),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_vstart_dlen)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW)
) u_vlsq2buf_vl_dlen (
    .out(vlsq2buf_vl_dlen),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_vl_dlen)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(BUF_DEPTH)
) u_vlsq2buf_start_buf_ptr (
    .out(vlsq2buf_start_buf_ptr),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_start_buf_ptr)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VLEN)
) u_vlsq2buf_v0t (
    .out(vlsq2buf_v0t),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_v0t)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq2buf_hvm (
    .out(vlsq2buf_hvm),
    .sel(vlsq2buf_req_ptr),
    .in(vlsq_ent_hit_hvm)
);
kv_mux #(
    .N(8 * VLEN_DLEN_RATIO),
    .W(DLEN / 8)
) u_vlsq2buf_eew8_v0t (
    .out(vlsq2buf_eew8_v0t),
    .sel(vlsq2buf_v0t_sel),
    .in(vlsq2buf_v0t_final[VLEN - 1:0])
);
kv_mux #(
    .N(8 * VLEN_DLEN_RATIO),
    .W(DLEN / 16)
) u_vlsq2buf_eew16_v0t (
    .out(vlsq2buf_eew16_v0t),
    .sel(vlsq2buf_v0t_sel),
    .in(vlsq2buf_v0t_final[(VLEN / 2) - 1:0])
);
kv_mux #(
    .N(8 * VLEN_DLEN_RATIO),
    .W(DLEN / 32)
) u_vlsq2buf_eew32_v0t (
    .out(vlsq2buf_eew32_v0t),
    .sel(vlsq2buf_v0t_sel),
    .in(vlsq2buf_v0t_final[(VLEN / 4) - 1:0])
);
generate
    if (ELEN == 64) begin:gen_vlsq2buf_eew64_v0t
        kv_mux #(
            .N(8 * VLEN_DLEN_RATIO),
            .W(DLEN / 64)
        ) u_vlsq2buf_eew64_v0t (
            .out(vlsq2buf_eew64_v0t),
            .sel(vlsq2buf_v0t_sel),
            .in(vlsq2buf_v0t_final[(VLEN / 8) - 1:0])
        );
    end
    else begin:gen_vlsq2buf_eew64_v0t_stub
        assign vlsq2buf_eew64_v0t = {DLEN / 64{1'b0}};
    end
endgenerate
kv_vls_v0t_dlen #(
    .DLEN(DLEN),
    .DMLEN(DMLEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .SHIFT(0)
) u_vls_v0t_vstart_dlen (
    .v0t_byte(vlsq2buf_v0t_byte),
    .element_byte(vlsq2buf_vstart_byte_remap),
    .v0t_byte_mask(vlsq2buf_v0t_first_dlen)
);
kv_vls_v0t_dlen #(
    .DLEN(DLEN),
    .DMLEN(DMLEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .SHIFT(1)
) u_vls_v0t_vl_dlen (
    .v0t_byte(vlsq2buf_v0t_byte),
    .element_byte(vlsq2buf_vl_byte_remap_minus1),
    .v0t_byte_mask(vlsq2buf_v0t_last_dlen)
);
kv_vls_element_remap #(
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH)
) u_vlsq_element_num_dlen (
    .element_num(vlsq_req_element[ELE_CNT_WIDTH - 1:0]),
    .eew_onehot(vlsq_vd_eew_onehot),
    .element_num_remap(vlsq_element_num_dlen)
);
kv_vls_element_remap #(
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH)
) u_vlsq2buf_vstart_remap (
    .element_num(vlsq2buf_req_vstart),
    .eew_onehot(vlsq2buf_vd_eew_onehot),
    .element_num_remap(vlsq2buf_vstart_remap)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(BUF_DEPTH)
) u_vlsq_deq_start_buf_ptr (
    .out(vlsq_deq_start_buf_ptr),
    .sel(vlsq_deq_ptr),
    .in(vlsq_ent_start_buf_ptr)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(1)
) u_vlsq_deq_kill_buf (
    .out(vlsq_deq_kill_buf),
    .sel(vlsq_deq_ptr),
    .in(vlsq_ent_deq_kill_buf)
);
kv_mux_onehot #(
    .N(VLSQ_DEPTH),
    .W(VRF_LW + 1)
) u_vlsq_deq_kill_size (
    .out(vlsq_deq_kill_size),
    .sel(vlsq_deq_ptr),
    .in(vlsq_ent_deq_kill_size)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2 + 1),
    .IW(VRF_LW + 1)
) u_vlsq_deq_kill_size_zext (
    .out(vlsq_deq_kill_size_zext),
    .in(vlsq_deq_kill_size)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_enq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_enq_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_enq_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_req_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_req_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_req_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_ack_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_ack_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_ack_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_cmt_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_cmt_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_cmt_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq2uop_cmt_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq2uop_cmt_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq2uop_cmt_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq2buf_req_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq2buf_req_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq2buf_req_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_claim_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_claim_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_claim_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_st_ptr_en (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq2vs3_req_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq2vs3_req_ptr)
);
kv_cnt_onehot #(
    .N(VLSQ_DEPTH)
) u_vlsq_deq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(vlsq_deq_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({VLSQ_DEPTH{1'b0}}),
    .cnt(vlsq_deq_ptr)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vls_gen_vs3_kill (
    .en(vlsq_deq_kill_buf),
    .in(vlsq_deq_start_buf_ptr),
    .num(vlsq_deq_kill_size_zext),
    .out(kill_buf_ptr)
);
assign elen64 = (ELEN == 64);
assign vlsq_load_pending = |vlsq_ent_load;
assign vlsq_store_pending = |vlsq_ent_store;
assign vlsq_block_cmd = |vlsq_ent_block_cmd;
assign vlsu_dispatch_ready = vlsq_not_full;
assign vlsu_dispatch_grant = vlsu_dispatch_valid & vlsu_dispatch_ready;
assign vlsq_full = &vlsq_ent_occupied;
assign vlsq_not_full = ~vlsq_full;
assign vlsq_enq_valid = vlsu_dispatch_grant;
assign vlsq_enq_ptr_en = vlsu_dispatch_grant;
assign vlsq_enq_sel = {VLSQ_DEPTH{vlsq_enq_valid}} & vlsq_enq_ptr;
assign vlsq_enq_ctrl[4] = vlsu_dispatch_ctrl[2];
assign vlsq_enq_ctrl[17] = vlsu_dispatch_ctrl[19];
assign vlsq_enq_ctrl[2] = vlsu_dispatch_ctrl[1];
assign vlsq_enq_ctrl[9 +:3] = vlsu_dispatch_ctrl[9 +:3];
assign vlsq_enq_ctrl[22 +:3] = vlsu_dispatch_ctrl[21 +:3];
assign vlsq_enq_ctrl[25 +:2] = vlsu_dispatch_ctrl[39 +:2];
assign vlsq_enq_ctrl[13 +:2] = vlsu_dispatch_ctrl[12 +:2];
assign vlsq_enq_ctrl[1] = vlsu_dispatch_ctrl[0];
assign vlsq_enq_ctrl[27] = vlsu_dispatch_ctrl[54];
assign vlsq_enq_ctrl[16] = vlsu_dispatch_ctrl[18];
assign vlsq_enq_ctrl[6] = vlsu_dispatch_ctrl[4];
assign vlsq_enq_ctrl[5] = vlsu_dispatch_ctrl[3];
assign vlsq_enq_ctrl[7] = vlsu_dispatch_ctrl[7];
assign vlsq_enq_ctrl[8] = vlsu_dispatch_ctrl[8];
assign vlsq_enq_ctrl[21] = vlsu_dispatch_ctrl[20];
assign vlsq_enq_ctrl[20] = (vlsu_mop == UNIT_STRIDE) & vlsu_vm;
assign vlsq_enq_ctrl[18] = (vlsu_mop == CONST_STRIDE) | ((vlsu_mop == UNIT_STRIDE) & ~vlsu_vm);
assign vlsq_enq_ctrl[3] = vlsu_mop[0];
assign vlsq_enq_ctrl[15] = (vlsu_nf != 3'd0);
assign vlsq_enq_ctrl[0] = vlsu_buf_ill;
assign vlsq_enq_ctrl[19] = (vlsu_dispatch_ctrl[14 +:4] == SATP_MODE_SV39);
assign vlsq_enq_ctrl[12] = ~vlsu_zero_element;
assign vlsu_nf0 = (vlsu_nf == 3'd0);
assign vlsu_nf1 = (vlsu_nf == 3'd1);
assign vlsu_nf2 = (vlsu_nf == 3'd2);
assign vlsu_nf3 = (vlsu_nf == 3'd3);
assign vlsu_nf4 = (vlsu_nf == 3'd4);
assign vlsu_nf5 = (vlsu_nf == 3'd5);
assign vlsu_nf6 = (vlsu_nf == 3'd6);
assign vlsu_nf7 = (vlsu_nf == 3'd7);
assign {nds_unused_vstart_x3_ov,vlsu_vstart_x3} = vlsu_vstart_x2 + vlsu_vstart_x1;
assign {nds_unused_vstart_x5_ov,vlsu_vstart_x5} = vlsu_vstart_x4 + vlsu_vstart_x1;
assign {nds_unused_vstart_x6_ov,vlsu_vstart_x6} = vlsu_vstart_x4 + vlsu_vstart_x2;
assign {nds_unused_vstart_x7_ov,vlsu_vstart_x7} = vlsu_vstart_x4 + vlsu_vstart_x3;
assign vlsu_vstart_x1 = {vlsu_vstart[ELE_CNT_WIDTH - 1:0]};
assign vlsu_vstart_x2 = {vlsu_vstart[ELE_CNT_WIDTH - 2:0],1'b0};
assign vlsu_vstart_x4 = {vlsu_vstart[ELE_CNT_WIDTH - 3:0],2'b0};
assign vlsu_vstart_x8 = {vlsu_vstart[ELE_CNT_WIDTH - 4:0],3'b0};
assign vlsq_enq_useg_vstart = ({ELE_CNT_WIDTH{vlsu_nf0}} & vlsu_vstart_x1) | ({ELE_CNT_WIDTH{vlsu_nf1}} & vlsu_vstart_x2) | ({ELE_CNT_WIDTH{vlsu_nf2}} & vlsu_vstart_x3) | ({ELE_CNT_WIDTH{vlsu_nf3}} & vlsu_vstart_x4) | ({ELE_CNT_WIDTH{vlsu_nf4}} & vlsu_vstart_x5) | ({ELE_CNT_WIDTH{vlsu_nf5}} & vlsu_vstart_x6) | ({ELE_CNT_WIDTH{vlsu_nf6}} & vlsu_vstart_x7) | ({ELE_CNT_WIDTH{vlsu_nf7}} & vlsu_vstart_x8);
assign {nds_unused_vl_x3_ov,vlsu_vl_x3} = vlsu_vl_x2 + vlsu_vl_x1;
assign {nds_unused_vl_x5_ov,vlsu_vl_x5} = vlsu_vl_x4 + vlsu_vl_x1;
assign {nds_unused_vl_x6_ov,vlsu_vl_x6} = vlsu_vl_x4 + vlsu_vl_x2;
assign {nds_unused_vl_x7_ov,vlsu_vl_x7} = vlsu_vl_x4 + vlsu_vl_x3;
assign vlsu_vl_x1 = {vlsu_vl[ELE_CNT_WIDTH:0]};
assign vlsu_vl_x2 = {vlsu_vl[ELE_CNT_WIDTH - 1:0],1'b0};
assign vlsu_vl_x4 = {vlsu_vl[ELE_CNT_WIDTH - 2:0],2'b0};
assign vlsu_vl_x8 = {vlsu_vl[ELE_CNT_WIDTH - 3:0],3'b0};
assign vlsq_enq_useg_vl = ({ELE_CNT_WIDTH + 1{vlsu_nf0}} & vlsu_vl_x1) | ({ELE_CNT_WIDTH + 1{vlsu_nf1}} & vlsu_vl_x2) | ({ELE_CNT_WIDTH + 1{vlsu_nf2}} & vlsu_vl_x3) | ({ELE_CNT_WIDTH + 1{vlsu_nf3}} & vlsu_vl_x4) | ({ELE_CNT_WIDTH + 1{vlsu_nf4}} & vlsu_vl_x5) | ({ELE_CNT_WIDTH + 1{vlsu_nf5}} & vlsu_vl_x6) | ({ELE_CNT_WIDTH + 1{vlsu_nf6}} & vlsu_vl_x7) | ({ELE_CNT_WIDTH + 1{vlsu_nf7}} & vlsu_vl_x8);
assign vlsu_vd_eew = vlsu_dispatch_ctrl[21 +:3];
assign vlsu_vd_eew4 = (vlsu_vd_eew[1:0] == 2'b00) & vlsu_vd_eew[2];
assign vlsu_vd_eew8 = (vlsu_vd_eew[1:0] == 2'b00) & ~vlsu_vd_eew[2];
assign vlsu_vd_eew16 = (vlsu_vd_eew[1:0] == 2'b01);
assign vlsu_vd_eew32 = (vlsu_vd_eew[1:0] == 2'b10);
assign vlsu_vd_eew64 = (vlsu_vd_eew[1:0] == 2'b11) & elen64;
assign vlsq_enq_ustride = vlsq_enq_ctrl[20];
assign vlsq_enq_useg = vlsq_enq_ustride & (|vlsu_dispatch_ctrl[9 +:3]);
assign vlsq_ustride_op2 = ({7{vlsu_vd_eew8}} & 7'd1) | ({7{vlsu_vd_eew16}} & 7'd2) | ({7{vlsu_vd_eew32}} & 7'd4) | ({7{vlsu_vd_eew64}} & 7'd8);
assign vlsu_zero_element = ({1'b0,vlsu_vstart} >= vlsu_vl);
assign vlsq_enq_op1 = vlsu_dispatch_op1;
assign vlsq_enq_op2 = (vlsu_mop == CONST_STRIDE) ? vlsu_dispatch_op2 : {{XLEN - 7{1'b0}},vlsq_ustride_seg_op2};
assign vlsq_enq_v0t = ({VLEN{vlsu_dispatch_ctrl[38]}} | vlsu_dispatch_v0t);
assign {nds_unused_co5,vlsu_vstart_adj} = {1'b0,vlsu_vstart[ELE_CNT_WIDTH - 1:0]} - {{ELE_CNT_WIDTH{1'b0}},vlsu_vstart[0]};
assign vlsu_vstart_adj_div2 = {1'b0,vlsu_vstart_adj[ELE_CNT_WIDTH - 1:1]};
assign {nds_unused_co6,vlsu_vl_adj} = {2'b0,vlsu_vl[ELE_CNT_WIDTH:1]} + {{ELE_CNT_WIDTH + 1{1'b0}},vlsu_vl[0]};
assign vlsq_enq_vstart = vlsu_zero_element ? {ELE_CNT_WIDTH{1'b0}} : vlsu_vd_eew4 ? vlsu_vstart_adj_div2 : vlsu_vstart[ELE_CNT_WIDTH - 1:0];
assign vlsq_enq_vstart_nf_pre = vlsq_enq_useg ? vlsq_enq_useg_vstart : vlsq_enq_vstart;
assign vlsq_enq_vstart_nf = vlsu_zero_element ? {ELE_CNT_WIDTH{1'b0}} : vlsq_enq_vstart_nf_pre;
assign vlsq_enq_vstart_byte = (vlsu_zero_element | (~vlsq_enq_ustride)) ? {MAX_BYTE_WIDTH{1'b0}} : {1'b0,vlsq_enq_vstart_nf_pre} << vlsu_vd_eew[1:0];
assign vlsq_enq_vstart_eew4_lsb = vlsu_vd_eew4 & vlsu_vstart[0];
assign vlsq_enq_vl_adj = vlsu_vd_eew4 ? vlsu_vl_adj : vlsu_vl[ELE_CNT_WIDTH:0];
assign vlsq_enq_vl_adj_minus1 = vlsq_enq_vl_adj - {{ELE_CNT_WIDTH{1'b0}},1'b1};
assign vlsq_enq_vl = vlsq_enq_vl_adj;
assign vlsq_enq_vl_nf = vlsq_enq_useg ? vlsq_enq_useg_vl : vlsq_enq_vl;
assign vlsq_enq_vl_minus1 = vlsu_zero_element ? {{ELE_CNT_WIDTH{1'b0}},1'b0} : vlsq_enq_vl_adj_minus1;
assign vlsq_enq_vs2_len = vlsu_dispatch_vs2_len;
generate
    if (VLEN / DLEN == 2) begin:gen_enq_vd_emul_len_v2d1
        assign vlsq_enq_vd_emul_len = {vlsu_vd_emul_len,1'b1};
    end
    else begin:gen_enq_vd_emul_len_v1d1
        assign vlsq_enq_vd_emul_len = vlsu_vd_emul_len;
    end
endgenerate
assign vlsu_vd_emul_len = ({3{vlsu_vd_emul_len1}} & 3'd0) | ({3{vlsu_vd_emul_len2}} & 3'd1) | ({3{vlsu_vd_emul_len4}} & 3'd3) | ({3{vlsu_vd_emul_len8}} & 3'd7);
assign vlsu_vd_emul_len1 = (vlsu_vd_emul == 3'b000) | (vlsu_vd_emul == 3'b111) | (vlsu_vd_emul == 3'b110) | (vlsu_vd_emul == 3'b101);
assign vlsu_vd_emul_len2 = (vlsu_vd_emul == 3'b001);
assign vlsu_vd_emul_len4 = (vlsu_vd_emul == 3'b010);
assign vlsu_vd_emul_len8 = (vlsu_vd_emul == 3'b011);
assign vlsu_vd_emul = vlsu_dispatch_ctrl[24 +:3];
assign vlsu_mop = vlsu_dispatch_ctrl[5 +:2];
assign vlsu_vstart = vlsu_dispatch_ctrl[44 +:10];
assign vlsu_vl = vlsu_dispatch_ctrl[27 +:11];
assign vlsu_vm = ~vlsu_zero_element & (vlsu_dispatch_ctrl[38] | (&vlsu_dispatch_v0t));
assign vlsu_nf = vlsu_dispatch_ctrl[9 +:3];
assign vlsu_buf_ill = (vlsu_vd_emul_len2 & (vlsu_nf > 3'd3)) | (vlsu_vd_emul_len4 & (vlsu_nf > 3'd1)) | (vlsu_vd_emul_len8 & (vlsu_nf > 3'd0));
assign vlsq_deq_ptr_en = |(vlsq_ent_deq_valid & vlsq_deq_ptr);
assign vlsbuf_kill_sel = {BUF_DEPTH{vlsq_deq_kill_buf}} & kill_buf_ptr;
assign vlsq_cmt_ptr_en = vlsu_cmt_grant;
assign vlsq_cmt_sel = {VLSQ_DEPTH{vlsu_cmt_valid}} & vlsq_cmt_ptr;
assign vlsq_cmt_kill = vlsu_cmt_kill;
assign vlsu_cmt_grant = vlsu_cmt_valid;
assign vlsq_ack_ptr_en = vlsu_ack_valid;
assign vlsq_req_sel_en = vlsq_req_grant | vlsq_skip;
assign vlsq_req_sel = {VLSQ_DEPTH{vlsq_req_sel_en}} & vlsq_req_ptr;
assign vlsq_inst_req_mark_sel = {VLSQ_DEPTH{vlsq_req_ptr_en}} & vlsq_req_ptr;
assign vlsq_resp_sel_en = vlsq_req_grant & vlsq_xcpt_check_en;
assign vlsq_resp_sel = {VLSQ_DEPTH{vlsq_resp_sel_en}} & vlsq_req_ptr;
assign vlsq_req_vs2_kill = vlsq_indexed & (vlsq_vs2_skip | vlsq_skip);
assign vlsq_vs2_eew = vlsq_ctrl[25 +:2];
assign vlsq_vs2_eew8 = (vlsq_vs2_eew == 2'b00);
assign vlsq_vs2_eew16 = (vlsq_vs2_eew == 2'b01);
assign vlsq_vs2_eew32 = (vlsq_vs2_eew == 2'b10);
assign vlsq_vs2_eew64 = (vlsq_vs2_eew == 2'b11) & elen64;
assign vlsq_vs2_eew_onehot = {vlsq_vs2_eew64,vlsq_vs2_eew32,vlsq_vs2_eew16,vlsq_vs2_eew8};
assign vlsq_req_vs2_ptr = 1'b1;
assign vlsq_req_vs2_shift_valid = vlsq_req_vs2_rgrant & (vlsq_req_in_4k_grant | ~vlsq_va_ready);
assign vlsq_req_vs2_shift_value = vlsq_vs2_eew;
assign vlsq_vd_beat_cnt_eew8 = vlsq_req_element[SEW8_DLEN_WIDTH +:VRF_LW];
assign vlsq_vd_beat_cnt_eew16 = vlsq_req_element[SEW16_DLEN_WIDTH +:VRF_LW];
assign vlsq_vd_beat_cnt_eew32 = vlsq_req_element[SEW32_DLEN_WIDTH +:VRF_LW];
assign vlsq_vd_beat_cnt_eew64 = vlsq_req_element[SEW64_DLEN_WIDTH +:VRF_LW];
assign vlsq_vd_beat_cnt = ({VRF_LW{vlsq_vd_eew8}} & vlsq_vd_beat_cnt_eew8) | ({VRF_LW{vlsq_vd_eew16}} & vlsq_vd_beat_cnt_eew16) | ({VRF_LW{vlsq_vd_eew32}} & vlsq_vd_beat_cnt_eew32) | ({VRF_LW{vlsq_vd_eew64}} & vlsq_vd_beat_cnt_eew64);
assign vlsq_req_ptr_en = ~vlsq_inst_req_mark & (vlsq_req_ustride_last | vlsq_req_strided_last | vlsq_req_indexed_last | vlsq_skip);
assign vlsq_vs2_done_valid = vlsq_indexed & (vlsu_vs2_rgrant_last | vlsq_vs2_skip);
assign vlsu_vs2_rgrant_last = vlsu_vs2_rgrant & vlsu_vs2_rlast;
assign vlsq_req_ctrl = vlsq_ctrl;
assign vlsq_req_vd_emul_len = vlsq_vd_emul_len;
assign vlsq_req_vd_beats = vlsq_vd_beats;
assign vlsq_req_vd_seg_beats = vlsq_vd_seg_beats;
assign vlsq_vd_eew = vlsq_ctrl[22 +:3];
assign vlsq_vd_eew4 = (vlsq_vd_eew[1:0] == 2'b00) & vlsq_vd_eew[2];
assign vlsq_vd_eew8 = (vlsq_vd_eew[1:0] == 2'b00);
assign vlsq_vd_eew16 = (vlsq_vd_eew[1:0] == 2'b01);
assign vlsq_vd_eew32 = (vlsq_vd_eew[1:0] == 2'b10);
assign vlsq_vd_eew64 = (vlsq_vd_eew[1:0] == 2'b11) & elen64;
assign vlsq_vd_eew_onehot = {vlsq_vd_eew64,vlsq_vd_eew32,vlsq_vd_eew16,vlsq_vd_eew8};
assign vlsq_req_cmt_killing = (vlsq_req_ptr == vlsq_cmt_ptr) & vlsu_cmt_valid & vlsu_cmt_kill;
assign vlsq_valid = vlsq_valid_pre & ~vlsq_req_cmt_killing;
assign vlsq_load = vlsq_ctrl[4];
assign vlsq_store = vlsq_ctrl[17];
assign vlsq_fof = vlsq_ctrl[2];
assign vlsq_nf = vlsq_ctrl[9 +:3];
assign vlsq_seg = vlsq_ctrl[15];
assign vlsq_ustride = vlsq_ctrl[20];
assign vlsq_strided = vlsq_ctrl[18];
assign vlsq_indexed = vlsq_ctrl[3];
assign vlsq_element = vlsq_strided | vlsq_indexed;
assign vlsq_useg = vlsq_ustride & vlsq_seg;
assign vlsq_eseg = vlsq_element & vlsq_seg;
assign vlsq_milmb_ien = vlsq_ctrl[6];
assign vlsq_mdlmb_den = vlsq_ctrl[5];
assign vlsq_req_last_grant = vlsq_req_grant & vlsq_req_last;
assign vlsq_req_in_4k_grant = vlsq_req_grant & ~vlsq_req_cross_4k;
assign vlsq_req_cross_4k_d1_kill = vlsq_skip & vlsq_eseg & vlsq_cross_4k_d1;
assign vlsq_req_element_zero = (vlsq_req_element == {ELE_CNT_WIDTH{1'b0}});
assign vlsq_ustride_check_cnt = (vlsq_ustride_second_cmd & ~vlsq_skip) ? {{ELE_CNT_WIDTH - 1{1'b0}},1'b1} : {ELE_CNT_WIDTH{1'b0}};
assign vlsq_enq_check_cnt = vlsq_ustride ? vlsq_ustride_check_cnt : vlsq_req_element_zero ? {ELE_CNT_WIDTH{1'b0}} : vlsq_skip ? vlsq_ele_check_cnt_minus1 : vlsq_ele_check_cnt;
assign vlsq_ele_widen_check_cnt = {1'b0,vlsq_req_element[ELE_CNT_WIDTH - 1:1]};
assign vlsq_ele_check_cnt = vlsq_widen ? vlsq_ele_widen_check_cnt : vlsq_req_element;
assign vlsq_ele_check_cnt_minus1 = vlsq_ele_check_cnt - {{ELE_CNT_WIDTH - 1{1'b0}},1'b1};
assign vlsq2uop_eew = vlsq2uop_ctrl[22 +:3];
assign vlsq2uop_eew8 = (vlsq2uop_eew[1:0] == 2'b00);
assign vlsq2uop_eew16 = (vlsq2uop_eew[1:0] == 2'b01);
assign vlsq2uop_eew32 = (vlsq2uop_eew[1:0] == 2'b10);
assign vlsq2uop_eew64 = (vlsq2uop_eew[1:0] == 2'b11) & elen64;
assign vlsq2uop_enseg = (vlsq2uop_ctrl[18] | vlsq2uop_ctrl[3]) & ~vlsq2uop_ctrl[15];
assign vlsq2uop_enseg_buf_ready = (vlsq2uop_claim_buf_cnt > {1'b0,vlsq2uop_dlen_num});
assign vlsq2uop_buf_ready = vlsq2uop_buf_ready_pre & ((~vlsq2uop_enseg) | (vlsq2uop_enseg & vlsq2uop_enseg_buf_ready));
assign vlsq2uop_cmt_bypass = (vlsq2uop_cmt_ptr == vlsq_cmt_ptr) & vlsu_cmt_valid;
assign vlsq2uop_cmt_valid = vlsq2uop_valid & (((vlsq2uop_cmtted | vlsq2uop_cmt_bypass) & vlsq2uop_buf_ready) | vlsq2uop_cmt_kill);
assign vlsq2uop_cmt_kill = vlsq2uop_killed | (vlsq2uop_cmt_bypass & vlsu_cmt_kill);
assign vlsq2uop_cmt_buf_valid = vlsq2uop_buf_ready;
assign vlsq2uop_cmt_done_sel = {VLSQ_DEPTH{vlsq2uop_cmt_ptr_en}} & vlsq2uop_cmt_ptr;
assign vlsq2uop_cmt_ptr_en = vlsq2uop_cmt_done | vlsq2uop_cmt_skip;
assign vlsq2uop_cmt_done = vlsq2uop_cmt_grant & vlsq2uop_cmt_last;
assign vlsq2uop_cmt_stop = (vlsq2uop_cmt_ptr == vlsq_req_ptr) & vlsq2uop_cmt_grant & vlsq2uop_cmt_kill & (vlsq2uop_check_cnt == {ELE_CNT_WIDTH{1'b0}});
assign vlsq2uop_cmt_last = (vlsq2uop_check_done & (vlsq2uop_cmt_cnt == vlsq2uop_check_cnt)) | vlsq2uop_cmt_stop;
assign vlsq2uop_cmt_cnt_en = vlsq2uop_cmt_grant;
assign vlsq2uop_cmt_cnt_add1 = vlsq2uop_cmt_cnt + {{ELE_CNT_WIDTH - 1{1'b0}},1'b1};
assign vlsq2uop_cmt_cnt_nx = (vlsq2uop_cmt_last | vlsq2uop_cmt_skip) ? {ELE_CNT_WIDTH{1'b0}} : vlsq2uop_cmt_cnt_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2uop_cmt_cnt <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq2uop_cmt_cnt_en) begin
        vlsq2uop_cmt_cnt <= vlsq2uop_cmt_cnt_nx;
    end
end

assign vlsq2uop_widen = vlsq2uop_ctrl[27];
assign vlsq2uop_cmt_cnt_sel = vlsq2uop_widen ? {vlsq2uop_cmt_cnt[ELE_CNT_WIDTH - 2:0],1'b1} : vlsq2uop_cmt_cnt;
assign vlsq2uop_cmt_cnt_nx_sel = vlsq2uop_widen ? {vlsq2uop_cmt_cnt_nx[ELE_CNT_WIDTH - 2:0],1'b1} : vlsq2uop_cmt_cnt_nx;
assign vlsq2uop_dlen_num_normal = ({VRF_LW{vlsq2uop_eew8}} & vlsq2uop_cmt_cnt_sel[SEW8_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew16}} & vlsq2uop_cmt_cnt_sel[SEW16_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew32}} & vlsq2uop_cmt_cnt_sel[SEW32_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew64}} & vlsq2uop_cmt_cnt_sel[SEW64_DLEN_WIDTH +:VRF_LW]);
assign vlsq2uop_dlen_num_normal_nx = ({VRF_LW{vlsq2uop_eew8}} & vlsq2uop_cmt_cnt_nx_sel[SEW8_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew16}} & vlsq2uop_cmt_cnt_nx_sel[SEW16_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew32}} & vlsq2uop_cmt_cnt_nx_sel[SEW32_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2uop_eew64}} & vlsq2uop_cmt_cnt_nx_sel[SEW64_DLEN_WIDTH +:VRF_LW]);
assign vlsq2uop_dlen_num_add1 = vlsq2uop_dlen_num + {{VRF_LW - 1{1'b0}},1'b1};
assign vlsq2uop_dlen_num_inc = (vlsq2uop_xcpted & (vlsq2uop_cmt_cnt_sel >= vlsq2uop_fault_element)) | (vlsq2uop_xcpted & (vlsq2uop_cmt_cnt_sel < vlsq2uop_fault_element) & (vlsq2uop_dlen_num_normal != vlsq2uop_dlen_num_normal_nx)) | (~vlsq2uop_xcpted & (vlsq2uop_dlen_num_normal != vlsq2uop_dlen_num_normal_nx));
assign vlsq2uop_dlen_num_en = vlsq2uop_cmt_grant & (vlsq2uop_cmt_last | vlsq2uop_dlen_num_inc);
assign vlsq2uop_dlen_num_nx = vlsq2uop_cmt_last ? {VRF_LW{1'b0}} : vlsq2uop_dlen_num_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2uop_dlen_num <= {VRF_LW{1'b0}};
    end
    else if (vlsq2uop_dlen_num_en) begin
        vlsq2uop_dlen_num <= vlsq2uop_dlen_num_nx;
    end
end

genvar m;
genvar n;
genvar o;
assign vlsq2buf_eew8_byte_mask = vlsq2buf_eew8_v0t;
generate
    for (m = 0; m < DMLEN / 2; m = m + 1) begin:gen_vlsq2buf_eew16_mask
        assign vlsq2buf_eew16_byte_mask[(m * 2) + 1:m * 2] = {2{vlsq2buf_eew16_v0t[m]}};
    end
endgenerate
generate
    for (n = 0; n < DMLEN / 4; n = n + 1) begin:gen_vlsq2buf_eew32_mask
        assign vlsq2buf_eew32_byte_mask[(n * 4) + 3:n * 4] = {4{vlsq2buf_eew32_v0t[n]}};
    end
endgenerate
generate
    for (o = 0; o < DMLEN / 8; o = o + 1) begin:gen_vlsq2buf_eew64_mask
        assign vlsq2buf_eew64_byte_mask[(o * 8) + 7:o * 8] = {8{vlsq2buf_eew64_v0t[o]}};
    end
endgenerate
assign vlsq2buf_req_killing = vlsq2buf_req_valid & (vlsq2buf_req_ptr == vlsq_cmt_ptr) & vlsu_cmt_valid & vlsu_cmt_kill;
assign vlsq2buf_req_kill = vlsq2buf_req_skip | vlsq2buf_req_killing;
assign vlsq2buf_req_vstart = vlsq2buf_vstart;
assign vlsq2buf_fault_element_add1 = {1'b0,vlsq2buf_fault_element} + {{ELE_CNT_WIDTH{1'b0}},1'b1};
assign vlsq2buf_req_keep_vl = (vlsq2buf_xcpted & vlsq2buf_fault_element_zero & vlsq2buf_fault_nf_zero) | ~vlsq2buf_xcpted;
assign vlsq2buf_req_vl_inc = vlsq2buf_xcpted & vlsq2buf_byte_mask_xcpt_nf;
assign vlsq2buf_req_vl = vlsq2buf_req_keep_vl ? vlsq2buf_vl : vlsq2buf_req_vl_inc ? vlsq2buf_fault_element_add1 : vlsq2buf_vd_eew4 ? {2'b0,vlsq2buf_fault_element[ELE_CNT_WIDTH - 1:1]} : {1'b0,vlsq2buf_fault_element};
assign vlsq2buf_req_ptr_en = (vlsq2buf_req_grant & vlsq2buf_req_last) | vlsq2buf_req_kill;
assign vlsq2buf_vstart_byte_remap = vlsq2buf_vstart_remap << vlsq2buf_vd_eew[1:0];
assign vlsq2buf_vl_byte_remap_minus1 = vlsq2buf_vl_byte_remap - {{ELE_DLEN_WIDTH - 1{1'b0}},1'b1};
assign vlsq2buf_vl8_remap = {vlsq2buf_req_vl[SEW8_DLEN_WIDTH - 1:0]};
assign vlsq2buf_vl16_remap = {{ELE_DLEN_WIDTH - SEW16_DLEN_WIDTH{1'b0}},vlsq2buf_req_vl[SEW16_DLEN_WIDTH - 1:0]};
assign vlsq2buf_vl32_remap = {{ELE_DLEN_WIDTH - SEW32_DLEN_WIDTH{1'b0}},vlsq2buf_req_vl[SEW32_DLEN_WIDTH - 1:0]};
assign vlsq2buf_vl64_remap = {{ELE_DLEN_WIDTH - SEW64_DLEN_WIDTH{1'b0}},vlsq2buf_req_vl[SEW64_DLEN_WIDTH - 1:0]};
assign vlsq2buf_vl_remap = ({ELE_DLEN_WIDTH{vlsq2buf_vd_eew8}} & vlsq2buf_vl8_remap) | ({ELE_DLEN_WIDTH{vlsq2buf_vd_eew16}} & vlsq2buf_vl16_remap) | ({ELE_DLEN_WIDTH{vlsq2buf_vd_eew32}} & vlsq2buf_vl32_remap) | ({ELE_DLEN_WIDTH{vlsq2buf_vd_eew64}} & vlsq2buf_vl64_remap);
assign vlsq2buf_vl_byte_remap = vlsq2buf_vl_remap << vlsq2buf_vd_eew[1:0];
assign vlsq2buf_seg = vlsq2buf_ctrl[15];
assign vlsq2buf_widen = vlsq2buf_ctrl[27];
assign vlsq2buf_ustride = vlsq2buf_ctrl[20];
assign vlsq2buf_ustride_nseg = vlsq2buf_ustride & ~vlsq2buf_seg;
assign vlsq2buf_nf = vlsq2buf_ctrl[9 +:3];
assign vlsq2buf_vd_eew = vlsq2buf_ctrl[22 +:3];
assign vlsq2buf_vd_eew4 = (vlsq2buf_vd_eew[1:0] == 2'b00) & vlsq2buf_vd_eew[2];
assign vlsq2buf_vd_eew8 = (vlsq2buf_vd_eew[1:0] == 2'b00);
assign vlsq2buf_vd_eew16 = (vlsq2buf_vd_eew[1:0] == 2'b01);
assign vlsq2buf_vd_eew32 = (vlsq2buf_vd_eew[1:0] == 2'b10);
assign vlsq2buf_vd_eew64 = (vlsq2buf_vd_eew[1:0] == 2'b11) & elen64;
assign vlsq2buf_vd_eew_onehot = {vlsq2buf_vd_eew64,vlsq2buf_vd_eew32,vlsq2buf_vd_eew16,vlsq2buf_vd_eew8};
assign vlsq2buf_req_first = vlsq2buf_emul_len_first & vlsq2buf_nf_first;
assign vlsq2buf_req_last = vlsq2buf_emul_len_last & vlsq2buf_nf_last;
assign vlsq2buf_nf_first = (vlsq2buf_nf_cnt == 3'd0);
assign vlsq2buf_nf_last = (vlsq2buf_nf_cnt == vlsq2buf_nf);
assign vlsq2buf_emul_len_pre = vlsq2buf_beat_cnt < vlsq2buf_vstart_dlen;
assign vlsq2buf_emul_len_vstart = vlsq2buf_beat_cnt == vlsq2buf_vstart_dlen;
assign vlsq2buf_emul_len_first = (vlsq2buf_beat_cnt == {VRF_LW{1'b0}});
assign vlsq2buf_emul_len_last = (vlsq2buf_beat_cnt == vlsq2buf_vd_beats);
assign vlsq2buf_req_alive_last = (vlsq2buf_beat_cnt == vlsq2buf_fault_element_dlen) & vlsq2buf_xcpted;
assign vlsq2buf_req_done_sel = {VLSQ_DEPTH{vlsq2buf_req_ptr_en}} & vlsq2buf_req_ptr;
assign vlsq2buf_beat_cnt_en = vlsq2buf_req_grant | vlsq2buf_req_kill;
assign vlsq2buf_beat_cnt_add1 = vlsq2buf_beat_cnt + {{VRF_LW - 1{1'b0}},1'b1};
assign vlsq2buf_beat_cnt_nx = (vlsq2buf_emul_len_last | vlsq2buf_req_kill) ? {VRF_LW{1'b0}} : vlsq2buf_beat_cnt_add1;
assign vlsq2buf_fault_element_sel = vlsq2buf_vd_eew4 ? {1'b0,vlsq2buf_fault_element[ELE_CNT_WIDTH - 1:1]} : vlsq2buf_fault_element;
assign vlsq2buf_fault_element_minus1 = vlsq2buf_fault_element_sel - {{ELE_CNT_WIDTH - 1{1'b0}},1'b1};
assign vlsq2buf_fault_element_final = vlsq2buf_req_vl_inc ? vlsq2buf_fault_element : vlsq2buf_fault_element_minus1;
assign vlsq2buf_fault_element_dlen = vlsq2buf_fault_element_zero ? {VRF_LW{1'b0}} : ({VRF_LW{vlsq2buf_vd_eew8}} & vlsq2buf_fault_element_final[SEW8_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2buf_vd_eew16}} & vlsq2buf_fault_element_final[SEW16_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2buf_vd_eew32}} & vlsq2buf_fault_element_final[SEW32_DLEN_WIDTH +:VRF_LW]) | ({VRF_LW{vlsq2buf_vd_eew64}} & vlsq2buf_fault_element_final[SEW64_DLEN_WIDTH +:VRF_LW]);
assign vlsq2buf_fault_element_zero = (vlsq2buf_fault_element_sel == vlsq2buf_vstart) & (vlsq2buf_nf_cnt >= vlsq2buf_fault_nf);
assign vlsq2buf_fault_nf_zero = (vlsq2buf_fault_nf == 3'd0);
assign vlsq2buf_fault_dlen_en = vlsq2buf_xcpted & (vlsq2buf_beat_cnt > vlsq2buf_fault_element_dlen);
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2buf_beat_cnt <= {VRF_LW{1'b0}};
    end
    else if (vlsq2buf_beat_cnt_en) begin
        vlsq2buf_beat_cnt <= vlsq2buf_beat_cnt_nx;
    end
end

assign vlsq2buf_nf_cnt_en = (vlsq2buf_req_grant & vlsq2buf_emul_len_last) | vlsq2buf_req_kill;
assign vlsq2buf_nf_cnt_add1 = vlsq2buf_nf_cnt + 3'd1;
assign vlsq2buf_nf_cnt_nx = (vlsq2buf_req_last | vlsq2buf_req_kill) ? 3'd0 : vlsq2buf_nf_cnt_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2buf_nf_cnt <= 3'd0;
    end
    else if (vlsq2buf_nf_cnt_en) begin
        vlsq2buf_nf_cnt <= vlsq2buf_nf_cnt_nx;
    end
end

assign vlsq2buf_v0t_sel_add1 = vlsq2buf_v0t_sel + {{VRF_LW - 1{1'b0}},1'b1};
assign vlsq2buf_v0t_sel = vlsq2buf_v0t_sel_cur;
assign vlsq2buf_v0t_sel_nx = (vlsq2buf_req_kill | vlsq2buf_emul_len_last) ? {VRF_LW{1'b0}} : vlsq2buf_v0t_sel_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2buf_v0t_sel_cur <= {VRF_LW{1'b0}};
    end
    else if (vlsq2buf_beat_cnt_en) begin
        vlsq2buf_v0t_sel_cur <= vlsq2buf_v0t_sel_nx;
    end
end

assign vlsq2buf_v0t_zero_en = vlsq2buf_xcpted & vlsq2buf_fault_element_zero & ((~vlsq2buf_byte_mask_xcpt_nf) | vlsq2buf_fault_nf_zero);
assign vlsq2buf_v0t_final = vlsq2buf_v0t_zero_en ? {VLEN{1'b0}} : vlsq2buf_v0t;
assign vlsq2buf_v0t_byte = ({DMLEN{vlsq2buf_vd_eew8}} & vlsq2buf_eew8_byte_mask) | ({DMLEN{vlsq2buf_vd_eew16}} & vlsq2buf_eew16_byte_mask) | ({DMLEN{vlsq2buf_vd_eew32}} & vlsq2buf_eew32_byte_mask) | ({DMLEN{vlsq2buf_vd_eew64}} & vlsq2buf_eew64_byte_mask);
assign vlsq2buf_hit_same_dlen = (~vlsq2buf_xcpted & (vlsq2buf_vstart_dlen == vlsq2buf_vl_dlen)) | (vlsq2buf_xcpted & (vlsq2buf_vstart_dlen == vlsq2buf_fault_element_dlen));
assign vlsq2buf_v0t_same_dlen = vlsq2buf_v0t_first_dlen & vlsq2buf_v0t_last_dlen;
assign vlsq2buf_byte_mask = (vlsq2buf_fault_dlen_en | vlsq2buf_emul_len_pre) ? {DMLEN{1'b0}} : vlsq2buf_hit_same_dlen ? vlsq2buf_v0t_same_dlen : (vlsq2buf_emul_len_last | vlsq2buf_req_alive_last) ? vlsq2buf_v0t_last_dlen : vlsq2buf_emul_len_vstart ? vlsq2buf_v0t_first_dlen : vlsq2buf_v0t_byte;
assign vlsq2buf_byte_mask_xcpt_nf = vlsq2buf_xcpted & (vlsq2buf_nf_cnt < vlsq2buf_fault_nf);
assign vlsq2buf_req_ready = |(vlsq2buf_req_buf_ptr & ~vlsbuf_ent_mask_ready);
assign vlsq2buf_req_grant = vlsq2buf_req_valid & vlsq2buf_req_ready;
assign vlsq2buf_byte_mask_wptr = {BUF_DEPTH{vlsq2buf_req_grant}} & vlsq2buf_req_buf_ptr;
assign vlsq2buf_req_buf_ptr = vlsq2buf_req_first ? vlsq2buf_start_buf_ptr : vlsq2buf_buf_ptr;
assign vlsq2buf_buf_ptr_en = vlsq2buf_req_grant;
assign vlsq2buf_buf_ptr_revert = vlsq2buf_hvm & vlsq2buf_ustride_nseg & ~vlsq2buf_widen & vlsq2buf_beat_cnt[0];
assign vlsq2buf_buf_ptr_add1 = {vlsq2buf_req_buf_ptr[BUF_DEPTH - 2:0],vlsq2buf_req_buf_ptr[BUF_DEPTH - 1]};
assign vlsq2buf_buf_ptr_sub1 = {vlsq2buf_req_buf_ptr[0],vlsq2buf_req_buf_ptr[BUF_DEPTH - 1:1]};
assign vlsq2buf_buf_ptr_nx = vlsq2buf_buf_ptr_revert ? vlsq2buf_buf_ptr_sub1 : vlsq2buf_buf_ptr_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2buf_buf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (vlsq2buf_buf_ptr_en) begin
        vlsq2buf_buf_ptr <= vlsq2buf_buf_ptr_nx;
    end
end

assign vlsbuf_vs3_wvalid = (vlsu_vs3_rgrant & ~vlsbuf_vs3_wr_dummy);
assign vlsbuf_vs3_wdata = vlsu_vs3_rdata;
assign vlsbuf_vs3_wr_dummy = (vs3_emul_cnt > vlsq2vs3_vd_beats);
assign vlsbuf_vs3_wsel = {BUF_DEPTH{vlsbuf_vs3_wvalid}} & vlsq2vs3_req_buf_ptr;
assign vlsq2vs3_buf_ready_cond = vlsq2vs3_ustride | vlsq2vs3_seg | (vlsq2vs3_element_nseg & (vlsq2vs3_claim_buf_cnt > {1'b0,vs3_emul_cnt}));
assign vlsu_vs3_rready = vlsbuf_vs3_wr_dummy | (vlsq2vs3_rready_pre & vlsq2vs3_buf_ready_cond & (|(vlsq2vs3_req_buf_ptr & ~vlsbuf_ent_occupied)));
assign vlsu_vs3_rgrant = vlsu_vs3_rvalid & vlsu_vs3_rready;
assign vlsq2vs3_req_ptr_en = (~vlsq2vs3_seg & vlsq2vs3_req_last) | (vlsq2vs3_seg & packed_resp_finish) | vlsq2vs3_req_kill;
assign vlsq2vs3_req_first = (vs3_emul_cnt == {VRF_LW{1'b0}}) & (vs3_nf_cnt == 3'd0);
assign vlsq2vs3_req_last = vlsu_vs3_rgrant & vlsu_vs3_rlast;
assign vlsq2vs3_req_killing = vlsq2vs3_rready_pre & (vlsq2vs3_req_ptr == vlsq_cmt_ptr) & vlsu_cmt_valid & vlsu_cmt_kill;
assign vlsq2vs3_req_kill = vlsq2vs3_req_skip | vlsq2vs3_req_killing;
assign vlsq2vs3_req_done_sel = {VLSQ_DEPTH{vlsq2vs3_req_ptr_en}} & vlsq2vs3_req_ptr;
assign vlsq2vs3_seg = vlsq2vs3_ctrl[15];
assign vlsq2vs3_widen = vlsq2vs3_ctrl[27];
assign vlsq2vs3_ustride = vlsq2vs3_ctrl[20];
assign vlsq2vs3_element = vlsq2vs3_ctrl[18] | vlsq2vs3_ctrl[3];
assign vlsq2vs3_ustride_nseg = vlsq2vs3_ustride & ~vlsq2vs3_seg;
assign vlsq2vs3_element_nseg = vlsq2vs3_element & ~vlsq2vs3_seg;
assign vlsq2vs3_eew = vlsq2vs3_ctrl[22 +:3];
assign vlsq2vs3_eew8 = (vlsq2vs3_eew[1:0] == 2'b00);
assign vlsq2vs3_eew16 = (vlsq2vs3_eew[1:0] == 2'b01);
assign vlsq2vs3_eew32 = (vlsq2vs3_eew[1:0] == 2'b10);
assign vlsq2vs3_eew64 = (vlsq2vs3_eew[1:0] == 2'b11) & elen64;
assign vlsq2vs3_req_buf_ptr = vlsq2vs3_req_first ? vlsq2vs3_start_buf_ptr : vlsq2vs3_buf_ptr;
assign vlsq2vs3_buf_ptr_en = vlsu_vs3_rgrant & ~vlsbuf_vs3_wr_dummy;
assign vlsq2vs3_buf_ptr_revert = vlsq2vs3_hvm & vlsq2vs3_ustride_nseg & ~vlsq2vs3_widen & vs3_emul_cnt[0];
assign vlsq2vs3_buf_ptr_add1 = {vlsq2vs3_req_buf_ptr[BUF_DEPTH - 2:0],vlsq2vs3_req_buf_ptr[BUF_DEPTH - 1]};
assign vlsq2vs3_buf_ptr_sub1 = {vlsq2vs3_req_buf_ptr[0],vlsq2vs3_req_buf_ptr[BUF_DEPTH - 1:1]};
assign vlsq2vs3_buf_ptr_nx = vlsq2vs3_buf_ptr_revert ? vlsq2vs3_buf_ptr_sub1 : vlsq2vs3_buf_ptr_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq2vs3_buf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (vlsq2vs3_buf_ptr_en) begin
        vlsq2vs3_buf_ptr <= vlsq2vs3_buf_ptr_nx;
    end
end

assign vs3_emul_rlast = (vs3_emul_cnt == vlsq2vs3_vd_emul_len);
assign vs3_emul_cnt_en = vlsu_vs3_rgrant | vlsq2vs3_req_kill;
assign vs3_emul_cnt_nx = (vs3_emul_rlast | vlsu_vs3_rlast | vlsq2vs3_req_kill) ? {VRF_LW{1'b0}} : vs3_emul_cnt + {{VRF_LW - 1{1'b0}},1'b1};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs3_emul_cnt <= {VRF_LW{1'b0}};
    end
    else if (vs3_emul_cnt_en) begin
        vs3_emul_cnt <= vs3_emul_cnt_nx;
    end
end

assign vs3_nf_cnt_en = (vlsu_vs3_rgrant & vs3_emul_rlast) | (vlsu_vs3_rgrant & vlsu_vs3_rlast) | vlsq2vs3_req_kill;
assign vs3_nf_cnt_nx = (vlsu_vs3_rlast | vlsq2vs3_req_kill) ? 3'd0 : vs3_nf_cnt + 3'd1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vs3_nf_cnt <= 3'd0;
    end
    else if (vs3_nf_cnt_en) begin
        vs3_nf_cnt <= vs3_nf_cnt_nx;
    end
end

assign packed_ctrl[1 +:3] = vlsq2vs3_ctrl[9 +:3];
assign packed_ctrl[4] = vlsq2vs3_ctrl[20] & vlsq2vs3_ctrl[15];
assign packed_ctrl[0] = (vlsq2vs3_ctrl[18] | vlsq2vs3_ctrl[3]) & vlsq2vs3_ctrl[15];
assign packed_ctrl[5 +:2] = vlsq2vs3_eew[1:0];
assign packed_ctrl[7 +:4] = {vlsq2vs3_eew64,vlsq2vs3_eew32,vlsq2vs3_eew16,vlsq2vs3_eew8};
assign packed_vd_beats = vlsq2vs3_vd_beats;
assign packed_start_buf_ptr = vlsq2vs3_start_buf_ptr;
assign packed_vl_minus1 = vlsq2vs3_vl_minus1;
assign packed_req_trig = (vlsq2vs3_seg & vlsq2vs3_req_last) & ~vlsq2vs3_req_kill;
assign packed_req_en = packed_req_trig | packed_req_pending;
assign packed_req_kill = vlsq2vs3_req_kill;
assign packed_req_pending_en = packed_req_trig | packed_resp_finish | vlsq2vs3_req_kill;
assign packed_req_pending_nx = packed_req_trig;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        packed_req_pending <= 1'b0;
    end
    else if (packed_req_pending_en) begin
        packed_req_pending <= packed_req_pending_nx;
    end
end

assign claim_buf_num = claim_buf_resp_num;
assign claim_buf_kill = claim_buf_skip | claim_buf_killing;
assign claim_buf_killing = claim_buf_valid & (vlsq_cmt_ptr == vlsq_claim_ptr) & vlsu_cmt_valid & vlsu_cmt_kill;
assign claim_vbuf_valid = claim_buf_valid & ~claim_buf_killing;
assign claim_vbuf_grant = claim_vbuf_valid & claim_vbuf_ready;
assign claim_vbuf_ready_sel = {VLSQ_DEPTH{claim_vbuf_ready}} & vlsq_claim_ptr;
assign vlsq_claim_ptr_en = (claim_vbuf_grant & claim_buf_last) | claim_buf_kill;
assign claim_buf_mark_sel = {VLSQ_DEPTH{vlsq_claim_ptr_en}} & vlsq_claim_ptr;
generate
    if (BUF_DEPTH_LOG2 == VRF_LW) begin:gen_claim_vbuf_size_v1
        assign claim_vbuf_size = claim_buf_size;
    end
    else begin:gen_claim_vbuf_size_v2
        assign claim_vbuf_size = {{BUF_DEPTH_LOG2 - VRF_LW{1'b0}},claim_buf_size};
    end
endgenerate
assign claim_buf_num_add1 = claim_buf_num + {{BUF_DEPTH_LOG2 - 1{1'b0}},1'b1};
assign claim_vbuf_cnt_init = claim_buf_vd_seg_beats[VRF_LW - 1:1];
assign {nds_unused_co7,claim_vbuf_cnt_last} = {1'b0,claim_buf_vd_seg_beats[VRF_LW - 1:1]} - {{BUF_UCNT_WIDTH{1'b0}},~claim_buf_vd_seg_beats[0]};
assign claim_vbuf_cnt = claim_buf_adj ? claim_vbuf_cnt_adj : {BUF_DEPTH * BUF_UCNT_WIDTH{1'b0}};
generate
    if (BUF_DEPTH == 8) begin:gen_vbuf8_cnt
        always @* begin
            claim_vbuf_cnt_adj = {BUF_DEPTH{claim_vbuf_cnt_init}};
            case (claim_buf_num_add1)
                3'd0: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 0 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd1: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 1 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd2: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 2 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd3: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 3 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd4: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 4 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd5: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 5 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd6: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 6 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                3'd7: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 7 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                default: begin
                    claim_vbuf_cnt_adj = {BUF_UCNT_WIDTH * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 16) begin:gen_vbuf16_cnt
        always @* begin
            claim_vbuf_cnt_adj = {BUF_DEPTH{claim_vbuf_cnt_init}};
            case (claim_buf_num_add1)
                4'd0: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 0 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd1: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 1 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd2: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 2 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd3: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 3 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd4: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 4 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd5: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 5 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd6: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 6 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd7: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 7 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd8: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 8 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd9: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 9 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd10: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 10 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd11: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 11 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd12: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 12 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd13: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 13 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd14: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 14 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                4'd15: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 15 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                default: begin
                    claim_vbuf_cnt_adj = {BUF_UCNT_WIDTH * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 32) begin:gen_vbuf32_cnt
        always @* begin
            claim_vbuf_cnt_adj = {BUF_DEPTH{claim_vbuf_cnt_init}};
            case (claim_buf_num_add1)
                5'd0: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 0 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd1: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 1 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd2: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 2 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd3: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 3 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd4: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 4 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd5: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 5 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd6: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 6 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd7: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 7 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd8: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 8 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd9: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 9 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd10: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 10 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd11: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 11 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd12: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 12 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd13: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 13 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd14: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 14 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd15: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 15 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd16: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 16 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd17: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 17 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd18: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 18 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd19: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 19 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd20: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 20 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd21: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 21 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd22: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 22 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd23: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 23 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd24: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 24 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd25: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 25 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd26: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 26 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd27: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 27 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd28: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 28 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd29: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 29 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd30: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 30 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                5'd31: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 31 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                default: begin
                    claim_vbuf_cnt_adj = {BUF_UCNT_WIDTH * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 64) begin:gen_vbuf64_cnt
        always @* begin
            claim_vbuf_cnt_adj = {BUF_DEPTH{claim_vbuf_cnt_init}};
            case (claim_buf_num_add1)
                6'd0: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 0 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd1: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 1 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd2: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 2 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd3: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 3 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd4: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 4 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd5: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 5 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd6: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 6 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd7: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 7 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd8: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 8 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd9: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 9 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd10: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 10 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd11: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 11 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd12: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 12 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd13: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 13 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd14: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 14 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd15: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 15 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd16: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 16 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd17: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 17 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd18: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 18 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd19: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 19 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd20: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 20 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd21: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 21 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd22: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 22 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd23: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 23 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd24: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 24 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd25: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 25 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd26: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 26 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd27: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 27 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd28: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 28 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd29: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 29 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd30: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 30 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd31: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 31 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd32: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 32 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd33: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 33 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd34: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 34 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd35: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 35 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd36: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 36 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd37: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 37 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd38: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 38 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd39: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 39 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd40: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 40 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd41: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 41 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd42: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 42 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd43: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 43 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd44: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 44 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd45: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 45 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd46: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 46 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd47: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 47 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd48: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 48 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd49: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 49 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd50: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 50 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd51: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 51 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd52: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 52 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd53: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 53 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd54: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 54 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd55: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 55 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd56: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 56 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd57: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 57 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd58: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 58 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd59: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 59 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd60: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 60 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd61: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 61 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd62: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 62 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                6'd63: claim_vbuf_cnt_adj[BUF_UCNT_WIDTH * 63 +:BUF_UCNT_WIDTH] = claim_vbuf_cnt_last;
                default: begin
                    claim_vbuf_cnt_adj = {BUF_UCNT_WIDTH * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
endgenerate
kv_vls_total_element_num #(
    .POWER2(0),
    .ELEN(ELEN),
    .ELE_NUM_WIDTH(ELE_DLEN_WIDTH),
    .WIDTH(DLEN)
) u_vls_vs2_total_element_num_dlen (
    .eew_onehot({1'b0,vlsq_vs2_eew_onehot}),
    .total_element_num(cur_vs2_element_num_dlen)
);
kv_vls_total_element_num #(
    .POWER2(0),
    .ELEN(ELEN),
    .ELE_NUM_WIDTH(ELE_DLEN_WIDTH),
    .WIDTH(DLEN)
) u_vls_vd_total_element_num_dlen (
    .eew_onehot({1'b0,vlsq_vd_eew_onehot}),
    .total_element_num(cur_vd_element_num_dlen)
);
kv_vls_element_remap #(
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH)
) u_vlsq_vs2_element_num_dlen (
    .element_num(vlsq_vs2_element[ELE_CNT_WIDTH - 1:0]),
    .eew_onehot(vlsq_vs2_eew_onehot),
    .element_num_remap(vlsq_vs2_element_num_dlen)
);
assign vlsq_vs2_cmd_valid = vlsq_indexed & (vlsq_req_in_4k_grant | ~vlsq_vs2_addr_valid);
assign vlsq_vs2_dlen_last = vlsq_req_vs2_rgrant & ((vlsq_vs2_element_num_dlen == cur_vs2_element_num_dlen) | vlsq_vs2_last);
assign vlsq_xcpt_vs2_dlen_last = (vlsq_indexed & vlsq_resp_xcpt_trig) | (vlsq_indexed & vlsq_xcpted);
assign vlsq_req_vs2_dlen_last = (vlsq_vs2_cmd_valid & vlsq_vs2_dlen_last) | vlsq_xcpt_vs2_dlen_last;
assign vlsq_vs2_element_en = vlsq_indexed & ((vlsq_req_vs2_rgrant & vlsq_vs2_cmd_valid & ~vlsq_xcpted) | vlsq_skip | vlsq_resp_xcpt_trig);
assign vlsq_vs2_last = (vlsq_vs2_element == vlsq_vl_minus1);
assign vlsq_vs2_element_add1 = vlsq_vs2_element + {{ELE_CNT_WIDTH - 1{1'b0}},1'b1};
assign vlsq_vs2_element_nx = (vlsq_vs2_last | vlsq_skip | vlsq_resp_xcpt_trig) ? {ELE_CNT_WIDTH{1'b0}} : vlsq_vs2_element_add1;
assign vlsq_resp_xcpt_trig = vlsq_req_grant & vlsq_resp_xcpt;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_vs2_element <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq_vs2_element_en) begin
        vlsq_vs2_element <= vlsq_vs2_element_nx;
    end
end

assign vlsq_vs2_dummy_rready_set0 = (vlsq_req_vs2_rgrant & vlsq_vs2_last);
assign vlsq_vs2_dummy_rready_set1 = (vlsq_xcpted | vlsq_resp_xcpt_trig);
assign vlsq_vs2_dummy_rready_set = (vlsq_vs2_dummy_rready_set0 | vlsq_vs2_dummy_rready_set1) & vlsq_vs2_cmd_valid & ~vlsq_vs2_done_valid & ~vlsq_vs2_done & ~vlsq_vs2_dummy_rready;
assign vlsq_vs2_dummy_rready_clr = vlsq_vs2_dummy_rready & ((vlsu_vs2_rgrant & vlsu_vs2_rlast) | vlsq_vs2_skip);
assign vlsq_vs2_dummy_rready_en = vlsq_vs2_dummy_rready_set | vlsq_vs2_dummy_rready_clr;
assign vlsq_vs2_dummy_rready_nx = vlsq_vs2_dummy_rready_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_vs2_dummy_rready <= 1'b0;
    end
    else if (vlsq_vs2_dummy_rready_en) begin
        vlsq_vs2_dummy_rready <= vlsq_vs2_dummy_rready_nx;
    end
end

assign vlsu_vs2_rready = vlsq_vs2_accept & vs2q_not_full;
assign vlsu_vs2_rgrant = vlsu_vs2_rvalid & vlsu_vs2_rready;
assign vlsq_vs2_accept = (vlsq_valid | vlsq_vs2_dummy_rready) & vlsq_indexed & ~vlsq_vs2_done;
assign vlsq_req_vs2_rvalid = vlsq_valid & vlsq_indexed;
assign vlsq_req_vs2_rgrant = vlsq_req_vs2_rvalid & vlsq_req_vs2_rready;
assign vlsq_vs2_addr_valid_set = ~vlsq_vs2_addr_valid & vlsq_req_vs2_rgrant & ~vlsq_xcpted;
assign vlsq_vs2_addr_valid_clr = vlsq_vs2_addr_valid & (vlsq_skip | (vlsq_req_in_4k_grant & (~vlsq_req_vs2_rgrant | vlsq_resp_xcpt)));
assign vlsq_vs2_addr_valid_en = vlsq_indexed & (vlsq_vs2_addr_valid_set | vlsq_vs2_addr_valid_clr);
assign vlsq_vs2_addr_valid_nx = vlsq_vs2_addr_valid_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_vs2_addr_valid <= 1'b0;
    end
    else if (vlsq_vs2_addr_valid_en) begin
        vlsq_vs2_addr_valid <= vlsq_vs2_addr_valid_nx;
    end
end

kv_vls_cross_check #(
    .ADDR_WIDTH(XLEN),
    .BYTE_WIDTH(MAX_BYTE_WIDTH),
    .CROSS_BIT(FOURK_OFFSET_WIDTH)
) u_kv_vls_cross_4k (
    .check_en(vlsq_cross_check_en),
    .addr(vlsq_req_xlen_addr),
    .access_bytes(vlsq_total_check_byte),
    .addr_cross_nx(vlsq_req_cross_addr_nx),
    .remaining_byte(vlsq_remain_byte_nx),
    .avaliable_byte(vlsq_avaliable_byte),
    .cross_en(vlsq_req_cross_4k)
);
kv_vls_cross_check #(
    .ADDR_WIDTH(XLEN),
    .BYTE_WIDTH(MAX_BYTE_WIDTH),
    .CROSS_BIT(FOURK_OFFSET_WIDTH)
) u_kv_vls_cross_4k_vstart (
    .check_en(vlsq_cross_check_en),
    .addr(vlsq_op1),
    .access_bytes(vlsq_vl_byte),
    .addr_cross_nx(nds_unused_vlsq_req_cross_addr_nx),
    .remaining_byte(nds_unused_vlsq_remain_byte_nx),
    .avaliable_byte(vlsq_avaliable_byte_vstart),
    .cross_en(nds_unused_vlsq_req_cross_4k)
);
kv_vagu #(
    .XLEN(XLEN)
) u_vagu (
    .addr_op0(vlsq_base_sel),
    .addr_op1(vlsq_offset),
    .addr_out(vlsq_addr_out)
);
assign vlsq_vstart_byte_sel = vlsq_widen ? {1'b0,vlsq_vstart_byte[MAX_BYTE_WIDTH - 1:1]} : vlsq_vstart_byte;
assign vlsq_ustride_offset = vlsq_prestart ? {{XLEN - MAX_BYTE_WIDTH{1'b0}},vlsq_vstart_byte_sel} : {{XLEN - MAX_BYTE_WIDTH{1'b0}},vlsq_remain_byte};
assign vlsq_strided_offset = vlsq_op2;
assign vlsq_indexed_offset = ({XLEN{vlsq_vs2_eew8}} & vlsq_vs2_addr_eew8_zext) | ({XLEN{vlsq_vs2_eew16}} & vlsq_vs2_addr_eew16_zext) | ({XLEN{vlsq_vs2_eew32}} & vlsq_vs2_addr_eew32_zext) | ({XLEN{vlsq_vs2_eew64 & elen64}} & vlsq_vs2_addr_eew64);
assign vlsq_vs2_addr_eew8 = vlsq_req_vs2_addr[7:0];
assign vlsq_vs2_addr_eew16 = vlsq_req_vs2_addr[15:0];
assign vlsq_vs2_addr_eew32 = vlsq_req_vs2_addr[31:0];
assign vlsq_vs2_addr_eew64 = vlsq_req_vs2_addr[63:0];
assign vlsq_req_ustride_last = vlsq_ustride & vlsq_req_last_grant;
assign vlsq_req_strided_last = vlsq_strided & vlsq_req_last_grant;
assign vlsq_req_indexed_last = vlsq_indexed & (vlsq_req_last_grant | vlsq_req_done) & (vlsq_vs2_done | (vlsu_vs2_rgrant & vlsu_vs2_rlast));
assign vlsq_vstart_nf_sel = vlsq_widen ? {vlsq_vstart_nf[ELE_CNT_WIDTH - 1:1],1'b0} : vlsq_vstart_nf[ELE_CNT_WIDTH - 1:0];
assign vlsq_prestart = (vlsq_req_element < vlsq_vstart_nf_sel);
assign vlsq_body = (vlsq_req_element >= vlsq_vstart_nf_sel) & ({1'b0,vlsq_req_element} < vlsq_vl_nf);
assign vlsq_req_first = (vlsq_element & vlsq_req_element_zero) | (vlsq_ustride & ~vlsq_cross_4k_d1);
assign vlsq_ele_rvv_last = (~vlsq_widen & (vlsq_req_element == vlsq_vl_minus1));
assign vlsq_ele_widen_last = (vlsq_widen & (vlsq_req_element[ELE_CNT_WIDTH - 1:1] == vlsq_vl_minus1[ELE_CNT_WIDTH - 1:1]));
assign vlsq_ele_last = vlsq_ele_rvv_last | vlsq_ele_widen_last;
assign vlsq_req_last = ~vlsq_req_cross_4k & ((vlsq_element & (vlsq_ele_last | vlsq_req_xcpt_last)) | (vlsq_ustride & vlsq_body));
assign vlsq_offset = ({XLEN{vlsq_ustride}} & vlsq_ustride_offset) | ({XLEN{vlsq_strided}} & vlsq_strided_offset) | ({XLEN{vlsq_indexed}} & vlsq_indexed_offset);
assign vlsq_vl_widen = {1'b0,vlsq_vl[ELE_CNT_WIDTH:1]} + {{ELE_CNT_WIDTH{1'b0}},vlsq_vl[0]};
assign vlsq_nf_add1 = vlsq_nf + 3'b1;
assign vlsq_vl_sel = vlsq_element ? {{ELE_CNT_WIDTH + 1 - 4{1'b0}},vlsq_nf_add1} : vlsq_widen ? vlsq_vl_widen : vlsq_vl_nf;
assign vlsq_vl_byte = vlsq_vl_sel << vlsq_vd_eew[1:0];
assign {nds_unused_co8,vlsq_total_check_byte} = vlsq_vl_byte - vlsq_vstart_byte_sel;
assign vlsq_va_ready = vlsq_valid & ((vlsq_indexed & vlsq_vs2_addr_valid) | vlsq_strided | (vlsq_ustride & vlsq_body));
assign vlsq_xcpt_check_pre = vlsq_ewiden ? vlsq_widen_alive_cond : vlsq_alive;
assign vlsq_xcpt_check_en = vlsq_body & vlsq_xcpt_check_pre;
assign vlsq_cross_check_en = vlsq_xcpt_check_en & ~vlsq_addr_misalign;
assign vlsq_base_sel = (vlsq_req_element_zero | vlsq_indexed) ? vlsq_op1 : vlsq_addr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_remain_byte <= {MAX_BYTE_WIDTH{1'b0}};
    end
    else if (vlsq_req_cross_4k) begin
        vlsq_remain_byte <= vlsq_remain_byte_nx;
    end
end

assign vlsq_req_addr = (vlsq_indexed | ~vlsq_req_element_zero) ? vlsq_addr : vlsq_op1;
assign vlsq_req_xlen_addr = vlsq_cross_4k_d1 ? vlsq_cross_4k_addr : vlsq_req_addr;
assign vlsq_addr_en = vlsq_req_in_4k_grant | vlsq_vs2_addr_valid_set | vlsq_ustride_prestart_valid;
assign vlsq_addr_nx = vlsq_addr_out;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_addr <= {XLEN{1'b0}};
    end
    else if (vlsq_addr_en) begin
        vlsq_addr <= vlsq_addr_nx;
    end
end

assign vlsq_cross_4k_d1_nx = vlsq_skip ? 1'b0 : vlsq_req_cross_4k;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_cross_4k_d1 <= 1'b0;
        vlsq_cross_4k_addr <= {XLEN{1'b0}};
    end
    else if (vlsq_req_sel_en) begin
        vlsq_cross_4k_d1 <= vlsq_cross_4k_d1_nx;
        vlsq_cross_4k_addr <= vlsq_req_cross_addr_nx;
    end
end

assign vlsq_ustride_prestart_valid = vlsq_valid & vlsq_ustride & vlsq_prestart;
assign vlsq_useg_prestart_valid = vlsq_valid & vlsq_ustride & vlsq_prestart & vlsq_seg;
assign vlsq_ustride_second_cmd = vlsq_ustride & vlsq_cross_4k_d1;
assign vlsq_req_byte = vlsq_cross_4k_d1 ? vlsq_remain_byte : vlsq_req_cross_4k ? vlsq_ustride ? vlsq_avaliable_byte_vstart : vlsq_avaliable_byte : vlsq_ustride ? vlsq_vl_byte : vlsq_total_check_byte;
assign vlsq_req_total_byte = vlsq_vl_byte;
assign vlsq_req_element_en = (vlsq_element & vlsq_req_in_4k_grant) | (vlsq_ustride & vlsq_req_grant) | vlsq_ustride_prestart_valid | vlsq_skip;
assign vlsq_req_byte2element = (vlsq_avaliable_byte >> vlsq_vd_eew[1:0]);
assign vlsq_req_element_offset = vlsq_ustride_prestart_valid ? vlsq_vstart_nf : (vlsq_element & vlsq_widen) ? {{ELE_CNT_WIDTH - 2{1'b0}},2'd2} : (vlsq_element & ~vlsq_widen) ? {{ELE_CNT_WIDTH - 1{1'b0}},1'd1} : (vlsq_ustride & vlsq_widen) ? {vlsq_req_byte2element[ELE_CNT_WIDTH - 2:0],1'b0} : vlsq_req_byte2element[ELE_CNT_WIDTH - 1:0];
assign vlsq_req_element_sel = (vlsq_ustride & vlsq_widen) ? {vlsq_req_element[ELE_CNT_WIDTH - 1:1],1'b0} : vlsq_req_element;
assign {nds_unused_co1,vlsq_req_element_add} = vlsq_req_element_sel + vlsq_req_element_offset;
assign vlsq_req_element_nx = (vlsq_req_last | vlsq_skip) ? {ELE_CNT_WIDTH{1'b0}} : vlsq_req_element_add;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_req_element <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq_req_element_en) begin
        vlsq_req_element <= vlsq_req_element_nx;
    end
end

assign vlsq_req_valid = vlsq2vtlb_req_grant | (vlsq_va_ready & ~vlsq_xcpt_check_en) | (vlsq_va_ready & vlsq_bad_va) | (vlsq_valid & vlsq_xcpted);
assign vlsq_req_grant = vlsq_req_valid & vlsq_req_ready;
assign vlsq_req_alive = vlsq_body & vlsq_alive_sel & ~vlsq_resp_xcpt;
assign vlsq_req_rvv_dlen_last = ~vlsq_widen & ((vlsq_element_num_dlen == cur_vd_element_num_dlen) | vlsq_ele_rvv_last);
assign vlsq_req_widen_dlen_last = vlsq_widen & ((vlsq_element_num_dlen[ELE_DLEN_WIDTH - 1:1] == cur_vd_element_num_dlen[ELE_DLEN_WIDTH - 1:1]) | vlsq_ele_widen_last);
assign vlsq_req_dlen_last = vlsq_element & (vlsq_req_rvv_dlen_last | vlsq_req_widen_dlen_last | vlsq_xcpt_dlen_last);
assign vlsq_req_widen_alive = vlsq_body & vlsq_widen_alive_with_vl & ~vlsq_resp_xcpt;
assign vlsq_alive_sel = vlsq_ewiden ? vlsq_alive_with_vstart : vlsq_alive;
assign vlsq_widen_first = vlsq_req_element[ELE_CNT_WIDTH - 1:1] == vlsq_vstart[ELE_CNT_WIDTH - 1:1];
assign vlsq_widen_last = vlsq_req_element[ELE_CNT_WIDTH - 1:1] == vlsq_vl_minus1[ELE_CNT_WIDTH - 1:1];
assign vlsq_alive_with_vstart = (vlsq_widen_first & vlsq_alive & (~vlsq_vstart[0])) | (~vlsq_widen_first & vlsq_alive);
assign vlsq_widen_alive_with_vl = (vlsq_widen_last & vlsq_widen_alive & vlsq_vl_minus1[0]) | (~vlsq_widen_last & vlsq_widen_alive);
assign vlsq_widen_alive_cond = vlsq_widen_alive_with_vl | vlsq_alive_with_vstart;
assign vlsq_req_element_num_dlen = vlsq_xcpted ? {ELE_DLEN_WIDTH{1'b0}} : vlsq_element_num_dlen;
assign vlsq_va2pa_en = vlsq_req_ctrl[21];
assign vlsq_sv39 = vlsq_req_ctrl[19];
assign vlsq_mstatus_mxr = vlsq_req_ctrl[7];
assign vlsq_mstatus_sum = vlsq_req_ctrl[8];
assign vlsq2vtlb_cmt_valid = vlsq_cmtted | ((vlsq_req_ptr == vlsq_cmt_ptr) & vlsu_cmt_valid);
assign vlsq2vtlb_cmt_kill = vlsq_killed | ((vlsq_req_ptr == vlsq_cmt_ptr) & vlsu_cmt_kill);
assign vlsq2vtlb_req_valid = vlsq_va_ready & vlsq_xcpt_check_en & ~vlsq_bad_va;
assign vlsq2vtlb_req_grant = (vlsq2vtlb_req_valid & vlsq2vtlb_req_ready);
assign vlsq2vtlb_req_va = vlsq_req_xlen_addr[VALEN - 1:0];
assign vlsq2vtlb_req_va2pa_en = (MMU_SCHEME_INT != 0) & vlsq_va2pa_en;
assign vlsq_pa_mask = vlsq_addr_misalign ? (({3{vlsq_vd_eew16}} & 3'b110) | ({3{vlsq_vd_eew32}} & 3'b100) | ({3{vlsq_vd_eew64}} & 3'b000)) : 3'b111;
assign vlsq_req_pa = vlsq2vtlb_resp_pa & {{PALEN - 3{1'b1}},vlsq_pa_mask};
assign vlsq_req_prestart_cross = vlsq_op1[VALEN - 1:12] != vlsq2vtlb_req_va[VALEN - 1:12];
assign vlsq_req_base_offset = vlsq_op1[11:0] & {{12 - 3{1'b1}},vlsq_pa_mask};
assign vlsq_req_vstart_byte = vlsq_cross_4k_d1 ? {MAX_BYTE_WIDTH{1'b0}} : vlsq_vstart_byte_sel;
assign vlsq_req_mtype = vlsq2vtlb_resp_pma_mtype;
assign vlsq_req_shareable = ~vlsq2vtlb_resp_pma_nosh;
assign vlsq_req_cross_4k_d1 = vlsq_cross_4k_d1;
assign vlsq_req_hvm = mtype_check_valid ? hvm_check_data : vlsq_hit_hvm;
assign vlsq2vtlb_req_priv_u = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_USER);
assign vlsq2vtlb_req_priv = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_MACHINE);
assign vlsq2vtlb_req_unpriv = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_USER) | (vlsq_req_ctrl[13 +:2] == PRIVILEGE_SUPERVISOR);
assign vlsq2vtlb_req_store = vlsq_req_ctrl[17];
assign vlsq2vtlb_req_load = vlsq_req_ctrl[4];
assign vlsq2vtlb_req_priv_r = vlsq2vtlb_req_priv & vlsq2vtlb_req_load;
assign vlsq2vtlb_req_priv_w = vlsq2vtlb_req_priv & vlsq2vtlb_req_store;
assign vlsq2vtlb_req_unpriv_r = vlsq2vtlb_req_unpriv & vlsq2vtlb_req_load;
assign vlsq2vtlb_req_unpriv_w = vlsq2vtlb_req_unpriv & vlsq2vtlb_req_store;
assign vlsq2vtlb_req_permission = {vlsq2vtlb_req_unpriv_w,vlsq2vtlb_req_unpriv_r,vlsq2vtlb_req_priv_w,vlsq2vtlb_req_priv_r};
assign vlsq2vtlb_resp_pmp_fault = ~|(vlsq2vtlb_req_permission & vlsq2vtlb_resp_pmp_permission);
assign vlsq2vtlb_resp_pmp_permission = vlsq2vtlb_resp_data[31 +:4];
assign vlsq2vtlb_resp_pma_fault = vlsq2vtlb_resp_data[25];
assign vlsq2vtlb_resp_pma_mtype = vlsq2vtlb_resp_data[26 +:4];
assign vlsq2vtlb_resp_pma_nosh = vlsq2vtlb_resp_data[30];
assign vlsq_ilm_mask_bits = $unsigned(ILM_MASK_BITS);
assign vlsq_dlm_mask_bits = $unsigned(DLM_MASK_BITS);
assign vlsq_hvm_mask_bits = $unsigned(HVM_MASK_BITS);
assign vlsq_ilm_mask = ~((64'd1 << vlsq_ilm_mask_bits) - 64'd1);
assign vlsq_dlm_mask = ~((64'd1 << vlsq_dlm_mask_bits) - 64'd1);
assign vlsq_hvm_mask = ~((64'd1 << vlsq_hvm_mask_bits) - 64'd1);
assign vlsq_hit_ilm = (ILM_SIZE_KB != 0) & vlsq_xcpt_check_en & vlsq_milmb_ien & ((vlsq_req_xlen_addr[VALEN - 1:0] & vlsq_ilm_mask[VALEN - 1:0]) == ILM_BASE[VALEN - 1:0]);
assign vlsq_hit_dlm = (DLM_SIZE_KB != 0) & vlsq_xcpt_check_en & vlsq_mdlmb_den & ((vlsq_req_xlen_addr[VALEN - 1:0] & vlsq_dlm_mask[VALEN - 1:0]) == DLM_BASE[VALEN - 1:0]);
assign vlsq_hit_hvm = (HVM_SIZE_KB != 0) & vlsq_xcpt_check_en & ~vlsq_bad_va & ((vlsq_req_pa[PALEN - 1:0] & vlsq_hvm_mask[PALEN - 1:0]) == HVM_BASE[PALEN - 1:0]);
assign vlsq_widen = vlsq_ctrl[27];
assign vlsq_ewiden = vlsq_element & vlsq_widen;
assign vlsq_widen_fault_element = vlsq_alive_with_vstart ? vlsq_req_element : {vlsq_req_element[ELE_CNT_WIDTH - 1:1],1'b1};
assign vlsq_eew4_lsb_sel = ~vlsq_cross_4k_d1 & vlsq_vstart_eew4_lsb;
assign vlsq_eew4_fault_element = {vlsq_req_element[ELE_CNT_WIDTH - 2:0],vlsq_eew4_lsb_sel};
assign vlsq_resp_fault_element = vlsq_widen ? vlsq_widen_fault_element : vlsq_vd_eew4 ? vlsq_eew4_fault_element : vlsq_useg ? vlsq_resp_fault_element_seg : vlsq_req_element;
assign vlsq_resp_hit_hvm = vlsq_hit_hvm;
assign vlsq_vd_beats_minus1 = vlsq_vd_beats - {{VRF_LW - 1{1'b0}},1'b1};
assign vlsq_vd_beats_sel = vlsq_req_cross_4k ? vlsq_vd_beats : vlsq_vd_beats_minus1;
assign {nds_unused_co4,vlsq_resp_remain_vd_beats} = vlsq_vd_beats_sel - vlsq_vd_beat_cnt;
assign vlsq_xcpt_dlen_last = vlsq_element & (vlsq_xcpted | vlsq_resp_xcpt);
assign vlsq_req_xcpt_last = (vlsq_xcpted & (vlsq_req_xcpt_cnt == vlsq_remain_vd_beats)) | (vlsq_resp_xcpt & (vlsq_vd_beat_cnt == vlsq_vd_beats));
assign vlsq_req_xcpt_cnt_en = (vlsq_req_grant & vlsq_element & vlsq_xcpted) | vlsq_skip;
assign vlsq_req_xcpt_cnt_add1 = vlsq_req_xcpt_cnt + {{VRF_LW - 1{1'b0}},1'b1};
assign vlsq_req_xcpt_cnt_nx = (vlsq_skip | vlsq_req_last) ? {VRF_LW{1'b0}} : vlsq_req_xcpt_cnt_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_req_xcpt_cnt <= {VRF_LW{1'b0}};
    end
    else if (vlsq_req_xcpt_cnt_en) begin
        vlsq_req_xcpt_cnt <= vlsq_req_xcpt_cnt_nx;
    end
end

assign mtype_check_set = vlsq_req_grant & vlsq_xcpt_check_en & ~vlsq_req_last;
assign mtype_check_clr = (vlsq_req_grant & vlsq_req_last) | vlsq_skip;
assign mtype_check_en = mtype_check_set | mtype_check_clr;
assign mtype_check_valid_nx = mtype_check_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        mtype_check_valid <= 1'b0;
    end
    else if (mtype_check_en) begin
        mtype_check_valid <= mtype_check_valid_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        mtype_check_data <= 4'b0;
        nosh_check_data <= 1'b0;
        hvm_check_data <= 1'b0;
    end
    else if (mtype_check_set) begin
        mtype_check_data <= vlsq2vtlb_resp_pma_mtype;
        nosh_check_data <= vlsq2vtlb_resp_pma_nosh;
        hvm_check_data <= vlsq_req_hvm;
    end
end

assign vlsq_bad_va = vlsq_va2pa_en & vlsq_xcpt_check_en & ((vlsq_sv39 & vlsq_bad_va39_pre) | (~vlsq_sv39 & vlsq_bad_va48_pre));
generate
    if (MMU_SCHEME_INT == 2) begin:gen_bad_va39
        assign vlsq_bad_va39_pre = ~(&vlsq_req_xlen_addr[XLEN - 1:VALEN - 1]) & (|vlsq_req_xlen_addr[XLEN - 1:VALEN - 1]);
        assign vlsq_bad_va48_pre = 1'b0;
        assign vlsq_resp_extvalen = vlsq_bad_va39_pre ? ~vlsq_req_xlen_addr[VALEN - 1] : vlsq_req_xlen_addr[VALEN - 1];
        assign vlsq_resp_tval = {vlsq_resp_extvalen,vlsq_req_xlen_addr[VALEN - 1:0]};
    end
    else if (MMU_SCHEME_INT == 3) begin:gen_bad_va48
        assign vlsq_bad_va39_pre = ~(&vlsq_req_xlen_addr[XLEN - 1:38]) & (|vlsq_req_xlen_addr[XLEN - 1:38]);
        assign vlsq_bad_va48_pre = ~(&vlsq_req_xlen_addr[XLEN - 1:VALEN - 1]) & (|vlsq_req_xlen_addr[XLEN - 1:VALEN - 1]);
        assign vlsq_resp_extvalen = vlsq_bad_va48_pre ? ~vlsq_req_xlen_addr[VALEN - 1] : vlsq_req_xlen_addr[VALEN - 1];
        assign vlsq_resp_tval = {vlsq_resp_extvalen,vlsq_req_xlen_addr[VALEN - 1:0]};
    end
    else begin:gen_bad_va_stub
        wire nds_unused_vlsq_resp_extvalen;
        assign nds_unused_vlsq_resp_extvalen = vlsq_resp_extvalen;
        assign vlsq_bad_va39_pre = 1'b0;
        assign vlsq_bad_va48_pre = 1'b0;
        assign vlsq_resp_extvalen = 1'b0;
        assign vlsq_resp_tval = vlsq_req_xlen_addr[VALEN - 1:0];
    end
endgenerate
assign vlsq_addr_misalign = (vlsq2vtlb_req_va[0] & (vlsq_vd_eew[1:0] > 2'b00)) | (|vlsq2vtlb_req_va[1:0] & (vlsq_vd_eew[1:0] > 2'b01)) | (|vlsq2vtlb_req_va[2:0] & (vlsq_vd_eew[1:0] == 2'b11) & elen64);
assign vlsq2vtlb_resp_page_v = vlsq2vtlb_resp_data[22];
assign vlsq2vtlb_resp_page_r = vlsq2vtlb_resp_data[20];
assign vlsq2vtlb_resp_page_w = vlsq2vtlb_resp_data[23];
assign vlsq2vtlb_resp_page_x = vlsq2vtlb_resp_data[24];
assign vlsq2vtlb_resp_page_u = vlsq2vtlb_resp_data[21];
assign vlsq2vtlb_resp_page_a = vlsq2vtlb_resp_data[0];
assign vlsq2vtlb_resp_page_d = vlsq2vtlb_resp_data[2];
assign vlsq2vtlb_resp_page_fault_ptw = vlsq2vtlb_resp_data[19];
assign vlsq2vtlb_resp_page_dcause = vlsq2vtlb_resp_data[3 +:3];
assign vlsq2vtlb_resp_page_ecc_code = vlsq2vtlb_resp_data[6 +:8];
assign vlsq2vtlb_resp_page_ecc_corr = vlsq2vtlb_resp_data[14];
assign vlsq2vtlb_resp_page_ecc_ramid = vlsq2vtlb_resp_data[15 +:4];
assign page_access_fault = vlsq2vtlb_resp_page_v & ~vlsq2vtlb_resp_page_a;
assign page_dirty_fault = vlsq2vtlb_resp_page_v & ~vlsq2vtlb_resp_page_d & vlsq2vtlb_req_store;
assign page_readable_fault = vlsq2vtlb_resp_page_v & vlsq2vtlb_req_load & (~vlsq2vtlb_resp_page_r & ~(vlsq2vtlb_resp_page_x & vlsq_mstatus_mxr));
assign page_writable_fault = vlsq2vtlb_resp_page_v & vlsq2vtlb_req_store & ~vlsq2vtlb_resp_page_w;
assign page_userpage_fault = vlsq2vtlb_resp_page_v & ((vlsq2vtlb_req_priv_u & ~vlsq2vtlb_resp_page_u) | (~vlsq2vtlb_req_priv_u & vlsq2vtlb_resp_page_u & ~vlsq_mstatus_sum));
assign vlsq2vtlb_resp_page_fault = (vlsq2vtlb_req_va2pa_en & (vlsq2vtlb_resp_page_fault_ptw | page_access_fault | page_dirty_fault | page_readable_fault | page_writable_fault | page_userpage_fault)) | (vlsq_va_ready & vlsq_bad_va);
assign vlsq2vtlb_resp_page_access_fault = vlsq2vtlb_req_va2pa_en & vlsq2vtlb_resp_data[1] & ~(vlsq_va_ready & vlsq_bad_va);
assign vlsq2vtlb_resp_pa = vlsq2vtlb_req_va2pa_en ? {vlsq2vtlb_resp_ppn,vlsq2vtlb_req_va[11:0]} : vlsq2vtlb_req_va[PALEN - 1:0];
assign vlsq2vtlb_resp_pma_device = (vlsq2vtlb_resp_pma_mtype == 4'd0) | (vlsq2vtlb_resp_pma_mtype == 4'd1);
assign mtype_check_inconsistent = mtype_check_valid & ((mtype_check_data != vlsq2vtlb_resp_pma_mtype) | (nosh_check_data != vlsq2vtlb_resp_pma_nosh) | (hvm_check_data != vlsq_hit_hvm));
assign vlsq_resp_xcpt = vlsq_xcpt_check_en & vlsq_resp_status[21];
assign vlsq_xcpt_status = {vlsq_addr_misalign,vlsq_hit_ilm,vlsq_hit_dlm,mtype_check_inconsistent,vlsq2vtlb_resp_pma_device,vlsq2vtlb_resp_pma_fault,vlsq2vtlb_resp_pmp_fault,vlsq2vtlb_resp_page_access_fault,vlsq2vtlb_resp_page_fault};
assign vlsq_fault_element_seg_en = (vlsq_req_grant & vlsq_useg & (vlsq_req_cross_4k | vlsq_req_last)) | vlsq_useg_prestart_valid | vlsq_skip;
assign {nds_unused_co9,vlsq_fault_element_seg_add} = vlsq_fault_element_seg + vlsq_req_byte2element[ELE_CNT_WIDTH - 1:0];
assign vlsq_fault_element_seg_nx = (vlsq_req_last | vlsq_skip) ? {ELE_CNT_WIDTH{1'b0}} : vlsq_useg_prestart_valid ? vlsq_vstart_nf : vlsq_fault_element_seg_add;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsq_fault_element_seg <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (vlsq_fault_element_seg_en) begin
        vlsq_fault_element_seg <= vlsq_fault_element_seg_nx;
    end
end

assign vlsq_nfield2 = (vlsq_nf == 3'd1);
assign vlsq_nfield4 = (vlsq_nf == 3'd3);
assign vlsq_nfield8 = (vlsq_nf == 3'd7);
assign vlsq_nfield3 = (vlsq_nf == 3'd2);
assign vlsq_nfield5 = (vlsq_nf == 3'd4);
assign vlsq_nfield6 = (vlsq_nf == 3'd5);
assign vlsq_nfield7 = (vlsq_nf == 3'd6);
assign vlsq_resp_fault_element_seg = vlsq_resp_fault_element_dict;
assign vlsq_resp_fault_nf = (vlsq_nf == 3'd0) ? 3'd0 : vlsq_resp_fault_nf_dict;
kv_vls_seg_dict #(
    .VLEN(VLEN),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH)
) u_vls_seg_dict (
    .element(vlsq_fault_element_seg),
    .eew(vlsq_vd_eew[1:0]),
    .nf2(vlsq_nfield2),
    .nf3(vlsq_nfield3),
    .nf4(vlsq_nfield4),
    .nf5(vlsq_nfield5),
    .nf6(vlsq_nfield6),
    .nf7(vlsq_nfield7),
    .nf8(vlsq_nfield8),
    .fault_element(vlsq_resp_fault_element_dict),
    .fault_nf(vlsq_resp_fault_nf_dict)
);
kv_zero_ext #(
    .OW(64),
    .IW(EXTVALEN)
) u_vlsu_ack_tval (
    .out(vlsu_ack_tval),
    .in(vlsu_ack_tval_pre)
);
kv_zero_ext #(
    .OW(11),
    .IW(ELE_CNT_WIDTH)
) u_vlsu_ack_element (
    .out(vlsu_ack_element),
    .in(vlsu_ack_element_pre)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

