// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_hr_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    hr_vd_bypass_cond,
    hr_vd_buf_ptr,
    hr_req_seg_num_dlen,
    hr_enq_valid,
    hr_deq_valid,
    hr_a_grant_valid,
    hr_d_grant_valid,
    hr_dummy_d_grant_valid,
    hr_ld_ualign_valid,
    hr_a_last,
    hr_enq_pa,
    hr_enq_ctrl,
    hr_enq_start_buf_ptr,
    hr_enq_seg_buf_ptr,
    hr_enq_buf_ptr_tl,
    hr_enq_element_num_dlen,
    hr_enq_element_sel,
    hr_enq_mask_cnt,
    hr_enq_byte,
    hr_enq_nf_cnt,
    hr_enq_first,
    hr_enq_last,
    hr_enq_total_beat_cnt,
    hr_enq_vd_beats,
    hr_enq_dlen_beat,
    hr_enq_align_value,
    hr_enq_umask_cnt_offset,
    hr_enq_align_onehot_sel,
    hr_enq_beat_mask,
    hr_enq_st_beat_mask,
    hr_enq_ucross,
    hr_enq_uextra,
    hr_enq_eseg_hp,
    hr_enq_ustride_mutation,
    hr_wait_reg_set,
    hr_wait_reg_clr,
    hr_hvm_wait_reg_set,
    ld_ualign_buf_hvm_set,
    ld_ualign_buf_cmnc_set,
    ld_ualign_buf_clr,
    ld_ualign_buf_free_init,
    hr_qout_occupied,
    hr_qout_req_valid,
    hr_qout_done,
    hr_qout_pa_cl_base,
    hr_qout_pa_base,
    hr_qout_ctrl,
    hr_qout_buf_ptr,
    hr_qout_seg_buf_ptr,
    hr_qout_buf_ptr_tl,
    hr_qout_element_num_dlen,
    hr_qout_element_sel,
    hr_qout_first,
    hr_qout_last,
    hr_qout_total_beat_cnt,
    hr_qout_beat_cnt,
    hr_qout_vd_beats,
    hr_qout_umask_cnt,
    hr_qout_check_hazard_en,
    hr_qout_ustride_una_hvm_en,
    hr_qout_ustride_una_cmnc_en,
    hr_qout_d_last,
    hr_qout_load_pending,
    hr_qout_store_pending,
    hr_qout_store_pending_hvm,
    hr_qout_store_pending_nhvm,
    hr_qout_cmd_valid,
    hr_qout_block_cmd_hvm,
    hr_qout_block_cmd_nhvm,
    hr_qout_busy,
    hr_qout_inflight_ld,
    hr_qout_bypass_cond,
    hr_qout_seg_num_dlen_hit,
    hr_qout_skip,
    hr_qout_align_value,
    hr_qout_umask_cnt_offset,
    hr_qout_align_onehot_sel,
    hr_qout_beat_mask,
    hr_qout_beat_mask_lsb,
    hr_qout_dlen_beat,
    hr_qout_eseg_hp,
    hr_qout_ustride_mutation,
    hr_qout_ucross,
    hr_qout_uextra,
    hr_qout_ld_ucross_dlen,
    hr_qout_ld_ucross_mask_cnt,
    hr_qout_vd_mask,
    hr_qout_vd_bwe_offset
);
parameter VLSU_SUPPORT_HVM = 1;
parameter BIU_DATA_WIDTH = 512;
parameter BIU_MASK_WIDTH = 64;
parameter BIU_OFFSET_WIDTH = 6;
parameter HVM_DATA_WIDTH = 1024;
parameter HVM_OFFSET_WIDTH = 7;
parameter HR_DEPTH = 8;
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = 64;
parameter ELEN = 32;
parameter PALEN = 38;
parameter VRF_LW = 3;
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter BEAT_CNT_WIDTH = 1;
parameter CL_OFFSET_WIDTH = 6;
parameter CL_BASE_WIDTH = 32;
parameter HR_OFFSET_WIDTH = 5;
parameter HR_BASE_WIDTH = 33;
parameter BIU_BASE_WIDTH = 33;
parameter BIU_BYTE_WIDTH = 6;
parameter NF_BYTE_WIDTH = 6;
parameter CL_BYTE_WIDTH = 7;
parameter HR_BYTE_WIDTH = 8;
parameter HR_MAX_BYTE_WIDTH = 5;
parameter HR_MASK_WIDTH = 128;
parameter DLEN_BYTE_WIDTH = 6;
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
localparam VLSHR_FSM_BITS = 4;
localparam VLSHR_FSM_INVALID = 0;
localparam VLSHR_FSM_VALID = 1;
localparam VLSHR_FSM_ONGOING = 2;
localparam VLSHR_FSM_DONE = 3;
input vpu_vlsu_clk;
input vpu_reset_n;
input hr_vd_bypass_cond;
input [BUF_DEPTH - 1:0] hr_vd_buf_ptr;
input [ELE_DLEN_WIDTH - 1:0] hr_req_seg_num_dlen;
input hr_enq_valid;
input hr_deq_valid;
input hr_a_grant_valid;
input hr_d_grant_valid;
input hr_dummy_d_grant_valid;
input hr_ld_ualign_valid;
input hr_a_last;
input [PALEN - 1:0] hr_enq_pa;
input [34 - 1:0] hr_enq_ctrl;
input [BUF_DEPTH - 1:0] hr_enq_start_buf_ptr;
input [BUF_DEPTH - 1:0] hr_enq_seg_buf_ptr;
input [BUF_DEPTH - 1:0] hr_enq_buf_ptr_tl;
input [ELE_DLEN_WIDTH - 1:0] hr_enq_element_num_dlen;
input hr_enq_element_sel;
input [HR_BYTE_WIDTH - 1:0] hr_enq_mask_cnt;
input [HR_MAX_BYTE_WIDTH - 1:0] hr_enq_byte;
input [3:0] hr_enq_nf_cnt;
input hr_enq_first;
input hr_enq_last;
input [BEAT_CNT_WIDTH - 1:0] hr_enq_total_beat_cnt;
input [VRF_LW - 1:0] hr_enq_vd_beats;
input hr_enq_dlen_beat;
input [HR_OFFSET_WIDTH - 1:0] hr_enq_align_value;
input [HR_OFFSET_WIDTH - 1:0] hr_enq_umask_cnt_offset;
input [1:0] hr_enq_align_onehot_sel;
input [3:0] hr_enq_beat_mask;
input [3:0] hr_enq_st_beat_mask;
input hr_enq_ucross;
input hr_enq_uextra;
input hr_enq_eseg_hp;
input hr_enq_ustride_mutation;
input [HR_DEPTH - 1:0] hr_wait_reg_set;
input [HR_DEPTH - 1:0] hr_wait_reg_clr;
input [HR_DEPTH - 1:0] hr_hvm_wait_reg_set;
input ld_ualign_buf_hvm_set;
input ld_ualign_buf_cmnc_set;
input ld_ualign_buf_clr;
input ld_ualign_buf_free_init;
output hr_qout_occupied;
output hr_qout_req_valid;
output hr_qout_done;
output [CL_BASE_WIDTH - 1:0] hr_qout_pa_cl_base;
output [HR_BASE_WIDTH - 1:0] hr_qout_pa_base;
output [34 - 1:0] hr_qout_ctrl;
output [BUF_DEPTH - 1:0] hr_qout_buf_ptr;
output [BUF_DEPTH - 1:0] hr_qout_seg_buf_ptr;
output [BUF_DEPTH - 1:0] hr_qout_buf_ptr_tl;
output [ELE_DLEN_WIDTH - 1:0] hr_qout_element_num_dlen;
output hr_qout_element_sel;
output hr_qout_first;
output hr_qout_last;
output [BEAT_CNT_WIDTH - 1:0] hr_qout_total_beat_cnt;
output [BEAT_CNT_WIDTH - 1:0] hr_qout_beat_cnt;
output [VRF_LW - 1:0] hr_qout_vd_beats;
output [HR_BYTE_WIDTH - 1:0] hr_qout_umask_cnt;
output hr_qout_check_hazard_en;
output hr_qout_ustride_una_hvm_en;
output hr_qout_ustride_una_cmnc_en;
output hr_qout_d_last;
output hr_qout_load_pending;
output hr_qout_store_pending;
output hr_qout_store_pending_hvm;
output hr_qout_store_pending_nhvm;
output hr_qout_cmd_valid;
output hr_qout_block_cmd_hvm;
output hr_qout_block_cmd_nhvm;
output hr_qout_busy;
output hr_qout_inflight_ld;
output hr_qout_bypass_cond;
output hr_qout_seg_num_dlen_hit;
output hr_qout_skip;
output [HR_OFFSET_WIDTH - 1:0] hr_qout_align_value;
output [HR_OFFSET_WIDTH - 1:0] hr_qout_umask_cnt_offset;
output [1:0] hr_qout_align_onehot_sel;
output [3:0] hr_qout_beat_mask;
output hr_qout_beat_mask_lsb;
output hr_qout_dlen_beat;
output hr_qout_eseg_hp;
output hr_qout_ustride_mutation;
output hr_qout_ucross;
output hr_qout_uextra;
output hr_qout_ld_ucross_dlen;
output [HR_BYTE_WIDTH - 1:0] hr_qout_ld_ucross_mask_cnt;
output [HR_MASK_WIDTH - 1:0] hr_qout_vd_mask;
output [ELE_DLEN_WIDTH - 1:0] hr_qout_vd_bwe_offset;





