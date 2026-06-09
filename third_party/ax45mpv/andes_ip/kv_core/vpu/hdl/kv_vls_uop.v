// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_uop (
    vpu_vlsu_clk,
    vpu_reset_n,
    uopq_load_pending,
    uopq_store_pending,
    uopq_block_cmd,
    vlsq_req_valid,
    vlsq_req_ready,
    vlsq_req_first,
    vlsq_req_last,
    vlsq_req_pa,
    vlsq_req_base_offset,
    vlsq_req_vstart_byte,
    vlsq_req_prestart_cross,
    vlsq_req_mtype,
    vlsq_req_shareable,
    vlsq_req_hvm,
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
    vlsq_req_cross_4k,
    vlsq_req_cross_4k_d1,
    vlsq_req_cross_4k_d1_kill,
    vlsq2uop_cmt_valid,
    vlsq2uop_cmt_grant,
    vlsq2uop_cmt_kill,
    vlsq2uop_cmt_buf_valid,
    vlsq2uop_cmt_start_buf_num,
    uop_req_valid,
    uop_req_grant,
    uop_req_pa,
    uop_req_ctrl,
    uop_req_vd_emul_len,
    uop_req_vd_beats,
    uop_req_vd_seg_beats,
    uop_req_vd_buf_beats,
    uop_req_size,
    uop_req_putfull,
    uop_req_beat_cnt,
    uop_req_buf_opt,
    uop_req_buf_cross_revert,
    uop_req_buf_num,
    uop_req_buf_ptr,
    uop_req_element_num_dlen,
    uop_req_mask_cnt,
    uop_req_byte,
    uop_req_nf_cnt,
    uop_req_first,
    uop_req_last,
    uop_req_ele_dlen_last,
    uop_req_ele_seg_first,
    uop_req_ele_seg_last,
    uop_req_skip,
    uop_req_dlen_beat,
    uop_req_align,
    uop_req_bypass,
    uop_req_seg_buf_ptr,
    uop_req_buf_ptr_tl,
    uop_req_ucross,
    uop_req_uextra,
    uop_req_element_sel,
    uop_req_align_value,
    uop_req_umask_offset,
    uop_req_align_onehot_sel,
    uop_req_beat_mask,
    uop_req_st_beat_mask,
    uop_req_eseg_hp,
    uop_req_ustride_mutation,
    uop_claim_buf_valid,
    uop_claim_buf_size,
    uop_claim_buf_grant,
    uop_claim_buf_resp_num,
    vlsbuf_uop_claim_sel,
    buf_info_init_wsel,
    buf_info_init_value
);
parameter VLSU_SUPPORT_HVM = 1;
parameter XLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = DLEN / 8;
parameter ELEN = 64;
parameter VALEN = 39;
parameter PALEN = 38;
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
parameter DLEN_BYTE_WIDTH = 7;
parameter MAX_BYTE_WIDTH = 10;
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter UOPQ_DEPTH = 8;
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = 3;
parameter VRF_LW = 3;
parameter CL_OFFSET_WIDTH = 6;
parameter CL_BASE_WIDTH = 32;
parameter CL_BYTE_WIDTH = 7;
parameter BIU_OFFSET_WIDTH = 5;
parameter BIU_BASE_WIDTH = 33;
parameter BIU_BYTE_WIDTH = 6;
parameter BIU_DATA_WIDTH = 256;
parameter HVM_OFFSET_WIDTH = 6;
parameter HVM_BASE_WIDTH = 32;
parameter HVM_BYTE_WIDTH = 7;
parameter HVM_DATA_WIDTH = 1024;
parameter HR_OFFSET_WIDTH = 6;
parameter HR_MAX_BYTE_WIDTH = 5;
parameter HR_BYTE_WIDTH = 8;
parameter NF_BYTE_WIDTH = 6;
parameter BEAT_CNT_WIDTH = 1;
parameter SEG_DATA_WIDTH = 512;
parameter BUF_INFO_DW = 8;
localparam UOP_NR_CNT = $clog2(VLEN) + 3 - 9 + 1;
localparam UOP_VM_CNT = $clog2(VLEN) + 3 - $clog2(DLEN) + 1;
localparam UOP_CNT_WIDTH = (VLSU_SUPPORT_HVM & (UOP_VM_CNT > UOP_NR_CNT)) ? UOP_VM_CNT : UOP_NR_CNT;
localparam PRIVILEGE_USER = 2'b00;
localparam PRIVILEGE_SUPERVISOR = 2'b01;
localparam PRIVILEGE_HYPERVISOR = 2'b10;
localparam PRIVILEGE_MACHINE = 2'b11;
localparam DLEN_LMUL = 8 * (VLEN / DLEN);
localparam DLEN_SIZE = (DLEN == 1024) ? 3'd7 : (DLEN == 512) ? 3'd6 : (DLEN == 256) ? 3'd5 : (DLEN == 128) ? 3'd4 : 3'd3;
localparam BUF_VALID_WIDTH = 2 ** (VRF_LW - 1);
input vpu_vlsu_clk;
input vpu_reset_n;
output uopq_load_pending;
output uopq_store_pending;
output uopq_block_cmd;
input vlsq_req_valid;
output vlsq_req_ready;
input vlsq_req_first;
input vlsq_req_last;
input [PALEN - 1:0] vlsq_req_pa;
input [11:0] vlsq_req_base_offset;
input [MAX_BYTE_WIDTH - 1:0] vlsq_req_vstart_byte;
input vlsq_req_prestart_cross;
input [3:0] vlsq_req_mtype;
input vlsq_req_shareable;
input vlsq_req_hvm;
input [28 - 1:0] vlsq_req_ctrl;
input [VRF_LW - 1:0] vlsq_req_vd_emul_len;
input [VRF_LW - 1:0] vlsq_req_vd_beats;
input [VRF_LW - 1:0] vlsq_req_vd_seg_beats;
input [MAX_BYTE_WIDTH - 1:0] vlsq_req_byte;
input [MAX_BYTE_WIDTH - 1:0] vlsq_req_total_byte;
input [ELE_DLEN_WIDTH - 1:0] vlsq_req_element_num_dlen;
input vlsq_req_alive;
input vlsq_req_widen_alive;
input vlsq_req_dlen_last;
input vlsq_req_cross_4k;
input vlsq_req_cross_4k_d1;
input vlsq_req_cross_4k_d1_kill;
input vlsq2uop_cmt_valid;
output vlsq2uop_cmt_grant;
input vlsq2uop_cmt_kill;
input vlsq2uop_cmt_buf_valid;
input [BUF_DEPTH_LOG2 - 1:0] vlsq2uop_cmt_start_buf_num;
output uop_req_valid;
input uop_req_grant;
output [PALEN - 1:0] uop_req_pa;
output [25 - 1:0] uop_req_ctrl;
output [VRF_LW - 1:0] uop_req_vd_emul_len;
output [VRF_LW - 1:0] uop_req_vd_beats;
output [VRF_LW - 1:0] uop_req_vd_seg_beats;
output [VRF_LW - 1:0] uop_req_vd_buf_beats;
output [2:0] uop_req_size;
output uop_req_putfull;
output [BEAT_CNT_WIDTH - 1:0] uop_req_beat_cnt;
output uop_req_buf_opt;
output uop_req_buf_cross_revert;
output [BUF_DEPTH_LOG2 - 1:0] uop_req_buf_num;
output [BUF_DEPTH - 1:0] uop_req_buf_ptr;
output [ELE_DLEN_WIDTH - 1:0] uop_req_element_num_dlen;
output [HR_BYTE_WIDTH - 1:0] uop_req_mask_cnt;
output [HR_MAX_BYTE_WIDTH - 1:0] uop_req_byte;
output [3:0] uop_req_nf_cnt;
output uop_req_first;
output uop_req_last;
output uop_req_ele_dlen_last;
output uop_req_ele_seg_first;
output uop_req_ele_seg_last;
output uop_req_skip;
output uop_req_dlen_beat;
output uop_req_align;
output uop_req_bypass;
output [BUF_DEPTH - 1:0] uop_req_seg_buf_ptr;
output [BUF_DEPTH - 1:0] uop_req_buf_ptr_tl;
output uop_req_ucross;
output uop_req_uextra;
output uop_req_element_sel;
output [HR_OFFSET_WIDTH - 1:0] uop_req_align_value;
output [HR_OFFSET_WIDTH - 1:0] uop_req_umask_offset;
output [1:0] uop_req_align_onehot_sel;
output [3:0] uop_req_beat_mask;
output [3:0] uop_req_st_beat_mask;
output uop_req_eseg_hp;
output uop_req_ustride_mutation;
output uop_claim_buf_valid;
output [BUF_DEPTH_LOG2 - 1:0] uop_claim_buf_size;
input uop_claim_buf_grant;
input [BUF_DEPTH_LOG2 - 1:0] uop_claim_buf_resp_num;
output [BUF_DEPTH - 1:0] vlsbuf_uop_claim_sel;
output [BUF_DEPTH - 1:0] buf_info_init_wsel;
output [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_init_value;





// 54cc6122 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
localparam DLEN_BYTE_BIT = $clog2(DLEN / 8);


wire dlen_biu_1_1 = (DLEN / BIU_DATA_WIDTH == 1);
wire dlen_biu_2_1 = (DLEN / BIU_DATA_WIDTH == 2);
wire uop_enq_ptr_en;
wire uop_req_ptr_en;
wire uop_cmt_ptr_en;
wire [UOPQ_DEPTH - 1:0] uop_enq_ptr;
wire [UOPQ_DEPTH - 1:0] uop_req_ptr;
wire [UOPQ_DEPTH - 1:0] uop_cmt_ptr;
wire [UOPQ_DEPTH - 1:0] uop_enq_sel;
wire [UOPQ_DEPTH - 1:0] uop_cmt_sel;
wire [UOPQ_DEPTH - 1:0] uop_req_grant_sel;
wire uop_cmt_kill;
wire vlsq2uop_cmt_ready;
wire vlsq2uop_cmt_buf_grant;
wire [BUF_DEPTH_LOG2 - 1:0] uop_cmt_start_buf_num;
wire [UOPQ_DEPTH - 1:0] uop_deq_sel;
wire vlsq_req_grant;
wire pma_vlsu_resp_cable;
wire pma_vlsu_resp_ucable;
wire pma_vlsu_resp_device;
wire vlsq_req_mmode;
wire vlsq_req_smode;
wire vlsq_req_umode;
wire [PALEN - 1:0] uop_enq_pa;
wire [11:0] uop_enq_base_offset;
wire [MAX_BYTE_WIDTH - 1:0] uop_enq_vstart_byte;
wire uop_enq_prestart_cross;
wire [25 - 1:0] uop_enq_ctrl;
wire uop_enq_first;
wire uop_enq_last;
wire uop_enq_ele_dlen_last;
wire [VRF_LW - 1:0] uop_enq_vd_emul_len;
wire [VRF_LW - 1:0] uop_enq_vd_beats;
wire [VRF_LW - 1:0] uop_enq_vd_seg_beats;
wire uop_enq_cross_4k;
wire uop_enq_cross_4k_d1;
wire [UOPQ_DEPTH - 1:0] uop_enq_cross_4k_d1_kill;
wire uop_enq_alive;
wire [MAX_BYTE_WIDTH - 1:0] uop_enq_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_enq_total_byte;
wire [ELE_DLEN_WIDTH - 1:0] uop_enq_element_num_dlen;
wire [UOPQ_DEPTH - 1:0] uop_ent_ready;
wire [UOPQ_DEPTH - 1:0] uop_ent_valid;
wire [UOPQ_DEPTH - 1:0] uop_ent_cmt_ready;
wire [(UOPQ_DEPTH * PALEN) - 1:0] uop_ent_pa;
wire [(UOPQ_DEPTH * 25) - 1:0] uop_ent_ctrl;
wire [UOPQ_DEPTH - 1:0] uop_ent_first;
wire [UOPQ_DEPTH - 1:0] uop_ent_last;
wire [UOPQ_DEPTH - 1:0] uop_ent_ele_dlen_last;
wire [(UOPQ_DEPTH * VRF_LW) - 1:0] uop_ent_vd_emul_len;
wire [(UOPQ_DEPTH * VRF_LW) - 1:0] uop_ent_vd_beats;
wire [(UOPQ_DEPTH * VRF_LW) - 1:0] uop_ent_vd_seg_beats;
wire [UOPQ_DEPTH - 1:0] uop_ent_load;
wire [UOPQ_DEPTH - 1:0] uop_ent_store;
wire [UOPQ_DEPTH - 1:0] uop_ent_block_cmd;
wire [(UOPQ_DEPTH * MAX_BYTE_WIDTH) - 1:0] uop_ent_byte;
wire [(UOPQ_DEPTH * MAX_BYTE_WIDTH) - 1:0] uop_ent_alive_byte;
wire [(UOPQ_DEPTH * MAX_BYTE_WIDTH) - 1:0] uop_ent_total_byte;
wire [(UOPQ_DEPTH * BUF_DEPTH_LOG2) - 1:0] uop_ent_start_buf_num;
wire [(UOPQ_DEPTH * ELE_DLEN_WIDTH) - 1:0] uop_ent_element_num_dlen;
wire [(UOPQ_DEPTH * MAX_BYTE_WIDTH) - 1:0] uop_ent_vstart_byte;
wire [UOPQ_DEPTH - 1:0] uop_ent_killed;
wire [UOPQ_DEPTH - 1:0] uop_ent_claim_buf_valid;
wire [UOPQ_DEPTH - 1:0] uop_ent_alive;
wire uop_valid;
wire uop_bypass_valid;
wire uop_cmtted_valid;
wire uop_alive;
wire uop_store;
wire uop_load;
wire uop_hvm;
wire [PALEN - 1:0] uop_pa;
wire [MAX_BYTE_WIDTH - 1:0] uop_pa_offset_hr;
wire [HR_OFFSET_WIDTH - 1:0] uop_pa_offset;
wire [DLEN_BYTE_WIDTH - 1:0] uop_pa_offset_zext;
wire [25 - 1:0] uop_ctrl;
wire [VRF_LW - 1:0] uop_vd_emul_len;
wire [VRF_LW - 1:0] uop_vd_beats;
wire [VRF_LW - 1:0] uop_vd_seg_beats;
wire [VRF_LW - 1:0] uop_vd_buf_beats;
wire [VRF_LW - 1:0] uop_buf_beats;
wire [VRF_LW - 1:0] uop_buf_beats_sel;
wire [VRF_LW:0] uop_buf_beats_sel_add1;
wire [BUF_DEPTH_LOG2:0] uop_buf_beats_sel_add1_zext;
wire [VRF_LW:0] uop_vd_beats_add1;
wire [BUF_DEPTH_LOG2:0] uop_vd_seg_beats_add1;
wire [VRF_LW:0] uop_vd_seg_beats_widen;
wire [VRF_LW:0] uop_vd_seg_beats_widen_add1;
wire [VRF_LW - 1:0] uop_end_buf_num_offset;
wire [BUF_DEPTH_LOG2 - 1:0] uop_end_buf_num_offset_zext;
wire [3:0] uop_vd_beats_zext;
wire [MAX_BYTE_WIDTH - 1:0] uop_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_total_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_alive_byte;
wire [BUF_DEPTH_LOG2 - 1:0] uop_start_buf_num;
wire [BUF_DEPTH_LOG2 - 1:0] uop_end_buf_num;
wire [BUF_DEPTH_LOG2 - 1:0] uop_start_buf_num_sel;
wire uop_start_buf_bypass;
wire [ELE_DLEN_WIDTH - 1:0] uop_element_num_dlen;
wire uop_element_num_dlen_elast;
wire uop_element_num_dlen_ulast;
wire uop_element_last_reserve;
wire uop_element_skip;
wire uop_ustride_reserve;
wire uop_first;
wire uop_last;
wire uopq_first;
wire uopq_last;
wire uop_killed;
wire uop_keep_first_en;
wire uop_keep_first_set;
wire uop_keep_first_clr;
wire uop_keep_first_nx;
reg uop_keep_first;
wire uop_keep_unalign_en;
wire uop_keep_unalign_set;
wire uop_keep_unalign_clr;
wire uop_keep_unalign_nx;
reg uop_keep_unalign;
wire [HR_MAX_BYTE_WIDTH - 1:0] uop_byte_sel;
wire [CL_BYTE_WIDTH - 1:0] uop_access_byte;
wire [CL_BYTE_WIDTH - 1:0] uop_access_byte_minus1;
wire [MAX_BYTE_WIDTH - 1:0] uop_offer_byte_biu;
wire [MAX_BYTE_WIDTH - 1:0] uop_offer_byte_hvm;
wire [MAX_BYTE_WIDTH - 1:0] uop_offer_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_byte2element;
wire [3:0] uop_beat_mask;
wire [PALEN - 1:0] uop_pa_mask;
wire [HR_MAX_BYTE_WIDTH - 1:0] uop_nf_cnt;
wire [3:0] uop_nf_cnt_minus1;
wire uop_eseg2u_trans_biu;
wire uop_eseg2u_trans_hvm;
wire uop_eseg2u_trans;
wire uop_seg_info_en;
wire [NF_BYTE_WIDTH - 1:0] uop_eseg_align_byte_nx;
wire [HR_MAX_BYTE_WIDTH - 1:0] uop_eseg_align_byte_add;
wire [7:0] uop_eseg_align_byte_zext;
reg [NF_BYTE_WIDTH - 1:0] uop_eseg_align_byte;
wire [HR_BYTE_WIDTH - 1:0] uop_emask_cnt;
wire [HR_BYTE_WIDTH - 1:0] uop_umask_cnt;
wire [HR_BYTE_WIDTH - 1:0] uop_ld_umask_cnt;
wire [HR_BYTE_WIDTH - 1:0] uop_st_umask_cnt;
wire [HR_BYTE_WIDTH - 1:0] uop_st_umask_cnt_adj;
wire uop_mask_exceed_check;
wire [DLEN_BYTE_WIDTH - 1:0] uop_remain_byte_dlen;
wire [HR_BYTE_WIDTH - 1:0] uop_bus_offer_byte;
wire [7:0] uop_bus_offer_byte_zext;
wire [MAX_BYTE_WIDTH - 1:0] uop_remain_byte_biu_nx;
wire [MAX_BYTE_WIDTH - 1:0] uop_remain_byte_hvm_nx;
wire [MAX_BYTE_WIDTH - 1:0] uop_remain_byte_nx;
wire [MAX_BYTE_WIDTH - 1:0] uop_alive_byte_update;
reg [HR_OFFSET_WIDTH - 1:0] uop_keep_pa_offset;
wire [HR_OFFSET_WIDTH - 1:0] uop_keep_pa_offset_sel;
wire [DLEN_BYTE_WIDTH - 1:0] uop_keep_pa_offset_zext;
wire uop_align_cl;
wire uop_align_biu;
wire uop_align_hvm;
wire uop_align_bus;
wire uop_misalign_cl;
wire uop_misalign_biu;
wire uop_misalign_hvm;
wire uop_misalign_bus;
wire uop_align_access;
wire uop_misalign_access;
wire uop_widen;
wire uop_widen_alive;
wire [2:0] uop_vd_eew;
wire uop_vd_eew8;
wire uop_vd_eew16;
wire uop_vd_eew32;
wire uop_vd_eew64;
wire [2:0] uop_size;
wire [BEAT_CNT_WIDTH - 1:0] uop_beat_cnt;
wire uop_cross_cl_en;
wire uop_cross_hvm_en;
wire uop_cross_en;
wire [MAX_BYTE_WIDTH - 1:0] uop_byte_sel_zext;
wire uop_req_cnt_en;
wire [UOP_CNT_WIDTH - 1:0] uop_req_cnt_nx;
wire [UOP_CNT_WIDTH - 1:0] uop_req_cnt_add1;
reg [UOP_CNT_WIDTH - 1:0] uop_req_cnt;
wire uop_req_byte_zero;
wire uop_strided;
wire uop_ustride_native;
wire uop_ustride_mutation;
wire uop_ustride_all;
wire uop_eseg_hp;
wire uop_indexed;
wire uop_element;
wire uop_seg;
wire uop_eseg;
wire uop_useg;
wire uop_ustride_nseg;
wire uop_element_buf_num_en0;
wire uop_element_buf_num_en1;
wire uop_buf_cross_revert;
wire uop_buf_opt;
wire uop_buf_num_en;
wire uop_buf_num_revert;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_nx;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_add;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_sub;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_inc_sel;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_sel;
wire [VRF_LW - 1:0] uop_buf_num_uoffset;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_uoffset_zext;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_eoffset;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_eseg_offset_zext;
wire [VRF_LW - 1:0] uop_buf_num_eseg_offset;
wire [BUF_DEPTH_LOG2 - 1:0] uop_buf_num_offset;
reg [BUF_DEPTH_LOG2 - 1:0] uop_buf_num;
wire [PALEN - 1:0] uop_pa_cl_nx;
wire [PALEN - 1:0] uop_pa_hvm_nx;
wire [PALEN - 1:0] uop_pa_cross_nx;
wire uop_putfull_cond;
wire [BEAT_CNT_WIDTH - 1:0] uop_size_beat;
wire [BEAT_CNT_WIDTH - 1:0] uop_pa_beat;
wire [BEAT_CNT_WIDTH - 1:0] uop_beat_xor;
wire [BEAT_CNT_WIDTH - 1:0] uop_beat_diff;
wire [2:0] biu_data_size;
wire [2:0] hvm_data_size;
wire [2:0] hr_data_size;
wire [2:0] uop_beat_num;
wire uop_beat_num1;
wire uop_beat_num2;
wire uop_beat_num4;
wire uop_req_elememt_skip;
wire uop_req_ustride_skip;
wire uop_req_prestart_done;
wire [MAX_BYTE_WIDTH - 1:0] uop_vstart_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_vstart_byte_nx;
wire [MAX_BYTE_WIDTH - 1:0] uop_remain_vstart_byte_nx;
reg [BUF_DEPTH_LOG2 - 1:0] uop_seg_buf_num;
wire [BUF_DEPTH_LOG2 - 1:0] uop_seg_buf_num_nx;
reg uop_seg_cross_d1;
wire uop_seg_cross_d1_nx;
wire [2:0] uop_nf;
wire [3:0] uop_nf_add1;
wire [NF_BYTE_WIDTH - 1:0] uop_remain_byte_seg;
wire [7:0] uop_remain_byte_seg_zext;
wire [NF_BYTE_WIDTH - 1:0] uop_seg_byte_init;
wire [HR_BYTE_WIDTH - 1:0] uop_eseg_mask_cnt;
wire uop_ele_seg_first_set;
wire uop_ele_seg_first_clr;
wire uop_ele_seg_first_en;
wire uop_ele_seg_first_nx;
reg uop_ele_seg_first;
wire [ELE_DLEN_WIDTH - 1:0] uop_element_num_dlen_add1;
wire [BUF_DEPTH - 1:0] buf_info_ptr;
wire buf_info_ustride_wvalid;
wire buf_info_element_wvalid;
wire buf_info_seg_wvalid;
wire [DLEN_BYTE_WIDTH - 1:0] buf_info_element_value;
wire [BUF_INFO_DW - 1:0] buf_info_element_value_zext;
wire buf_info_init_wvalid;
wire buf_info_init_eseg_wvalid;
wire buf_info_init_useg_wvalid;
wire [1:0] buf_info_ustride_last;
wire [1:0] buf_info_ustride_last_2_1;
wire [1:0] buf_info_ustride_last_1_1;
wire [BUF_VALID_WIDTH - 1:0] uop_ustride_valid_hvm0;
wire [BUF_VALID_WIDTH - 1:0] uop_ustride_valid_hvm1;
wire [BUF_INFO_DW - 1:0] uop_ustride_cnt_hvm0;
wire [BUF_INFO_DW - 1:0] uop_ustride_cnt_hvm1;
wire [BUF_VALID_WIDTH - 1:0] uop_ustride_last_valid_ff;
wire uop_ustride_last_hvm0;
wire uop_ustride_last_hvm1;
wire [BUF_VALID_WIDTH - 1:0] uop_ustride_last_valid_hvm;
wire element_info_cnt_en;
wire element_info_cnt_reset;
wire [ELE_DLEN_WIDTH - 1:0] element_info_cnt_add;
wire [ELE_DLEN_WIDTH - 1:0] element_info_cnt_offset;
wire [ELE_DLEN_WIDTH - 1:0] element_info_uoffset;
wire [ELE_DLEN_WIDTH - 1:0] element_info_cnt_nx;
reg [ELE_DLEN_WIDTH - 1:0] element_info_cnt;
wire [ELE_DLEN_WIDTH - 1:0] element_info_cnt_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_exceed_dlen_byte;
wire [MAX_BYTE_WIDTH - 1:0] uop_exceed_dlen_byte_minus1;
wire [DLEN_BYTE_WIDTH - 1:0] uop_exceed_dlen_num;
wire uop_exceed_dlen_en;
wire uop_ld_ucross;
wire uop_st_ucross;
wire uop_st_uextra;
wire [BUF_DEPTH_LOG2:0] buf_info_size;
reg [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_ustride_value;
wire [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_ustride_value_hvm;
wire [DLEN_BYTE_WIDTH - 1:0] uop_ustride_byte_cnt_last;
wire [7:0] uop_dlen_byte_init;
wire [7:0] uop_dlen_byte_half_init;
wire [1:0] buf_info_bypass_cnt;
wire [1:0] buf_info_unbypass_cnt;
wire [BUF_INFO_DW - 1:0] buf_info_ustride_cnt_init;
wire [1:0] buf_info_ustride_cnt_last;
wire [7:0] uop_biu_byte_init;
wire [7:0] uop_hvm_byte_init;
wire [HR_BYTE_WIDTH - 1:0] uop_bus_byte_init;
wire [DLEN_BYTE_WIDTH - 1:0] uop_bus_byte_init_zext2dlen;
wire [DLEN_BYTE_WIDTH:0] byte_cnt_exceed_last;
wire [HR_OFFSET_WIDTH - 1:0] uop_align_value_byte;
wire uop_shift_value_uf;
wire [ELE_DLEN_WIDTH - 1:0] uop_shift_value_byte;
wire [ELE_DLEN_WIDTH - 1:0] uop_element_num_byte;
wire [ELE_DLEN_WIDTH - 1:0] uop_element_num_align;
wire uop_align_value_msb;
wire uop_estore_revert;
wire [1:0] uop_estore_default_2_1;
wire [1:0] uop_estore_onehot;
reg [1:0] uop_ustore_onehot;
wire [1:0] uop_ustore_onehot_sel;
wire [1:0] uop_ustore_onehot_nx;
wire [1:0] uop_ustore_onehot_init;
wire uop_req_prestart_hit;
wire [MAX_BYTE_WIDTH - 1:0] uop_st_vstart_location;
wire [1:0] uop_st_vstart_beat_num;
wire [3:0] uop_st_vstart_beat_mask;
wire [3:0] uop_st_vstart_beat_sel;
wire [3:0] uop_st_vstart_beat_shift;
wire [1:0] uop_st_vstart_beat_minus;
wire [MAX_BYTE_WIDTH - 1:0] uop_st_ustride_byte;
wire [HR_OFFSET_WIDTH - 1:0] uop_st_umask_offset;
wire [HR_BYTE_WIDTH - 1:0] uop_st_umask_cnt_first;
wire [HR_MAX_BYTE_WIDTH - 1:0] uop_st_umask_cnt_first_zext;
wire [HR_BYTE_WIDTH - 1:0] uop_st_umask_cnt_first_sel;
wire nds_unused_co1;
wire nds_unused_co2;
wire nds_unused_co4;
wire nds_unused_co5;
wire nds_unused_co6;
wire nds_unused_co7;
wire nds_unused_co8;
wire nds_unused_co9;
wire nds_unused_co10;
wire nds_unused_co12;
wire nds_unused_co13;
wire nds_unused_co14;
wire nds_unused_co15;
wire nds_unused_co16;
wire nds_unused_co17;
wire nds_unused_co18;
wire nds_unused_co19;
wire nds_unused_co20;
wire nds_unused_co21;
wire nds_unused_co22;
wire nds_unused_co23;
wire nds_unused_co24;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr0;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr1;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr2;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr3;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr4;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr5;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr6;
wire [BUF_DEPTH - 1:0] nds_unused_uop_seg_buf_ptr7;
generate
    genvar i;
    for (i = 0; i < UOPQ_DEPTH; i = i + 1) begin:gen_vls_uop_ent
        kv_vls_uop_ent #(
            .DLEN(DLEN),
            .PALEN(PALEN),
            .VRF_LW(VRF_LW),
            .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
            .MAX_BYTE_WIDTH(MAX_BYTE_WIDTH),
            .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
            .HR_OFFSET_WIDTH(HR_OFFSET_WIDTH),
            .BIU_OFFSET_WIDTH(BIU_OFFSET_WIDTH),
            .HVM_OFFSET_WIDTH(HVM_OFFSET_WIDTH)
        ) u_vls_uop_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .uop_enq_valid(uop_enq_sel[i]),
            .uop_deq_valid(uop_deq_sel[i]),
            .uop_cmt_valid(uop_cmt_sel[i]),
            .uop_enq_cross_4k_d1_kill(uop_enq_cross_4k_d1_kill[i]),
            .uop_cmt_kill(uop_cmt_kill),
            .uop_cmt_start_buf_num(uop_cmt_start_buf_num),
            .uop_enq_pa(uop_enq_pa),
            .uop_enq_base_offset(uop_enq_base_offset),
            .uop_enq_vstart_byte(uop_enq_vstart_byte),
            .uop_enq_prestart_cross(uop_enq_prestart_cross),
            .uop_enq_ctrl(uop_enq_ctrl),
            .uop_enq_first(uop_enq_first),
            .uop_enq_last(uop_enq_last),
            .uop_enq_ele_dlen_last(uop_enq_ele_dlen_last),
            .uop_enq_vd_emul_len(uop_enq_vd_emul_len),
            .uop_enq_vd_beats(uop_enq_vd_beats),
            .uop_enq_vd_seg_beats(uop_enq_vd_seg_beats),
            .uop_enq_cross_4k(uop_enq_cross_4k),
            .uop_enq_cross_4k_d1(uop_enq_cross_4k_d1),
            .uop_enq_alive(uop_enq_alive),
            .uop_enq_byte(uop_enq_byte),
            .uop_enq_total_byte(uop_enq_total_byte),
            .uop_enq_element_num_dlen(uop_enq_element_num_dlen),
            .uop_req_grant_valid(uop_req_grant_sel[i]),
            .uop_req_prestart_done(uop_req_prestart_done),
            .uop_pa_cross_nx(uop_pa_cross_nx),
            .uop_remain_byte_nx(uop_remain_byte_nx),
            .uop_remain_vstart_byte_nx(uop_remain_vstart_byte_nx),
            .uop_alive_byte_update(uop_alive_byte_update),
            .uop_qout_ready(uop_ent_ready[i]),
            .uop_qout_valid(uop_ent_valid[i]),
            .uop_qout_cmt_ready(uop_ent_cmt_ready[i]),
            .uop_qout_pa(uop_ent_pa[i * PALEN +:PALEN]),
            .uop_qout_ctrl(uop_ent_ctrl[i * 25 +:25]),
            .uop_qout_first(uop_ent_first[i]),
            .uop_qout_last(uop_ent_last[i]),
            .uop_qout_ele_dlen_last(uop_ent_ele_dlen_last[i]),
            .uop_qout_vd_emul_len(uop_ent_vd_emul_len[i * VRF_LW +:VRF_LW]),
            .uop_qout_vd_beats(uop_ent_vd_beats[i * VRF_LW +:VRF_LW]),
            .uop_qout_vd_seg_beats(uop_ent_vd_seg_beats[i * VRF_LW +:VRF_LW]),
            .uop_qout_load(uop_ent_load[i]),
            .uop_qout_store(uop_ent_store[i]),
            .uop_qout_block_cmd(uop_ent_block_cmd[i]),
            .uop_qout_byte(uop_ent_byte[i * MAX_BYTE_WIDTH +:MAX_BYTE_WIDTH]),
            .uop_qout_alive_byte(uop_ent_alive_byte[i * MAX_BYTE_WIDTH +:MAX_BYTE_WIDTH]),
            .uop_qout_total_byte(uop_ent_total_byte[i * MAX_BYTE_WIDTH +:MAX_BYTE_WIDTH]),
            .uop_qout_start_buf_num(uop_ent_start_buf_num[i * BUF_DEPTH_LOG2 +:BUF_DEPTH_LOG2]),
            .uop_qout_element_num_dlen(uop_ent_element_num_dlen[i * ELE_DLEN_WIDTH +:ELE_DLEN_WIDTH]),
            .uop_qout_vstart_byte(uop_ent_vstart_byte[i * MAX_BYTE_WIDTH +:MAX_BYTE_WIDTH]),
            .uop_qout_killed(uop_ent_killed[i]),
            .uop_qout_claim_buf_valid(uop_ent_claim_buf_valid[i]),
            .uop_qout_alive(uop_ent_alive[i])
        );
    end
endgenerate
kv_cnt_onehot #(
    .N(UOPQ_DEPTH)
) u_uop_enq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(uop_enq_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({UOPQ_DEPTH{1'b0}}),
    .cnt(uop_enq_ptr)
);
kv_cnt_onehot #(
    .N(UOPQ_DEPTH)
) u_uop_req_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(uop_req_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({UOPQ_DEPTH{1'b0}}),
    .cnt(uop_req_ptr)
);
kv_cnt_onehot #(
    .N(UOPQ_DEPTH)
) u_uop_cmt_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(uop_cmt_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({UOPQ_DEPTH{1'b0}}),
    .cnt(uop_cmt_ptr)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_cmtted_valid (
    .out(uop_cmtted_valid),
    .sel(uop_req_ptr),
    .in(uop_ent_valid)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(PALEN)
) u_uop_pa (
    .out(uop_pa),
    .sel(uop_req_ptr),
    .in(uop_ent_pa)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(25)
) u_uop_ctrl (
    .out(uop_ctrl),
    .sel(uop_req_ptr),
    .in(uop_ent_ctrl)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(VRF_LW)
) u_uop_vd_emul_len (
    .out(uop_vd_emul_len),
    .sel(uop_req_ptr),
    .in(uop_ent_vd_emul_len)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(VRF_LW)
) u_uop_vd_beats (
    .out(uop_vd_beats),
    .sel(uop_req_ptr),
    .in(uop_ent_vd_beats)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(VRF_LW)
) u_uop_vd_seg_beats (
    .out(uop_vd_seg_beats),
    .sel(uop_req_ptr),
    .in(uop_ent_vd_seg_beats)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(MAX_BYTE_WIDTH)
) u_uop_byte (
    .out(uop_byte),
    .sel(uop_req_ptr),
    .in(uop_ent_byte)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(BUF_DEPTH_LOG2)
) u_uop_start_buf_num (
    .out(uop_start_buf_num),
    .sel(uop_req_ptr),
    .in(uop_ent_start_buf_num)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(ELE_DLEN_WIDTH)
) u_uop_element_num_dlen (
    .out(uop_element_num_dlen),
    .sel(uop_req_ptr),
    .in(uop_ent_element_num_dlen)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_killed (
    .out(uop_killed),
    .sel(uop_req_ptr),
    .in(uop_ent_killed)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_claim_buf_valid (
    .out(uop_claim_buf_valid),
    .sel(uop_req_ptr),
    .in(uop_ent_claim_buf_valid)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(MAX_BYTE_WIDTH)
) u_uop_total_byte (
    .out(uop_total_byte),
    .sel(uop_req_ptr),
    .in(uop_ent_total_byte)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(MAX_BYTE_WIDTH)
) u_uop_alive_byte (
    .out(uop_alive_byte),
    .sel(uop_req_ptr),
    .in(uop_ent_alive_byte)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_alive (
    .out(uop_alive),
    .sel(uop_req_ptr),
    .in(uop_ent_alive)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_first (
    .out(uop_first),
    .sel(uop_req_ptr),
    .in(uop_ent_first)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_last (
    .out(uop_last),
    .sel(uop_req_ptr),
    .in(uop_ent_last)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(1)
) u_uop_element_num_dlen_elast (
    .out(uop_element_num_dlen_elast),
    .sel(uop_req_ptr),
    .in(uop_ent_ele_dlen_last)
);
kv_mux_onehot #(
    .N(UOPQ_DEPTH),
    .W(MAX_BYTE_WIDTH)
) u_uop_vstart_byte (
    .out(uop_vstart_byte),
    .sel(uop_req_ptr),
    .in(uop_ent_vstart_byte)
);
kv_vls_cross_check #(
    .ADDR_WIDTH(PALEN),
    .BYTE_WIDTH(MAX_BYTE_WIDTH),
    .CROSS_BIT(CL_OFFSET_WIDTH)
) u_kv_vls_cross_cacheline (
    .check_en(1'b1),
    .addr(uop_pa),
    .access_bytes(uop_byte[MAX_BYTE_WIDTH - 1:0]),
    .addr_cross_nx(uop_pa_cl_nx),
    .remaining_byte(uop_remain_byte_biu_nx),
    .avaliable_byte(uop_offer_byte_biu),
    .cross_en(uop_cross_cl_en)
);
kv_vls_cross_check #(
    .ADDR_WIDTH(PALEN),
    .BYTE_WIDTH(MAX_BYTE_WIDTH),
    .CROSS_BIT(HVM_OFFSET_WIDTH)
) u_kv_vls_cross_hvm (
    .check_en(1'b1),
    .addr(uop_pa),
    .access_bytes(uop_byte[MAX_BYTE_WIDTH - 1:0]),
    .addr_cross_nx(uop_pa_hvm_nx),
    .remaining_byte(uop_remain_byte_hvm_nx),
    .avaliable_byte(uop_offer_byte_hvm),
    .cross_en(uop_cross_hvm_en)
);
kv_bin2onehot #(
    .N(BUF_DEPTH)
) u_uop_req_buf_ptr (
    .out(uop_req_buf_ptr),
    .in(uop_req_buf_num)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vls_gen_buf_info_ptr (
    .en(buf_info_init_wvalid),
    .in(uop_req_buf_ptr),
    .num(buf_info_size),
    .out(buf_info_ptr)
);
kv_vls_gen_buf_info_hvm #(
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .BUF_INFO_DW(BUF_INFO_DW)
) u_vls_gen_buf_info_hvm (
    .uop_start_buf_num(uop_start_buf_num_sel),
    .uop_ustride_cnt_hvm0(uop_ustride_cnt_hvm0),
    .uop_ustride_cnt_hvm1(uop_ustride_cnt_hvm1),
    .buf_info_ustride_value_hvm(buf_info_ustride_value_hvm)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_uop_req_buf_ptr_tl (
    .en(uop_valid),
    .in(uop_req_buf_ptr),
    .num(uop_buf_beats_sel_add1_zext),
    .out(uop_req_buf_ptr_tl)
);
kv_vls_seg_xptr #(
    .VLEN(VLEN),
    .DLEN(DLEN),
    .BUF_DEPTH(BUF_DEPTH)
) u_vls_element_seg_ptr (
    .nf_add1(uop_req_nf_cnt),
    .emul_len(uop_vd_beats_zext),
    .start_ptr(uop_req_buf_ptr),
    .seg_ptr(uop_req_seg_buf_ptr),
    .xptr0(nds_unused_uop_seg_buf_ptr0),
    .xptr1(nds_unused_uop_seg_buf_ptr1),
    .xptr2(nds_unused_uop_seg_buf_ptr2),
    .xptr3(nds_unused_uop_seg_buf_ptr3),
    .xptr4(nds_unused_uop_seg_buf_ptr4),
    .xptr5(nds_unused_uop_seg_buf_ptr5),
    .xptr6(nds_unused_uop_seg_buf_ptr6),
    .xptr7(nds_unused_uop_seg_buf_ptr7)
);
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(HR_OFFSET_WIDTH)
) u_uop_pa_offset_zext (
    .out(uop_pa_offset_zext),
    .in(uop_pa_offset)
);
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(HR_OFFSET_WIDTH)
) u_uop_keep_pa_offset_zext (
    .out(uop_keep_pa_offset_zext),
    .in(uop_keep_pa_offset_sel)
);
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(HR_BYTE_WIDTH)
) u_uop_bus_byte_init_zext2dlen (
    .out(uop_bus_byte_init_zext2dlen),
    .in(uop_bus_byte_init[HR_BYTE_WIDTH - 1:0])
);
kv_zero_ext #(
    .OW(8),
    .IW(HR_BYTE_WIDTH)
) u_uop_bus_offer_byte_zext (
    .out(uop_bus_offer_byte_zext),
    .in(uop_bus_offer_byte)
);
kv_zero_ext #(
    .OW(8),
    .IW(NF_BYTE_WIDTH)
) u_uop_remain_byte_seg_zext (
    .out(uop_remain_byte_seg_zext),
    .in(uop_remain_byte_seg)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2),
    .IW(VRF_LW)
) u_uop_end_buf_num_offset_zext (
    .out(uop_end_buf_num_offset_zext),
    .in(uop_end_buf_num_offset)
);
kv_zero_ext #(
    .OW(4),
    .IW(VRF_LW)
) u_uop_vd_beats_zext (
    .out(uop_vd_beats_zext),
    .in(uop_vd_beats)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2 + 1),
    .IW(VRF_LW + 1)
) u_uop_buf_beats_sel_add1_zext (
    .out(uop_buf_beats_sel_add1_zext),
    .in(uop_buf_beats_sel_add1)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2),
    .IW(VRF_LW)
) u_uop_buf_num_uoffset_zext (
    .out(uop_buf_num_uoffset_zext),
    .in(uop_buf_num_uoffset)
);
kv_zero_ext #(
    .OW(BUF_INFO_DW),
    .IW(DLEN_BYTE_WIDTH)
) u_buf_info_element_value_zext (
    .out(buf_info_element_value_zext),
    .in(buf_info_element_value)
);
kv_zero_ext #(
    .OW(MAX_BYTE_WIDTH),
    .IW(HR_MAX_BYTE_WIDTH)
) u_uop_byte_sel_zext (
    .out(uop_byte_sel_zext),
    .in(uop_byte_sel)
);
kv_zero_ext #(
    .OW(HR_MAX_BYTE_WIDTH),
    .IW(HR_BYTE_WIDTH)
) u_uop_st_umask_cnt_first_zext (
    .out(uop_st_umask_cnt_first_zext),
    .in(uop_st_umask_cnt_first)
);
assign uop_biu_byte_init = (BIU_DATA_WIDTH == 128) ? 8'd16 : (BIU_DATA_WIDTH == 256) ? 8'd32 : 8'd64;
assign uop_hvm_byte_init = (HVM_DATA_WIDTH == 128) ? 8'd16 : (HVM_DATA_WIDTH == 256) ? 8'd32 : (HVM_DATA_WIDTH == 512) ? 8'd64 : 8'd128;
assign uop_dlen_byte_init = (DLEN == 1024) ? 8'd128 : (DLEN == 512) ? 8'd64 : (DLEN == 256) ? 8'd32 : 8'd16;
assign uop_dlen_byte_half_init = (DLEN == 1024) ? 8'd64 : (DLEN == 512) ? 8'd32 : (DLEN == 256) ? 8'd16 : 8'd8;
assign uopq_load_pending = |uop_ent_load;
assign uopq_store_pending = |uop_ent_store;
assign uopq_block_cmd = |uop_ent_block_cmd;
assign vlsq_req_ready = |(uop_enq_ptr & uop_ent_ready);
assign vlsq_req_grant = vlsq_req_valid & vlsq_req_ready;
assign vlsq2uop_cmt_ready = |(uop_cmt_ptr & uop_ent_cmt_ready);
assign vlsq2uop_cmt_grant = vlsq2uop_cmt_valid & vlsq2uop_cmt_ready;
assign uop_cmt_kill = vlsq2uop_cmt_kill;
assign uop_cmt_start_buf_num = vlsq2uop_cmt_start_buf_num;
assign uop_enq_ptr_en = vlsq_req_grant & ((~vlsq_req_ctrl[20] & ~vlsq_req_cross_4k) | vlsq_req_ctrl[20]) | (|uop_enq_cross_4k_d1_kill);
assign uop_req_ptr_en = (uop_req_grant & uopq_last) | (uop_valid & uop_element_skip) | uop_killed;
assign uop_cmt_ptr_en = vlsq2uop_cmt_grant;
assign uop_enq_sel = {UOPQ_DEPTH{vlsq_req_grant}} & uop_enq_ptr;
assign uop_cmt_sel = {UOPQ_DEPTH{uop_cmt_ptr_en}} & uop_cmt_ptr;
assign uop_deq_sel = {UOPQ_DEPTH{uop_req_ptr_en}} & uop_req_ptr;
assign uop_req_grant_sel = {UOPQ_DEPTH{uop_req_grant}} & uop_req_ptr;
assign uop_enq_ctrl[4] = vlsq_req_ctrl[4];
assign uop_enq_ctrl[17] = vlsq_req_ctrl[17];
assign uop_enq_ctrl[19] = vlsq_req_ctrl[20];
assign uop_enq_ctrl[18] = vlsq_req_ctrl[18];
assign uop_enq_ctrl[3] = vlsq_req_ctrl[3];
assign uop_enq_ctrl[14] = vlsq_req_ctrl[15];
assign uop_enq_ctrl[1] = vlsq_req_ctrl[2];
assign uop_enq_ctrl[9 +:3] = vlsq_req_ctrl[9 +:3];
assign uop_enq_ctrl[20 +:3] = vlsq_req_ctrl[22 +:3];
assign uop_enq_ctrl[23] = vlsq_req_ctrl[27];
assign uop_enq_ctrl[15] = vlsq_req_ctrl[16];
assign uop_enq_ctrl[0] = vlsq_req_ctrl[1];
assign uop_enq_ctrl[5 +:4] = vlsq_req_mtype;
assign uop_enq_ctrl[16] = vlsq_req_shareable;
assign uop_enq_ctrl[2] = vlsq_req_hvm;
assign uop_enq_ctrl[24] = vlsq_req_widen_alive;
assign uop_enq_ctrl[12] = (pma_vlsu_resp_ucable & (vlsq_req_mmode | vlsq_req_smode)) | pma_vlsu_resp_cable;
assign uop_enq_ctrl[13] = (pma_vlsu_resp_ucable & (vlsq_req_umode | vlsq_req_smode));
assign uop_enq_vd_emul_len = vlsq_req_vd_emul_len;
assign uop_enq_vd_beats = vlsq_req_vd_beats;
assign uop_enq_vd_seg_beats = vlsq_req_vd_seg_beats;
assign uop_enq_cross_4k = vlsq_req_cross_4k;
assign uop_enq_cross_4k_d1 = vlsq_req_cross_4k_d1;
assign uop_enq_cross_4k_d1_kill = {UOPQ_DEPTH{vlsq_req_cross_4k_d1_kill}} & uop_enq_ptr;
assign uop_enq_alive = vlsq_req_alive;
assign uop_enq_first = vlsq_req_first;
assign uop_enq_last = vlsq_req_last;
assign uop_enq_ele_dlen_last = vlsq_req_dlen_last;
assign pma_vlsu_resp_cable = ~pma_vlsu_resp_ucable & ~pma_vlsu_resp_device;
assign pma_vlsu_resp_ucable = (vlsq_req_mtype == 4'd2) | (vlsq_req_mtype == 4'd3);
assign pma_vlsu_resp_device = (vlsq_req_mtype == 4'd0) | (vlsq_req_mtype == 4'd1);
assign vlsq_req_mmode = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_MACHINE);
assign vlsq_req_smode = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_SUPERVISOR);
assign vlsq_req_umode = (vlsq_req_ctrl[13 +:2] == PRIVILEGE_USER);
assign uop_enq_pa = vlsq_req_pa;
assign uop_enq_base_offset = vlsq_req_base_offset;
assign uop_enq_vstart_byte = vlsq_req_vstart_byte;
assign uop_enq_prestart_cross = vlsq_req_prestart_cross;
assign uop_enq_byte = vlsq_req_byte;
assign uop_enq_total_byte = vlsq_req_total_byte;
assign uop_enq_element_num_dlen = vlsq_req_element_num_dlen;
assign uop_cross_en = (uop_hvm & uop_cross_hvm_en) | (~uop_hvm & uop_cross_cl_en);
assign uop_offer_byte = ({MAX_BYTE_WIDTH{uop_hvm}} & uop_offer_byte_hvm) | ({MAX_BYTE_WIDTH{~uop_hvm}} & uop_offer_byte_biu);
assign uop_align_bus = (uop_hvm & uop_align_hvm) | (~uop_hvm & uop_align_biu);
assign uop_misalign_bus = (uop_hvm & uop_misalign_hvm) | (~uop_hvm & uop_misalign_biu);
assign uop_remain_byte_nx = ({MAX_BYTE_WIDTH{uop_hvm}} & uop_remain_byte_hvm_nx) | ({MAX_BYTE_WIDTH{~uop_hvm}} & uop_remain_byte_biu_nx);
assign uop_pa_cross_nx = ({PALEN{uop_hvm}} & uop_pa_hvm_nx) | ({PALEN{~uop_hvm}} & uop_pa_cl_nx);
assign {nds_unused_co20,uop_alive_byte_update} = uop_alive_byte - uop_offer_byte;
assign uop_bus_byte_init = ({HR_BYTE_WIDTH{uop_hvm}} & uop_hvm_byte_init[HR_BYTE_WIDTH - 1:0]) | ({HR_BYTE_WIDTH{~uop_hvm}} & uop_biu_byte_init[HR_BYTE_WIDTH - 1:0]);
assign uop_eseg2u_trans = (uop_hvm & uop_eseg2u_trans_hvm) | (~uop_hvm & uop_eseg2u_trans_biu);
assign uop_pa_offset_hr = ({MAX_BYTE_WIDTH{uop_hvm}} & {{MAX_BYTE_WIDTH - HVM_OFFSET_WIDTH{1'b0}},uop_pa[HVM_OFFSET_WIDTH - 1:0]}) | ({MAX_BYTE_WIDTH{~uop_hvm}} & {{MAX_BYTE_WIDTH - CL_OFFSET_WIDTH{1'b0}},uop_pa[CL_OFFSET_WIDTH - 1:0]});
generate
    if (HR_OFFSET_WIDTH > BIU_OFFSET_WIDTH) begin:gen_hvm_lt_biu
        assign uop_pa_offset = ({HR_OFFSET_WIDTH{uop_hvm}} & uop_pa[HVM_OFFSET_WIDTH - 1:0]) | ({HR_OFFSET_WIDTH{~uop_hvm}} & {{HR_OFFSET_WIDTH - BIU_OFFSET_WIDTH{1'b0}},uop_pa[BIU_OFFSET_WIDTH - 1:0]});
        assign uop_align_value_byte = ({HR_OFFSET_WIDTH{uop_hvm}} & uop_shift_value_byte[HR_OFFSET_WIDTH - 1:0]) | ({HR_OFFSET_WIDTH{~uop_hvm}} & {{HR_OFFSET_WIDTH - BIU_OFFSET_WIDTH{1'b0}},uop_shift_value_byte[BIU_OFFSET_WIDTH - 1:0]});
        assign uop_st_umask_offset = ({HR_OFFSET_WIDTH{uop_hvm}} & uop_st_vstart_location[HR_OFFSET_WIDTH - 1:0]) | ({HR_OFFSET_WIDTH{~uop_hvm}} & {{HR_OFFSET_WIDTH - BIU_OFFSET_WIDTH{1'b0}},uop_st_vstart_location[BIU_OFFSET_WIDTH - 1:0]});
    end
    else begin:gen_hvm_eq_biu
        assign uop_pa_offset = uop_pa[HR_OFFSET_WIDTH - 1:0];
        assign uop_align_value_byte = uop_shift_value_byte[HR_OFFSET_WIDTH - 1:0];
        assign uop_st_umask_offset = uop_st_vstart_location[HR_OFFSET_WIDTH - 1:0];
    end
endgenerate
assign uop_bypass_valid = vlsq2uop_cmt_grant & ~vlsq2uop_cmt_kill & (uop_req_ptr == uop_cmt_ptr);
assign uop_valid = uop_cmtted_valid | uop_bypass_valid;
assign uop_store = uop_ctrl[17];
assign uop_load = uop_ctrl[4];
assign uop_hvm = uop_ctrl[2];
assign uop_element_num_dlen_ulast = uop_ustride_all & uop_req_last;
assign uop_element_last_reserve = uop_element & ((~uop_widen & ~uop_alive & uop_element_num_dlen_elast) | (uop_widen & ~uop_alive & ~uop_widen_alive & uop_element_num_dlen_elast));
assign uop_element_skip = uop_element & ((~uop_widen & ~uop_alive & ~uop_element_num_dlen_elast) | (uop_widen & ~uop_alive & ~uop_widen_alive & ~uop_element_num_dlen_elast));
assign uop_ustride_reserve = uop_ustride_native & ~uop_alive;
assign uop_widen = uop_ctrl[23];
assign uop_nf = uop_ctrl[9 +:3];
assign uop_nf_add1 = {1'b0,uop_nf} + 4'd1;
assign uop_vd_eew = uop_ctrl[20 +:3];
assign uop_vd_eew8 = (uop_vd_eew[1:0] == 2'b00);
assign uop_vd_eew16 = (uop_vd_eew[1:0] == 2'b01);
assign uop_vd_eew32 = (uop_vd_eew[1:0] == 2'b10);
assign uop_vd_eew64 = (uop_vd_eew[1:0] == 2'b11);
assign uop_req_pa = uop_pa & uop_pa_mask;
assign vlsq2uop_cmt_buf_grant = vlsq2uop_cmt_buf_valid & vlsq2uop_cmt_ready;
assign uop_start_buf_bypass = (uop_req_ptr == uop_cmt_ptr) & vlsq2uop_cmt_buf_grant;
assign uop_start_buf_num_sel = uop_start_buf_bypass ? uop_cmt_start_buf_num : uop_start_buf_num;
assign uop_req_ctrl = uop_ctrl;
assign uop_req_vd_emul_len = uop_vd_emul_len;
assign uop_req_vd_beats = (uop_ustride_mutation | (uop_useg & uop_store)) ? uop_vd_buf_beats : uop_vd_beats;
assign uop_req_vd_seg_beats = uop_vd_seg_beats;
assign uop_req_vd_buf_beats = uop_vd_buf_beats;
assign uop_req_align = uop_ustride_native & uop_align_bus & ~uop_keep_unalign;
assign uop_req_bypass = uop_req_align & ~uop_widen & ~uop_seg;
assign uop_req_buf_opt = uop_buf_opt;
assign uop_req_buf_cross_revert = uop_buf_cross_revert;
assign uop_req_buf_num = uop_seg_cross_d1 ? uop_seg_buf_num : uop_buf_num_sel;
assign uop_element_num_dlen_add1 = uop_element_num_dlen + {{ELE_DLEN_WIDTH - 1{1'b0}},1'b1};
assign uop_req_element_num_dlen = uop_element ? (uop_widen & ({uop_widen_alive,uop_alive} == 2'b10)) ? uop_element_num_dlen_add1 : uop_element_num_dlen : element_info_cnt;
assign uop_req_valid = uop_valid & (uop_alive | uop_widen_alive | uop_element_last_reserve | uop_ustride_reserve);
assign uop_req_first = (uop_first & uopq_first) | uop_keep_first;
assign uop_req_last = uop_last & uopq_last;
assign uop_req_ele_dlen_last = uop_element_num_dlen_elast;
assign uop_req_ele_seg_last = uop_eseg & ~uop_cross_en;
assign uop_req_ele_seg_first = uop_eseg & (uop_req_first | uop_ele_seg_first);
assign uop_ele_seg_first_set = uop_eseg & ~uop_cross_en;
assign uop_ele_seg_first_clr = uop_req_last | uop_eseg & uop_cross_en;
assign uop_ele_seg_first_en = uop_req_grant & (uop_ele_seg_first_set | uop_ele_seg_first_clr);
assign uop_ele_seg_first_nx = uop_ele_seg_first_clr ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_ele_seg_first <= 1'b0;
    end
    else if (uop_ele_seg_first_en) begin
        uop_ele_seg_first <= uop_ele_seg_first_nx;
    end
end

assign {nds_unused_co21,uop_vstart_byte_nx} = uop_vstart_byte - uop_byte_sel_zext;
assign uop_remain_vstart_byte_nx = uop_req_prestart_done ? {MAX_BYTE_WIDTH{1'b0}} : uop_vstart_byte_nx;
assign uop_req_byte_zero = uop_req_byte == {HR_MAX_BYTE_WIDTH{1'b0}};
assign uop_req_elememt_skip = uop_element & ~uop_alive & ~uop_widen_alive;
assign uop_req_ustride_skip = (uop_ustride_native & uop_alive & (~uop_req_prestart_done | uop_req_byte_zero)) | (uop_ustride_native & ~uop_alive);
assign uop_req_skip = uop_req_elememt_skip | uop_req_ustride_skip;
assign uop_req_dlen_beat = uop_ustride_all & (element_info_cnt_byte >= uop_dlen_byte_half_init[ELE_DLEN_WIDTH - 1:0]);
assign uop_req_size = uop_hvm ? hvm_data_size : uop_size;
assign uop_req_byte = uop_req_prestart_hit ? uop_st_ustride_byte[HR_MAX_BYTE_WIDTH - 1:0] : uop_byte_sel;
assign uop_req_putfull = uop_align_cl & uop_putfull_cond;
assign uop_putfull_cond = ~uop_hvm & (~|uop_req_byte[CL_OFFSET_WIDTH - 1:0]);
assign uop_req_beat_cnt = uop_beat_cnt;
assign uop_req_beat_mask = uop_beat_mask;
assign uop_req_st_beat_mask = uop_beat_mask & uop_st_vstart_beat_mask;
assign uop_req_eseg_hp = uop_eseg_hp;
assign uop_req_ustride_mutation = uop_ustride_mutation;
assign uop_req_mask_cnt = uop_ustride_all ? uop_umask_cnt : uop_eseg ? uop_eseg_mask_cnt : uop_emask_cnt;
assign uop_req_nf_cnt = uop_nf_cnt[3:0];
assign uop_req_element_sel = (dlen_biu_1_1 | uop_hvm) ? 1'b0 : (uop_vd_eew8 & uop_req_element_num_dlen[SEW8_DLEN_WIDTH - 1]) | (uop_vd_eew16 & uop_req_element_num_dlen[SEW16_DLEN_WIDTH - 1]) | (uop_vd_eew32 & uop_req_element_num_dlen[SEW32_DLEN_WIDTH - 1]) | (uop_vd_eew64 & uop_req_element_num_dlen[SEW64_DLEN_WIDTH - 1]);
assign uop_req_align_value = (uop_eseg & uop_load) ? uop_pa_offset[HR_OFFSET_WIDTH - 1:0] : uop_align_value_byte[HR_OFFSET_WIDTH - 1:0];
assign uop_req_align_onehot_sel = ((uop_req_align & ~uop_req_element_sel) | uop_load) ? 2'b01 : (uop_ustride_all & uop_store) ? uop_ustore_onehot_sel : uop_estore_onehot;
assign uop_estore_revert = (uop_req_element_sel ^ uop_align_value_msb);
assign uop_estore_default_2_1 = {uop_req_element_sel,~uop_req_element_sel};
assign uop_estore_onehot = (dlen_biu_1_1 | uop_hvm) ? 2'b10 : (dlen_biu_2_1 & uop_estore_revert) ? ~uop_estore_default_2_1 : uop_estore_default_2_1;
assign uop_ustore_onehot_init = 2'b01;
assign uop_ustore_onehot_sel = (uop_req_first | uop_req_ele_seg_first) ? uop_ustore_onehot_init : uop_ustore_onehot;
assign uop_ustore_onehot_nx = (^uop_req_beat_mask | uop_hvm) ? ~uop_ustore_onehot_sel : uop_ustore_onehot_sel;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_ustore_onehot <= 2'b0;
    end
    else if (uop_req_grant) begin
        uop_ustore_onehot <= uop_ustore_onehot_nx;
    end
end

generate
    if ((DLEN / BIU_DATA_WIDTH) == 1) begin:gen_uop_dlen_biu_1_1
        assign uop_align_value_msb = uop_shift_value_uf;
        assign uop_st_uextra = 1'b0;
    end
    else if ((DLEN / BIU_DATA_WIDTH) == 2) begin:gen_uop_dlen_biu_2_1
        wire [7:0] uop_biu_byte_init_x2;
        assign uop_biu_byte_init_x2 = (BIU_DATA_WIDTH == 128) ? 8'd32 : (BIU_DATA_WIDTH == 256) ? 8'd64 : 8'd128;
        assign uop_align_value_msb = uop_hvm ? uop_shift_value_uf : uop_shift_value_byte[BIU_OFFSET_WIDTH];
        assign uop_st_uextra = uop_hvm ? 1'b0 : (byte_cnt_exceed_last > {1'b0,uop_biu_byte_init_x2[BIU_BYTE_WIDTH:0]});
    end
endgenerate
assign uop_element_num_byte = uop_req_element_num_dlen << uop_vd_eew[1:0];
assign uop_element_num_align = (uop_widen & uop_element) ? {ELE_DLEN_WIDTH{1'b0}} : uop_eseg ? uop_eseg_align_byte_zext[ELE_DLEN_WIDTH - 1:0] : uop_element_num_byte;
assign {uop_shift_value_uf,uop_shift_value_byte} = uop_pa_offset_zext[ELE_DLEN_WIDTH - 1:0] - uop_element_num_align;
assign uop_misalign_cl = |uop_pa[CL_OFFSET_WIDTH - 1:0];
assign uop_misalign_biu = |uop_pa[BIU_OFFSET_WIDTH - 1:0];
assign uop_misalign_hvm = |uop_pa[HVM_OFFSET_WIDTH - 1:0];
assign uop_align_cl = ~uop_misalign_cl;
assign uop_align_biu = ~uop_misalign_biu;
assign uop_align_hvm = ~uop_misalign_hvm;
assign uopq_first = uop_req_cnt == {UOP_CNT_WIDTH{1'b0}};
assign uopq_last = ~uop_cross_en;
assign uop_byte_sel = (uop_byte < uop_offer_byte) ? uop_byte[HR_MAX_BYTE_WIDTH - 1:0] : uop_offer_byte[HR_MAX_BYTE_WIDTH - 1:0];
assign uop_buf_beats = uop_exceed_dlen_byte_minus1[ELE_DLEN_WIDTH +:VRF_LW];
assign uop_buf_beats_sel = uop_load ? uop_vd_buf_beats : uop_buf_beats;
assign uop_buf_beats_sel_add1 = {1'b0,uop_buf_beats_sel} + {{VRF_LW{1'b0}},1'b1};
assign {nds_unused_co12,uop_access_byte} = uop_byte_sel[CL_BYTE_WIDTH - 1:0] + {1'b0,uop_pa[CL_OFFSET_WIDTH - 1:0]};
assign uop_byte2element = uop_byte_sel >> uop_vd_eew[1:0];
assign uop_mask_exceed_check = uop_byte_sel <= uop_bus_offer_byte_zext[HR_MAX_BYTE_WIDTH - 1:0];
assign {nds_unused_co1,uop_bus_offer_byte} = {1'b0,uop_bus_byte_init} - {2'b0,uop_pa_offset};
assign {nds_unused_co2,uop_remain_byte_dlen} = {1'b0,uop_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0]} - {2'b0,element_info_cnt_byte};
assign uop_seg_byte_init = uop_nf_add1 << uop_vd_eew[1:0];
assign {nds_unused_co18,uop_remain_byte_seg} = uop_seg_byte_init[NF_BYTE_WIDTH - 1:0] - uop_eseg_align_byte;
assign uop_eseg_mask_cnt = (uop_remain_byte_seg_zext >= uop_bus_offer_byte_zext[7:0]) ? uop_bus_offer_byte : uop_remain_byte_seg_zext[HR_BYTE_WIDTH - 1:0];
assign uop_ld_umask_cnt = (uop_remain_byte_dlen >= uop_bus_offer_byte_zext[DLEN_BYTE_WIDTH - 1:0]) ? uop_bus_offer_byte : uop_remain_byte_dlen[HR_BYTE_WIDTH - 1:0];
assign uop_umask_cnt = uop_load ? uop_ld_umask_cnt : uop_st_umask_cnt_adj;
assign uop_widen_alive = uop_ctrl[24];
assign uop_emask_cnt = (&{uop_widen_alive,uop_alive}) ? {uop_byte_sel[HR_BYTE_WIDTH - 2:0],1'b0} : (|{uop_widen_alive,uop_alive}) ? uop_byte_sel[HR_BYTE_WIDTH - 1:0] : {HR_BYTE_WIDTH{1'b0}};
assign uop_nf_cnt = uop_byte_sel >> uop_vd_eew[1:0];
assign uop_eseg2u_trans_biu = (BIU_DATA_WIDTH == 256) & uop_vd_eew64 & (uop_nf > 3'd3) | (BIU_DATA_WIDTH == 128) & uop_vd_eew32 & (uop_nf > 3'd3) | (BIU_DATA_WIDTH == 128) & uop_vd_eew64 & (uop_nf > 3'd1);
assign uop_eseg2u_trans_hvm = (DLEN == 256) & uop_vd_eew64 & (uop_nf > 3'd3) | (DLEN == 128) & uop_vd_eew32 & (uop_nf > 3'd3) | (DLEN == 128) & uop_vd_eew64 & (uop_nf > 3'd1);
assign uop_keep_first_en = uop_keep_first_set | uop_keep_first_clr;
assign uop_keep_first_set = uop_valid & uop_first & uop_element & ~uop_alive & ~uop_widen_alive & ~uop_last & ~uop_element_num_dlen_elast;
assign uop_keep_first_clr = uop_req_grant & uop_keep_first;
assign uop_keep_first_nx = uop_keep_first_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_keep_first <= 1'b0;
    end
    else if (uop_keep_first_en) begin
        uop_keep_first <= uop_keep_first_nx;
    end
end

assign uop_keep_unalign_en = uop_req_grant & (uop_keep_unalign_set | uop_keep_unalign_clr);
assign uop_keep_unalign_set = uop_valid & ~uop_req_last & ~uop_req_align & ((uop_req_first & uop_ustride_native) | (~uop_req_ele_seg_last & uop_ustride_mutation));
assign uop_keep_unalign_clr = uop_valid & uop_keep_unalign & ((uop_req_last & uop_ustride_native) | (uop_req_ele_seg_last & uop_ustride_mutation));
assign uop_keep_unalign_nx = uop_keep_unalign_set;
assign uop_keep_pa_offset_sel = uop_req_first ? uop_pa_offset : uop_keep_pa_offset;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_keep_unalign <= 1'b0;
        uop_keep_pa_offset <= {HR_OFFSET_WIDTH{1'b0}};
    end
    else if (uop_keep_unalign_en) begin
        uop_keep_unalign <= uop_keep_unalign_nx;
        uop_keep_pa_offset <= uop_pa_offset;
    end
end

assign uop_req_cnt_en = uop_req_grant;
assign uop_req_cnt_add1 = uop_req_cnt + {{UOP_CNT_WIDTH - 1{1'b0}},1'b1};
assign uop_req_cnt_nx = uop_req_last ? {UOP_CNT_WIDTH{1'b0}} : uop_req_cnt_add1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_req_cnt <= {UOP_CNT_WIDTH{1'b0}};
    end
    else if (uop_req_cnt_en) begin
        uop_req_cnt <= uop_req_cnt_nx;
    end
end

assign buf_info_ustride_wvalid = uop_ustride_native & ~uop_seg & uop_req_first;
assign buf_info_element_wvalid = uop_element & ~uop_seg & uop_element_num_dlen_elast;
assign buf_info_seg_wvalid = uop_seg & ~uop_store;
assign buf_info_element_value = {1'b0,element_info_cnt} + {{DLEN_BYTE_WIDTH - 1{1'b0}},1'b1};
assign buf_info_init_wvalid = uop_req_grant & (buf_info_element_wvalid | buf_info_ustride_wvalid);
assign buf_info_init_eseg_wvalid = uop_req_grant & buf_info_seg_wvalid & uop_element_num_dlen_elast;
assign buf_info_init_useg_wvalid = uop_req_grant & uop_ustride_native & uop_load & uop_seg & uop_req_first;
assign buf_info_init_wsel = {BUF_DEPTH{buf_info_init_wvalid}} & buf_info_ptr | {BUF_DEPTH{buf_info_init_eseg_wvalid}} & uop_req_seg_buf_ptr | {BUF_DEPTH{buf_info_init_useg_wvalid}} & uop_req_buf_ptr_tl;
assign buf_info_init_value = uop_ustride_native ? uop_buf_opt ? buf_info_ustride_value_hvm : buf_info_ustride_value : {BUF_DEPTH{buf_info_element_value_zext}};
assign element_info_cnt_en = uop_req_grant & ((uop_element & ~uop_cross_en) | uop_ustride_all);
assign {nds_unused_co4,element_info_cnt_add} = element_info_cnt + element_info_uoffset;
assign element_info_uoffset = ({ELE_DLEN_WIDTH{uop_vd_eew8}} & {element_info_cnt_offset[SEW8_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew16}} & {1'b0,element_info_cnt_offset[SEW16_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew32}} & {2'b0,element_info_cnt_offset[SEW32_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew64}} & {3'b0,element_info_cnt_offset[SEW64_DLEN_WIDTH - 1:0]});
assign element_info_cnt_offset = uop_ustride_all ? uop_byte2element[ELE_DLEN_WIDTH - 1:0] : {{ELE_DLEN_WIDTH - 1{1'b0}},1'b1};
assign element_info_cnt_reset = (uop_element_num_dlen_elast & ~uop_cross_en) | uop_element_num_dlen_ulast | (uop_ustride_mutation & uop_req_ele_seg_last);
assign element_info_cnt_nx = element_info_cnt_reset ? {ELE_DLEN_WIDTH{1'b0}} : ({ELE_DLEN_WIDTH{uop_vd_eew8}} & {element_info_cnt_add[SEW8_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew16}} & {1'b0,element_info_cnt_add[SEW16_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew32}} & {2'b0,element_info_cnt_add[SEW32_DLEN_WIDTH - 1:0]}) | ({ELE_DLEN_WIDTH{uop_vd_eew64}} & {3'b0,element_info_cnt_add[SEW64_DLEN_WIDTH - 1:0]});
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        element_info_cnt <= {ELE_DLEN_WIDTH{1'b0}};
    end
    else if (element_info_cnt_en) begin
        element_info_cnt <= element_info_cnt_nx;
    end
end

assign element_info_cnt_byte = element_info_cnt << uop_vd_eew[1:0];
assign {nds_unused_co5,uop_exceed_dlen_byte} = {{MAX_BYTE_WIDTH - ELE_DLEN_WIDTH + 1{1'b0}},element_info_cnt_byte} + {{MAX_BYTE_WIDTH - HR_MAX_BYTE_WIDTH + 1{1'b0}},uop_byte_sel};
assign uop_exceed_dlen_byte_minus1 = uop_exceed_dlen_byte - {{MAX_BYTE_WIDTH - 1{1'b0}},1'b1};
assign uop_exceed_dlen_en = uop_hvm ? |uop_exceed_dlen_byte[MAX_BYTE_WIDTH - 1:HVM_OFFSET_WIDTH] : dlen_biu_1_1 ? |uop_exceed_dlen_byte[MAX_BYTE_WIDTH - 1:BIU_OFFSET_WIDTH] : |uop_exceed_dlen_byte[MAX_BYTE_WIDTH - 1:BIU_OFFSET_WIDTH] & ~uop_exceed_dlen_byte[BIU_OFFSET_WIDTH];
assign {nds_unused_co6,uop_exceed_dlen_num} = uop_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0] - uop_keep_pa_offset_zext[DLEN_BYTE_WIDTH - 1:0];
assign uop_ld_ucross = uop_exceed_dlen_en & ((~uop_hvm & (uop_exceed_dlen_byte_minus1[BIU_OFFSET_WIDTH - 1:0] < uop_exceed_dlen_num[BIU_OFFSET_WIDTH - 1:0])) | (uop_hvm & (uop_exceed_dlen_byte_minus1[HVM_OFFSET_WIDTH - 1:0] < uop_exceed_dlen_num[HVM_OFFSET_WIDTH - 1:0])));
assign uop_st_ucross = (byte_cnt_exceed_last > {1'b0,uop_bus_byte_init_zext2dlen});
assign uop_req_ucross = uop_ustride_all & ((uop_load & uop_ld_ucross) | (uop_store & uop_st_ucross));
assign uop_req_uextra = uop_ustride_all & uop_store & uop_st_uextra;
assign biu_data_size = (BIU_DATA_WIDTH == 128) ? 3'd4 : (BIU_DATA_WIDTH == 256) ? 3'd5 : 3'd6;
assign hvm_data_size = (HVM_DATA_WIDTH == 128) ? 3'd4 : (HVM_DATA_WIDTH == 256) ? 3'd5 : (HVM_DATA_WIDTH == 512) ? 3'd6 : 3'd7;
assign hr_data_size = uop_hvm ? hvm_data_size : biu_data_size;
assign {nds_unused_co13,uop_beat_num} = uop_req_size - hr_data_size;
assign {nds_unused_co14,uop_access_byte_minus1} = {1'b0,uop_access_byte} - {{CL_BYTE_WIDTH{1'b0}},1'b1};
assign uop_size_beat = uop_access_byte_minus1[BIU_OFFSET_WIDTH +:BEAT_CNT_WIDTH];
assign uop_pa_beat = uop_pa[BIU_OFFSET_WIDTH +:BEAT_CNT_WIDTH];
assign uop_beat_xor = uop_size_beat ^ uop_pa_beat;
assign {nds_unused_co19,uop_beat_diff} = {1'b0,uop_size_beat} - {1'b0,uop_pa_beat};
generate
    if (BIU_DATA_WIDTH == 128) begin:gen_tl_cmd_128
        wire [3:0] uop_beat_mask_init;
        wire uop_tl_cmd_adjust;
        assign uop_tl_cmd_adjust = (uop_pa_beat == 2'd1) & (uop_size != biu_data_size);
        assign uop_pa_mask = uop_tl_cmd_adjust ? {{PALEN - 2 - BIU_OFFSET_WIDTH{1'b1}},2'b00,{BIU_OFFSET_WIDTH{1'b1}}} : {PALEN{1'b1}};
        assign uop_size = uop_beat_xor[1] ? 3'd6 : uop_beat_xor[0] ? 3'd5 : 3'd4;
        assign uop_beat_mask_init = (uop_beat_diff == 2'd0) ? 4'b0001 : (uop_beat_diff == 2'd1) ? 4'b0011 : (uop_beat_diff == 2'd2) ? 4'b0111 : 4'b1111;
        assign uop_beat_mask = uop_tl_cmd_adjust ? {uop_beat_mask_init[2:0],1'b0} : uop_beat_mask_init;
        assign uop_beat_num1 = (uop_beat_num[1:0] == 2'd0);
        assign uop_beat_num2 = (uop_beat_num[1:0] == 2'd1);
        assign uop_beat_num4 = (uop_beat_num[1:0] == 2'd2);
        assign uop_beat_cnt = ({BEAT_CNT_WIDTH{uop_beat_num1}} & {{BEAT_CNT_WIDTH - 1{1'b0}},1'd0}) | ({BEAT_CNT_WIDTH{uop_beat_num2}} & {{BEAT_CNT_WIDTH - 1{1'b0}},1'd1}) | ({BEAT_CNT_WIDTH{uop_beat_num4}} & {2'd3});
    end
    else if (BIU_DATA_WIDTH == 256) begin:gen_tl_cmd_256
        wire nds_unused_uop_beat_num = uop_beat_num4;
        assign uop_pa_mask = {PALEN{1'b1}};
        assign uop_size = uop_beat_xor[0] ? 3'd6 : 3'd5;
        assign uop_beat_mask = (uop_beat_diff == 1'b1) ? 4'b0011 : 4'b0001;
        assign uop_beat_num1 = (uop_beat_num[0] == 1'b0);
        assign uop_beat_num2 = (uop_beat_num[0] == 1'b1);
        assign uop_beat_num4 = 1'b0;
        assign uop_beat_cnt = ({BEAT_CNT_WIDTH{uop_beat_num1}} & {BEAT_CNT_WIDTH{1'b0}}) | ({BEAT_CNT_WIDTH{uop_beat_num2}} & 1'b1);
    end
    else begin:gen_tl_cmd_512
        wire nds_unused_uop_beat_xor = |uop_beat_xor;
        wire nds_unused_uop_beat_diff = uop_beat_diff;
        wire nds_unused_uop_beat_num = (|uop_beat_num) | uop_beat_num1 | uop_beat_num2 | uop_beat_num4;
        assign uop_pa_mask = {PALEN{1'b1}};
        assign uop_size = 3'd6;
        assign uop_beat_mask = 4'b0001;
        assign uop_beat_num1 = 1'b0;
        assign uop_beat_num2 = 1'b0;
        assign uop_beat_num4 = 1'b0;
        assign uop_beat_cnt = {BEAT_CNT_WIDTH{1'b0}};
    end
endgenerate
assign uop_req_umask_offset = uop_st_umask_offset[HR_OFFSET_WIDTH - 1:0];
assign uop_req_prestart_done = (uop_ustride_native & (uop_byte_sel_zext >= uop_vstart_byte));
assign uop_req_prestart_hit = uop_req_prestart_done & (uop_vstart_byte != {MAX_BYTE_WIDTH{1'b0}});
assign uop_st_umask_cnt = uop_mask_exceed_check ? uop_byte_sel[HR_BYTE_WIDTH - 1:0] : (uop_req_first | uop_req_ele_seg_first) ? uop_bus_offer_byte[HR_BYTE_WIDTH - 1:0] : uop_bus_byte_init[HR_BYTE_WIDTH - 1:0];
assign uop_st_umask_cnt_adj = uop_req_prestart_hit ? uop_st_umask_cnt_first_sel[HR_BYTE_WIDTH - 1:0] : uop_st_umask_cnt;
assign {nds_unused_co22,uop_st_ustride_byte} = uop_byte_sel_zext - uop_vstart_byte;
assign {nds_unused_co23,uop_st_vstart_location} = uop_pa_offset_hr + uop_vstart_byte;
assign {nds_unused_co24,uop_st_umask_cnt_first} = {1'b0,uop_bus_byte_init} - {2'b0,uop_st_umask_offset[HR_OFFSET_WIDTH - 1:0]};
assign uop_st_umask_cnt_first_sel = (uop_req_byte < uop_st_umask_cnt_first_zext) ? uop_req_byte[HR_BYTE_WIDTH - 1:0] : uop_st_umask_cnt_first;
assign uop_st_vstart_beat_num = ({2{uop_hvm}} & uop_st_vstart_location[HVM_OFFSET_WIDTH + 1:HVM_OFFSET_WIDTH]) | ({2{~uop_hvm}} & uop_st_vstart_location[BIU_OFFSET_WIDTH + 1:BIU_OFFSET_WIDTH]);
assign uop_st_vstart_beat_sel = ({4{(uop_st_vstart_beat_num == 2'b00)}} & 4'b1111) | ({4{(uop_st_vstart_beat_num == 2'b01)}} & 4'b1110) | ({4{(uop_st_vstart_beat_num == 2'b10)}} & 4'b1100) | ({4{(uop_st_vstart_beat_num == 2'b11)}} & 4'b1000);
assign uop_st_vstart_beat_minus = (uop_hvm | (BIU_DATA_WIDTH == 512)) ? 2'b00 : (BIU_DATA_WIDTH == 256) ? {1'b0,uop_req_pa[BIU_OFFSET_WIDTH]} : uop_req_pa[BIU_OFFSET_WIDTH + 1:BIU_OFFSET_WIDTH];
assign uop_st_vstart_beat_shift = ({4{(uop_st_vstart_beat_minus == 2'b00)}} & {uop_st_vstart_beat_sel[3:0]}) | ({4{(uop_st_vstart_beat_minus == 2'b01)}} & {1'd1,uop_st_vstart_beat_sel[3:1]}) | ({4{(uop_st_vstart_beat_minus == 2'b10)}} & {2'd3,uop_st_vstart_beat_sel[3:2]}) | ({4{(uop_st_vstart_beat_minus == 2'b11)}} & {3'd7,uop_st_vstart_beat_sel[3]});
assign uop_st_vstart_beat_mask = (uop_req_prestart_hit & uop_store & uop_ustride_native) ? uop_st_vstart_beat_shift : 4'b1111;
assign uop_strided = uop_ctrl[18];
assign uop_ustride_native = uop_ctrl[19];
assign uop_ustride_mutation = uop_eseg & uop_store & uop_eseg2u_trans;
assign uop_eseg_hp = uop_eseg & uop_store & ~uop_eseg2u_trans;
assign uop_ustride_all = uop_ustride_native | uop_ustride_mutation;
assign uop_indexed = uop_ctrl[3];
assign uop_seg = uop_ctrl[14];
assign uop_element = uop_strided | uop_indexed;
assign uop_eseg = uop_seg & uop_element;
assign uop_useg = uop_seg & uop_ustride_native;
assign uop_ustride_nseg = uop_ustride_native & ~uop_seg;
assign uop_element_buf_num_en0 = uop_element & uop_req_first & (~uop_element_num_dlen_elast | uop_cross_en);
assign uop_element_buf_num_en1 = uop_element & uop_element_num_dlen_elast & ~uop_cross_en;
assign uop_buf_num_en = uop_req_grant & (uop_element_buf_num_en0 | uop_element_buf_num_en1 | uop_ustride_native);
assign uop_buf_num_sel = uop_req_first ? uop_start_buf_num_sel : uop_buf_num;
generate
    if (VLEN == DLEN) begin:gen_vlen_dlen_1_1_uoffset
        assign uop_buf_num_uoffset = uop_exceed_dlen_byte[ELE_DLEN_WIDTH +:3];
    end
    else begin:gen_vlen_dlen_2_1_uoffset_uoffset
        assign uop_buf_num_uoffset = uop_exceed_dlen_byte[ELE_DLEN_WIDTH +:4];
    end
endgenerate
assign uop_buf_num_eoffset = {{BUF_DEPTH_LOG2 - 1{1'b0}},1'b1};
wire [MAX_BYTE_WIDTH - 1:0] uop_total_byte_minus1;
assign uop_vd_beats_add1 = {1'b0,uop_vd_beats} + {{VRF_LW{1'b0}},1'b1};
assign uop_vd_seg_beats_add1 = {{BUF_DEPTH_LOG2 - VRF_LW + 1{1'b0}},uop_vd_seg_beats[VRF_LW - 1:0]} + {{BUF_DEPTH_LOG2{1'b0}},1'b1};
assign uop_total_byte_minus1 = uop_total_byte - {{MAX_BYTE_WIDTH - 1{1'b0}},1'b1};
assign uop_vd_buf_beats = uop_total_byte_minus1[MAX_BYTE_WIDTH - 2:DLEN_BYTE_BIT];
assign uop_nf_cnt_minus1 = uop_nf_cnt[3:0] - 4'd1;
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2),
    .IW(VRF_LW)
) u_uop_buf_num_eseg_offset_zext (
    .out(uop_buf_num_eseg_offset_zext),
    .in(uop_buf_num_eseg_offset)
);
kv_vls_seg_num #(
    .WIDTH(VRF_LW)
) u_vls_vl_seg (
    .data_in(uop_vd_beats_add1[VRF_LW - 1:0]),
    .nf(uop_nf_cnt_minus1[2:0]),
    .data_out(uop_buf_num_eseg_offset)
);
assign uop_buf_opt = (uop_hvm & uop_ustride_nseg & ~uop_widen & (uop_vd_seg_beats > {{VRF_LW - 1{1'b0}},1'b1}));
assign uop_buf_num_offset = uop_element ? uop_buf_num_eoffset : uop_buf_num_uoffset_zext;
assign {nds_unused_co7,uop_buf_num_add} = uop_buf_num_sel + uop_buf_num_offset;
assign uop_buf_num_sub = uop_buf_num_sel - {{BUF_DEPTH_LOG2 - 1{1'b0}},1'b1};
assign uop_misalign_access = uop_keep_unalign | uop_misalign_bus;
assign uop_align_access = uop_align_bus & ~uop_keep_unalign;
assign uop_buf_cross_revert = uop_buf_opt & uop_misalign_access & (uop_buf_num_uoffset_zext != {BUF_DEPTH_LOG2{1'b0}}) & ~uop_req_cnt[0];
assign uop_buf_num_revert = uop_buf_opt & (uop_buf_num_uoffset_zext != {BUF_DEPTH_LOG2{1'b0}}) & ((uop_align_access & uop_req_cnt[0]) | (uop_misalign_access & ~uop_req_cnt[0]));
assign uop_buf_num_inc_sel = uop_buf_num_revert ? uop_buf_num_sub : uop_buf_num_add;
assign uop_buf_num_nx = uop_element_buf_num_en0 ? uop_start_buf_num_sel : uop_buf_num_inc_sel;
assign buf_info_size = uop_ustride_native ? uop_buf_opt ? {{BUF_DEPTH_LOG2 - 1{1'b0}},2'd2} : uop_vd_seg_beats_add1 : {{BUF_DEPTH_LOG2{1'b0}},1'b1};
assign uop_ustride_byte_cnt_last = (~|uop_total_byte[ELE_DLEN_WIDTH - 1:0]) ? uop_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0] : {1'b0,uop_total_byte[ELE_DLEN_WIDTH - 1:0]};
assign {nds_unused_co8,byte_cnt_exceed_last} = {2'b0,uop_ustride_byte_cnt_last} + {2'b0,uop_pa_offset_zext};
assign buf_info_bypass_cnt = (dlen_biu_1_1 | uop_hvm) ? 2'd1 : 2'd2;
assign buf_info_unbypass_cnt = buf_info_bypass_cnt + 2'd1;
assign buf_info_ustride_cnt_init = (uop_store & ~uop_align_bus) ? {{BUF_INFO_DW - 1{1'b0}},1'b1} : uop_align_bus ? {{BUF_INFO_DW - 2{1'b0}},buf_info_bypass_cnt} : {{BUF_INFO_DW - 2{1'b0}},buf_info_unbypass_cnt};
assign buf_info_ustride_cnt_last = (uop_store & ~uop_align_bus) ? 2'd1 : buf_info_ustride_last;
assign buf_info_ustride_last_1_1 = (byte_cnt_exceed_last[DLEN_BYTE_WIDTH - 1:0] <= uop_bus_byte_init_zext2dlen) ? 2'd1 : 2'd2;
assign buf_info_ustride_last_2_1 = (byte_cnt_exceed_last[DLEN_BYTE_WIDTH - 1:0] <= uop_bus_byte_init_zext2dlen) ? 2'd1 : (byte_cnt_exceed_last[DLEN_BYTE_WIDTH - 1:0] <= uop_dlen_byte_init[DLEN_BYTE_WIDTH - 1:0]) ? 2'd2 : 2'd3;
assign buf_info_ustride_last = (dlen_biu_1_1 | uop_hvm) ? buf_info_ustride_last_1_1 : buf_info_ustride_last_2_1;
assign {nds_unused_co15,uop_vd_seg_beats_widen_add1} = {2'b0,uop_vd_seg_beats_add1[VRF_LW:1]} + {{VRF_LW + 1{1'b0}},uop_vd_seg_beats_add1[0]};
assign {nds_unused_co16,uop_vd_seg_beats_widen} = {1'b0,uop_vd_seg_beats_widen_add1} - {{VRF_LW + 1{1'b0}},1'b1};
assign uop_end_buf_num_offset = uop_widen ? uop_vd_seg_beats_widen[VRF_LW - 1:0] : uop_useg ? uop_vd_buf_beats : uop_vd_seg_beats;
assign {nds_unused_co9,uop_end_buf_num} = uop_start_buf_num_sel + uop_end_buf_num_offset_zext;
generate
    if (BUF_DEPTH == 8) begin:gen_ustride_buf8_info_init
        always @* begin
            buf_info_ustride_value = {BUF_DEPTH{buf_info_ustride_cnt_init[BUF_INFO_DW - 1:0]}};
            case (uop_end_buf_num)
                3'd0: buf_info_ustride_value[BUF_INFO_DW * 0 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd1: buf_info_ustride_value[BUF_INFO_DW * 1 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd2: buf_info_ustride_value[BUF_INFO_DW * 2 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd3: buf_info_ustride_value[BUF_INFO_DW * 3 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd4: buf_info_ustride_value[BUF_INFO_DW * 4 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd5: buf_info_ustride_value[BUF_INFO_DW * 5 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd6: buf_info_ustride_value[BUF_INFO_DW * 6 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                3'd7: buf_info_ustride_value[BUF_INFO_DW * 7 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                default: begin
                    buf_info_ustride_value = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 16) begin:gen_ustride_buf16_info_init
        always @* begin
            buf_info_ustride_value = {BUF_DEPTH{buf_info_ustride_cnt_init[BUF_INFO_DW - 1:0]}};
            case (uop_end_buf_num)
                4'd0: buf_info_ustride_value[BUF_INFO_DW * 0 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd1: buf_info_ustride_value[BUF_INFO_DW * 1 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd2: buf_info_ustride_value[BUF_INFO_DW * 2 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd3: buf_info_ustride_value[BUF_INFO_DW * 3 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd4: buf_info_ustride_value[BUF_INFO_DW * 4 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd5: buf_info_ustride_value[BUF_INFO_DW * 5 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd6: buf_info_ustride_value[BUF_INFO_DW * 6 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd7: buf_info_ustride_value[BUF_INFO_DW * 7 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd8: buf_info_ustride_value[BUF_INFO_DW * 8 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd9: buf_info_ustride_value[BUF_INFO_DW * 9 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd10: buf_info_ustride_value[BUF_INFO_DW * 10 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd11: buf_info_ustride_value[BUF_INFO_DW * 11 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd12: buf_info_ustride_value[BUF_INFO_DW * 12 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd13: buf_info_ustride_value[BUF_INFO_DW * 13 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd14: buf_info_ustride_value[BUF_INFO_DW * 14 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                4'd15: buf_info_ustride_value[BUF_INFO_DW * 15 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                default: begin
                    buf_info_ustride_value = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 32) begin:gen_ustride_buf32_info_init
        always @* begin
            buf_info_ustride_value = {BUF_DEPTH{buf_info_ustride_cnt_init[BUF_INFO_DW - 1:0]}};
            case (uop_end_buf_num)
                5'd0: buf_info_ustride_value[BUF_INFO_DW * 0 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd1: buf_info_ustride_value[BUF_INFO_DW * 1 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd2: buf_info_ustride_value[BUF_INFO_DW * 2 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd3: buf_info_ustride_value[BUF_INFO_DW * 3 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd4: buf_info_ustride_value[BUF_INFO_DW * 4 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd5: buf_info_ustride_value[BUF_INFO_DW * 5 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd6: buf_info_ustride_value[BUF_INFO_DW * 6 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd7: buf_info_ustride_value[BUF_INFO_DW * 7 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd8: buf_info_ustride_value[BUF_INFO_DW * 8 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd9: buf_info_ustride_value[BUF_INFO_DW * 9 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd10: buf_info_ustride_value[BUF_INFO_DW * 10 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd11: buf_info_ustride_value[BUF_INFO_DW * 11 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd12: buf_info_ustride_value[BUF_INFO_DW * 12 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd13: buf_info_ustride_value[BUF_INFO_DW * 13 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd14: buf_info_ustride_value[BUF_INFO_DW * 14 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd15: buf_info_ustride_value[BUF_INFO_DW * 15 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd16: buf_info_ustride_value[BUF_INFO_DW * 16 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd17: buf_info_ustride_value[BUF_INFO_DW * 17 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd18: buf_info_ustride_value[BUF_INFO_DW * 18 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd19: buf_info_ustride_value[BUF_INFO_DW * 19 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd20: buf_info_ustride_value[BUF_INFO_DW * 20 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd21: buf_info_ustride_value[BUF_INFO_DW * 21 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd22: buf_info_ustride_value[BUF_INFO_DW * 22 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd23: buf_info_ustride_value[BUF_INFO_DW * 23 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd24: buf_info_ustride_value[BUF_INFO_DW * 24 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd25: buf_info_ustride_value[BUF_INFO_DW * 25 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd26: buf_info_ustride_value[BUF_INFO_DW * 26 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd27: buf_info_ustride_value[BUF_INFO_DW * 27 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd28: buf_info_ustride_value[BUF_INFO_DW * 28 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd29: buf_info_ustride_value[BUF_INFO_DW * 29 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd30: buf_info_ustride_value[BUF_INFO_DW * 30 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                5'd31: buf_info_ustride_value[BUF_INFO_DW * 31 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                default: begin
                    buf_info_ustride_value = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
    else if (BUF_DEPTH == 64) begin:gen_ustride_buf64_info_init
        always @* begin
            buf_info_ustride_value = {BUF_DEPTH{buf_info_ustride_cnt_init[BUF_INFO_DW - 1:0]}};
            case (uop_end_buf_num)
                6'd0: buf_info_ustride_value[BUF_INFO_DW * 0 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd1: buf_info_ustride_value[BUF_INFO_DW * 1 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd2: buf_info_ustride_value[BUF_INFO_DW * 2 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd3: buf_info_ustride_value[BUF_INFO_DW * 3 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd4: buf_info_ustride_value[BUF_INFO_DW * 4 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd5: buf_info_ustride_value[BUF_INFO_DW * 5 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd6: buf_info_ustride_value[BUF_INFO_DW * 6 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd7: buf_info_ustride_value[BUF_INFO_DW * 7 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd8: buf_info_ustride_value[BUF_INFO_DW * 8 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd9: buf_info_ustride_value[BUF_INFO_DW * 9 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd10: buf_info_ustride_value[BUF_INFO_DW * 10 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd11: buf_info_ustride_value[BUF_INFO_DW * 11 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd12: buf_info_ustride_value[BUF_INFO_DW * 12 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd13: buf_info_ustride_value[BUF_INFO_DW * 13 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd14: buf_info_ustride_value[BUF_INFO_DW * 14 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd15: buf_info_ustride_value[BUF_INFO_DW * 15 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd16: buf_info_ustride_value[BUF_INFO_DW * 16 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd17: buf_info_ustride_value[BUF_INFO_DW * 17 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd18: buf_info_ustride_value[BUF_INFO_DW * 18 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd19: buf_info_ustride_value[BUF_INFO_DW * 19 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd20: buf_info_ustride_value[BUF_INFO_DW * 20 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd21: buf_info_ustride_value[BUF_INFO_DW * 21 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd22: buf_info_ustride_value[BUF_INFO_DW * 22 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd23: buf_info_ustride_value[BUF_INFO_DW * 23 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd24: buf_info_ustride_value[BUF_INFO_DW * 24 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd25: buf_info_ustride_value[BUF_INFO_DW * 25 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd26: buf_info_ustride_value[BUF_INFO_DW * 26 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd27: buf_info_ustride_value[BUF_INFO_DW * 27 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd28: buf_info_ustride_value[BUF_INFO_DW * 28 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd29: buf_info_ustride_value[BUF_INFO_DW * 29 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd30: buf_info_ustride_value[BUF_INFO_DW * 30 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd31: buf_info_ustride_value[BUF_INFO_DW * 31 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd32: buf_info_ustride_value[BUF_INFO_DW * 32 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd33: buf_info_ustride_value[BUF_INFO_DW * 33 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd34: buf_info_ustride_value[BUF_INFO_DW * 34 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd35: buf_info_ustride_value[BUF_INFO_DW * 35 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd36: buf_info_ustride_value[BUF_INFO_DW * 36 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd37: buf_info_ustride_value[BUF_INFO_DW * 37 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd38: buf_info_ustride_value[BUF_INFO_DW * 38 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd39: buf_info_ustride_value[BUF_INFO_DW * 39 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd40: buf_info_ustride_value[BUF_INFO_DW * 40 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd41: buf_info_ustride_value[BUF_INFO_DW * 41 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd42: buf_info_ustride_value[BUF_INFO_DW * 42 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd43: buf_info_ustride_value[BUF_INFO_DW * 43 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd44: buf_info_ustride_value[BUF_INFO_DW * 44 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd45: buf_info_ustride_value[BUF_INFO_DW * 45 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd46: buf_info_ustride_value[BUF_INFO_DW * 46 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd47: buf_info_ustride_value[BUF_INFO_DW * 47 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd48: buf_info_ustride_value[BUF_INFO_DW * 48 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd49: buf_info_ustride_value[BUF_INFO_DW * 49 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd50: buf_info_ustride_value[BUF_INFO_DW * 50 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd51: buf_info_ustride_value[BUF_INFO_DW * 51 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd52: buf_info_ustride_value[BUF_INFO_DW * 52 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd53: buf_info_ustride_value[BUF_INFO_DW * 53 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd54: buf_info_ustride_value[BUF_INFO_DW * 54 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd55: buf_info_ustride_value[BUF_INFO_DW * 55 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd56: buf_info_ustride_value[BUF_INFO_DW * 56 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd57: buf_info_ustride_value[BUF_INFO_DW * 57 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd58: buf_info_ustride_value[BUF_INFO_DW * 58 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd59: buf_info_ustride_value[BUF_INFO_DW * 59 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd60: buf_info_ustride_value[BUF_INFO_DW * 60 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd61: buf_info_ustride_value[BUF_INFO_DW * 61 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd62: buf_info_ustride_value[BUF_INFO_DW * 62 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                6'd63: buf_info_ustride_value[BUF_INFO_DW * 63 +:BUF_INFO_DW] = {{BUF_INFO_DW - 2{1'b0}},buf_info_ustride_cnt_last};
                default: begin
                    buf_info_ustride_value = {BUF_INFO_DW * BUF_DEPTH{1'b0}};
                end
            endcase
        end

    end
endgenerate
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_buf_num <= {BUF_DEPTH_LOG2{1'b0}};
    end
    else if (uop_buf_num_en) begin
        uop_buf_num <= uop_buf_num_nx;
    end
end

kv_zero_ext #(
    .OW(8),
    .IW(NF_BYTE_WIDTH)
) u_uop_eseg_align_byte_zext (
    .out(uop_eseg_align_byte_zext),
    .in(uop_eseg_align_byte)
);
assign uop_seg_info_en = uop_req_grant & uop_eseg;
assign uop_seg_cross_d1_nx = uop_element & uop_cross_en;
assign {nds_unused_co17,uop_eseg_align_byte_add} = uop_eseg_align_byte_zext[HR_MAX_BYTE_WIDTH - 1:0] + uop_byte_sel;
assign uop_eseg_align_byte_nx = uop_req_ele_seg_last ? {NF_BYTE_WIDTH{1'b0}} : uop_eseg_align_byte_add[NF_BYTE_WIDTH - 1:0];
assign {nds_unused_co10,uop_seg_buf_num_nx} = uop_req_buf_num + uop_buf_num_eseg_offset_zext;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        uop_seg_buf_num <= {BUF_DEPTH_LOG2{1'b0}};
        uop_seg_cross_d1 <= 1'b0;
        uop_eseg_align_byte <= {NF_BYTE_WIDTH{1'b0}};
    end
    else if (uop_seg_info_en) begin
        uop_seg_buf_num <= uop_seg_buf_num_nx;
        uop_seg_cross_d1 <= uop_seg_cross_d1_nx;
        uop_eseg_align_byte <= uop_eseg_align_byte_nx;
    end
end

kv_ffs #(
    .WIDTH(BUF_VALID_WIDTH)
) u_last_valid_hvm (
    .out(uop_ustride_last_valid_ff),
    .in(uop_ustride_last_valid_hvm)
);
assign uop_ustride_last_hvm0 = ~uop_vd_beats[0];
assign uop_ustride_last_hvm1 = uop_vd_beats[0];
assign uop_ustride_last_valid_hvm = ({BUF_VALID_WIDTH{uop_ustride_last_hvm0}} & uop_ustride_valid_hvm0) | ({BUF_VALID_WIDTH{uop_ustride_last_hvm1}} & uop_ustride_valid_hvm1);
generate
    for (i = 0; i < BUF_VALID_WIDTH; i = i + 1) begin:gen_last_cnt_hvm
        assign uop_ustride_cnt_hvm0[i * 2 +:2] = (uop_ustride_last_valid_ff[BUF_VALID_WIDTH - i - 1] & uop_ustride_last_hvm0 & uop_load) ? buf_info_ustride_cnt_last : uop_ustride_valid_hvm0[BUF_VALID_WIDTH - i - 1] ? buf_info_ustride_cnt_init[1:0] : 2'd0;
        assign uop_ustride_cnt_hvm1[i * 2 +:2] = (uop_ustride_last_valid_ff[BUF_VALID_WIDTH - i - 1] & uop_ustride_last_hvm1 & uop_load) ? buf_info_ustride_cnt_last : uop_ustride_valid_hvm1[BUF_VALID_WIDTH - i - 1] ? buf_info_ustride_cnt_init[1:0] : 2'd0;
    end
endgenerate
generate
    if (VRF_LW == 3) begin:gen_hvm_buf_info_1_1
        assign uop_ustride_valid_hvm0 = ({4{uop_vd_beats[2:1] == 2'd0}} & 4'b1000) | ({4{uop_vd_beats[2:1] == 2'd1}} & 4'b1100) | ({4{uop_vd_beats[2:1] == 2'd2}} & 4'b1110) | ({4{uop_vd_beats[2:1] == 2'd3}} & 4'b1111);
        assign uop_ustride_valid_hvm1 = ({4{uop_vd_beats[2:1] == 2'd0}} & {uop_vd_beats[0],3'b0}) | ({4{uop_vd_beats[2:1] == 2'd1}} & {1'd1,uop_vd_beats[0],2'b0}) | ({4{uop_vd_beats[2:1] == 2'd2}} & {2'd3,uop_vd_beats[0],1'b0}) | ({4{uop_vd_beats[2:1] == 2'd3}} & {3'd7,uop_vd_beats[0]});
    end
    else begin:gen_hvm_buf_info_2_1
        assign uop_ustride_valid_hvm0 = ({8{uop_vd_beats[3:1] == 3'd0}} & 8'b1000_0000) | ({8{uop_vd_beats[3:1] == 3'd1}} & 8'b1100_0000) | ({8{uop_vd_beats[3:1] == 3'd2}} & 8'b1110_0000) | ({8{uop_vd_beats[3:1] == 3'd3}} & 8'b1111_0000) | ({8{uop_vd_beats[3:1] == 3'd4}} & 8'b1111_1000) | ({8{uop_vd_beats[3:1] == 3'd5}} & 8'b1111_1100) | ({8{uop_vd_beats[3:1] == 3'd6}} & 8'b1111_1110) | ({8{uop_vd_beats[3:1] == 3'd7}} & 8'b1111_1111);
        assign uop_ustride_valid_hvm1 = ({8{uop_vd_beats[3:1] == 3'd0}} & {uop_vd_beats[0],7'b0}) | ({8{uop_vd_beats[3:1] == 3'd1}} & {1'd1,uop_vd_beats[0],6'b0}) | ({8{uop_vd_beats[3:1] == 3'd2}} & {2'd3,uop_vd_beats[0],5'b0}) | ({8{uop_vd_beats[3:1] == 3'd3}} & {3'd7,uop_vd_beats[0],4'b0}) | ({8{uop_vd_beats[3:1] == 3'd4}} & {4'd15,uop_vd_beats[0],3'b0}) | ({8{uop_vd_beats[3:1] == 3'd5}} & {5'd31,uop_vd_beats[0],2'b0}) | ({8{uop_vd_beats[3:1] == 3'd6}} & {6'd63,uop_vd_beats[0],1'b0}) | ({8{uop_vd_beats[3:1] == 3'd7}} & {7'd127,uop_vd_beats[0]});
    end
endgenerate
assign vlsbuf_uop_claim_sel = {BUF_DEPTH{1'b0}};
assign uop_claim_buf_size = {BUF_DEPTH_LOG2{1'b0}};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