// 81309e96 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire dlen_biu_1_1;
wire hr_enq_load;
wire hr_enq_skip;
wire [PALEN - 1:0] hr_biu_pa;
wire [HR_BASE_WIDTH - 1:0] hr_enq_pa_base;
reg [HR_BASE_WIDTH - 1:0] hr_pa_base;
reg [34 - 1:0] hr_ctrl;
reg [BUF_DEPTH - 1:0] hr_seg_buf_ptr;
reg [BUF_DEPTH - 1:0] hr_buf_ptr_tl;
reg hr_element_sel;
reg hr_first;
reg hr_last;
reg [BEAT_CNT_WIDTH - 1:0] hr_total_beat_cnt;
reg [VRF_LW - 1:0] hr_vd_beats;
wire [VRF_LW:0] hr_vd_beats_add1;
reg [3:0] hr_beat_mask;
reg [3:0] hr_st_beat_mask;
wire hr_qout_st_beat_mask_lsb;
reg hr_eseg_hp;
reg hr_ustride_mutation;
wire [HR_OFFSET_WIDTH - 1:0] hr_enq_pa_offset;
wire [HR_OFFSET_WIDTH - 1:0] hr_pa_offset_nx;
reg [HR_OFFSET_WIDTH - 1:0] hr_pa_offset;
wire hr_wait_reg_en;
wire [HR_DEPTH - 1:0] hr_wait_reg_set_all;
wire [HR_DEPTH - 1:0] hr_wait_reg_nx;
reg [HR_DEPTH - 1:0] hr_wait_reg;
wire hr_wait_reg_free_nx;
reg hr_wait_reg_free;
wire ld_ualign_buf_update;
wire hr_ld_ualign_buf_free_en;
wire hr_ld_ualign_buf_free_nx;
wire hr_ld_ualign_buf_free_cond;
reg hr_ld_ualign_buf_free;
reg hr_fsm_en;
reg [VLSHR_FSM_BITS - 1:0] hr_fsm;
reg [VLSHR_FSM_BITS - 1:0] hr_fsm_nx;
wire hr_fsm_valid;
wire hr_fsm_invalid;
wire hr_fsm_ongoing;
wire hr_fsm_done;
wire [HR_OFFSET_WIDTH - 1:0] hr_align_value_nx;
reg [HR_OFFSET_WIDTH - 1:0] hr_align_value;
wire [1:0] hr_align_onehot_sel_nx;
reg [1:0] hr_align_onehot_sel;
wire hr_dlen_beat_nx;
reg hr_dlen_beat;
wire hr_eseg_store;
wire hr_resp_beat_last;
wire hr_resp_ualign_rlast;
wire hr_d_last_valid;
reg [BEAT_CNT_WIDTH - 1:0] hr_beat_cnt;
wire [BEAT_CNT_WIDTH:0] hr_beat_cnt_add1;
wire [BEAT_CNT_WIDTH - 1:0] hr_beat_cnt_nx;
wire hr_beat_cnt_en;
wire hr_align_en;
wire hr_buf_num_offset_inc;
wire [VRF_LW - 1:0] hr_seg_buf_num_offset;
wire [VRF_LW - 1:0] hr_buf_num_offset_nx;
wire [BUF_DEPTH - 1:0] hr_buf_ptr_nx;
wire [(BUF_DEPTH * 2) - 1:0] hr_buf_ptr_widen;
wire [BUF_DEPTH - 1:0] hr_buf_ptr_wrap;
reg [BUF_DEPTH - 1:0] hr_buf_ptr;
wire hr_seg;
wire hr_element_seg;
wire hr_ustride;
wire hr_element;
wire hr_widen;
wire hr_ubypass;
wire hr_align;
wire hr_hvm;
wire hr_ld_ustride_una;
wire [7:0] hr_biu_byte_init;
wire [7:0] hr_hvm_byte_init;
wire [7:0] hr_bus_byte_init;
wire [7:0] hr_dlen_byte_init;
wire [HR_BYTE_WIDTH - 1:0] hr_mask_cnt_val_nx;
wire [HR_BYTE_WIDTH - 1:0] hr_mask_cnt_nx;
reg [HR_BYTE_WIDTH - 1:0] hr_mask_cnt;
wire [HR_MAX_BYTE_WIDTH - 1:0] hr_mask_cnt_zexthr;
wire [3:0] hr_nf_cnt;
wire [3:0] hr_nf_cnt_minus1;
wire [7:0] hr_remain_nf_byte_minus_zext8;
wire [HR_BYTE_WIDTH - 1:0] hr_ld_eseg_mask_cnt_nx;
wire [3:0] hr_remain_nf_cnt_minus;
wire [3:0] hr_remain_nf_cnt_nx;
reg [3:0] hr_remain_nf_cnt;
wire [NF_BYTE_WIDTH - 1:0] hr_remain_nf_byte_minus;
wire hr_ld_ucross_dlen;
wire [DLEN_BYTE_WIDTH - 1:0] hr_ld_ucross_mask_cnt;
reg hr_ucross;
reg hr_uextra;
wire [DLEN_BYTE_WIDTH - 1:0] hr_element_num_dlen_add;
wire [ELE_DLEN_WIDTH - 1:0] hr_element_num_dlen_eew;
wire [ELE_DLEN_WIDTH - 1:0] hr_element_num_dlen_nx;
reg [ELE_DLEN_WIDTH - 1:0] hr_element_num_dlen;
wire [HR_BYTE_WIDTH - 1:0] hr_mask_cnt_element;
wire [DLEN_BYTE_WIDTH - 1:0] hr_element_num_dlen_byte_nx;
wire [HR_BYTE_WIDTH - 1:0] hr_bus_offer_byte_nx;
wire [7:0] hr_bus_offer_byte_nx_zext8;
wire [DLEN_BYTE_WIDTH - 1:0] hr_remain_byte_dlen_nx;
wire [HR_BYTE_WIDTH - 1:0] hr_bus_offer_byte;
wire [DLEN_BYTE_WIDTH - 1:0] hr_bus_offer_byte_zext;
wire [HR_BYTE_WIDTH - 1:0] hr_bus_offer_element;
wire [DLEN_BYTE_WIDTH - 1:0] hr_bus_offer_element_zext;
wire [DLEN_BYTE_WIDTH - 1:0] hr_element_num_dlen_byte;
wire [DLEN_BYTE_WIDTH - 1:0] hr_remain_byte_dlen;
wire hr_umask_cnt_offset_en;
wire [HR_OFFSET_WIDTH - 1:0] hr_umask_cnt_offset_nx;
reg [HR_OFFSET_WIDTH - 1:0] hr_umask_cnt_offset;
wire [HR_BYTE_WIDTH - 1:0] hr_ld_umask_cnt_nx;
wire [HR_BYTE_WIDTH - 1:0] hr_st_mask_cnt_nx;
wire hr_remain_byte_lt_biu;
wire hr_remain_byte_eq_biu;
wire [2:0] hr_eew;
wire hr_eew8;
wire hr_eew16;
wire hr_eew32;
wire hr_eew64;
wire hr_byte_en;
wire [HR_MAX_BYTE_WIDTH - 1:0] hr_byte_minus;
wire [HR_MAX_BYTE_WIDTH - 1:0] hr_byte_nx;
reg [HR_MAX_BYTE_WIDTH - 1:0] hr_byte;
wire d_accepted_set;
wire d_accepted_clr;
wire d_accepted_en;
wire d_accepted_nx;
reg d_accepted;
wire [ELE_DLEN_WIDTH - 1:0] hr_element_num_dlen_byte_sel;
wire [HR_BYTE_WIDTH - 1:0] hr_mask_cnt_sel;
wire hr_load;
wire hr_store;
wire hr_skip;
wire hr_deq_grant;
wire nds_unused_co1;
wire nds_unused_co3;
wire nds_unused_co4;
wire nds_unused_co5;
wire nds_unused_co6;
wire nds_unused_co7;
wire nds_unused_co8;
wire nds_unused_co9;
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(HR_BYTE_WIDTH)
) u_hr_bus_offer_byte_zext (
    .out(hr_bus_offer_byte_zext),
    .in(hr_bus_offer_byte)
);
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(HR_BYTE_WIDTH)
) u_hr_bus_offer_element_zext (
    .out(hr_bus_offer_element_zext),
    .in(hr_bus_offer_element)
);
kv_zero_ext #(
    .OW(8),
    .IW(HR_BYTE_WIDTH)
) u_hr_bus_offer_byte_nx_zext8 (
    .out(hr_bus_offer_byte_nx_zext8),
    .in(hr_bus_offer_byte_nx)
);
kv_zero_ext #(
    .OW(8),
    .IW(NF_BYTE_WIDTH)
) u_hr_remain_nf_byte_minus_zext8 (
    .out(hr_remain_nf_byte_minus_zext8),
    .in(hr_remain_nf_byte_minus)
);
kv_zero_ext #(
    .OW(HR_MAX_BYTE_WIDTH),
    .IW(HR_BYTE_WIDTH)
) u_hr_mask_cnt_zexthr (
    .out(hr_mask_cnt_zexthr),
    .in(hr_mask_cnt)
);
assign dlen_biu_1_1 = DLEN == BIU_DATA_WIDTH;
assign hr_deq_grant = hr_deq_valid & hr_fsm_done;
assign d_accepted_set = (hr_fsm_valid & hr_ctrl[27] & hr_d_grant_valid);
assign d_accepted_clr = hr_deq_grant;
assign d_accepted_en = d_accepted_set | d_accepted_clr;
assign d_accepted_nx = d_accepted_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        d_accepted <= 1'b0;
    end
    else if (d_accepted_en) begin
        d_accepted <= d_accepted_nx;
    end
end

assign hr_fsm_valid = hr_fsm[VLSHR_FSM_VALID];
assign hr_fsm_invalid = hr_fsm[VLSHR_FSM_INVALID];
assign hr_fsm_ongoing = hr_fsm[VLSHR_FSM_ONGOING];
assign hr_fsm_done = hr_fsm[VLSHR_FSM_DONE];
assign hr_qout_occupied = ~hr_fsm_invalid;
assign hr_qout_req_valid = hr_fsm_valid & hr_wait_reg_free & hr_ld_ualign_buf_free & ~hr_skip;
assign hr_qout_done = hr_fsm_done;
assign hr_qout_pa_cl_base = hr_biu_pa[PALEN - 1:CL_OFFSET_WIDTH];
assign hr_qout_pa_base = hr_pa_base[HR_BASE_WIDTH - 1:0];
assign hr_qout_ctrl = hr_ctrl;
assign hr_qout_buf_ptr = hr_buf_ptr;
assign hr_qout_seg_buf_ptr = hr_seg_buf_ptr;
assign hr_qout_buf_ptr_tl = hr_buf_ptr_tl;
assign hr_qout_element_num_dlen = hr_element_num_dlen;
assign hr_qout_element_sel = hr_element_sel;
assign hr_qout_total_beat_cnt = hr_total_beat_cnt;
assign hr_qout_vd_beats = hr_vd_beats;
assign hr_qout_first = hr_first;
assign hr_qout_last = hr_last;
assign hr_qout_check_hazard_en = (hr_fsm_valid | hr_fsm_ongoing) & ~hr_d_last_valid & ~d_accepted & ~hr_skip & ~hr_hvm;
assign hr_qout_ustride_una_hvm_en = (hr_fsm_valid | hr_fsm_ongoing) & hr_ld_ustride_una & hr_hvm & ~hr_d_last_valid & ~d_accepted & ~hr_skip;
assign hr_qout_ustride_una_cmnc_en = (hr_fsm_valid | hr_fsm_ongoing) & hr_ld_ustride_una & ~hr_hvm & ~hr_d_last_valid & ~d_accepted & ~hr_skip;
assign hr_qout_d_last = (hr_load & hr_resp_beat_last) | hr_store;
assign hr_qout_umask_cnt = hr_qout_st_beat_mask_lsb ? hr_mask_cnt : {HR_BYTE_WIDTH{1'b0}};
assign hr_qout_skip = (hr_fsm_valid | hr_fsm_ongoing) & hr_skip;
assign hr_qout_load_pending = (hr_fsm_valid | hr_fsm_ongoing) & hr_load;
assign hr_qout_store_pending = (hr_fsm_valid | hr_fsm_ongoing) & hr_store;
assign hr_qout_store_pending_hvm = hr_fsm_valid & hr_store & hr_hvm;
assign hr_qout_store_pending_nhvm = (hr_fsm_valid | hr_fsm_ongoing) & hr_store & ~hr_hvm;
assign hr_qout_cmd_valid = hr_fsm_valid | hr_qout_skip;
assign hr_qout_block_cmd_hvm = ((hr_fsm_valid | hr_fsm_ongoing) & hr_load | hr_fsm_valid & hr_store) & hr_element & hr_hvm;
assign hr_qout_block_cmd_nhvm = (hr_fsm_valid | hr_fsm_ongoing) & hr_element & ~hr_hvm;
assign hr_qout_ucross = hr_ucross;
assign hr_qout_uextra = hr_uextra;
assign hr_qout_ld_ucross_dlen = hr_resp_ualign_rlast ? hr_ucross : hr_ustride & hr_ld_ucross_dlen;
assign hr_qout_ld_ucross_mask_cnt = hr_ld_ucross_mask_cnt[HR_BYTE_WIDTH - 1:0];
assign hr_qout_beat_cnt = hr_beat_cnt;
assign hr_qout_align_value = hr_align_value;
assign hr_qout_umask_cnt_offset = hr_umask_cnt_offset;
assign hr_qout_align_onehot_sel = hr_align_onehot_sel;
assign hr_qout_beat_mask = hr_beat_mask;
assign hr_qout_dlen_beat = hr_dlen_beat;
assign hr_qout_eseg_hp = hr_eseg_hp;
assign hr_qout_ustride_mutation = hr_ustride_mutation;
assign hr_qout_busy = ~hr_skip & hr_fsm_ongoing;
assign hr_qout_inflight_ld = ~hr_skip & hr_fsm_ongoing & hr_load;
assign hr_qout_bypass_cond = (hr_vd_buf_ptr == hr_buf_ptr) & hr_vd_bypass_cond & hr_ubypass & (((BIU_DATA_WIDTH == 128) & hr_qout_beat_mask_lsb) | (BIU_DATA_WIDTH != 128));
assign hr_qout_seg_num_dlen_hit = hr_element_num_dlen == hr_req_seg_num_dlen;
assign hr_load = hr_ctrl[13];
assign hr_store = hr_ctrl[27];
assign hr_skip = hr_ctrl[26];
assign hr_enq_load = hr_enq_ctrl[13];
assign hr_enq_skip = hr_enq_ctrl[26];
always @* begin
    hr_fsm_nx = {VLSHR_FSM_BITS{1'b0}};
    case (1'b1)
        hr_fsm[VLSHR_FSM_INVALID]: begin
            hr_fsm_en = hr_enq_valid;
            if (hr_enq_skip & hr_enq_load) begin
                hr_fsm_nx[VLSHR_FSM_ONGOING] = 1'b1;
            end
            else begin
                hr_fsm_nx[VLSHR_FSM_VALID] = 1'b1;
            end
        end
        hr_fsm[VLSHR_FSM_VALID]: begin
            hr_fsm_en = (hr_a_grant_valid & hr_a_last);
            if (hr_skip & hr_store) begin
                hr_fsm_nx[VLSHR_FSM_DONE] = 1'b1;
            end
            else begin
                hr_fsm_nx[VLSHR_FSM_ONGOING] = 1'b1;
            end
        end
        hr_fsm[VLSHR_FSM_ONGOING]: begin
            hr_fsm_en = hr_d_last_valid | d_accepted;
            hr_fsm_nx[VLSHR_FSM_DONE] = 1'b1;
        end
        hr_fsm[VLSHR_FSM_DONE]: begin
            hr_fsm_en = hr_deq_grant;
            hr_fsm_nx[VLSHR_FSM_INVALID] = 1'b1;
        end
        default: begin
            hr_fsm_en = 1'b0;
            hr_fsm_nx = {VLSHR_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_fsm <= {{VLSHR_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (hr_fsm_en) begin
        hr_fsm <= hr_fsm_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_ctrl <= {34{1'b0}};
    end
    else if (hr_enq_valid) begin
        hr_ctrl <= hr_enq_ctrl;
    end
end

generate
    if (BIU_DATA_WIDTH != HVM_DATA_WIDTH) begin:gen_biu_hvm_neq
        assign hr_enq_pa_base = hr_enq_ctrl[11] ? {1'b0,hr_enq_pa[PALEN - 1:HVM_OFFSET_WIDTH]} : hr_enq_pa[PALEN - 1:BIU_OFFSET_WIDTH];
        assign hr_enq_pa_offset = hr_enq_ctrl[11] ? hr_enq_pa[HVM_OFFSET_WIDTH - 1:0] : {1'b0,hr_enq_pa[BIU_OFFSET_WIDTH - 1:0]};
    end
    else begin:gen_biu_hvm_eq
        assign hr_enq_pa_base = hr_enq_pa[PALEN - 1:HR_OFFSET_WIDTH];
        assign hr_enq_pa_offset = hr_enq_pa[HR_OFFSET_WIDTH - 1:0];
    end
endgenerate
always @(posedge vpu_vlsu_clk) begin
    if (hr_enq_valid) begin
        hr_pa_base <= hr_enq_pa_base;
        hr_seg_buf_ptr <= hr_enq_seg_buf_ptr;
        hr_buf_ptr_tl <= hr_enq_buf_ptr_tl;
        hr_element_sel <= hr_enq_element_sel;
        hr_first <= hr_enq_first;
        hr_last <= hr_enq_last;
        hr_total_beat_cnt <= hr_enq_total_beat_cnt;
        hr_vd_beats <= hr_enq_vd_beats;
        hr_ucross <= hr_enq_ucross;
        hr_uextra <= hr_enq_uextra;
        hr_beat_mask <= hr_enq_beat_mask;
        hr_st_beat_mask <= hr_enq_st_beat_mask;
        hr_eseg_hp <= hr_enq_eseg_hp;
        hr_ustride_mutation <= hr_enq_ustride_mutation;
    end
end

assign hr_wait_reg_set_all = hr_wait_reg_set | hr_hvm_wait_reg_set;
assign hr_wait_reg_en = hr_enq_valid | (|(hr_wait_reg[HR_DEPTH - 1:0] & hr_wait_reg_clr[HR_DEPTH - 1:0]));
assign hr_wait_reg_nx = hr_enq_valid ? hr_wait_reg_set_all[HR_DEPTH - 1:0] : (hr_wait_reg[HR_DEPTH - 1:0] & (~hr_wait_reg_clr[HR_DEPTH - 1:0]));
assign hr_wait_reg_free_nx = ~|hr_wait_reg_nx;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_wait_reg <= {HR_DEPTH{1'b0}};
        hr_wait_reg_free <= 1'b0;
    end
    else if (hr_wait_reg_en) begin
        hr_wait_reg <= hr_wait_reg_nx;
        hr_wait_reg_free <= hr_wait_reg_free_nx;
    end
end

assign hr_ld_ualign_buf_free_en = hr_enq_valid | (hr_fsm_valid & hr_ld_ustride_una & ld_ualign_buf_update);
assign ld_ualign_buf_update = ld_ualign_buf_clr | ld_ualign_buf_hvm_set | ld_ualign_buf_cmnc_set;
assign hr_ld_ualign_buf_free_cond = (ld_ualign_buf_hvm_set & hr_hvm) | (ld_ualign_buf_cmnc_set & ~hr_hvm) | ld_ualign_buf_clr;
assign hr_ld_ualign_buf_free_nx = hr_enq_valid ? ld_ualign_buf_free_init : hr_ld_ualign_buf_free_cond;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_ld_ualign_buf_free <= 1'b0;
    end
    else if (hr_ld_ualign_buf_free_en) begin
        hr_ld_ualign_buf_free <= hr_ld_ualign_buf_free_nx;
    end
end

assign hr_eew = hr_ctrl[30 +:3];
assign hr_eew8 = (hr_eew[1:0] == 2'b00);
assign hr_eew16 = (hr_eew[1:0] == 2'b01);
assign hr_eew32 = (hr_eew[1:0] == 2'b10);
assign hr_eew64 = (hr_eew[1:0] == 2'b11);
assign hr_seg = hr_ctrl[20];
assign hr_element_seg = hr_element & hr_seg;
assign hr_ustride = hr_ctrl[29];
assign hr_element = hr_ctrl[28] | hr_ctrl[12];
assign hr_widen = hr_ctrl[33];
assign hr_ubypass = hr_ctrl[6];
assign hr_align = hr_ctrl[0];
assign hr_hvm = hr_ctrl[11];
assign hr_ld_ustride_una = hr_load & hr_ustride & ~hr_align;
assign hr_eseg_store = hr_element_seg & hr_store;
assign hr_biu_pa = {hr_pa_base[BIU_BASE_WIDTH - 1:0],hr_pa_offset[BIU_OFFSET_WIDTH - 1:0]};
assign hr_d_last_valid = (hr_d_grant_valid | hr_dummy_d_grant_valid) & hr_qout_d_last;
assign hr_resp_beat_last = (hr_beat_cnt == hr_total_beat_cnt);
generate
    if (BIU_DATA_WIDTH == 128) begin:gen_hr_resp_ualign_rlast_128
        assign hr_resp_ualign_rlast = hr_last & ((hr_beat_cnt == hr_total_beat_cnt) | (hr_beat_cnt == 2'd2) & ~hr_beat_mask[3]);
        assign hr_qout_beat_mask_lsb = (hr_beat_cnt == 2'd0) ? hr_beat_mask[0] : (hr_beat_cnt == 2'd1) ? hr_beat_mask[1] : (hr_beat_cnt == 2'd2) ? hr_beat_mask[2] : hr_beat_mask[3];
        assign hr_qout_st_beat_mask_lsb = (hr_beat_cnt == 2'd0) ? hr_st_beat_mask[0] : (hr_beat_cnt == 2'd1) ? hr_st_beat_mask[1] : (hr_beat_cnt == 2'd2) ? hr_st_beat_mask[2] : hr_st_beat_mask[3];
    end
    else if (BIU_DATA_WIDTH == 256) begin:gen_hr_resp_ualign_rlast_256
        assign hr_resp_ualign_rlast = hr_last & hr_resp_beat_last;
        assign hr_qout_beat_mask_lsb = (hr_beat_cnt == 1'd0) ? hr_beat_mask[0] : hr_beat_mask[1];
        assign hr_qout_st_beat_mask_lsb = (hr_beat_cnt == 1'd0) ? hr_st_beat_mask[0] : hr_st_beat_mask[1];
    end
    else begin:gen_hr_resp_ualign_rlast_512
        assign hr_resp_ualign_rlast = hr_last & hr_resp_beat_last;
        assign hr_qout_beat_mask_lsb = (hr_beat_cnt == 1'd0) ? hr_beat_mask[0] : hr_beat_mask[1];
        assign hr_qout_st_beat_mask_lsb = (hr_beat_cnt == 1'd0) ? hr_st_beat_mask[0] : hr_st_beat_mask[1];
    end
endgenerate
assign hr_vd_beats_add1 = {1'b0,hr_vd_beats} + {{VRF_LW{1'b0}},1'b1};
assign hr_nf_cnt_minus1 = hr_nf_cnt - 4'd1;
kv_vls_seg_num #(
    .WIDTH(VRF_LW)
) u_vls_vl_seg (
    .data_in(hr_vd_beats_add1[VRF_LW - 1:0]),
    .nf(hr_nf_cnt_minus1[2:0]),
    .data_out(hr_seg_buf_num_offset)
);
assign hr_align_en = hr_enq_valid | (hr_d_grant_valid & hr_load & hr_qout_beat_mask_lsb) | (hr_dummy_d_grant_valid & hr_load & hr_qout_beat_mask_lsb) | (hr_a_grant_valid & hr_store & hr_qout_beat_mask_lsb);
assign hr_align_value_nx = hr_enq_valid ? hr_enq_align_value : (hr_ustride | hr_eseg_store) ? hr_align_value : hr_pa_offset_nx[HR_OFFSET_WIDTH - 1:0];
assign hr_align_onehot_sel_nx = hr_enq_valid ? hr_enq_align_onehot_sel : (hr_eseg_hp & dlen_biu_1_1) ? hr_align_onehot_sel : ~hr_align_onehot_sel;
assign hr_dlen_beat_nx = hr_enq_valid ? hr_enq_dlen_beat : ~hr_dlen_beat;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_align_value <= {HR_OFFSET_WIDTH{1'b0}};
        hr_align_onehot_sel <= 2'b0;
        hr_dlen_beat <= 1'b0;
        hr_mask_cnt <= {HR_BYTE_WIDTH{1'b0}};
        hr_element_num_dlen <= {ELE_DLEN_WIDTH{1'b0}};
        hr_buf_ptr <= {BUF_DEPTH{1'b0}};
        hr_remain_nf_cnt <= 4'd0;
    end
    else if (hr_align_en) begin
        hr_align_value <= hr_align_value_nx;
        hr_align_onehot_sel <= hr_align_onehot_sel_nx;
        hr_dlen_beat <= hr_dlen_beat_nx;
        hr_mask_cnt <= hr_mask_cnt_nx;
        hr_element_num_dlen <= hr_element_num_dlen_nx;
        hr_buf_ptr <= hr_buf_ptr_nx;
        hr_remain_nf_cnt <= hr_remain_nf_cnt_nx;
    end
end

assign hr_umask_cnt_offset_en = hr_enq_valid | (hr_a_grant_valid & hr_store & hr_qout_st_beat_mask_lsb);
assign hr_umask_cnt_offset_nx = hr_enq_valid ? hr_enq_umask_cnt_offset : {HR_OFFSET_WIDTH{1'b0}};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_umask_cnt_offset <= {HR_OFFSET_WIDTH{1'b0}};
    end
    else if (hr_umask_cnt_offset_en) begin
        hr_umask_cnt_offset <= hr_umask_cnt_offset_nx;
    end
end

assign hr_beat_cnt_en = hr_enq_valid | (hr_d_grant_valid & hr_load) | (hr_dummy_d_grant_valid & hr_load) | (hr_a_grant_valid & hr_store);
assign hr_pa_offset_nx = hr_enq_valid ? hr_enq_pa_offset : (~hr_qout_beat_mask_lsb) ? hr_align_value : {HR_OFFSET_WIDTH{1'b0}};
assign hr_beat_cnt_nx = hr_enq_valid ? {BEAT_CNT_WIDTH{1'b0}} : hr_beat_cnt_add1[BEAT_CNT_WIDTH - 1:0];
assign hr_beat_cnt_add1 = {1'b0,hr_beat_cnt} + {{BEAT_CNT_WIDTH{1'b0}},1'b1};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_pa_offset <= {HR_OFFSET_WIDTH{1'b0}};
        hr_beat_cnt <= {BEAT_CNT_WIDTH{1'b0}};
    end
    else if (hr_beat_cnt_en) begin
        hr_pa_offset <= hr_pa_offset_nx;
        hr_beat_cnt <= hr_beat_cnt_nx;
    end
end

assign hr_biu_byte_init = (BIU_DATA_WIDTH == 128) ? 8'd16 : (BIU_DATA_WIDTH == 256) ? 8'd32 : 8'd64;
assign hr_hvm_byte_init = (HVM_DATA_WIDTH == 128) ? 8'd16 : (HVM_DATA_WIDTH == 256) ? 8'd32 : (HVM_DATA_WIDTH == 512) ? 8'd64 : 8'd128;
assign hr_bus_byte_init = ({8{hr_hvm}} & hr_hvm_byte_init) | ({8{~hr_hvm}} & hr_biu_byte_init);
assign hr_dlen_byte_init = (DLEN == 1024) ? 8'd128 : (DLEN == 512) ? 8'd64 : (DLEN == 256) ? 8'd32 : 8'd16;
assign hr_mask_cnt_val_nx = hr_element ? hr_ld_eseg_mask_cnt_nx : hr_store ? hr_st_mask_cnt_nx : hr_ld_umask_cnt_nx;
assign hr_element_num_dlen_byte_nx = hr_element_num_dlen_add << hr_eew[1:0];
assign {nds_unused_co4,hr_bus_offer_byte_nx} = {1'b0,hr_bus_byte_init[HR_BYTE_WIDTH - 1:0]} - {2'b0,hr_pa_offset_nx[HR_OFFSET_WIDTH - 1:0]};
assign {nds_unused_co5,hr_remain_byte_dlen_nx} = hr_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0] - hr_element_num_dlen_byte_nx;
assign hr_remain_byte_eq_biu = (hr_element_num_dlen_byte_nx == hr_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0]);
assign hr_remain_byte_lt_biu = (hr_remain_byte_dlen_nx < hr_bus_offer_byte_nx_zext8[DLEN_BYTE_WIDTH - 1:0]);
assign hr_ld_umask_cnt_nx = (hr_remain_byte_lt_biu & ~hr_remain_byte_eq_biu) ? hr_remain_byte_dlen_nx[HR_BYTE_WIDTH - 1:0] : hr_bus_offer_byte_nx;
assign hr_element_num_dlen_eew = ({ELE_DLEN_WIDTH{hr_eew8}} & {{hr_element_num_dlen_add[SEW8_DLEN_WIDTH - 1:0]}}) | ({ELE_DLEN_WIDTH{hr_eew16}} & {1'b0,{hr_element_num_dlen_add[SEW16_DLEN_WIDTH - 1:0]}}) | ({ELE_DLEN_WIDTH{hr_eew32}} & {2'b0,{hr_element_num_dlen_add[SEW32_DLEN_WIDTH - 1:0]}}) | ({ELE_DLEN_WIDTH{hr_eew64}} & {3'b0,{hr_element_num_dlen_add[SEW64_DLEN_WIDTH - 1:0]}});
assign hr_element_num_dlen_byte = hr_element_num_dlen << hr_eew[1:0];
assign {nds_unused_co8,hr_remain_byte_dlen} = hr_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0] - hr_element_num_dlen_byte;
assign {nds_unused_co1,hr_bus_offer_byte} = {1'b0,hr_bus_byte_init[HR_BYTE_WIDTH - 1:0]} - {2'b0,hr_pa_offset[HR_OFFSET_WIDTH - 1:0]};
assign hr_bus_offer_element = hr_bus_offer_byte >> hr_eew[1:0];
assign hr_ld_ucross_dlen = (hr_remain_byte_dlen < hr_bus_offer_byte_zext);
assign {nds_unused_co9,hr_ld_ucross_mask_cnt} = hr_bus_offer_byte_zext - hr_remain_byte_dlen;
assign {nds_unused_co3,hr_element_num_dlen_add} = {1'b0,hr_element_num_dlen} + hr_bus_offer_element_zext;
assign hr_mask_cnt_element = hr_mask_cnt >> hr_eew[1:0];
assign hr_nf_cnt = hr_mask_cnt_element[3:0];
assign hr_ld_eseg_mask_cnt_nx = (hr_remain_nf_byte_minus_zext8 >= hr_bus_offer_byte_nx_zext8) ? hr_bus_offer_byte_nx : hr_remain_nf_byte_minus_zext8[HR_BYTE_WIDTH - 1:0];
assign {nds_unused_co6,hr_remain_nf_cnt_minus} = hr_remain_nf_cnt - hr_nf_cnt;
assign hr_remain_nf_byte_minus = hr_remain_nf_cnt_minus << hr_eew[1:0];
assign hr_buf_num_offset_inc = hr_ld_ucross_dlen | (hr_remain_byte_dlen == hr_bus_offer_byte_zext);
assign hr_buf_num_offset_nx = hr_element_seg ? hr_seg_buf_num_offset : {{VRF_LW - 1{1'b0}},hr_buf_num_offset_inc};
assign hr_buf_ptr_widen = hr_buf_ptr << hr_buf_num_offset_nx;
assign hr_buf_ptr_wrap = hr_buf_ptr_widen[0 +:BUF_DEPTH] | hr_buf_ptr_widen[BUF_DEPTH +:BUF_DEPTH];
assign hr_buf_ptr_nx = hr_enq_valid ? hr_enq_start_buf_ptr : hr_buf_ptr_wrap;
assign hr_mask_cnt_nx = hr_enq_valid ? hr_enq_mask_cnt : hr_mask_cnt_val_nx;
assign hr_element_num_dlen_nx = hr_enq_valid ? hr_enq_element_num_dlen : hr_ustride ? hr_element_num_dlen_eew : hr_element_num_dlen;
assign hr_remain_nf_cnt_nx = hr_enq_valid ? hr_enq_nf_cnt : hr_remain_nf_cnt_minus;
assign hr_st_mask_cnt_nx = hr_qout_st_beat_mask_lsb ? (hr_byte_minus <= hr_bus_offer_byte_nx_zext8[HR_MAX_BYTE_WIDTH - 1:0]) ? hr_byte_minus[HR_BYTE_WIDTH - 1:0] : hr_biu_byte_init[HR_BYTE_WIDTH - 1:0] : hr_mask_cnt;
assign hr_byte_en = hr_enq_valid | (hr_a_grant_valid & hr_store & hr_qout_st_beat_mask_lsb);
assign {nds_unused_co7,hr_byte_minus} = hr_byte - hr_mask_cnt_zexthr;
assign hr_byte_nx = hr_enq_valid ? hr_enq_byte : hr_byte_minus;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_byte <= {HR_MAX_BYTE_WIDTH{1'b0}};
    end
    else if (hr_byte_en) begin
        hr_byte <= hr_byte_nx;
    end
end

kv_vls_gen_mask #(
    .MW_CNT(HR_BYTE_WIDTH),
    .MW(HR_MASK_WIDTH)
) u_hr_vd_mask (
    .mask_cnt(hr_mask_cnt_sel),
    .mask_out(hr_qout_vd_mask)
);
assign hr_mask_cnt_sel = (hr_element & hr_widen) ? {{HR_BYTE_WIDTH - 2{1'b0}},2'd2} : hr_mask_cnt;
assign hr_element_num_dlen_byte_sel = (hr_element & hr_widen) ? {hr_element_num_dlen[ELE_DLEN_WIDTH - 1:1],1'b0} : hr_element_num_dlen_byte[ELE_DLEN_WIDTH - 1:0];
assign hr_qout_vd_bwe_offset = hr_element_num_dlen_byte_sel;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

