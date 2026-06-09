// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_hr (
    vpu_vlsu_clk,
    vpu_reset_n,
    vlshr_load_pending,
    vlshr_store_pending,
    vlshr_store_pending_hvm,
    vlshr_store_pending_nhvm,
    vlshr_block_cmd_hvm,
    vlshr_block_cmd_nhvm,
    vlsu_hr_events,
    uop_req_valid,
    uop_req_grant,
    uop_req_pa,
    uop_req_ctrl,
    uop_req_vd_emul_len,
    uop_req_vd_beats,
    uop_req_vd_seg_beats,
    uop_req_vd_buf_beats,
    uop_req_size,
    uop_req_beat_cnt,
    uop_req_buf_opt,
    uop_req_buf_cross_revert,
    uop_req_buf_num,
    uop_req_buf_ptr,
    uop_req_seg_buf_ptr,
    uop_req_buf_ptr_tl,
    uop_req_element_num_dlen,
    uop_req_first,
    uop_req_last,
    uop_req_skip,
    uop_req_putfull,
    uop_req_ele_dlen_last,
    uop_req_ele_seg_first,
    uop_req_ele_seg_last,
    uop_req_dlen_beat,
    uop_req_align,
    uop_req_bypass,
    uop_req_ucross,
    uop_req_uextra,
    uop_req_mask_cnt,
    uop_req_byte,
    uop_req_nf_cnt,
    uop_req_element_sel,
    uop_req_align_value,
    uop_req_umask_offset,
    uop_req_align_onehot_sel,
    uop_req_beat_mask,
    uop_req_st_beat_mask,
    uop_req_eseg_hp,
    uop_req_ustride_mutation,
    buf_info_init_wsel,
    buf_info_init_value,
    vlsu_cm_a_address,
    vlsu_cm_a_corrupt,
    vlsu_cm_a_data,
    vlsu_cm_a_mask,
    vlsu_cm_a_opcode,
    vlsu_cm_a_param,
    vlsu_cm_a_ready,
    vlsu_cm_a_size,
    vlsu_cm_a_source,
    vlsu_cm_a_user,
    vlsu_cm_a_shareable,
    vlsu_cm_a_valid,
    vlsu_nc_a_address,
    vlsu_nc_a_corrupt,
    vlsu_nc_a_data,
    vlsu_nc_a_mask,
    vlsu_nc_a_opcode,
    vlsu_nc_a_param,
    vlsu_nc_a_ready,
    vlsu_nc_a_size,
    vlsu_nc_a_source,
    vlsu_nc_a_user,
    vlsu_nc_a_valid,
    vlsu_vm_a_address,
    vlsu_vm_a_data,
    vlsu_vm_a_mask,
    vlsu_vm_a_opcode,
    vlsu_vm_a_ready,
    vlsu_vm_a_size,
    vlsu_vm_a_valid,
    vlsu_cm_d_cause,
    vlsu_cm_d_corrupt,
    vlsu_cm_d_data,
    vlsu_cm_d_denied,
    vlsu_cm_d_opcode,
    vlsu_cm_d_param,
    vlsu_cm_d_ready,
    vlsu_cm_d_sink,
    vlsu_cm_d_size,
    vlsu_cm_d_source,
    vlsu_cm_d_user,
    vlsu_cm_d_valid,
    vlsu_nc_d_corrupt,
    vlsu_nc_d_data,
    vlsu_nc_d_denied,
    vlsu_nc_d_opcode,
    vlsu_nc_d_param,
    vlsu_nc_d_ready,
    vlsu_nc_d_sink,
    vlsu_nc_d_size,
    vlsu_nc_d_source,
    vlsu_nc_d_user,
    vlsu_nc_d_valid,
    vlsu_vm_d_corrupt,
    vlsu_vm_d_data,
    vlsu_vm_d_denied,
    vlsu_vm_d_opcode,
    vlsu_vm_d_ready,
    vlsu_vm_d_size,
    vlsu_vm_d_valid,
    vlsbuf_vs3_rptr,
    vlsbuf_vs3_rdata,
    vlsbuf_vs3_byte_mask,
    vlsbuf_vd_wsel,
    vlsbuf_vd_write_dlen_last,
    vlsbuf_vd_wdata,
    vlsbuf_vd_bwe,
    vlsbuf_vd_dlen_done,
    vlsbuf_vd_ualign_wsel,
    vlsbuf_vd_ualign_write_dlen_last,
    vlsbuf_vd_ualign_wdata,
    vlsbuf_vd_ualign_bwe,
    vlsbuf_vd_rdata,
    vlsbuf_vd_byte_mask,
    vlsbuf_ent_occupied,
    vlsbuf_ent_mask_ready,
    vlsbuf_ent_mask_ready_nx,
    vlsbuf_ent_return_last,
    vlsbuf_vd_element_bwe_wsel,
    vlsbuf_vd_element_bwe,
    vlsbuf_return_sel,
    hr_vd_buf_ptr_dup_en,
    hr_vd_buf_ptr_dup_nx,
    hr_vd_mask_buf_ptr_dup_nx,
    unpacked_req_en,
    unpacked_resp_finish,
    unpacked_vd_beats,
    unpacked_ctrl,
    unpacked_nf_cnt,
    unpacked_element_num_dlen,
    unpacked_start_buf_num,
    unpacked_start_buf_ptr,
    segbuf_unpacked_data_wvalid,
    segbuf_unpacked_data_wready,
    segbuf_unpacked_wdata,
    vlsbuf_unpacked_wsel,
    ustride_unpacked_req,
    ustride_unpacked_vd_beats,
    ustride_unpacked_ctrl,
    ustride_unpacked_start_buf_num,
    vlsbuf_useg_rptr,
    useg_occupied,
    ustride_seg_rdata,
    ustride_seg_data_clr,
    ustride_seg_data_done,
    hr_req_seg_inst_last,
    packing,
    segbuf_packed_data_rlast,
    segbuf_packed_buf_clr,
    segbuf_packed_buf_shift,
    segbuf_packed_occupied,
    segbuf_packed_rdata,
    vlsu_vd_wvalid,
    vlsu_vd_wready,
    vlsu_vd_wlast,
    vlsu_vd_wdata,
    vlsu_vd_wmask,
    vpu_ls_async_read_error,
    vpu_ls_async_write_error,
    vpu_ls_async_ecc_error,
    vpu_ls_async_ecc_corr,
    vpu_ls_async_ecc_ramid,
    vpu_ls_async_ecc_read
);
parameter VLSU_SUPPORT_HVM = 1;
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = DLEN / 8;
parameter ELEN = 64;
parameter PALEN = 38;
parameter IFIFO_DEPTH = 8;
parameter DLEN_BYTE_WIDTH = 7;
parameter NF_BYTE_WIDTH = 7;
parameter TL_SINK_WIDTH = 2;
parameter L2_SOURCE_WIDTH = 4;
parameter HR_SOURCE_WIDTH = 3;
parameter HR_MAX_BYTE_WIDTH = 8;
parameter HR_DEPTH = 8;
parameter HR_DEPTH_LOG2 = $clog2(HR_DEPTH);
parameter BUF_DEPTH = 8;
parameter BUF_DEPTH_LOG2 = $clog2(BUF_DEPTH);
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter BEAT_CNT_WIDTH = 1;
parameter VRF_LW = 3;
parameter CL_OFFSET_WIDTH = 6;
parameter CL_BASE_WIDTH = 32;
parameter CL_BYTE_WIDTH = 7;
parameter BIU_OFFSET_WIDTH = 5;
parameter BIU_BASE_WIDTH = 33;
parameter BIU_BYTE_WIDTH = 7;
parameter BIU_DATA_WIDTH = 256;
parameter BIU_MASK_WIDTH = 32;
parameter HVM_OFFSET_WIDTH = 6;
parameter HVM_BASE_WIDTH = 32;
parameter HVM_ADDR_WIDTH = 16;
parameter HVM_DATA_WIDTH = 1024;
parameter HVM_MASK_WIDTH = 128;
parameter HR_OFFSET_WIDTH = 6;
parameter HR_BASE_WIDTH = 33;
parameter VLSU_ADDR_WIDTH = 38;
parameter HR_BYTE_WIDTH = 5;
parameter HR_DATA_WIDTH = 1024;
parameter HR_MASK_WIDTH = 128;
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
parameter SEG_DATA_WIDTH = 256;
parameter SEG_MASK_WIDTH = 32;
parameter BUF_INFO_DW = 8;
parameter VLSU_BYPASS_EN = 1;
localparam DLEN_LMUL = (VLEN == DLEN) ? 8 : 16;
localparam VM_D_EN = 3'b001;
localparam CM_D_EN = 3'b010;
localparam NC_D_EN = 3'b100;
localparam DUMMY_D_EN = 3'b000;
input vpu_vlsu_clk;
input vpu_reset_n;
output vlshr_load_pending;
output vlshr_store_pending;
output vlshr_store_pending_hvm;
output vlshr_store_pending_nhvm;
output vlshr_block_cmd_hvm;
output vlshr_block_cmd_nhvm;
output [64 - 1:0] vlsu_hr_events;
input uop_req_valid;
output uop_req_grant;
input [PALEN - 1:0] uop_req_pa;
input [25 - 1:0] uop_req_ctrl;
input [VRF_LW - 1:0] uop_req_vd_emul_len;
input [VRF_LW - 1:0] uop_req_vd_beats;
input [VRF_LW - 1:0] uop_req_vd_seg_beats;
input [VRF_LW - 1:0] uop_req_vd_buf_beats;
input [2:0] uop_req_size;
input [BEAT_CNT_WIDTH - 1:0] uop_req_beat_cnt;
input uop_req_buf_opt;
input uop_req_buf_cross_revert;
input [BUF_DEPTH_LOG2 - 1:0] uop_req_buf_num;
input [BUF_DEPTH - 1:0] uop_req_buf_ptr;
input [BUF_DEPTH - 1:0] uop_req_seg_buf_ptr;
input [BUF_DEPTH - 1:0] uop_req_buf_ptr_tl;
input [ELE_DLEN_WIDTH - 1:0] uop_req_element_num_dlen;
input uop_req_first;
input uop_req_last;
input uop_req_skip;
input uop_req_putfull;
input uop_req_ele_dlen_last;
input uop_req_ele_seg_first;
input uop_req_ele_seg_last;
input uop_req_dlen_beat;
input uop_req_align;
input uop_req_bypass;
input uop_req_ucross;
input uop_req_uextra;
input [HR_BYTE_WIDTH - 1:0] uop_req_mask_cnt;
input [HR_MAX_BYTE_WIDTH - 1:0] uop_req_byte;
input [3:0] uop_req_nf_cnt;
input uop_req_element_sel;
input [HR_OFFSET_WIDTH - 1:0] uop_req_align_value;
input [HR_OFFSET_WIDTH - 1:0] uop_req_umask_offset;
input [1:0] uop_req_align_onehot_sel;
input [3:0] uop_req_beat_mask;
input [3:0] uop_req_st_beat_mask;
input uop_req_eseg_hp;
input uop_req_ustride_mutation;
input [BUF_DEPTH - 1:0] buf_info_init_wsel;
input [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_init_value;
output [VLSU_ADDR_WIDTH - 1:0] vlsu_cm_a_address;
output vlsu_cm_a_corrupt;
output [BIU_DATA_WIDTH - 1:0] vlsu_cm_a_data;
output [BIU_MASK_WIDTH - 1:0] vlsu_cm_a_mask;
output [2:0] vlsu_cm_a_opcode;
output [2:0] vlsu_cm_a_param;
input vlsu_cm_a_ready;
output [2:0] vlsu_cm_a_size;
output [L2_SOURCE_WIDTH - 1:0] vlsu_cm_a_source;
output [11:0] vlsu_cm_a_user;
output vlsu_cm_a_shareable;
output vlsu_cm_a_valid;
output [VLSU_ADDR_WIDTH - 1:0] vlsu_nc_a_address;
output vlsu_nc_a_corrupt;
output [BIU_DATA_WIDTH - 1:0] vlsu_nc_a_data;
output [BIU_MASK_WIDTH - 1:0] vlsu_nc_a_mask;
output [2:0] vlsu_nc_a_opcode;
output [2:0] vlsu_nc_a_param;
input vlsu_nc_a_ready;
output [2:0] vlsu_nc_a_size;
output [L2_SOURCE_WIDTH - 1:0] vlsu_nc_a_source;
output [11:0] vlsu_nc_a_user;
output vlsu_nc_a_valid;
output [HVM_ADDR_WIDTH - 1:0] vlsu_vm_a_address;
output [DLEN - 1:0] vlsu_vm_a_data;
output [DMLEN - 1:0] vlsu_vm_a_mask;
output [2:0] vlsu_vm_a_opcode;
input vlsu_vm_a_ready;
output [2:0] vlsu_vm_a_size;
output vlsu_vm_a_valid;
input [4 - 1:0] vlsu_cm_d_cause;
input vlsu_cm_d_corrupt;
input [BIU_DATA_WIDTH - 1:0] vlsu_cm_d_data;
input vlsu_cm_d_denied;
input [2:0] vlsu_cm_d_opcode;
input [1:0] vlsu_cm_d_param;
output vlsu_cm_d_ready;
input [TL_SINK_WIDTH - 1:0] vlsu_cm_d_sink;
input [2:0] vlsu_cm_d_size;
input [L2_SOURCE_WIDTH - 1:0] vlsu_cm_d_source;
input [5:0] vlsu_cm_d_user;
input vlsu_cm_d_valid;
input vlsu_nc_d_corrupt;
input [BIU_DATA_WIDTH - 1:0] vlsu_nc_d_data;
input vlsu_nc_d_denied;
input [2:0] vlsu_nc_d_opcode;
input [1:0] vlsu_nc_d_param;
output vlsu_nc_d_ready;
input [TL_SINK_WIDTH - 1:0] vlsu_nc_d_sink;
input [2:0] vlsu_nc_d_size;
input [L2_SOURCE_WIDTH - 1:0] vlsu_nc_d_source;
input [5:0] vlsu_nc_d_user;
input vlsu_nc_d_valid;
input vlsu_vm_d_corrupt;
input [DLEN - 1:0] vlsu_vm_d_data;
input vlsu_vm_d_denied;
input [2:0] vlsu_vm_d_opcode;
output vlsu_vm_d_ready;
input [2:0] vlsu_vm_d_size;
input vlsu_vm_d_valid;
output [BUF_DEPTH - 1:0] vlsbuf_vs3_rptr;
input [DLEN - 1:0] vlsbuf_vs3_rdata;
input [DMLEN - 1:0] vlsbuf_vs3_byte_mask;
output [BUF_DEPTH - 1:0] vlsbuf_vd_wsel;
output vlsbuf_vd_write_dlen_last;
output [DLEN - 1:0] vlsbuf_vd_wdata;
output [DMLEN - 1:0] vlsbuf_vd_bwe;
output [BUF_DEPTH - 1:0] vlsbuf_vd_dlen_done;
output [BUF_DEPTH - 1:0] vlsbuf_vd_ualign_wsel;
output vlsbuf_vd_ualign_write_dlen_last;
output [DLEN - 1:0] vlsbuf_vd_ualign_wdata;
output [DMLEN - 1:0] vlsbuf_vd_ualign_bwe;
input [DLEN - 1:0] vlsbuf_vd_rdata;
input [DMLEN - 1:0] vlsbuf_vd_byte_mask;
input [BUF_DEPTH - 1:0] vlsbuf_ent_occupied;
input [BUF_DEPTH - 1:0] vlsbuf_ent_mask_ready;
input [BUF_DEPTH - 1:0] vlsbuf_ent_mask_ready_nx;
input [BUF_DEPTH - 1:0] vlsbuf_ent_return_last;
output [BUF_DEPTH - 1:0] vlsbuf_vd_element_bwe_wsel;
output [DMLEN - 1:0] vlsbuf_vd_element_bwe;
output [BUF_DEPTH - 1:0] vlsbuf_return_sel;
output hr_vd_buf_ptr_dup_en;
output [BUF_DEPTH - 1:0] hr_vd_buf_ptr_dup_nx;
output [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_dup_nx;
output unpacked_req_en;
input unpacked_resp_finish;
output [VRF_LW - 1:0] unpacked_vd_beats;
output [11 - 1:0] unpacked_ctrl;
output [3:0] unpacked_nf_cnt;
output [ELE_DLEN_WIDTH - 1:0] unpacked_element_num_dlen;
output [BUF_DEPTH_LOG2 - 1:0] unpacked_start_buf_num;
output [BUF_DEPTH - 1:0] unpacked_start_buf_ptr;
output segbuf_unpacked_data_wvalid;
input segbuf_unpacked_data_wready;
output [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_wdata;
input [BUF_DEPTH - 1:0] vlsbuf_unpacked_wsel;
output ustride_unpacked_req;
output [VRF_LW - 1:0] ustride_unpacked_vd_beats;
output [11 - 1:0] ustride_unpacked_ctrl;
output [BUF_DEPTH_LOG2 - 1:0] ustride_unpacked_start_buf_num;
output [BUF_DEPTH - 1:0] vlsbuf_useg_rptr;
input useg_occupied;
input [DLEN - 1:0] ustride_seg_rdata;
output ustride_seg_data_clr;
output ustride_seg_data_done;
output hr_req_seg_inst_last;
input packing;
output segbuf_packed_data_rlast;
output segbuf_packed_buf_clr;
output segbuf_packed_buf_shift;
input segbuf_packed_occupied;
input [DLEN - 1:0] segbuf_packed_rdata;
output vlsu_vd_wvalid;
input vlsu_vd_wready;
input vlsu_vd_wlast;
output [DLEN - 1:0] vlsu_vd_wdata;
output [(DLEN / 8) - 1:0] vlsu_vd_wmask;
output vpu_ls_async_read_error;
output vpu_ls_async_write_error;
output vpu_ls_async_ecc_error;
output vpu_ls_async_ecc_corr;
output [3:0] vpu_ls_async_ecc_ramid;
output vpu_ls_async_ecc_read;





// c6020405 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire hr_enq_cmd_alive;
wire hr_ent_enq_alive_d1_en;
wire [HR_DEPTH - 1:0] hr_ent_enq_alive;
reg [HR_DEPTH - 1:0] hr_ent_enq_alive_d1;
wire [31:0] hr_ent_enq_alive_zext;
wire [HR_DEPTH - 1:0] hr_ent_busy;
wire [31:0] hr_ent_busy_zext;
wire [HR_DEPTH - 1:0] hr_ent_inflight_ld;
wire hr_enq_ptr_en;
wire hr_req_ptr_en;
wire hr_deq_ptr_en;
wire [HR_DEPTH - 1:0] hr_enq_ptr;
wire [HR_DEPTH - 1:0] hr_req_ptr;
wire hr_req_num_en;
wire [HR_DEPTH_LOG2 - 1:0] hr_req_num_nx;
reg [HR_DEPTH_LOG2 - 1:0] hr_req_num;
wire [HR_DEPTH - 1:0] hr_deq_ptr;
wire [HR_DEPTH - 1:0] hr_resp_ptr;
wire [HR_DEPTH_LOG2 - 1:0] hr_resp_num;
wire [HR_DEPTH - 1:0] hr_enq_sel;
wire [HR_DEPTH - 1:0] hr_a_grant_sel;
wire [HR_DEPTH - 1:0] hr_d_grant_sel;
wire [HR_DEPTH - 1:0] hr_ld_ualign_sel;
wire hr_full;
wire hr_not_full;
wire uop_req_ready;
wire [HR_DEPTH - 1:0] hr_ent_occupied;
wire [HR_DEPTH - 1:0] hr_ent_req_valid;
wire [HR_DEPTH - 1:0] hr_ent_done;
wire [(CL_BASE_WIDTH * HR_DEPTH) - 1:0] hr_ent_pa_cl_base;
wire [(HR_BASE_WIDTH * HR_DEPTH) - 1:0] hr_ent_pa_base;
wire [(34 * HR_DEPTH) - 1:0] hr_ent_ctrl;
wire [(BUF_DEPTH * HR_DEPTH) - 1:0] hr_ent_buf_ptr;
wire [(BUF_DEPTH * HR_DEPTH) - 1:0] hr_ent_seg_buf_ptr;
wire [(BUF_DEPTH * HR_DEPTH) - 1:0] hr_ent_buf_ptr_tl;
wire [(ELE_DLEN_WIDTH * HR_DEPTH) - 1:0] hr_ent_element_num_dlen;
wire [HR_DEPTH - 1:0] hr_ent_element_sel;
wire [(HR_OFFSET_WIDTH * HR_DEPTH) - 1:0] hr_ent_align_value;
wire [(HR_OFFSET_WIDTH * HR_DEPTH) - 1:0] hr_ent_umask_cnt_offset;
wire [(2 * HR_DEPTH) - 1:0] hr_ent_align_onehot_sel;
wire [HR_DEPTH - 1:0] hr_ent_beat_mask_lsb;
wire [(4 * HR_DEPTH) - 1:0] hr_ent_beat_mask;
wire [HR_DEPTH - 1:0] hr_ent_dlen_beat;
wire [HR_DEPTH - 1:0] hr_ent_eseg_hp;
wire [HR_DEPTH - 1:0] hr_ent_ustride_mutation;
wire [HR_DEPTH - 1:0] hr_ent_ucross;
wire [HR_DEPTH - 1:0] hr_ent_uextra;
wire [HR_DEPTH - 1:0] hr_ent_ld_ucross_dlen;
wire [(HR_DEPTH * HR_BYTE_WIDTH) - 1:0] hr_ent_ld_ucross_mask_cnt;
wire [(HR_DEPTH * HR_MASK_WIDTH) - 1:0] hr_ent_vd_mask;
wire [(HR_DEPTH * ELE_DLEN_WIDTH) - 1:0] hr_ent_vd_bwe_offset;
wire [HR_DEPTH - 1:0] hr_ent_first;
wire [HR_DEPTH - 1:0] hr_ent_last;
wire [(HR_DEPTH * BEAT_CNT_WIDTH) - 1:0] hr_ent_total_beat_cnt;
wire [(HR_DEPTH * BEAT_CNT_WIDTH) - 1:0] hr_ent_beat_cnt;
wire [(HR_DEPTH * VRF_LW) - 1:0] hr_ent_vd_beats;
wire [(HR_DEPTH * HR_BYTE_WIDTH) - 1:0] hr_ent_umask_cnt;
wire [HR_DEPTH - 1:0] hr_ent_check_hazard_en;
wire [HR_DEPTH - 1:0] hr_ent_ustride_una_hvm_en;
wire [HR_DEPTH - 1:0] hr_ent_ustride_una_cmnc_en;
wire [HR_DEPTH - 1:0] hr_ent_d_last;
wire [HR_DEPTH - 1:0] hr_ent_wait_reg_clr;
wire [HR_DEPTH - 1:0] hr_ent_store_valid;
wire [HR_DEPTH - 1:0] hr_ent_load_valid;
wire [HR_DEPTH - 1:0] hr_ent_load_pending;
wire [HR_DEPTH - 1:0] hr_ent_store_pending;
wire [HR_DEPTH - 1:0] hr_ent_store_pending_hvm;
wire [HR_DEPTH - 1:0] hr_ent_store_pending_nhvm;
wire [HR_DEPTH - 1:0] hr_ent_cmd_valid;
wire [HR_DEPTH - 1:0] hr_ent_block_cmd_hvm;
wire [HR_DEPTH - 1:0] hr_ent_block_cmd_nhvm;
wire [HR_DEPTH - 1:0] hr_ent_skip;
wire [HR_DEPTH - 1:0] hr_ent_bypass_cond;
wire [HR_DEPTH - 1:0] hr_ent_seg_num_dlen_hit;
wire [PALEN - 1:0] hr_enq_pa;
wire [34 - 1:0] hr_enq_ctrl;
wire [BUF_DEPTH - 1:0] hr_enq_start_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_enq_seg_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_enq_buf_ptr_tl;
wire [HR_BYTE_WIDTH - 1:0] hr_enq_mask_cnt;
wire [HR_MAX_BYTE_WIDTH - 1:0] hr_enq_byte;
wire [3:0] hr_enq_nf_cnt;
wire hr_enq_hvm;
wire hr_enq_skip;
wire hr_enq_first;
wire hr_enq_last;
wire hr_enq_load;
wire hr_enq_store;
wire hr_enq_c2nc;
wire [3:0] hr_enq_mtype;
wire [3:0] hr_enq_arcache;
wire [3:0] hr_enq_awcache;
wire [ELE_DLEN_WIDTH - 1:0] hr_enq_element_num_dlen;
wire hr_enq_element_sel;
wire [HR_DEPTH - 1:0] hr_wait_reg_set;
wire [HR_DEPTH - 1:0] hr_wait_reg_clr;
wire [HR_DEPTH - 1:0] hr_wait_reg_raw;
wire [HR_DEPTH - 1:0] hr_wait_reg_waw;
wire [HR_DEPTH - 1:0] hr_wait_reg_war;
wire [HR_DEPTH - 1:0] hr_wait_reg_en;
wire [HR_DEPTH - 1:0] hr_hvm_wait_reg_set0;
wire [HR_DEPTH - 1:0] hr_hvm_wait_reg_set1;
wire [HR_DEPTH - 1:0] hr_hvm_wait_reg_set;
wire [BEAT_CNT_WIDTH - 1:0] hr_enq_total_beat_cnt;
wire [VRF_LW - 1:0] hr_enq_vd_beats;
wire hr_enq_dlen_beat;
wire [HR_OFFSET_WIDTH - 1:0] hr_enq_align_value;
wire [HR_OFFSET_WIDTH - 1:0] hr_enq_umask_cnt_offset;
wire [1:0] hr_enq_align_onehot_sel;
wire [3:0] hr_enq_beat_mask;
wire [3:0] hr_enq_st_beat_mask;
wire hr_enq_eseg_hp;
wire hr_enq_ustride_mutation;
wire hr_enq_ucross;
wire hr_enq_uextra;
wire [BUF_DEPTH_LOG2 - 1:0] hr_resp_buf_num;
wire [BUF_DEPTH - 1:0] hr_resp_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_req_seg_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_req_buf_ptr_tl;
wire [VRF_LW:0] hr_vd_sint_cnt;
wire [VRF_LW:0] hr_vd_sint_cnt_sel;
wire [BUF_DEPTH_LOG2:0] hr_vd_sint_cnt_sel_zext;
wire [VRF_LW:0] hr_vd_sint_cnt_add1;
wire vlsbuf_ld_return_valid0;
wire vlsbuf_ld_return_valid1;
wire [BUF_DEPTH - 1:0] vlsbuf_ld_return_ptr0_nx;
wire [BUF_DEPTH - 1:0] vlsbuf_ld_return_ptr1;
wire [BUF_DEPTH - 1:0] vlsbuf_ld_return_sel;
wire [BUF_DEPTH - 1:0] vlsbuf_ld_seg_return_sel;
wire vlsbuf_st_return_valid;
wire vlsbuf_st_return_cond;
wire [BUF_DEPTH - 1:0] vlsbuf_st_return_sel;
reg [2:0] channel_d_sel;
wire [2:0] channel_d_sel_cur;
wire [2:0] channel_d_sel_nx;
wire channel_d_sel_en;
reg [(BIU_DATA_WIDTH / 64) * 2 - 1:0] channel_d_data_sel;
wire [(BIU_DATA_WIDTH / 64) * 2 - 1:0] channel_d_data_sel_nx;
wire channel_d_data_sel_en;
reg [2:0] channel_d_sel_dup;
wire [2:0] channel_d_sel_dup_cur;
wire [2:0] channel_d_sel_dup_nx;
wire channel_d_sel_dup_en;
wire ififo_wvalid;
wire ififo_wready;
wire [2:0] ififo_vd_eew_w;
wire [VRF_LW - 1:0] ififo_vd_emul_len_w;
wire [BUF_DEPTH_LOG2 - 1:0] ififo_start_buf_num_w;
wire [BUF_DEPTH - 1:0] ififo_start_buf_ptr_w;
wire [2:0] ififo_nf_w;
wire ififo_useg_w;
wire ififo_uwiden_w;
wire ififo_sext_w;
wire [VRF_LW - 1:0] ififo_vd_beats_w;
wire [VRF_LW - 1:0] ififo_vd_seg_beats_w;
wire [VRF_LW - 1:0] ififo_vd_buf_beats_w;
wire ififo_buf_opt_w;
wire [1:0] ififo_vd_eew_r;
wire [VRF_LW - 1:0] ififo_vd_emul_len_r;
wire [BUF_DEPTH_LOG2 - 1:0] ififo_start_buf_num_r;
wire [BUF_DEPTH - 1:0] ififo_start_buf_ptr_r;
wire [2:0] ififo_nf_r;
wire ififo_useg_r;
wire ififo_uwiden_r;
wire ififo_sext_r;
wire [VRF_LW - 1:0] ififo_vd_beats_r;
wire [VRF_LW - 1:0] ififo_vd_seg_beats_r;
wire [VRF_LW - 1:0] ififo_vd_buf_beats_r;
wire ififo_buf_opt_r;
wire ififo_rvalid;
wire ififo_rready;
wire hr_vd_en;
wire hr_vd_reset_en;
wire hr_vd_init_en;
reg hr_vd_valid;
reg [(DMLEN / 8) - 1:0] hr_vd_valid_dup;
reg [1:0] hr_vd_eew;
reg [VRF_LW - 1:0] hr_vd_emul_len;
reg [BUF_DEPTH_LOG2 - 1:0] hr_vd_start_buf_num;
reg [BUF_DEPTH - 1:0] hr_vd_start_buf_ptr;
reg [2:0] hr_vd_nf;
reg hr_vd_useg;
reg hr_vd_uwiden;
reg [(DLEN / 64) - 1:0] hr_vd_useg_dup;
reg [(DLEN / 64) - 1:0] hr_vd_uwiden_dup;
reg hr_vd_sext;
reg hr_vd_buf_opt;
reg [VRF_LW - 1:0] hr_vd_beats;
reg [VRF_LW - 1:0] hr_vd_seg_beats;
reg [VRF_LW - 1:0] hr_vd_buf_beats;
wire hr_vd_buf_ptr_en;
wire hr_vd_buf_ptr_clr;
wire hr_vd_buf_ptr_resume;
wire hr_vd_resume;
wire hr_vd_data_revert;
wire hr_vd_mask_revert;
reg [BUF_DEPTH - 1:0] hr_vd_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_vd_buf_ptr_nx;
wire [BUF_DEPTH - 1:0] hr_vd_buf_ptr_add1;
wire [BUF_DEPTH - 1:0] hr_vd_buf_ptr_sub1;
wire [BUF_DEPTH - 1:0] hr_vd_buf_ptr_inc_sel;
wire [BUF_DEPTH - 1:0] hr_vd_buf_ptr_bk_nx;
reg [BUF_DEPTH - 1:0] hr_vd_buf_ptr_bk;
reg [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr;
wire [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_nx;
wire [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_add1;
wire [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_sub1;
wire [BUF_DEPTH - 1:0] hr_vd_mask_buf_ptr_inc_sel;
wire hr_vd_useg_wlast;
wire hr_vd_ustride_dlen_last;
wire hr_vd_bypass_cond;
wire [VRF_LW:0] hr_vd_buf_beats_add1;
wire [BUF_DEPTH_LOG2:0] hr_vd_buf_beats_add1_zext;
wire [VRF_LW:0] hr_vd_seg_beats_add1;
wire [BUF_DEPTH_LOG2:0] hr_vd_seg_beats_add1_zext;
wire hr_vd_eew8;
wire hr_vd_eew16;
wire hr_vd_eew32;
wire hr_vd_eew64;
wire [3:0] hr_vd_eew_onehot;
wire hr_vd_wr_dummy_valid;
wire [(DMLEN / 8) - 1:0] hr_vd_wr_dummy_valid_dup;
wire hr_vd_finished_set;
wire hr_vd_finished_clr;
wire hr_vd_finished_en;
wire hr_vd_finished_nx;
reg hr_vd_finished;
reg [(DMLEN / 8) - 1:0] hr_vd_finished_dup;
wire [BUF_DEPTH - 1:0] hr_vd_seg_start_buf_ptr;
wire [BUF_DEPTH - 1:0] vlsbuf_useg_rptr;
wire [BUF_DEPTH - 1:0] vlsbuf_useg_return_ptr;
wire ustride_seg_data_rvalid;
wire ustride_seg_data_rgrant;
wire [BUF_DEPTH - 1:0] vlsbuf_vd_unpacked_last;
wire vlsbuf_vd_data_ready_nx;
wire vlsbuf_vd_eseg_ready_nx;
wire vlsbuf_vd_mask_ready_en;
wire vlsbuf_vd_mask_ready_nx;
wire vlsbuf_vd_rgrant_en;
wire vlsbuf_vd_rgrant_nx;
reg vlsbuf_vd_rgrant;
reg [(DLEN / 64) - 1:0] vlsbuf_vd_rgrant_dup;
wire [DLEN - 1:0] vlsbuf_vd_widen_data0;
wire [DLEN - 1:0] vlsbuf_vd_widen_data1;
wire [DLEN - 1:0] vlsbuf_vd_widen_rdata;
wire [DLEN - 1:0] vlsu_vd_bypass_data;
wire vlsu_vd_bypass_valid;
wire vlsu_vd_bypass_cond;
wire vlsu_vd_bypass_fail;
wire vlsu_vd_wgrant;
wire hr_resp_load2buf_valid;
wire hr_vd_emul_cnt_en;
wire [VRF_LW - 1:0] hr_vd_emul_cnt_nx;
reg [VRF_LW - 1:0] hr_vd_emul_cnt;
wire hr_vd_emul_len_wlast;
wire hr_vd_emul_wlast;
wire hr_vd_nf_cnt_en;
wire hr_vd_nf_cnt_set;
wire hr_vd_nf_cnt_clr;
wire [2:0] hr_vd_nf_cnt_nx;
reg [2:0] hr_vd_nf_cnt;
wire inst_vd_wr_last;
reg vlsbuf_vd_mask_ready;
wire hr_req_valid;
wire hr_req_first;
wire hr_req_last;
wire hr_cmd_empty_all;
wire hr_cmd_empty_others;
wire hr_req_buf_ptr_rst0;
wire hr_req_buf_ptr_rst1;
wire hr_req_buf_ptr_rst2;
wire [HR_DEPTH - 1:0] hr_req_ptr_nx;
wire [BUF_DEPTH - 1:0] hr_req_buf_ptr_pre_nx;
wire hr_req_cmd_valid_nx;
wire hr_req_buf_ptr_en;
wire [BUF_DEPTH - 1:0] hr_req_buf_ptr_nx;
reg [BUF_DEPTH - 1:0] hr_req_buf_ptr;
wire hr_req_ualgin_st_period_set;
wire hr_req_ualgin_st_period_clr;
wire hr_req_ualgin_st_period_en;
wire hr_req_ualgin_st_period_nx;
reg hr_req_ualgin_st_period;
wire hr_ualign_st_period_valid;
wire hr_vs3_rptr_en;
wire hr_vs3_rptr_inc_en;
wire hr_vs3_rptr_revert;
wire [BUF_DEPTH - 1:0] hr_vs3_rptr_add1;
wire [BUF_DEPTH - 1:0] hr_vs3_rptr_sub1;
wire [BUF_DEPTH - 1:0] hr_vs3_rptr_inc_sel;
wire [VRF_LW - 1:0] hr_vs3_rcnt_nx;
wire [VRF_LW - 1:0] hr_vs3_rcnt_add1;
reg [VRF_LW - 1:0] hr_vs3_rcnt;
wire hr_vs3_cross_biu_nx;
reg hr_vs3_cross_biu;
wire hr_vs3_cross_biu_sel;
wire hr_vs3_extra_biu_nx;
reg hr_vs3_extra_biu;
wire hr_vs3_extra_biu_sel;
wire hr_vs3_hvm_sel;
wire hr_vs3_rfirst;
wire hr_vs3_rlast;
wire hr_vs3_done_set;
wire hr_vs3_done_clr;
wire hr_vs3_done_en;
wire hr_vs3_done_nx;
reg hr_vs3_done;
wire [1:0] hr_vs3_onehot_sel_nx;
reg [1:0] hr_vs3_onehot_sel;
wire hr_vs3_hvm_set;
wire hr_vs3_hvm_clr;
wire hr_vs3_hvm_en;
wire hr_vs3_hvm_nx;
reg hr_vs3_hvm;
wire st_ualign_valid;
wire st_ualign_eseg_valid;
wire st_ualign_useg_valid;
wire st_ualign_seg_valid;
wire st_ualign_nseg_wvalid;
wire st_ualign_seg_wvalid;
wire st_ualign_nseg_wgrant;
wire st_ualign_seg_wgrant;
wire [BEAT_CNT_WIDTH - 1:0] hr_req_total_beat_cnt;
wire [VRF_LW - 1:0] hr_req_vd_beats;
wire vlsbuf_vd_element_cond;
wire vlsbuf_vd_element_wvalid;
wire hr_a_grant;
wire hr_a_last;
wire hr_a_store_grant;
wire [HR_MASK_WIDTH - 1:0] hr_req_mask;
wire hr_req_ucross_biu;
wire hr_req_uextra_biu;
wire hr_a_ncable;
wire hr_a_cable;
wire hr_a_hvm;
wire hr_req_cmd_valid;
wire [34 - 1:0] hr_req_ctrl;
wire [2:0] hr_req_size;
wire [HR_BYTE_WIDTH - 1:0] hr_req_umask_cnt;
wire [HR_BYTE_WIDTH - 1:0] hr_req_mask_cnt;
wire [2:0] hr_req_eew;
wire hr_req_eew8;
wire hr_req_eew16;
wire hr_req_eew32;
wire hr_req_eew64;
wire hr_req_ustride;
wire hr_req_element;
wire hr_req_seg;
wire hr_req_non_seg;
wire hr_req_ustride_seg;
wire hr_req_ustride_nseg;
wire hr_req_element_seg;
wire hr_req_element_nseg;
wire [HR_BASE_WIDTH - 1:0] hr_req_pa_base;
wire [HR_OFFSET_WIDTH - 1:0] hr_req_mask_offset;
wire hr_req_align;
wire hr_req_ustride_mutation;
wire hr_req_eseg_hp;
wire hr_req_u_nseg_bypass_cond;
wire hr_req_u_nseg_unbypass_cond;
wire hr_req_e_nseg_bypass_cond;
wire hr_req_useg_bypass_cond;
wire hr_req_useg_unbypass_cond;
wire hr_req_eseg_bypass_cond;
wire hr_req_eseg_unbypass_cond;
wire hr_req_u_nseg_bypass_valid;
wire hr_req_eseg_bypass_valid;
wire hr_req_eseg_unbypass_valid;
wire hr_req_useg_bypass_valid;
wire hr_req_useg_unbypass_valid;
wire hr_a_eseg_bypass_grant;
wire hr_a_useg_bypass_grant;
wire hr_a_st_eseg_valid;
wire hr_a_st_useg_valid;
wire hr_a_st_eseg_grant;
wire hr_a_st_useg_grant;
wire hr_req_seg_num_dlen_hit;
wire hr_req_seg_num_dlen_skip;
wire hr_req_seg_num_dlen_en;
wire [ELE_DLEN_WIDTH - 1:0] hr_req_seg_num_dlen_nx;
reg [ELE_DLEN_WIDTH - 1:0] hr_req_seg_num_dlen;
wire hr_req_load;
wire hr_req_store;
wire hr_req_putfull;
wire hr_req_putpart;
wire hr_req_dlen_beat;
wire hr_req_ele_dlen_last;
wire hr_req_ele_seg_first;
wire hr_req_ele_seg_last;
wire hr_req_skip;
wire hr_req_wait_clr;
wire [2:0] hr_req_prot;
wire [3:0] hr_req_axcache;
wire [BEAT_CNT_WIDTH - 1:0] hr_req_beat_cnt;
wire hr_req_beat_first;
wire hr_req_beat_last;
wire [ELE_DLEN_WIDTH - 1:0] hr_req_element_num_dlen;
wire [HR_OFFSET_WIDTH - 1:0] hr_req_element_num_biu;
wire [HR_OFFSET_WIDTH - 1:0] hr_req_element_byte_biu;
wire hr_req_element_sel;
wire [HR_OFFSET_WIDTH - 1:0] hr_req_align_value;
wire [HR_OFFSET_WIDTH - 1:0] hr_req_umask_cnt_offset;
wire [1:0] hr_req_align_onehot_sel;
wire hr_req_beat_mask_lsb;
wire [3:0] hr_req_beat_mask;
wire [DLEN - 1:0] hr_req_align_data_in;
wire [DLEN * 2 - 1:0] hr_req_align_data_init;
wire [HR_DATA_WIDTH * 4 - 1:0] hr_req_align_data_out;
wire [HR_DATA_WIDTH * 2 - 1:0] hr_req_align_data_wrap;
wire [BIU_DATA_WIDTH - 1:0] hr_req_ealign_data;
wire [HVM_DATA_WIDTH - 1:0] hr_req_vm_ealign_data;
wire hr_payload_data_ready;
wire hr_ustride_payload_ready;
wire hr_bypass_beat_ready;
wire hr_unbypass_payload_ready;
wire hr_req_u_nseg_bypass_ready;
wire hr_req_u_nseg_unbypass_ready;
wire hr_req_e_nseg_bypass_ready;
wire hr_req_eseg_bypass_ready;
wire hr_req_eseg_unbypass_ready;
wire hr_req_useg_bypass_ready;
wire hr_req_useg_unbypass_ready;
wire hr_vs3_buf_ptr_tl_en;
wire [BUF_DEPTH - 1:0] hr_vs3_buf_ptr_tl_nx;
reg [BUF_DEPTH - 1:0] hr_vs3_buf_ptr_tl;
wire [1:0] st_ualign_onehot_sel;
wire st_ualign_wvalid;
wire st_ualign_wready;
wire st_ualign_wgrant;
wire [HR_DATA_WIDTH * 2 - 1:0] st_ualign_wdata;
wire [BIU_DATA_WIDTH - 1:0] st_ualign_wdata_extra;
wire [BIU_MASK_WIDTH * 2 - 1:0] st_ualign_biu_bwe;
wire [HR_MASK_WIDTH * 2 - 1:0] st_ualign_hvm_bwe;
wire [HR_MASK_WIDTH * 2 - 1:0] st_ualign_bwe;
wire [HR_MASK_WIDTH * 2 - 1:0] st_ualign_v0t_wdata;
wire [BIU_MASK_WIDTH - 1:0] st_ualign_v0t_extra_wdata;
wire st_ualign_wfirst;
wire st_ualign_wlast;
wire [1:0] st_ualign_wfirst_cnt;
wire [1:0] st_ualign_wlast_cnt;
wire st_ualign_cross_biu;
wire st_ualign_extra_biu;
wire [HR_MASK_WIDTH * 2 - 1:0] st_ualign_bwe_sel;
wire [HR_MASK_WIDTH * 4 - 1:0] st_ualign_bwe_shift;
wire [HR_MASK_WIDTH * 4 - 1:0] st_ualign_v0t_shift;
wire [DMLEN * 2 - 1:0] st_ualign_v0t_init;
wire st_ualign_hvm;
wire hr_req_ualign_rfirst;
wire hr_req_ualign_rlast;
wire [BIU_DATA_WIDTH - 1:0] hr_req_ualign_data_xhvm;
wire [HVM_DATA_WIDTH - 1:0] hr_req_ualign_data_hvm;
wire [HR_MASK_WIDTH - 1:0] nds_unused_hr_req_ualign_mask;
wire [HR_MASK_WIDTH - 1:0] hr_req_ualign_mask_clr;
wire hr_req_ualign_rvalid;
wire hr_req_ualign_rready;
wire segbuf_packed_data_rvalid;
wire segbuf_packed_data_rgrant;
wire segbuf_upacked_rlast;
wire segbuf_epacked_rlast;
wire segbuf_eseg_rlast;
wire hr_dummy_a_grant;
wire hr_dummy_d_valid_en;
wire hr_dummy_d_valid_stall;
wire hr_dummy_d_valid_set;
wire hr_dummy_d_valid_clr;
wire hr_dummy_d_valid_nx;
reg hr_dummy_d_valid;
wire hr_dummy_d_valid_hvm_set;
wire hr_dummy_d_hvm_nx;
reg hr_dummy_d_hvm;
wire hr_dummy_d_ready;
wire hr_dummy_d_grant;
wire [HR_DEPTH - 1:0] hr_dummy_d_grant_sel;
wire hr_dummy_resp_num_en;
wire [HR_DEPTH_LOG2 - 1:0] hr_dummy_resp_num_nx;
reg [HR_DEPTH_LOG2 - 1:0] hr_dummy_resp_num;
wire vlsu_cm_async_err;
wire vlsu_cm_async_ecc_error;
wire vlsu_cm_async_ecc_corr;
wire vlsu_cm_async_ecc_ramid;
wire vlsu_vm_async_bus_err;
wire vlsu_cm_async_bus_err;
wire vlsu_nc_async_bus_err;
wire vlsu_async_bus_err;
wire vlsu_async_error_set;
wire vlsu_async_error_clr;
wire vlsu_async_error_en;
wire vlsu_async_bus_error_nx;
wire vlsu_async_ecc_error_nx;
wire vlsu_async_ecc_corr_nx;
wire vlsu_async_ecc_ramid_nx;
wire vlsu_async_ecc_read_nx;
reg vlsu_async_bus_error;
reg vlsu_async_ecc_error;
reg vlsu_async_ecc_corr;
reg vlsu_async_ecc_ramid;
reg vlsu_async_ecc_read;
wire vlsu_vm_d_grant;
wire hr_d_grant;
wire hr_d_load;
wire hr_d_load_grant;
wire [DLEN - 1:0] hr_d_align_data;
wire [DLEN - 1:0] hr_resp_widen_data_in;
wire [DLEN - 1:0] hr_resp_widen_data_out;
wire [DLEN * 2 - 1:0] hr_resp_align_data_in;
wire [DLEN * 2 - 1:0] hr_resp_align_data_out;
wire [2:0] hr_resp_eew;
wire hr_resp_eew8;
wire hr_resp_eew16;
wire hr_resp_eew32;
wire hr_resp_eew64;
wire [3:0] hr_resp_eew_onehot;
wire [34 - 1:0] hr_resp_ctrl;
wire hr_resp_sext;
wire hr_resp_ewiden;
wire hr_resp_widen;
wire [HR_BYTE_WIDTH - 1:0] hr_resp_umask_cnt;
wire [HR_BYTE_WIDTH - 1:0] unpacked_nf_byte2element;
wire [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_wdata_biu;
wire [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_wdata_vm;
wire hr_resp_vd_wvalid;
wire [DMLEN - 1:0] hr_resp_vd_bwe;
wire [HR_MASK_WIDTH - 1:0] hr_resp_vd_mask;
wire [ELE_DLEN_WIDTH - 1:0] hr_resp_vd_bwe_offset;
wire [BUF_DEPTH - 1:0] hr_resp_vd_wsel;
wire hr_resp_ustride;
wire hr_resp_element;
wire hr_resp_dlen_beat;
wire hr_resp_align;
wire hr_resp_cross_revert;
wire hr_resp_ld_ucross_dlen;
wire [HR_BYTE_WIDTH - 1:0] hr_resp_ld_ucross_mask_cnt;
wire hr_resp_seg;
wire hr_resp_ustride_nseg;
wire hr_resp_element_seg;
wire hr_resp_element_nseg;
wire [ELE_DLEN_WIDTH - 1:0] hr_resp_element_num_dlen;
wire [HR_OFFSET_WIDTH - 1:0] hr_resp_align_value;
wire hr_resp_beat_mask_lsb;
wire [BEAT_CNT_WIDTH - 1:0] hr_resp_beat_cnt;
wire hr_resp_beat_first;
wire [VRF_LW - 1:0] hr_resp_vd_beats;
wire ld_ualign_wvalid;
wire ld_ualign_wready;
wire ld_ualign_wgrant;
wire [DLEN - 1:0] ld_ualign_wdata;
wire [HR_BYTE_WIDTH - 1:0] ld_ualign_wmask_cnt;
wire [BUF_DEPTH - 1:0] ld_ualign_wbuf_ptr;
wire ld_ualign_whvm;
wire ld_ualign_rvalid;
wire ld_ualign_rready;
wire ld_ualign_rgrant;
wire ld_ualign_rgrant_fail;
wire [HR_BYTE_WIDTH - 1:0] ld_ualign_rmask_cnt;
wire [BUF_DEPTH - 1:0] ld_ualign_rbuf_ptr;
wire [DLEN - 1:0] ld_ualign_rdata;
wire ld_ualign_rhvm;
wire ld_ualign_buf_clr;
wire ld_ualign_buf_hvm_set;
wire ld_ualign_buf_cmnc_set;
wire ld_ualign_buf_free_init;
wire [DMLEN - 1:0] resp_vd_ualign_bwe;
wire buf_info_resp_wvalid;
wire [BUF_DEPTH - 1:0] buf_info_resp_wsel;
wire [BUF_DEPTH - 1:0] buf_info_resp_ualign_wsel;
wire buf_info_req_rvalid;
wire [BUF_DEPTH - 1:0] buf_info_req_rsel;
wire [BUF_DEPTH - 1:0] buf_info_ent_req_dlen_last;
wire [BUF_DEPTH - 1:0] buf_info_ent_resp_dlen_last;
wire [BUF_DEPTH - 1:0] buf_info_ent_ubypass_dlen_last;
wire [BUF_DEPTH - 1:0] buf_info_ent_unbypass_dlen_last;
wire [BUF_DEPTH - 1:0] buf_info_clr_sel;
wire buf_info_req_clr;
wire buf_info_resp_clr;
wire buf_info_resp_ualign_clr;
wire hr_req_dlen_last_u;
wire hr_resp_dlen_last_u;
wire hr_resp_dlen_last_e;
wire hr_resp_dlen_last;
wire hr_resp_ualign_dlen_last;
wire hr_resp_simu_dlen_last;
wire [PALEN - 1:0] hr_a_address;
wire hr_a_corrupt;
wire [BIU_DATA_WIDTH - 1:0] hr_a_data;
wire [BIU_MASK_WIDTH - 1:0] hr_a_mask;
wire [2:0] hr_a_opcode;
wire [2:0] hr_a_param;
wire hr_a_ready;
wire [2:0] hr_a_size;
wire [L2_SOURCE_WIDTH - 1:0] hr_a_source;
wire [11:0] hr_a_user;
wire hr_a_shareable;
wire hr_a_valid;
wire [BIU_DATA_WIDTH - 1:0] hr_d_data;
wire [2:0] hr_d_opcode;
wire hr_d_ready;
wire [L2_SOURCE_WIDTH - 1:0] hr_d_source;
wire hr_d_valid;
wire [L2_SOURCE_WIDTH - 1:0] vlsu_vm_d_source;
wire [5:0] vlsu_vm_d_user = 6'd0;
wire [TL_SINK_WIDTH - 1:0] vlsu_vm_d_sink = {TL_SINK_WIDTH{1'b0}};
wire [1:0] vlsu_vm_d_param = 2'd0;
wire vm_fifo_wvalid;
wire [HR_DEPTH_LOG2 - 1:0] vm_fifo_wsource;
wire vm_fifo_wload;
wire vm_fifo_rvalid;
wire vm_fifo_rready;
wire [HR_DEPTH_LOG2 - 1:0] vm_fifo_rsource;
wire vm_fifo_rload;
wire hr_vm_d_source_en;
wire [HR_DEPTH_LOG2 - 1:0] hr_vm_d_source_nx;
wire hr_vm_d_load_nx;
reg [HR_DEPTH_LOG2 - 1:0] hr_vm_d_source;
wire hr_vm_d_source_valid_nx;
reg hr_vm_d_load;
reg hr_vm_d_source_valid;
wire [HR_DEPTH_LOG2 - 1:0] hr_vm_d_source_sel;
wire [BUF_DEPTH - 1:0] hr_vm_resp_buf_ptr_nx;
wire hr_vm_resp_load_nx;
wire hr_vm_resp_ustride_nx;
wire hr_vm_resp_align_nx;
wire [34 - 1:0] hr_vm_resp_ctrl_nx;
wire hr_vm_d_busy_nx;
wire hr_vm_d_ready_nx;
reg hr_vm_d_ready;
wire vlsu_vd_hvm_wrtie;
wire hr_vm_d_busy_cond_nx;
wire nds_unused_vm_fifo_wready;
wire nds_unused_vlsu_vm_d_user = |vlsu_vm_d_user;
wire nds_unused_vlsu_vm_d_sink = |vlsu_vm_d_sink;
wire nds_unused_vlsu_vm_d_param = |vlsu_vm_d_param;
wire nds_unused_vlsu_cm_d_param = |vlsu_cm_d_param;
wire nds_unused_vlsu_nc_d_param = |vlsu_nc_d_param;
wire nds_unused_vlsu_vm_d_size = |vlsu_vm_d_size;
wire nds_unused_vlsu_cm_d_size = |vlsu_cm_d_size;
wire nds_unused_vlsu_nc_d_size = |vlsu_nc_d_size;
wire nds_unused_vlsu_vd_bypass_data = |vlsu_vd_bypass_data;
wire nds_unused_vlsbuf_vd_rgrant_dup = |vlsbuf_vd_rgrant_dup;
wire [HR_DEPTH - 1:0] nds_unused_hr_ent_ustride_una_hvm_en;
wire [HR_DEPTH - 1:0] nds_unused_hr_hvm_wait_reg_set0;
wire [HR_DEPTH - 1:0] nds_unused_hr_hvm_wait_reg_set1;
wire [HR_DEPTH - 1:0] nds_unused_hr_ent_ustride_una_cmnc_en;
kv_bin2onehot #(
    .N(HR_DEPTH)
) u_hr_resp_ptr (
    .out(hr_resp_ptr),
    .in(hr_resp_num)
);
kv_zero_ext #(
    .OW((64 / 2)),
    .IW(HR_DEPTH)
) u_hr_ent_enq_alive_zext (
    .out(hr_ent_enq_alive_zext),
    .in(hr_ent_enq_alive_d1)
);
kv_zero_ext #(
    .OW((64 / 2)),
    .IW(HR_DEPTH)
) u_hr_ent_busy_zext (
    .out(hr_ent_busy_zext),
    .in(hr_ent_busy)
);
kv_cnt_onehot #(
    .N(HR_DEPTH)
) u_hr_enq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(hr_enq_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({HR_DEPTH{1'b0}}),
    .cnt(hr_enq_ptr)
);
kv_cnt_onehot #(
    .N(HR_DEPTH)
) u_hr_req_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(hr_req_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({HR_DEPTH{1'b0}}),
    .cnt(hr_req_ptr)
);
kv_cnt_onehot #(
    .N(HR_DEPTH)
) u_hr_deq_ptr (
    .clk(vpu_vlsu_clk),
    .rst_n(vpu_reset_n),
    .en(hr_deq_ptr_en),
    .up_dn(1'b1),
    .load(1'b0),
    .data({HR_DEPTH{1'b0}}),
    .cnt(hr_deq_ptr)
);
genvar i;
generate
    for (i = 0; i < HR_DEPTH; i = i + 1) begin:gen_vls_hr_ent
        kv_vls_hr_ent #(
            .VLSU_SUPPORT_HVM(VLSU_SUPPORT_HVM),
            .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
            .BIU_MASK_WIDTH(BIU_MASK_WIDTH),
            .BIU_OFFSET_WIDTH(BIU_OFFSET_WIDTH),
            .HVM_DATA_WIDTH(HVM_DATA_WIDTH),
            .HVM_OFFSET_WIDTH(HVM_OFFSET_WIDTH),
            .HR_DEPTH(HR_DEPTH),
            .VLEN(VLEN),
            .DLEN(DLEN),
            .DMLEN(DMLEN),
            .ELEN(ELEN),
            .PALEN(PALEN),
            .VRF_LW(VRF_LW),
            .BUF_DEPTH(BUF_DEPTH),
            .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
            .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
            .BEAT_CNT_WIDTH(BEAT_CNT_WIDTH),
            .CL_OFFSET_WIDTH(CL_OFFSET_WIDTH),
            .CL_BASE_WIDTH(CL_BASE_WIDTH),
            .HR_OFFSET_WIDTH(HR_OFFSET_WIDTH),
            .HR_BASE_WIDTH(HR_BASE_WIDTH),
            .BIU_BASE_WIDTH(BIU_BASE_WIDTH),
            .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
            .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
            .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
            .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
            .BIU_BYTE_WIDTH(BIU_BYTE_WIDTH),
            .DLEN_BYTE_WIDTH(DLEN_BYTE_WIDTH),
            .NF_BYTE_WIDTH(NF_BYTE_WIDTH),
            .CL_BYTE_WIDTH(CL_BYTE_WIDTH),
            .HR_BYTE_WIDTH(HR_BYTE_WIDTH),
            .HR_MAX_BYTE_WIDTH(HR_MAX_BYTE_WIDTH),
            .HR_MASK_WIDTH(HR_MASK_WIDTH)
        ) u_vls_hr_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .hr_vd_bypass_cond(hr_vd_bypass_cond),
            .hr_vd_buf_ptr(hr_vd_buf_ptr),
            .hr_req_seg_num_dlen(hr_req_seg_num_dlen),
            .hr_enq_valid(hr_enq_sel[i]),
            .hr_deq_valid(hr_deq_ptr[i]),
            .hr_a_grant_valid(hr_a_grant_sel[i]),
            .hr_d_grant_valid(hr_d_grant_sel[i]),
            .hr_dummy_d_grant_valid(hr_dummy_d_grant_sel[i]),
            .hr_ld_ualign_valid(hr_ld_ualign_sel[i]),
            .hr_a_last(hr_a_last),
            .hr_enq_pa(hr_enq_pa),
            .hr_enq_ucross(hr_enq_ucross),
            .hr_enq_uextra(hr_enq_uextra),
            .hr_enq_ctrl(hr_enq_ctrl),
            .hr_enq_start_buf_ptr(hr_enq_start_buf_ptr),
            .hr_enq_seg_buf_ptr(hr_enq_seg_buf_ptr),
            .hr_enq_buf_ptr_tl(hr_enq_buf_ptr_tl),
            .hr_enq_element_num_dlen(hr_enq_element_num_dlen),
            .hr_enq_element_sel(hr_enq_element_sel),
            .hr_enq_align_value(hr_enq_align_value),
            .hr_enq_umask_cnt_offset(hr_enq_umask_cnt_offset),
            .hr_enq_align_onehot_sel(hr_enq_align_onehot_sel),
            .hr_enq_beat_mask(hr_enq_beat_mask),
            .hr_enq_st_beat_mask(hr_enq_st_beat_mask),
            .hr_enq_eseg_hp(hr_enq_eseg_hp),
            .hr_enq_ustride_mutation(hr_enq_ustride_mutation),
            .hr_enq_first(hr_enq_first),
            .hr_enq_last(hr_enq_last),
            .hr_enq_total_beat_cnt(hr_enq_total_beat_cnt),
            .hr_enq_vd_beats(hr_enq_vd_beats),
            .hr_enq_dlen_beat(hr_enq_dlen_beat),
            .hr_enq_mask_cnt(hr_enq_mask_cnt),
            .hr_enq_byte(hr_enq_byte),
            .hr_enq_nf_cnt(hr_enq_nf_cnt),
            .hr_wait_reg_set(hr_wait_reg_set),
            .hr_wait_reg_clr(hr_wait_reg_clr),
            .hr_hvm_wait_reg_set(hr_hvm_wait_reg_set),
            .ld_ualign_buf_hvm_set(ld_ualign_buf_hvm_set),
            .ld_ualign_buf_cmnc_set(ld_ualign_buf_cmnc_set),
            .ld_ualign_buf_clr(ld_ualign_buf_clr),
            .ld_ualign_buf_free_init(ld_ualign_buf_free_init),
            .hr_qout_occupied(hr_ent_occupied[i]),
            .hr_qout_req_valid(hr_ent_req_valid[i]),
            .hr_qout_done(hr_ent_done[i]),
            .hr_qout_pa_cl_base(hr_ent_pa_cl_base[CL_BASE_WIDTH * i +:CL_BASE_WIDTH]),
            .hr_qout_pa_base(hr_ent_pa_base[HR_BASE_WIDTH * i +:HR_BASE_WIDTH]),
            .hr_qout_ctrl(hr_ent_ctrl[34 * i +:34]),
            .hr_qout_buf_ptr(hr_ent_buf_ptr[BUF_DEPTH * i +:BUF_DEPTH]),
            .hr_qout_seg_buf_ptr(hr_ent_seg_buf_ptr[BUF_DEPTH * i +:BUF_DEPTH]),
            .hr_qout_buf_ptr_tl(hr_ent_buf_ptr_tl[BUF_DEPTH * i +:BUF_DEPTH]),
            .hr_qout_align_value(hr_ent_align_value[HR_OFFSET_WIDTH * i +:HR_OFFSET_WIDTH]),
            .hr_qout_umask_cnt_offset(hr_ent_umask_cnt_offset[HR_OFFSET_WIDTH * i +:HR_OFFSET_WIDTH]),
            .hr_qout_align_onehot_sel(hr_ent_align_onehot_sel[2 * i +:2]),
            .hr_qout_beat_mask_lsb(hr_ent_beat_mask_lsb[i]),
            .hr_qout_beat_mask(hr_ent_beat_mask[4 * i +:4]),
            .hr_qout_dlen_beat(hr_ent_dlen_beat[i]),
            .hr_qout_eseg_hp(hr_ent_eseg_hp[i]),
            .hr_qout_ustride_mutation(hr_ent_ustride_mutation[i]),
            .hr_qout_ucross(hr_ent_ucross[i]),
            .hr_qout_uextra(hr_ent_uextra[i]),
            .hr_qout_ld_ucross_dlen(hr_ent_ld_ucross_dlen[i]),
            .hr_qout_ld_ucross_mask_cnt(hr_ent_ld_ucross_mask_cnt[HR_BYTE_WIDTH * i +:HR_BYTE_WIDTH]),
            .hr_qout_vd_mask(hr_ent_vd_mask[HR_MASK_WIDTH * i +:HR_MASK_WIDTH]),
            .hr_qout_vd_bwe_offset(hr_ent_vd_bwe_offset[ELE_DLEN_WIDTH * i +:ELE_DLEN_WIDTH]),
            .hr_qout_element_num_dlen(hr_ent_element_num_dlen[ELE_DLEN_WIDTH * i +:ELE_DLEN_WIDTH]),
            .hr_qout_element_sel(hr_ent_element_sel[i]),
            .hr_qout_first(hr_ent_first[i]),
            .hr_qout_last(hr_ent_last[i]),
            .hr_qout_total_beat_cnt(hr_ent_total_beat_cnt[BEAT_CNT_WIDTH * i +:BEAT_CNT_WIDTH]),
            .hr_qout_beat_cnt(hr_ent_beat_cnt[BEAT_CNT_WIDTH * i +:BEAT_CNT_WIDTH]),
            .hr_qout_vd_beats(hr_ent_vd_beats[VRF_LW * i +:VRF_LW]),
            .hr_qout_umask_cnt(hr_ent_umask_cnt[HR_BYTE_WIDTH * i +:HR_BYTE_WIDTH]),
            .hr_qout_check_hazard_en(hr_ent_check_hazard_en[i]),
            .hr_qout_ustride_una_hvm_en(hr_ent_ustride_una_hvm_en[i]),
            .hr_qout_ustride_una_cmnc_en(hr_ent_ustride_una_cmnc_en[i]),
            .hr_qout_d_last(hr_ent_d_last[i]),
            .hr_qout_load_pending(hr_ent_load_pending[i]),
            .hr_qout_store_pending(hr_ent_store_pending[i]),
            .hr_qout_store_pending_hvm(hr_ent_store_pending_hvm[i]),
            .hr_qout_store_pending_nhvm(hr_ent_store_pending_nhvm[i]),
            .hr_qout_cmd_valid(hr_ent_cmd_valid[i]),
            .hr_qout_block_cmd_hvm(hr_ent_block_cmd_hvm[i]),
            .hr_qout_block_cmd_nhvm(hr_ent_block_cmd_nhvm[i]),
            .hr_qout_busy(hr_ent_busy[i]),
            .hr_qout_inflight_ld(hr_ent_inflight_ld[i]),
            .hr_qout_bypass_cond(hr_ent_bypass_cond[i]),
            .hr_qout_seg_num_dlen_hit(hr_ent_seg_num_dlen_hit[i]),
            .hr_qout_skip(hr_ent_skip[i])
        );
    end
endgenerate
genvar m;
generate
    for (m = 0; m < BUF_DEPTH; m = m + 1) begin:gen_vls_buf_info_ent
        kv_vls_buf_info_ent #(
            .DLEN_BYTE_WIDTH(DLEN_BYTE_WIDTH),
            .BUF_INFO_DW(BUF_INFO_DW)
        ) u_vls_buf_info_ent (
            .vpu_vlsu_clk(vpu_vlsu_clk),
            .vpu_reset_n(vpu_reset_n),
            .buf_return_last(vlsbuf_ent_return_last[m]),
            .buf_init_wvalid(buf_info_init_wsel[m]),
            .buf_init_value(buf_info_init_value[m * BUF_INFO_DW +:BUF_INFO_DW]),
            .buf_info_clr(buf_info_clr_sel[m]),
            .buf_cnt_req_update(buf_info_req_rsel[m]),
            .buf_cnt_resp_update(buf_info_resp_wsel[m]),
            .buf_cnt_resp_ualign_update(buf_info_resp_ualign_wsel[m]),
            .buf_req_dlen_last(buf_info_ent_req_dlen_last[m]),
            .buf_resp_dlen_last(buf_info_ent_resp_dlen_last[m]),
            .buf_unbypass_dlen_last(buf_info_ent_unbypass_dlen_last[m]),
            .buf_ubypass_dlen_last(buf_info_ent_ubypass_dlen_last[m])
        );
    end
    assign hr_req_dlen_last_u = |(hr_req_buf_ptr & buf_info_ent_req_dlen_last);
    assign hr_resp_dlen_last_u = |(hr_resp_buf_ptr & buf_info_ent_ubypass_dlen_last);
    assign hr_resp_dlen_last_e = |(hr_resp_buf_ptr & buf_info_ent_resp_dlen_last);
    assign hr_resp_dlen_last = (hr_resp_ustride_nseg & hr_resp_dlen_last_u) | (~hr_resp_ustride_nseg & hr_resp_dlen_last_e);
    assign hr_resp_ualign_dlen_last = |(ld_ualign_rbuf_ptr & buf_info_ent_ubypass_dlen_last);
    assign hr_resp_simu_dlen_last = (|(ld_ualign_rbuf_ptr & buf_info_ent_unbypass_dlen_last)) & (hr_resp_buf_ptr == ld_ualign_rbuf_ptr);
    assign hr_vd_ustride_dlen_last = |(hr_vd_buf_ptr & buf_info_ent_ubypass_dlen_last);
endgenerate
kv_pma2axcache u_axcache(
    .c2nc(hr_enq_c2nc),
    .pma_mtype(hr_enq_mtype),
    .arcache(hr_enq_arcache),
    .awcache(hr_enq_awcache)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_valid (
    .out(hr_req_valid),
    .sel(hr_req_ptr),
    .in(hr_ent_req_valid)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_first (
    .out(hr_req_first),
    .sel(hr_req_ptr),
    .in(hr_ent_first)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_last (
    .out(hr_req_last),
    .sel(hr_req_ptr),
    .in(hr_ent_last)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(ELE_DLEN_WIDTH)
) u_hr_req_element_num_dlen (
    .out(hr_req_element_num_dlen),
    .sel(hr_req_ptr),
    .in(hr_ent_element_num_dlen)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_element_sel (
    .out(hr_req_element_sel),
    .sel(hr_req_ptr),
    .in(hr_ent_element_sel)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(HR_OFFSET_WIDTH)
) u_hr_req_align_value (
    .out(hr_req_align_value),
    .sel(hr_req_ptr),
    .in(hr_ent_align_value)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(HR_OFFSET_WIDTH)
) u_hr_req_umask_cnt_offset (
    .out(hr_req_umask_cnt_offset),
    .sel(hr_req_ptr),
    .in(hr_ent_umask_cnt_offset)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(2)
) u_hr_req_align_onehot_sel (
    .out(hr_req_align_onehot_sel),
    .sel(hr_req_ptr),
    .in(hr_ent_align_onehot_sel)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_beat_mask_lsb (
    .out(hr_req_beat_mask_lsb),
    .sel(hr_req_ptr),
    .in(hr_ent_beat_mask_lsb)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(4)
) u_hr_req_beat_mask (
    .out(hr_req_beat_mask),
    .sel(hr_req_ptr),
    .in(hr_ent_beat_mask)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_dlen_beat (
    .out(hr_req_dlen_beat),
    .sel(hr_req_ptr),
    .in(hr_ent_dlen_beat)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_ucross_biu (
    .out(hr_req_ucross_biu),
    .sel(hr_req_ptr),
    .in(hr_ent_ucross)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_uextra_biu (
    .out(hr_req_uextra_biu),
    .sel(hr_req_ptr),
    .in(hr_ent_uextra)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(BEAT_CNT_WIDTH)
) u_hr_req_total_beat_cnt (
    .out(hr_req_total_beat_cnt),
    .sel(hr_req_ptr),
    .in(hr_ent_total_beat_cnt)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(VRF_LW)
) u_hr_req_vd_beats (
    .out(hr_req_vd_beats),
    .sel(hr_req_ptr),
    .in(hr_ent_vd_beats)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(BEAT_CNT_WIDTH)
) u_hr_req_beat_cnt (
    .out(hr_req_beat_cnt),
    .sel(hr_req_ptr),
    .in(hr_ent_beat_cnt)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(HR_BASE_WIDTH)
) u_hr_req_pa_base (
    .out(hr_req_pa_base),
    .sel(hr_req_ptr),
    .in(hr_ent_pa_base)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(34)
) u_hr_req_ctrl (
    .out(hr_req_ctrl),
    .sel(hr_req_ptr),
    .in(hr_ent_ctrl)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(HR_BYTE_WIDTH)
) u_hr_req_umask_cnt (
    .out(hr_req_umask_cnt),
    .sel(hr_req_ptr),
    .in(hr_ent_umask_cnt)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(BUF_DEPTH)
) u_hr_req_seg_buf_ptr (
    .out(hr_req_seg_buf_ptr),
    .sel(hr_req_ptr),
    .in(hr_ent_seg_buf_ptr)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(BUF_DEPTH)
) u_hr_req_buf_ptr_tl (
    .out(hr_req_buf_ptr_tl),
    .sel(hr_req_ptr),
    .in(hr_ent_buf_ptr_tl)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_skip (
    .out(hr_req_skip),
    .sel(hr_req_ptr),
    .in(hr_ent_skip)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_eseg_hp (
    .out(hr_req_eseg_hp),
    .sel(hr_req_ptr),
    .in(hr_ent_eseg_hp)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_ustride_mutation (
    .out(hr_req_ustride_mutation),
    .sel(hr_req_ptr),
    .in(hr_ent_ustride_mutation)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_seg_num_dlen_hit (
    .out(hr_req_seg_num_dlen_hit),
    .sel(hr_req_ptr),
    .in(hr_ent_seg_num_dlen_hit)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(BUF_DEPTH)
) u_hr_req_buf_ptr_pre_nx (
    .out(hr_req_buf_ptr_pre_nx),
    .sel(hr_req_ptr_nx),
    .in(hr_ent_buf_ptr)
);
kv_mux_onehot #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_req_cmd_valid_nx (
    .out(hr_req_cmd_valid_nx),
    .sel(hr_req_ptr_nx),
    .in(hr_ent_cmd_valid)
);
kv_vls_gen_bwe #(
    .OFFSET_WIDTH(HR_OFFSET_WIDTH),
    .MW_CNT(HR_BYTE_WIDTH),
    .MW_IN(HR_MASK_WIDTH),
    .MW_OUT(HR_MASK_WIDTH),
    .MASK_READY(0)
) u_hr_req_mask (
    .offset(hr_req_mask_offset),
    .mask_cnt(hr_req_mask_cnt),
    .mask_in({HR_MASK_WIDTH{1'b0}}),
    .bwe(hr_req_mask)
);
kv_vls_align_wbuf #(
    .DW(HR_DATA_WIDTH * 2),
    .MW(HR_MASK_WIDTH * 2),
    .V0T_DW(HR_MASK_WIDTH * 2),
    .V0T_MW((HR_MASK_WIDTH * 2) / 8),
    .HR_DATA_WIDTH(HR_DATA_WIDTH),
    .HR_MASK_WIDTH(HR_MASK_WIDTH),
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BIU_MASK_WIDTH(BIU_MASK_WIDTH),
    .DLEN(DLEN)
) u_vls_st_ualign_buf (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .wvalid(st_ualign_wvalid),
    .wready(st_ualign_wready),
    .wfirst(st_ualign_wfirst),
    .wlast(st_ualign_wlast),
    .wfirst_cnt(st_ualign_wfirst_cnt),
    .wlast_cnt(st_ualign_wlast_cnt),
    .cross_biu(st_ualign_cross_biu),
    .extra_biu(st_ualign_extra_biu),
    .onehot_sel_w(st_ualign_onehot_sel),
    .wdata(st_ualign_wdata),
    .extra_wdata(st_ualign_wdata_extra),
    .bwe(st_ualign_bwe),
    .v0t_wdata(st_ualign_v0t_wdata),
    .v0t_extra_wdata(st_ualign_v0t_extra_wdata),
    .hvm(st_ualign_hvm),
    .onehot_sel_r(hr_req_align_onehot_sel),
    .rvalid(hr_req_ualign_rvalid),
    .rready(hr_req_ualign_rready),
    .rfirst(hr_req_ualign_rfirst),
    .rlast(hr_req_ualign_rlast),
    .rdata_xhvm(hr_req_ualign_data_xhvm),
    .rdata_hvm(hr_req_ualign_data_hvm),
    .rmask(nds_unused_hr_req_ualign_mask),
    .mask_clr(hr_req_ualign_mask_clr)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(ELE_DLEN_WIDTH)
) u_hr_resp_element_num_dlen (
    .out(hr_resp_element_num_dlen),
    .sel(hr_resp_num),
    .in(hr_ent_element_num_dlen)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(HR_OFFSET_WIDTH)
) u_hr_resp_align_value (
    .out(hr_resp_align_value),
    .sel(hr_resp_num),
    .in(hr_ent_align_value)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_resp_beat_mask_lsb (
    .out(hr_resp_beat_mask_lsb),
    .sel(hr_resp_num),
    .in(hr_ent_beat_mask_lsb)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_resp_dlen_beat (
    .out(hr_resp_dlen_beat),
    .sel(hr_resp_num),
    .in(hr_ent_dlen_beat)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(1)
) u_hr_resp_ld_ucross_dlen (
    .out(hr_resp_ld_ucross_dlen),
    .sel(hr_resp_num),
    .in(hr_ent_ld_ucross_dlen)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(HR_BYTE_WIDTH)
) u_hr_resp_ld_ucross_mask_cnt (
    .out(hr_resp_ld_ucross_mask_cnt),
    .sel(hr_resp_num),
    .in(hr_ent_ld_ucross_mask_cnt)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(34)
) u_hr_resp_ctrl (
    .out(hr_resp_ctrl),
    .sel(hr_resp_num),
    .in(hr_ent_ctrl)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(HR_BYTE_WIDTH)
) u_hr_resp_umask_cnt (
    .out(hr_resp_umask_cnt),
    .sel(hr_resp_num),
    .in(hr_ent_umask_cnt)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(BEAT_CNT_WIDTH)
) u_hr_resp_beat_cnt (
    .out(hr_resp_beat_cnt),
    .sel(hr_resp_num),
    .in(hr_ent_beat_cnt)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(BUF_DEPTH)
) u_hr_resp_buf_ptr (
    .out(hr_resp_buf_ptr),
    .sel(hr_resp_num),
    .in(hr_ent_buf_ptr)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(VRF_LW)
) u_hr_resp_vd_beats (
    .out(hr_resp_vd_beats),
    .sel(hr_resp_num),
    .in(hr_ent_vd_beats)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(HR_MASK_WIDTH)
) u_hr_resp_vd_mask (
    .out(hr_resp_vd_mask),
    .sel(hr_resp_num),
    .in(hr_ent_vd_mask)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(ELE_DLEN_WIDTH)
) u_hr_resp_vd_bwe_offset (
    .out(hr_resp_vd_bwe_offset),
    .sel(hr_resp_num),
    .in(hr_ent_vd_bwe_offset)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(1)
) u_vlsu_vd_bypass_cond (
    .out(vlsu_vd_bypass_cond),
    .sel(hr_resp_num),
    .in(hr_ent_bypass_cond)
);
kv_onehot2bin #(
    .N(BUF_DEPTH)
) u_hr_resp_buf_num (
    .out(hr_resp_buf_num),
    .in(hr_resp_buf_ptr)
);
kv_vls_gen_bwe #(
    .OFFSET_WIDTH(ELE_DLEN_WIDTH),
    .MW_CNT(HR_BYTE_WIDTH),
    .MW_IN(HR_MASK_WIDTH),
    .MW_OUT(DMLEN),
    .MASK_READY(0)
) u_vls_ld_ualign_buf_bwe (
    .offset({ELE_DLEN_WIDTH{1'b0}}),
    .mask_cnt(ld_ualign_rmask_cnt),
    .mask_in({HR_MASK_WIDTH{1'b0}}),
    .bwe(resp_vd_ualign_bwe)
);
kv_vls_gen_bwe #(
    .OFFSET_WIDTH(ELE_DLEN_WIDTH),
    .MW_CNT(HR_BYTE_WIDTH),
    .MW_IN(HR_MASK_WIDTH),
    .MW_OUT(DMLEN),
    .MASK_READY(1)
) u_vls_vd_buf_bwe (
    .offset(hr_resp_vd_bwe_offset),
    .mask_cnt({HR_BYTE_WIDTH{1'b0}}),
    .mask_in(hr_resp_vd_mask),
    .bwe(hr_resp_vd_bwe)
);
assign vlsbuf_vd_ualign_wsel = {BUF_DEPTH{ld_ualign_rgrant}} & ld_ualign_rbuf_ptr;
assign vlsbuf_vd_ualign_write_dlen_last = hr_resp_ualign_dlen_last | (hr_resp_vd_wvalid & hr_resp_simu_dlen_last);
assign vlsbuf_vd_ualign_bwe = resp_vd_ualign_bwe;
assign vlsbuf_vd_ualign_wdata = ld_ualign_rdata;
assign ld_ualign_wvalid = hr_d_load_grant & hr_resp_beat_mask_lsb & ~hr_resp_align & hr_resp_ld_ucross_dlen;
assign ld_ualign_wgrant = ld_ualign_wvalid & ld_ualign_wready;
assign ld_ualign_wmask_cnt = hr_resp_ld_ucross_mask_cnt;
assign ld_ualign_wbuf_ptr = hr_resp_cross_revert ? {hr_resp_buf_ptr[0],hr_resp_buf_ptr[BUF_DEPTH - 1:1]} : {hr_resp_buf_ptr[BUF_DEPTH - 2:0],hr_resp_buf_ptr[BUF_DEPTH - 1]};
assign ld_ualign_whvm = hr_resp_ctrl[11];
assign ld_ualign_rgrant = ld_ualign_rvalid & ld_ualign_rready;
assign ld_ualign_rgrant_fail = ld_ualign_rvalid & ~ld_ualign_rready;
assign ld_ualign_rready = |(ld_ualign_rbuf_ptr & ~vlsbuf_ent_occupied);
assign ld_ualign_buf_clr = ld_ualign_rgrant & ~ld_ualign_wgrant;
assign ld_ualign_buf_hvm_set = ld_ualign_wgrant & ld_ualign_whvm;
assign ld_ualign_buf_cmnc_set = ld_ualign_wgrant & ~ld_ualign_whvm;
assign hr_dummy_d_valid_nx = hr_dummy_d_valid_set;
assign hr_dummy_d_hvm_nx = hr_dummy_d_valid_clr ? 1'b0 : hr_a_hvm;
assign hr_dummy_d_valid_stall = hr_req_ustride & ((|hr_ent_inflight_ld) | ld_ualign_rgrant_fail);
assign hr_dummy_d_valid_hvm_set = hr_dummy_d_valid_set & hr_a_hvm;
assign hr_dummy_d_valid_set = (hr_req_skip & hr_req_load & ~hr_req_wait_clr) & ~hr_dummy_d_valid_stall;
assign hr_dummy_d_valid_clr = (hr_req_skip & hr_req_load & hr_req_wait_clr);
assign hr_dummy_d_valid_en = hr_dummy_d_valid_set | hr_dummy_d_valid_clr;
assign hr_dummy_d_ready = ((hr_dummy_d_hvm & hr_vm_d_ready) | (~hr_dummy_d_hvm));
assign hr_dummy_d_grant = hr_dummy_d_valid & hr_dummy_d_ready;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_dummy_d_valid <= 1'b0;
        hr_dummy_d_hvm <= 1'b0;
    end
    else if (hr_dummy_d_valid_en) begin
        hr_dummy_d_valid <= hr_dummy_d_valid_nx;
        hr_dummy_d_hvm <= hr_dummy_d_hvm_nx;
    end
end

assign hr_resp_num = hr_dummy_d_valid ? hr_dummy_resp_num : hr_d_source[HR_DEPTH_LOG2 - 1:0];
assign hr_dummy_resp_num_en = hr_dummy_d_valid_set;
assign hr_dummy_resp_num_nx = hr_req_num;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_dummy_resp_num <= {HR_DEPTH_LOG2{1'b0}};
    end
    else if (hr_dummy_resp_num_en) begin
        hr_dummy_resp_num <= hr_dummy_resp_num_nx;
    end
end

assign ld_ualign_wdata = hr_resp_align_data_out[DLEN - 1:0];
assign vlsbuf_vd_bwe = hr_resp_vd_bwe;
assign vlsbuf_vd_wdata = hr_resp_ewiden ? hr_resp_widen_data_out : hr_d_align_data;
assign vlsbuf_vd_wsel = hr_resp_vd_wsel;
assign vlsbuf_vd_write_dlen_last = hr_resp_dlen_last;
assign hr_resp_sext = hr_resp_ctrl[21];
assign hr_resp_ewiden = ~hr_resp_ustride & hr_resp_widen;
assign hr_resp_widen = hr_resp_ctrl[33];
assign hr_resp_widen_data_in = {DLEN / 8{hr_resp_align_data_out[7:0]}};
generate
    for (i = 0; i < DLEN / 8; i = i + 1) begin:gen_hr_resp_widen_data
        assign vlsbuf_vd_widen_data0[i * 8 +:8] = {{4{vlsbuf_vd_rdata[(i + 1) * 4 - 1] & hr_vd_sext}},vlsbuf_vd_rdata[i * 4 +:4]};
        assign vlsbuf_vd_widen_data1[i * 8 +:8] = {{4{vlsbuf_vd_rdata[((i + 1) * 4) + (DLEN / 2) - 1] & hr_vd_sext}},vlsbuf_vd_rdata[i * 4 + (DLEN / 2) +:4]};
        assign hr_resp_widen_data_out[i * 8 +:8] = {{4{hr_resp_widen_data_in[(i + 1) * 4 - 1] & hr_resp_sext}},hr_resp_widen_data_in[i * 4 +:4]};
    end
endgenerate
kv_vls_align_rbuf #(
    .DW(DLEN),
    .MW(DMLEN),
    .MASK_CNT(HR_BYTE_WIDTH),
    .BUF_DEPTH(BUF_DEPTH)
) u_vls_ld_ualign_buf (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .wvalid(ld_ualign_wvalid),
    .wready(ld_ualign_wready),
    .wdata(ld_ualign_wdata),
    .wmask_cnt(ld_ualign_wmask_cnt),
    .wbuf_ptr(ld_ualign_wbuf_ptr),
    .whvm(ld_ualign_whvm),
    .rvalid(ld_ualign_rvalid),
    .rready(ld_ualign_rready),
    .rdata(ld_ualign_rdata),
    .rmask_cnt(ld_ualign_rmask_cnt),
    .rbuf_ptr(ld_ualign_rbuf_ptr),
    .rhvm(ld_ualign_rhvm)
);
assign vlshr_load_pending = |hr_ent_load_pending;
assign vlshr_store_pending = |hr_ent_store_pending;
assign vlshr_store_pending_hvm = |hr_ent_store_pending_hvm;
assign vlshr_store_pending_nhvm = |hr_ent_store_pending_nhvm;
assign vlshr_block_cmd_hvm = |hr_ent_block_cmd_hvm;
assign vlshr_block_cmd_nhvm = |hr_ent_block_cmd_nhvm;
assign vlsu_hr_events = {hr_ent_busy_zext,hr_ent_enq_alive_zext};
assign hr_enq_cmd_alive = uop_req_grant & ~uop_req_skip;
assign hr_ent_enq_alive = ({HR_DEPTH{hr_enq_cmd_alive}} & hr_enq_ptr);
assign hr_ent_enq_alive_d1_en = hr_ent_enq_alive_d1 != hr_ent_enq_alive;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_ent_enq_alive_d1 <= {HR_DEPTH{1'b0}};
    end
    else if (hr_ent_enq_alive_d1_en) begin
        hr_ent_enq_alive_d1 <= hr_ent_enq_alive;
    end
end

assign hr_full = &hr_ent_occupied;
assign hr_not_full = ~hr_full;
assign uop_req_ready = hr_not_full & ((uop_req_first & uop_req_ctrl[4] & ififo_wready) | ~uop_req_first | uop_req_ctrl[17]);
assign uop_req_grant = uop_req_valid & uop_req_ready;
assign hr_enq_ptr_en = uop_req_grant;
assign hr_req_ptr_en = (hr_a_grant & ~hr_req_skip & (hr_req_load | (hr_req_store & hr_req_beat_last))) | (hr_a_grant & hr_req_skip & hr_req_beat_last) | hr_dummy_d_valid_clr;
assign hr_deq_ptr_en = |(hr_deq_ptr & hr_ent_done);
assign hr_enq_sel = {HR_DEPTH{uop_req_grant}} & hr_enq_ptr;
assign hr_a_grant_sel = {HR_DEPTH{hr_a_grant}} & hr_req_ptr;
assign hr_d_grant_sel = {HR_DEPTH{hr_d_grant}} & hr_resp_ptr;
assign hr_dummy_d_grant_sel = {HR_DEPTH{hr_dummy_d_grant}} & hr_req_ptr;
assign hr_ld_ualign_sel = {HR_DEPTH{ld_ualign_rgrant}} & hr_resp_ptr;
assign hr_ent_wait_reg_clr = (hr_d_grant_sel | hr_dummy_d_grant_sel) & hr_ent_d_last;
assign hr_req_wait_clr = |(hr_req_ptr & hr_ent_wait_reg_clr);
assign hr_enq_ctrl[13] = uop_req_ctrl[4];
assign hr_enq_ctrl[17] = uop_req_ctrl[12];
assign hr_enq_ctrl[18] = uop_req_ctrl[13];
assign hr_enq_ctrl[27] = uop_req_ctrl[17];
assign hr_enq_ctrl[14 +:3] = uop_req_ctrl[9 +:3];
assign hr_enq_ctrl[30 +:3] = uop_req_ctrl[20 +:3];
assign hr_enq_ctrl[29] = uop_req_ctrl[19];
assign hr_enq_ctrl[28] = uop_req_ctrl[18];
assign hr_enq_ctrl[12] = uop_req_ctrl[3];
assign hr_enq_ctrl[20] = uop_req_ctrl[14];
assign hr_enq_ctrl[33] = uop_req_ctrl[23];
assign hr_enq_ctrl[21] = uop_req_ctrl[15];
assign hr_enq_ctrl[22] = uop_req_ctrl[16];
assign hr_enq_ctrl[11] = uop_req_ctrl[2];
assign hr_enq_ctrl[1 +:4] = ({4{hr_enq_store}} & hr_enq_awcache) | ({4{hr_enq_load}} & hr_enq_arcache);
assign hr_enq_ctrl[8] = uop_req_ele_dlen_last;
assign hr_enq_ctrl[9] = uop_req_ele_seg_first;
assign hr_enq_ctrl[10] = uop_req_ele_seg_last;
assign hr_enq_ctrl[26] = uop_req_skip;
assign hr_enq_ctrl[23 +:3] = uop_req_size;
assign hr_enq_ctrl[0] = uop_req_align;
assign hr_enq_ctrl[6] = uop_req_bypass;
assign hr_enq_ctrl[19] = uop_req_putfull;
assign hr_enq_ctrl[5] = uop_req_buf_opt;
assign hr_enq_ctrl[7] = uop_req_buf_cross_revert;
assign hr_enq_load = uop_req_ctrl[4];
assign hr_enq_store = uop_req_ctrl[17];
assign hr_enq_mtype = uop_req_ctrl[5 +:4];
assign hr_enq_c2nc = uop_req_ctrl[0];
assign hr_enq_ucross = uop_req_ucross;
assign hr_enq_uextra = uop_req_uextra;
assign hr_enq_pa = uop_req_pa;
assign hr_enq_start_buf_ptr = uop_req_buf_ptr;
assign hr_enq_seg_buf_ptr = uop_req_seg_buf_ptr;
assign hr_enq_buf_ptr_tl = uop_req_buf_ptr_tl;
assign hr_enq_mask_cnt = uop_req_mask_cnt;
assign hr_enq_byte = uop_req_byte;
assign hr_enq_nf_cnt = uop_req_nf_cnt;
assign hr_enq_skip = uop_req_skip;
assign hr_enq_first = uop_req_first;
assign hr_enq_last = uop_req_last;
assign hr_enq_element_sel = uop_req_element_sel;
assign hr_enq_align_value = uop_req_align_value;
assign hr_enq_umask_cnt_offset = uop_req_umask_offset;
assign hr_enq_align_onehot_sel = uop_req_align_onehot_sel;
assign hr_enq_beat_mask = uop_req_beat_mask;
assign hr_enq_st_beat_mask = uop_req_st_beat_mask;
assign hr_enq_eseg_hp = uop_req_eseg_hp;
assign hr_enq_ustride_mutation = uop_req_ustride_mutation;
assign hr_enq_total_beat_cnt = uop_req_beat_cnt;
assign hr_enq_dlen_beat = uop_req_dlen_beat;
assign hr_enq_vd_beats = uop_req_vd_beats;
assign hr_enq_hvm = uop_req_ctrl[2];
assign hr_wait_reg_clr = hr_ent_wait_reg_clr;
genvar j;
generate
    for (j = 0; j < HR_DEPTH; j = j + 1) begin:gen_hr_wait_reg
        assign hr_ent_store_valid[j] = hr_ent_occupied[j] & hr_ent_ctrl[(j * 34) + 27];
        assign hr_ent_load_valid[j] = hr_ent_occupied[j] & hr_ent_ctrl[(j * 34) + 13];
        assign hr_wait_reg_raw[j] = hr_enq_load & hr_ent_store_valid[j];
        assign hr_wait_reg_waw[j] = hr_enq_store & hr_ent_store_valid[j];
        assign hr_wait_reg_war[j] = hr_enq_store & hr_ent_load_valid[j];
        assign hr_wait_reg_en[j] = hr_wait_reg_raw[j] | hr_wait_reg_waw[j] | hr_wait_reg_war[j];
        assign hr_wait_reg_set[j] = hr_ent_check_hazard_en[j] & hr_wait_reg_en[j] & ~hr_enq_skip & ~hr_enq_hvm & (hr_enq_pa[PALEN - 1:CL_OFFSET_WIDTH] == hr_ent_pa_cl_base[CL_BASE_WIDTH * j +:CL_BASE_WIDTH]);
    end
endgenerate
generate
    for (j = 0; j < HR_DEPTH; j = j + 1) begin:gen_hvm_wait_reg
        if (VLSU_SUPPORT_HVM == 1'b1) begin:gen_hvm_wait_reg_set
            assign hr_hvm_wait_reg_set0[j] = hr_enq_load & ~hr_enq_hvm & hr_enq_ctrl[29] & ~hr_enq_ctrl[0] & hr_ent_ustride_una_hvm_en[j];
            assign hr_hvm_wait_reg_set1[j] = hr_enq_load & hr_enq_hvm & hr_enq_ctrl[29] & ~hr_enq_ctrl[0] & hr_ent_ustride_una_cmnc_en[j];
            assign hr_hvm_wait_reg_set[j] = hr_hvm_wait_reg_set0[j] | hr_hvm_wait_reg_set1[j];
            assign nds_unused_hr_ent_ustride_una_hvm_en[j] = 1'b0;
            assign nds_unused_hr_hvm_wait_reg_set0[j] = 1'b0;
            assign nds_unused_hr_hvm_wait_reg_set1[j] = 1'b0;
            assign nds_unused_hr_ent_ustride_una_cmnc_en[j] = 1'b0;
        end
        else begin:gen_hvm_wait_reg_stub
            assign hr_hvm_wait_reg_set0[j] = 1'b0;
            assign hr_hvm_wait_reg_set1[j] = 1'b0;
            assign hr_hvm_wait_reg_set[j] = 1'b0;
            assign nds_unused_hr_ent_ustride_una_hvm_en[j] = hr_ent_ustride_una_hvm_en[j];
            assign nds_unused_hr_hvm_wait_reg_set0[j] = hr_hvm_wait_reg_set0[j];
            assign nds_unused_hr_hvm_wait_reg_set1[j] = hr_hvm_wait_reg_set1[j];
            assign nds_unused_hr_ent_ustride_una_cmnc_en[j] = hr_ent_ustride_una_cmnc_en[j];
        end
    end
endgenerate
generate
    if (VLSU_SUPPORT_HVM == 1'b1) begin:gen_ld_ualign_buf_free_init
        wire ld_ualign_buf_busy_init;
        wire ld_ualign_buf_hvm_use;
        wire ld_ualign_buf_cmnc_use;
        assign ld_ualign_buf_busy_init = hr_enq_load & hr_enq_ctrl[29] & ~hr_enq_ctrl[0] & (ld_ualign_buf_hvm_use | ld_ualign_buf_cmnc_use);
        assign ld_ualign_buf_cmnc_use = hr_enq_hvm & (ld_ualign_buf_cmnc_set | (ld_ualign_rgrant_fail & ~ld_ualign_rhvm));
        assign ld_ualign_buf_hvm_use = ~hr_enq_hvm & (ld_ualign_buf_hvm_set | (ld_ualign_rgrant_fail & ld_ualign_rhvm));
        assign ld_ualign_buf_free_init = ~ld_ualign_buf_busy_init;
    end
    else begin:gen_ld_ualign_buf_free_init_stub
        wire nds_unused_ld_ualign_rhvm = ld_ualign_rhvm;
        assign ld_ualign_buf_free_init = 1'b1;
    end
endgenerate
assign vlsu_vd_wvalid = (vlsbuf_vd_rgrant & ~hr_vd_useg) | vlsu_vd_bypass_valid | ustride_seg_data_rgrant | hr_vd_wr_dummy_valid;
assign vlsu_vd_wgrant = vlsu_vd_wvalid & vlsu_vd_wready;
generate
    for (i = 0; i < DLEN / 64; i = i + 1) begin:gen_vlsu_vd_wdata
        if (VLSU_BYPASS_EN == 1) begin:gen_vlsu_bypass_vd_wdata
            assign vlsu_vd_wdata[i * 64 +:64] = hr_vd_useg_dup[i] ? ustride_seg_rdata[i * 64 +:64] : vlsbuf_vd_rgrant_dup[i] ? hr_vd_uwiden_dup[i] ? vlsbuf_vd_widen_rdata[i * 64 +:64] : vlsbuf_vd_rdata[i * 64 +:64] : vlsu_vd_bypass_data[i * 64 +:64];
        end
        else begin:gen_vlsu_bypass_vd_wdata_stub
            assign vlsu_vd_wdata[i * 64 +:64] = hr_vd_useg_dup[i] ? ustride_seg_rdata[i * 64 +:64] : hr_vd_uwiden_dup[i] ? vlsbuf_vd_widen_rdata[i * 64 +:64] : vlsbuf_vd_rdata[i * 64 +:64];
        end
    end
    for (i = 0; i < DMLEN / 8; i = i + 1) begin:gen_vlsu_vd_wmask
        assign vlsu_vd_wmask[i * 8 +:8] = {8{(~hr_vd_wr_dummy_valid_dup[i])}} & vlsbuf_vd_byte_mask[(i * 8) +:8];
    end
endgenerate
assign hr_vd_bypass_cond = hr_vd_ustride_dlen_last & vlsbuf_vd_mask_ready & (VLSU_BYPASS_EN == 1);
assign vlsu_vd_bypass_valid = hr_d_load_grant & vlsu_vd_bypass_cond;
assign vlsu_vd_bypass_fail = vlsu_vd_bypass_valid & ~vlsu_vd_wready;
assign hr_resp_load2buf_valid = hr_d_load_grant & hr_resp_ustride & ~vlsu_vd_bypass_cond;
assign hr_resp_vd_wvalid = (hr_resp_beat_mask_lsb & ((vlsu_vd_bypass_fail | hr_resp_load2buf_valid) | (hr_resp_element_nseg & hr_d_load_grant)));
assign hr_resp_beat_first = hr_resp_beat_cnt == {BEAT_CNT_WIDTH{1'b0}};
assign vlsbuf_vd_element_cond = (hr_a_grant & hr_req_beat_first) | (hr_dummy_d_grant & hr_resp_beat_first);
assign vlsbuf_vd_element_wvalid = vlsbuf_vd_element_cond & hr_req_element & hr_req_load;
assign vlsbuf_vd_element_bwe_wsel = ({BUF_DEPTH{vlsbuf_vd_element_wvalid & ~hr_req_seg}} & hr_req_buf_ptr) | ({BUF_DEPTH{vlsbuf_vd_element_wvalid & hr_req_seg}} & hr_req_seg_buf_ptr);
assign hr_enq_element_num_dlen = uop_req_element_num_dlen;
assign hr_a_data = (hr_req_align | hr_req_element_nseg | hr_req_eseg_hp) ? hr_req_ealign_data[BIU_DATA_WIDTH - 1:0] : hr_req_ualign_data_xhvm[BIU_DATA_WIDTH - 1:0];
assign hr_req_align_data_in = ({DLEN{hr_req_non_seg}} & vlsbuf_vs3_rdata) | ({DLEN{hr_req_seg}} & segbuf_packed_rdata);
generate
    if (DLEN == BIU_DATA_WIDTH) begin:gen_dlen_biu_1_1
        wire nds_unused_hr_resp_dlen_beat = hr_resp_dlen_beat;
        wire nds_unused_hr_req_dlen_beat = hr_req_dlen_beat;
        wire nds_unused_hr_req_element_sel = hr_req_element_sel;
        wire nds_unused_st_ualign_hvm_bwe = |st_ualign_hvm_bwe;
        assign vlsu_vd_bypass_data = vlsu_vm_d_ready ? vlsu_vm_d_data : hr_d_data;
        assign hr_req_element_num_biu = hr_req_element_num_dlen;
        assign vlsbuf_vd_element_bwe = hr_req_mask;
        assign hr_resp_align_data_in = vlsu_vm_d_ready ? {2{vlsu_vm_d_data}} : {2{hr_d_data}};
        assign hr_req_align_data_wrap = hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0];
        assign hr_req_align_data_init = {2{hr_req_align_data_in}};
        assign st_ualign_wdata = hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0] | {{BIU_DATA_WIDTH{1'b0}},hr_req_align_data_out[BIU_DATA_WIDTH * 2 +:BIU_DATA_WIDTH]};
        assign st_ualign_wlast_cnt = (hr_vs3_rlast & hr_vs3_cross_biu_sel) ? 2'd1 : 2'd2;
        assign st_ualign_wdata_extra = {BIU_DATA_WIDTH{1'b0}};
        assign st_ualign_bwe_sel = ({BIU_MASK_WIDTH * 2{~hr_vs3_rcnt[0]}} & {{BIU_MASK_WIDTH{1'b0}},{BIU_MASK_WIDTH{1'b1}}}) | ({BIU_MASK_WIDTH * 2{hr_vs3_rcnt[0]}} & {{BIU_MASK_WIDTH{1'b1}},{BIU_MASK_WIDTH{1'b0}}});
        assign st_ualign_bwe = st_ualign_biu_bwe;
        assign st_ualign_v0t_init = {2{vlsbuf_vs3_byte_mask}};
        assign st_ualign_v0t_extra_wdata = {BIU_MASK_WIDTH{1'b0}};
        assign segbuf_upacked_rlast = 1'b1;
        assign hr_req_ualign_mask_clr = hr_a_mask;
    end
    else if (DLEN / BIU_DATA_WIDTH == 2) begin:gen_dlen_biu_2_1
        if (VLSU_SUPPORT_HVM == 1'b1) begin:gen_hr_hvm
            wire [BIU_DATA_WIDTH - 1:0] vlsu_vd_bypass_data_lo;
            wire [BIU_DATA_WIDTH - 1:0] vlsu_vd_bypass_data_hi;
            wire [1:0] hr_resp_beat_sel;
            assign hr_req_element_num_biu = hr_a_hvm ? hr_req_element_num_dlen : ({HR_OFFSET_WIDTH{hr_req_eew8}} & {1'b0,hr_req_element_num_dlen[SEW8_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew16}} & {2'b0,hr_req_element_num_dlen[SEW16_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew32}} & {3'b0,hr_req_element_num_dlen[SEW32_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew64}} & {4'b0,hr_req_element_num_dlen[SEW64_DLEN_WIDTH - 2:0]});
            assign hr_resp_align_data_in = vlsu_vm_d_ready ? {2{vlsu_vm_d_data}} : {4{hr_d_data}};
            assign hr_req_align_data_wrap = hr_a_hvm ? hr_req_align_data_out[HVM_DATA_WIDTH * 2 - 1:0] : hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0] | {{BIU_DATA_WIDTH{1'b0}},hr_req_align_data_out[BIU_DATA_WIDTH * 2 +:BIU_DATA_WIDTH]};
            assign vlsbuf_vd_element_bwe = hr_a_hvm ? hr_req_mask : {({BIU_MASK_WIDTH{hr_req_element_sel}} & hr_req_mask[BIU_MASK_WIDTH - 1:0]),({BIU_MASK_WIDTH{~hr_req_element_sel}} & hr_req_mask[BIU_MASK_WIDTH - 1:0])};
            assign hr_resp_beat_sel = {hr_resp_dlen_beat,~hr_resp_dlen_beat};
            assign vlsu_vd_bypass_data_lo = ({BIU_DATA_WIDTH{hr_resp_beat_sel[0]}} & hr_d_data) | ({BIU_DATA_WIDTH{hr_resp_beat_sel[1]}} & vlsbuf_vd_rdata[BIU_DATA_WIDTH * 0 +:BIU_DATA_WIDTH]);
            assign vlsu_vd_bypass_data_hi = ({BIU_DATA_WIDTH{hr_resp_beat_sel[0]}} & vlsbuf_vd_rdata[BIU_DATA_WIDTH * 1 +:BIU_DATA_WIDTH]) | ({BIU_DATA_WIDTH{hr_resp_beat_sel[1]}} & hr_d_data);
            assign vlsu_vd_bypass_data = vlsu_vm_d_ready ? vlsu_vm_d_data : {vlsu_vd_bypass_data_hi,vlsu_vd_bypass_data_lo};
            assign hr_req_align_data_init = hr_a_hvm ? {2{hr_req_align_data_in}} : {{DLEN{1'b0}},hr_req_align_data_in};
            assign st_ualign_wdata = hr_a_hvm ? hr_req_align_data_out[HVM_DATA_WIDTH * 2 - 1:0] | {{HVM_DATA_WIDTH{1'b0}},hr_req_align_data_out[HVM_DATA_WIDTH * 2 +:HVM_DATA_WIDTH]} : {{DLEN * 2 - BIU_DATA_WIDTH * 2{1'b0}},hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0]};
            assign st_ualign_wlast_cnt = hr_a_hvm ? (hr_vs3_rlast & hr_vs3_cross_biu_sel) ? 2'd1 : 2'd2 : 2'd1;
            assign st_ualign_wdata_extra = hr_a_hvm ? {BIU_DATA_WIDTH{1'b0}} : hr_req_align_data_out[BIU_DATA_WIDTH * 2 +:BIU_DATA_WIDTH];
            assign st_ualign_bwe = hr_a_hvm ? st_ualign_hvm_bwe : {{HR_MASK_WIDTH * 2 - BIU_MASK_WIDTH * 2{1'b0}},st_ualign_biu_bwe};
            assign st_ualign_bwe_sel = hr_a_hvm ? ({HVM_MASK_WIDTH * 2{~hr_vs3_rcnt[0]}} & {{HVM_MASK_WIDTH{1'b0}},{HR_MASK_WIDTH{1'b1}}}) | ({HVM_MASK_WIDTH * 2{hr_vs3_rcnt[0]}} & {{HVM_MASK_WIDTH{1'b1}},{HR_MASK_WIDTH{1'b0}}}) : {HR_MASK_WIDTH * 2{1'b1}};
            assign st_ualign_v0t_init = hr_a_hvm ? {2{vlsbuf_vs3_byte_mask}} : {{DMLEN{1'b0}},vlsbuf_vs3_byte_mask};
            assign st_ualign_v0t_extra_wdata = hr_a_hvm ? {BIU_MASK_WIDTH{1'b0}} : st_ualign_v0t_shift[BIU_MASK_WIDTH * 2 +:BIU_MASK_WIDTH];
            assign segbuf_upacked_rlast = hr_a_hvm ? 1'b1 : (hr_req_align & (hr_req_dlen_beat | (hr_req_last & hr_req_beat_last))) | (~hr_req_align);
            assign hr_req_ualign_mask_clr = hr_a_hvm ? vlsu_vm_a_mask : {{HR_MASK_WIDTH - BIU_MASK_WIDTH{1'b0}},hr_a_mask};
        end
        else begin:gen_hr_hvm_empty
            wire [BIU_DATA_WIDTH - 1:0] vlsu_vd_bypass_data_lo;
            wire [BIU_DATA_WIDTH - 1:0] vlsu_vd_bypass_data_hi;
            wire [1:0] hr_resp_beat_sel;
            wire nds_unused_st_ualign_hvm_bwe = |st_ualign_hvm_bwe;
            assign hr_req_element_num_biu = ({HR_OFFSET_WIDTH{hr_req_eew8}} & {hr_req_element_num_dlen[SEW8_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew16}} & {1'b0,hr_req_element_num_dlen[SEW16_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew32}} & {2'b0,hr_req_element_num_dlen[SEW32_DLEN_WIDTH - 2:0]}) | ({HR_OFFSET_WIDTH{hr_req_eew64}} & {3'b0,hr_req_element_num_dlen[SEW64_DLEN_WIDTH - 2:0]});
            assign hr_resp_align_data_in = {4{hr_d_data}};
            assign hr_req_align_data_wrap = hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0] | {{BIU_DATA_WIDTH{1'b0}},hr_req_align_data_out[BIU_DATA_WIDTH * 2 +:BIU_DATA_WIDTH]};
            assign vlsbuf_vd_element_bwe = {({BIU_MASK_WIDTH{hr_req_element_sel}} & hr_req_mask),({BIU_MASK_WIDTH{~hr_req_element_sel}} & hr_req_mask)};
            assign hr_resp_beat_sel = {hr_resp_dlen_beat,~hr_resp_dlen_beat};
            assign vlsu_vd_bypass_data_lo = ({BIU_DATA_WIDTH{hr_resp_beat_sel[0]}} & hr_d_data) | ({BIU_DATA_WIDTH{hr_resp_beat_sel[1]}} & vlsbuf_vd_rdata[BIU_DATA_WIDTH * 0 +:BIU_DATA_WIDTH]);
            assign vlsu_vd_bypass_data_hi = ({BIU_DATA_WIDTH{hr_resp_beat_sel[0]}} & vlsbuf_vd_rdata[BIU_DATA_WIDTH * 1 +:BIU_DATA_WIDTH]) | ({BIU_DATA_WIDTH{hr_resp_beat_sel[1]}} & hr_d_data);
            assign vlsu_vd_bypass_data = {vlsu_vd_bypass_data_hi,vlsu_vd_bypass_data_lo};
            assign hr_req_align_data_init = {{DLEN{1'b0}},hr_req_align_data_in};
            assign st_ualign_wdata = hr_req_align_data_out[BIU_DATA_WIDTH * 2 - 1:0];
            assign st_ualign_wlast_cnt = 2'd1;
            assign st_ualign_wdata_extra = hr_req_align_data_out[BIU_DATA_WIDTH * 2 +:BIU_DATA_WIDTH];
            assign st_ualign_bwe = st_ualign_biu_bwe;
            assign st_ualign_bwe_sel = {BIU_MASK_WIDTH * 2{1'b1}};
            assign st_ualign_v0t_init = {{DMLEN{1'b0}},vlsbuf_vs3_byte_mask};
            assign st_ualign_v0t_extra_wdata = st_ualign_v0t_shift[BIU_MASK_WIDTH * 2 +:BIU_MASK_WIDTH];
            assign segbuf_upacked_rlast = (hr_req_align & (hr_req_dlen_beat | (hr_req_last & hr_req_beat_last))) | (~hr_req_align);
            assign hr_req_ualign_mask_clr = hr_a_mask;
        end
    end
endgenerate
assign buf_info_req_clr = vlsbuf_st_return_valid;
assign buf_info_resp_clr = (hr_resp_vd_wvalid & hr_resp_dlen_last & ~hr_resp_element_seg) | vlsu_vd_bypass_valid;
assign buf_info_resp_ualign_clr = (ld_ualign_rgrant & hr_resp_ualign_dlen_last) | (ld_ualign_rgrant & hr_resp_vd_wvalid & hr_resp_simu_dlen_last);
assign buf_info_clr_sel = ({BUF_DEPTH{buf_info_resp_clr}} & hr_resp_buf_ptr) | ({BUF_DEPTH{buf_info_resp_ualign_clr}} & ld_ualign_rbuf_ptr) | ({BUF_DEPTH{buf_info_req_clr}} & hr_req_buf_ptr) | vlsbuf_ld_return_ptr1 | vlsbuf_vd_dlen_done;
assign vlsbuf_vd_unpacked_last = vlsbuf_unpacked_wsel & buf_info_ent_resp_dlen_last;
assign vlsbuf_vd_dlen_done = vlsbuf_vd_unpacked_last;
assign hr_resp_vd_wsel = ({BUF_DEPTH{hr_resp_vd_wvalid}} & hr_resp_buf_ptr);
assign vlsbuf_vd_widen_rdata = ({DLEN{~hr_vd_emul_cnt[0]}} & vlsbuf_vd_widen_data0) | ({DLEN{hr_vd_emul_cnt[0]}} & vlsbuf_vd_widen_data1);
assign vlsbuf_vd_mask_ready_nx = (hr_vd_buf_ptr_en & (|(hr_vd_mask_buf_ptr_nx & vlsbuf_ent_mask_ready_nx))) | (hr_vd_buf_ptr_en & (|(hr_vd_mask_buf_ptr_nx & vlsbuf_ent_mask_ready))) | (~vlsu_vd_wgrant & (|(hr_vd_mask_buf_ptr & vlsbuf_ent_mask_ready))) | (|(hr_vd_mask_buf_ptr & vlsbuf_ent_mask_ready_nx));
assign vlsbuf_vd_eseg_ready_nx = (hr_vd_buf_ptr_en & (|(vlsbuf_vd_unpacked_last & hr_vd_buf_ptr_nx))) | (|(vlsbuf_vd_unpacked_last & hr_vd_buf_ptr));
assign vlsbuf_vd_data_ready_nx = (hr_vd_buf_ptr_en & hr_resp_vd_wvalid & (hr_resp_buf_ptr == hr_vd_buf_ptr_nx) & vlsbuf_vd_write_dlen_last) | (hr_vd_buf_ptr_en & ld_ualign_rgrant & (ld_ualign_rbuf_ptr == hr_vd_buf_ptr_nx) & vlsbuf_vd_ualign_write_dlen_last) | (hr_vd_buf_ptr_en & (|(hr_vd_buf_ptr_nx & vlsbuf_ent_occupied))) | (~vlsu_vd_wgrant & (|(hr_vd_buf_ptr & vlsbuf_ent_occupied))) | (hr_resp_vd_wvalid & (hr_resp_buf_ptr == hr_vd_buf_ptr) & vlsbuf_vd_write_dlen_last) | (ld_ualign_rgrant & (ld_ualign_rbuf_ptr == hr_vd_buf_ptr) & vlsbuf_vd_ualign_write_dlen_last) | vlsbuf_vd_eseg_ready_nx;
assign vlsbuf_vd_rgrant_en = (vlsbuf_vd_rgrant_nx ^ vlsbuf_vd_rgrant);
assign vlsbuf_vd_rgrant_nx = vlsbuf_vd_mask_ready_nx & vlsbuf_vd_data_ready_nx;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsbuf_vd_rgrant <= 1'b0;
        vlsbuf_vd_rgrant_dup <= {DLEN / 64{1'b0}};
    end
    else if (vlsbuf_vd_rgrant_en) begin
        vlsbuf_vd_rgrant <= vlsbuf_vd_rgrant_nx;
        vlsbuf_vd_rgrant_dup <= {DLEN / 64{vlsbuf_vd_rgrant_nx}};
    end
end

assign vlsbuf_vd_mask_ready_en = vlsbuf_vd_mask_ready ^ vlsbuf_vd_mask_ready_nx;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsbuf_vd_mask_ready <= 1'b0;
    end
    else if (vlsbuf_vd_mask_ready_en) begin
        vlsbuf_vd_mask_ready <= vlsbuf_vd_mask_ready_nx;
    end
end

assign vm_fifo_wvalid = (vlsu_vm_a_valid & vlsu_vm_a_ready) & hr_a_hvm;
assign vm_fifo_wsource = hr_a_source[HR_SOURCE_WIDTH - 1:0];
assign vm_fifo_wload = hr_req_load;
assign vm_fifo_rready = vlsu_vm_d_grant | ~hr_vm_d_source_valid;
kv_fifo #(
    .DEPTH(HR_DEPTH),
    .WIDTH(HR_DEPTH_LOG2 + 1)
) u_vm_fifo (
    .clk(vpu_vlsu_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wdata({vm_fifo_wsource,vm_fifo_wload}),
    .wvalid(vm_fifo_wvalid),
    .wready(nds_unused_vm_fifo_wready),
    .rdata({vm_fifo_rsource,vm_fifo_rload}),
    .rvalid(vm_fifo_rvalid),
    .rready(vm_fifo_rready)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(BUF_DEPTH)
) u_hr_vm_resp_buf_ptr_nx (
    .out(hr_vm_resp_buf_ptr_nx),
    .sel(hr_vm_d_source_sel[HR_DEPTH_LOG2 - 1:0]),
    .in(hr_ent_buf_ptr)
);
kv_mux #(
    .N(HR_DEPTH),
    .W(34)
) u_hr_vm_resp_ctrl_nx (
    .out(hr_vm_resp_ctrl_nx),
    .sel(hr_vm_d_source_sel[HR_DEPTH_LOG2 - 1:0]),
    .in(hr_ent_ctrl)
);
assign hr_vm_d_source_sel = hr_dummy_d_valid_hvm_set ? hr_req_num : (hr_vm_d_source_valid & ~vlsu_vm_d_grant) ? hr_vm_d_source : hr_vm_d_source_nx;
assign vlsu_vd_hvm_wrtie = (hr_vm_resp_buf_ptr_nx == hr_vd_buf_ptr) & vlsu_vd_wgrant;
assign hr_vm_resp_load_nx = hr_vm_resp_ctrl_nx[13];
assign hr_vm_resp_align_nx = hr_vm_resp_ctrl_nx[0];
assign hr_vm_resp_ustride_nx = hr_vm_resp_ctrl_nx[29];
assign hr_vm_d_busy_cond_nx = (|(hr_vm_resp_buf_ptr_nx & vlsbuf_ent_occupied)) & ~vlsu_vd_hvm_wrtie;
assign hr_vm_d_busy_nx = hr_vm_resp_load_nx & hr_vm_resp_ustride_nx & (hr_vm_d_busy_cond_nx | (~hr_vm_resp_align_nx & ld_ualign_rgrant_fail));
assign hr_vm_d_ready_nx = (hr_vm_d_source_valid | vm_fifo_rvalid | hr_dummy_d_valid_hvm_set) & ~hr_vm_d_busy_nx;
assign hr_vm_d_source_en = vlsu_vm_d_grant | (~hr_vm_d_source_valid & vm_fifo_rvalid);
assign hr_vm_d_source_nx = vm_fifo_rsource;
assign hr_vm_d_load_nx = vm_fifo_rload;
assign hr_vm_d_source_valid_nx = vm_fifo_rvalid;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vm_d_source <= {HR_DEPTH_LOG2{1'b0}};
        hr_vm_d_source_valid <= 1'b0;
        hr_vm_d_load <= 1'b0;
    end
    else if (hr_vm_d_source_en) begin
        hr_vm_d_source <= hr_vm_d_source_nx;
        hr_vm_d_source_valid <= hr_vm_d_source_valid_nx;
        hr_vm_d_load <= hr_vm_d_load_nx;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vm_d_ready <= 1'b0;
    end
    else begin
        hr_vm_d_ready <= hr_vm_d_ready_nx;
    end
end

assign ififo_wvalid = uop_req_grant & uop_req_first & uop_req_ctrl[4];
assign ififo_vd_eew_w = uop_req_ctrl[20 +:3];
assign ififo_vd_emul_len_w = uop_req_vd_emul_len;
assign ififo_nf_w = uop_req_ctrl[9 +:3];
assign ififo_useg_w = uop_req_ctrl[19] & uop_req_ctrl[14];
assign ififo_uwiden_w = uop_req_ctrl[19] & uop_req_ctrl[23];
assign ififo_sext_w = uop_req_ctrl[15];
assign ififo_vd_beats_w = uop_req_vd_beats;
assign ififo_vd_seg_beats_w = uop_req_vd_seg_beats;
assign ififo_vd_buf_beats_w = uop_req_vd_buf_beats;
assign ififo_start_buf_num_w = uop_req_buf_num;
assign ififo_start_buf_ptr_w = uop_req_buf_ptr;
assign ififo_buf_opt_w = uop_req_buf_opt;
kv_fifo #(
    .DEPTH(IFIFO_DEPTH),
    .WIDTH(2 + VRF_LW + BUF_DEPTH_LOG2 + BUF_DEPTH + 6 + (VRF_LW * 3) + 1)
) u_vls_ififo (
    .clk(vpu_vlsu_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wdata({ififo_vd_eew_w[1:0],ififo_vd_emul_len_w,ififo_start_buf_num_w,ififo_start_buf_ptr_w,ififo_nf_w,ififo_useg_w,ififo_uwiden_w,ififo_sext_w,ififo_vd_beats_w,ififo_vd_seg_beats_w,ififo_vd_buf_beats_w,ififo_buf_opt_w}),
    .wvalid(ififo_wvalid),
    .wready(ififo_wready),
    .rdata({ififo_vd_eew_r[1:0],ififo_vd_emul_len_r,ififo_start_buf_num_r,ififo_start_buf_ptr_r,ififo_nf_r,ififo_useg_r,ififo_uwiden_r,ififo_sext_r,ififo_vd_beats_r,ififo_vd_seg_beats_r,ififo_vd_buf_beats_r,ififo_buf_opt_r}),
    .rvalid(ififo_rvalid),
    .rready(ififo_rready)
);
assign ififo_rready = hr_vd_en;
assign hr_vd_reset_en = vlsu_vd_wgrant & vlsu_vd_wlast;
assign hr_vd_init_en = ififo_rvalid & ~hr_vd_valid;
assign hr_vd_en = hr_vd_reset_en | hr_vd_init_en;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_valid <= 1'b0;
        hr_vd_valid_dup <= {DMLEN / 8{1'b0}};
        hr_vd_eew <= 2'b0;
        hr_vd_emul_len <= {VRF_LW{1'b0}};
        hr_vd_start_buf_num <= {BUF_DEPTH_LOG2{1'b0}};
        hr_vd_start_buf_ptr <= {BUF_DEPTH{1'b0}};
        hr_vd_nf <= 3'b0;
        hr_vd_useg <= 1'b0;
        hr_vd_uwiden <= 1'b0;
        hr_vd_useg_dup <= {DLEN / 64{1'b0}};
        hr_vd_uwiden_dup <= {DLEN / 64{1'b0}};
        hr_vd_sext <= 1'b0;
        hr_vd_buf_opt <= 1'b0;
        hr_vd_beats <= {VRF_LW{1'b0}};
        hr_vd_seg_beats <= {VRF_LW{1'b0}};
        hr_vd_buf_beats <= {VRF_LW{1'b0}};
    end
    else if (hr_vd_en) begin
        hr_vd_valid <= ififo_rvalid;
        hr_vd_valid_dup <= {DMLEN / 8{ififo_rvalid}};
        hr_vd_eew <= ififo_rvalid ? ififo_vd_eew_r : 2'b0;
        hr_vd_emul_len <= ififo_rvalid ? ififo_vd_emul_len_r : {VRF_LW{1'b0}};
        hr_vd_start_buf_num <= ififo_rvalid ? ififo_start_buf_num_r : {BUF_DEPTH_LOG2{1'b0}};
        hr_vd_start_buf_ptr <= ififo_rvalid ? ififo_start_buf_ptr_r : {BUF_DEPTH{1'b0}};
        hr_vd_nf <= ififo_rvalid ? ififo_nf_r : 3'b0;
        hr_vd_useg <= ififo_rvalid ? ififo_useg_r : 1'b0;
        hr_vd_uwiden <= ififo_rvalid ? ififo_uwiden_r : 1'b0;
        hr_vd_useg_dup <= ififo_rvalid ? {DLEN / 64{ififo_useg_r}} : {DLEN / 64{1'b0}};
        hr_vd_uwiden_dup <= ififo_rvalid ? {DLEN / 64{ififo_uwiden_r}} : {DLEN / 64{1'b0}};
        hr_vd_sext <= ififo_rvalid ? ififo_sext_r : 1'b0;
        hr_vd_buf_opt <= ififo_rvalid ? ififo_buf_opt_r : 1'b0;
        hr_vd_beats <= ififo_rvalid ? ififo_vd_beats_r : {VRF_LW{1'b0}};
        hr_vd_seg_beats <= ififo_rvalid ? ififo_vd_seg_beats_r : {VRF_LW{1'b0}};
        hr_vd_buf_beats <= ififo_rvalid ? ififo_vd_buf_beats_r : {VRF_LW{1'b0}};
    end
end

assign hr_vd_buf_ptr_en = vlsu_vd_wgrant | hr_vd_en;
assign hr_vd_buf_ptr_clr = vlsu_vd_wgrant & hr_vd_emul_wlast & ~hr_vd_emul_len_wlast;
assign hr_vd_buf_ptr_resume = vlsu_vd_wgrant & hr_vd_nf_cnt_set & ~hr_vd_nf_cnt_clr & hr_vd_resume;
assign hr_vd_buf_ptr_nx = hr_vd_en ? ({BUF_DEPTH{ififo_rvalid}} & ififo_start_buf_ptr_r) : hr_vd_buf_ptr_clr ? {BUF_DEPTH{1'b0}} : hr_vd_buf_ptr_resume ? hr_vd_buf_ptr_bk : (hr_vd_uwiden & ~hr_vd_emul_cnt[0]) ? hr_vd_buf_ptr : hr_vd_buf_ptr_inc_sel;
assign hr_vd_mask_buf_ptr_nx = hr_vd_en ? ({BUF_DEPTH{ififo_rvalid}} & ififo_start_buf_ptr_r) : hr_vd_buf_ptr_clr ? {BUF_DEPTH{1'b0}} : hr_vd_buf_ptr_resume ? hr_vd_buf_ptr_bk : hr_vd_mask_buf_ptr_inc_sel;
assign hr_vd_buf_ptr_add1 = {hr_vd_buf_ptr[BUF_DEPTH - 2:0],hr_vd_buf_ptr[BUF_DEPTH - 1]};
assign hr_vd_buf_ptr_sub1 = {hr_vd_buf_ptr[0],hr_vd_buf_ptr[BUF_DEPTH - 1:1]};
assign hr_vd_buf_ptr_inc_sel = hr_vd_data_revert ? hr_vd_buf_ptr_sub1 : hr_vd_buf_ptr_add1;
assign hr_vd_mask_buf_ptr_add1 = {hr_vd_mask_buf_ptr[BUF_DEPTH - 2:0],hr_vd_mask_buf_ptr[BUF_DEPTH - 1]};
assign hr_vd_mask_buf_ptr_sub1 = {hr_vd_mask_buf_ptr[0],hr_vd_mask_buf_ptr[BUF_DEPTH - 1:1]};
assign hr_vd_mask_buf_ptr_inc_sel = hr_vd_mask_revert ? hr_vd_mask_buf_ptr_sub1 : hr_vd_mask_buf_ptr_add1;
assign hr_vd_buf_ptr_bk_nx = hr_vd_finished_set ? hr_vd_buf_ptr_add1 : hr_vd_buf_ptr_bk;
assign hr_vd_resume = (hr_vd_emul_len != hr_vd_beats);
assign hr_vd_data_revert = hr_vd_buf_opt & hr_vd_emul_cnt[0];
assign hr_vd_mask_revert = hr_vd_buf_opt & hr_vd_emul_cnt[0];
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_buf_ptr <= {BUF_DEPTH{1'b0}};
        hr_vd_mask_buf_ptr <= {BUF_DEPTH{1'b0}};
        hr_vd_buf_ptr_bk <= {BUF_DEPTH{1'b0}};
    end
    else if (hr_vd_buf_ptr_en) begin
        hr_vd_buf_ptr <= hr_vd_buf_ptr_nx;
        hr_vd_mask_buf_ptr <= hr_vd_mask_buf_ptr_nx;
        hr_vd_buf_ptr_bk <= hr_vd_buf_ptr_bk_nx;
    end
end

assign hr_vd_buf_ptr_dup_en = hr_vd_buf_ptr_en;
assign hr_vd_buf_ptr_dup_nx = hr_vd_buf_ptr_nx;
assign hr_vd_mask_buf_ptr_dup_nx = hr_vd_mask_buf_ptr_nx;
assign hr_vd_eew8 = (hr_vd_eew[1:0] == 2'b00);
assign hr_vd_eew16 = (hr_vd_eew[1:0] == 2'b01);
assign hr_vd_eew32 = (hr_vd_eew[1:0] == 2'b10);
assign hr_vd_eew64 = (hr_vd_eew[1:0] == 2'b11);
assign hr_vd_eew_onehot = {hr_vd_eew64,hr_vd_eew32,hr_vd_eew16,hr_vd_eew8};
assign hr_vd_wr_dummy_valid = hr_vd_valid & hr_vd_finished;
assign hr_vd_wr_dummy_valid_dup = hr_vd_valid_dup & hr_vd_finished_dup;
assign hr_vd_useg_wlast = hr_vd_useg & vlsu_vd_wgrant & vlsu_vd_wlast;
assign hr_vd_buf_beats_add1 = {1'b0,hr_vd_buf_beats} + {{VRF_LW{1'b0}},1'b1};
assign hr_vd_seg_beats_add1 = {1'b0,hr_vd_seg_beats} + {{VRF_LW{1'b0}},1'b1};
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2 + 1),
    .IW(VRF_LW + 1)
) u_hr_vd_buf_beats_add1_zext (
    .out(hr_vd_buf_beats_add1_zext),
    .in(hr_vd_buf_beats_add1)
);
kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2 + 1),
    .IW(VRF_LW + 1)
) u_hr_vd_seg_beats_add1_zext (
    .out(hr_vd_seg_beats_add1_zext),
    .in(hr_vd_seg_beats_add1)
);
assign hr_vd_emul_wlast = (hr_vd_emul_cnt == hr_vd_beats);
assign hr_vd_emul_len_wlast = (hr_vd_emul_cnt == hr_vd_emul_len);
assign hr_vd_emul_cnt_en = vlsu_vd_wgrant;
assign hr_vd_emul_cnt_nx = hr_vd_emul_len_wlast ? {VRF_LW{1'b0}} : hr_vd_emul_cnt + {{VRF_LW - 1{1'b0}},1'b1};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_emul_cnt <= {VRF_LW{1'b0}};
    end
    else if (hr_vd_emul_cnt_en) begin
        hr_vd_emul_cnt <= hr_vd_emul_cnt_nx;
    end
end

assign hr_vd_nf_cnt_set = vlsu_vd_wgrant & hr_vd_emul_len_wlast;
assign hr_vd_nf_cnt_clr = vlsu_vd_wgrant & vlsu_vd_wlast;
assign hr_vd_nf_cnt_en = hr_vd_nf_cnt_set | hr_vd_nf_cnt_clr;
assign hr_vd_nf_cnt_nx = hr_vd_nf_cnt_clr ? 3'd0 : hr_vd_nf_cnt + 3'd1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_nf_cnt <= 3'd0;
    end
    else if (hr_vd_nf_cnt_en) begin
        hr_vd_nf_cnt <= hr_vd_nf_cnt_nx;
    end
end

assign hr_vd_finished_set = (vlsu_vd_wgrant & ~vlsu_vd_wlast & hr_vd_emul_wlast);
assign hr_vd_finished_clr = inst_vd_wr_last | hr_vd_nf_cnt_set;
assign hr_vd_finished_en = hr_vd_finished_set | hr_vd_finished_clr;
assign hr_vd_finished_nx = hr_vd_finished_clr ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vd_finished <= 1'b0;
        hr_vd_finished_dup <= {DMLEN / 8{1'b0}};
    end
    else if (hr_vd_finished_en) begin
        hr_vd_finished <= hr_vd_finished_nx;
        hr_vd_finished_dup <= {DMLEN / 8{hr_vd_finished_nx}};
    end
end

assign inst_vd_wr_last = vlsu_vd_wgrant & vlsu_vd_wlast;
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vlsbuf_useg_rptr (
    .en(ustride_seg_data_rvalid),
    .in(hr_vd_seg_start_buf_ptr),
    .num(hr_vd_buf_beats_add1_zext),
    .out(vlsbuf_useg_rptr)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vlsbuf_useg_return_ptr (
    .en(ustride_seg_data_rvalid),
    .in(hr_vd_seg_start_buf_ptr),
    .num(hr_vd_seg_beats_add1_zext),
    .out(vlsbuf_useg_return_ptr)
);
assign vlsbuf_ld_seg_return_sel = {BUF_DEPTH{hr_vd_useg_wlast}} & vlsbuf_useg_return_ptr;
assign ustride_unpacked_req = hr_vd_valid & hr_vd_useg & ((vlsbuf_useg_rptr & vlsbuf_ent_occupied) == vlsbuf_useg_rptr);
assign ustride_unpacked_start_buf_num = hr_vd_start_buf_num;
assign hr_vd_seg_start_buf_ptr = hr_vd_start_buf_ptr;
assign ustride_seg_data_rvalid = hr_vd_valid & hr_vd_useg;
assign ustride_seg_data_rgrant = ustride_seg_data_rvalid & useg_occupied;
assign ustride_seg_data_clr = vlsu_vd_wgrant & ~hr_vd_wr_dummy_valid;
assign ustride_seg_data_done = vlsu_vd_wgrant & vlsu_vd_wlast;
assign hr_req_ualgin_st_period_en = hr_req_ualgin_st_period_set | hr_req_ualgin_st_period_clr;
assign hr_req_ualgin_st_period_set = st_ualign_wgrant & hr_req_u_nseg_unbypass_cond & hr_vs3_rfirst;
assign hr_req_ualgin_st_period_clr = hr_a_grant & hr_req_u_nseg_unbypass_cond & hr_req_last;
assign hr_req_ualgin_st_period_nx = hr_req_ualgin_st_period_set;
assign hr_ualign_st_period_valid = hr_req_ualgin_st_period & ~hr_req_ualgin_st_period_clr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_req_ualgin_st_period <= 1'b0;
    end
    else if (hr_req_ualgin_st_period_en) begin
        hr_req_ualgin_st_period <= hr_req_ualgin_st_period_nx;
    end
end

assign hr_req_ptr_nx = {hr_req_ptr[HR_DEPTH - 2:0],hr_req_ptr[HR_DEPTH - 1]};
assign hr_cmd_empty_all = ~|hr_ent_cmd_valid;
assign hr_cmd_empty_others = ~|(~hr_req_ptr & hr_ent_cmd_valid);
assign hr_req_buf_ptr_rst0 = uop_req_grant & hr_cmd_empty_all & ~hr_ualign_st_period_valid;
assign hr_req_buf_ptr_rst1 = uop_req_grant & hr_cmd_empty_others & hr_req_ptr_en & ~hr_ualign_st_period_valid;
assign hr_req_buf_ptr_rst2 = hr_req_ptr_en & hr_req_cmd_valid_nx & (hr_req_load | (hr_req_store & hr_req_last));
assign hr_req_buf_ptr_en = hr_vs3_rptr_en | hr_req_buf_ptr_rst0 | hr_req_buf_ptr_rst1 | hr_req_buf_ptr_rst2;
assign hr_req_buf_ptr_nx = hr_req_buf_ptr_rst2 ? hr_req_buf_ptr_pre_nx : (hr_vs3_rptr_en & hr_vs3_done_set) ? {BUF_DEPTH{1'b0}} : (hr_vs3_rptr_en & hr_vs3_rptr_inc_en & ~hr_vs3_rlast) ? hr_vs3_rptr_inc_sel : (hr_req_buf_ptr_rst0 | hr_req_buf_ptr_rst1) ? uop_req_buf_ptr : hr_req_buf_ptr;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_req_buf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (hr_req_buf_ptr_en) begin
        hr_req_buf_ptr <= hr_req_buf_ptr_nx;
    end
end

assign hr_req_seg_inst_last = (hr_a_st_eseg_grant | hr_a_st_useg_grant) & hr_req_last & hr_req_beat_last;
assign hr_req_beat_last = (hr_req_beat_cnt == hr_req_total_beat_cnt);
assign hr_req_beat_first = (hr_req_beat_cnt == {BEAT_CNT_WIDTH{1'b0}});
assign hr_a_last = hr_req_ptr_en;
assign vlsbuf_vs3_rptr = hr_req_buf_ptr;
assign segbuf_epacked_rlast = (hr_req_eseg_hp & segbuf_eseg_rlast) | (hr_req_ustride_mutation & hr_vs3_rlast);
assign segbuf_packed_data_rlast = (hr_req_element_seg & segbuf_epacked_rlast) | (hr_req_ustride_seg & segbuf_upacked_rlast) | hr_req_seg_num_dlen_skip;
assign segbuf_packed_data_rvalid = hr_req_cmd_valid & hr_req_store & hr_req_seg;
assign segbuf_packed_data_rgrant = segbuf_packed_data_rvalid & segbuf_packed_occupied;
assign hr_vs3_rptr_en = (hr_a_store_grant & hr_req_beat_mask_lsb & (hr_req_align | hr_req_element_nseg)) | st_ualign_wgrant;
assign hr_vs3_rptr_inc_en = vlsbuf_st_return_cond | st_ualign_seg_valid | hr_req_eseg_bypass_valid;
assign hr_vs3_rptr_revert = hr_a_hvm & hr_req_ustride_nseg & hr_vs3_rcnt[0];
assign hr_vs3_rptr_add1 = {hr_req_buf_ptr[BUF_DEPTH - 2:0],hr_req_buf_ptr[BUF_DEPTH - 1]};
assign hr_vs3_rptr_sub1 = {hr_req_buf_ptr[0],hr_req_buf_ptr[BUF_DEPTH - 1:1]};
assign hr_vs3_rptr_inc_sel = hr_vs3_rptr_revert ? hr_vs3_rptr_sub1 : hr_vs3_rptr_add1;
assign hr_vs3_rcnt_nx = (hr_vs3_rlast & hr_vs3_rptr_inc_en) ? {VRF_LW{1'b0}} : hr_vs3_rptr_inc_en ? hr_vs3_rcnt_add1 : hr_vs3_rcnt;
assign hr_vs3_rfirst = (hr_vs3_rcnt == {VRF_LW{1'b0}}) & ~hr_vs3_done;
assign hr_vs3_rlast = (hr_req_vd_beats == hr_vs3_rcnt);
assign hr_vs3_rcnt_add1 = hr_vs3_rcnt + {{VRF_LW - 1{1'b0}},1'b1};
assign hr_vs3_cross_biu_nx = hr_vs3_rlast ? 1'b0 : hr_vs3_rfirst ? hr_req_ucross_biu : hr_vs3_cross_biu;
assign hr_vs3_extra_biu_nx = hr_vs3_rlast ? 1'b0 : hr_vs3_rfirst ? hr_req_uextra_biu : hr_vs3_extra_biu;
assign hr_vs3_onehot_sel_nx = hr_vs3_rlast ? 2'b0 : ~st_ualign_onehot_sel;
assign hr_vs3_cross_biu_sel = hr_vs3_rfirst ? hr_req_ucross_biu : hr_vs3_cross_biu;
assign hr_vs3_extra_biu_sel = hr_vs3_rfirst ? hr_req_uextra_biu : hr_vs3_extra_biu;
assign hr_vs3_hvm_sel = hr_vs3_rfirst ? hr_a_hvm : hr_vs3_hvm;
assign st_ualign_onehot_sel = hr_vs3_rfirst ? hr_req_align_onehot_sel : hr_vs3_onehot_sel;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vs3_rcnt <= {VRF_LW{1'b0}};
        hr_vs3_cross_biu <= 1'b0;
        hr_vs3_extra_biu <= 1'b0;
        hr_vs3_onehot_sel <= 2'b0;
    end
    else if (hr_vs3_rptr_en) begin
        hr_vs3_rcnt <= hr_vs3_rcnt_nx;
        hr_vs3_cross_biu <= hr_vs3_cross_biu_nx;
        hr_vs3_extra_biu <= hr_vs3_extra_biu_nx;
        hr_vs3_onehot_sel <= hr_vs3_onehot_sel_nx;
    end
end

assign hr_vs3_done_set = st_ualign_wgrant & (hr_vs3_rlast & (vlsbuf_st_return_cond | hr_req_ustride_mutation));
assign hr_vs3_done_clr = hr_a_store_grant & ((hr_req_ustride & hr_req_last & hr_req_beat_last) | (hr_req_ustride_mutation & hr_req_ele_seg_last & hr_req_beat_last));
assign hr_vs3_done_en = hr_vs3_done_set | hr_vs3_done_clr;
assign hr_vs3_done_nx = hr_vs3_done_set;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vs3_done <= 1'b0;
    end
    else if (hr_vs3_done_en) begin
        hr_vs3_done <= hr_vs3_done_nx;
    end
end

assign hr_vs3_hvm_set = st_ualign_wgrant & st_ualign_wfirst;
assign hr_vs3_hvm_clr = hr_a_store_grant & ((hr_req_ustride & hr_req_last & hr_req_beat_last) | (hr_req_ustride_mutation & hr_req_ele_seg_last & hr_req_beat_last));
assign hr_vs3_hvm_en = hr_vs3_hvm_set | hr_vs3_hvm_clr;
assign hr_vs3_hvm_nx = hr_vs3_hvm_set & hr_a_hvm;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vs3_hvm <= 1'b0;
    end
    else if (hr_vs3_hvm_en) begin
        hr_vs3_hvm <= hr_vs3_hvm_nx;
    end
end

assign hr_req_seg_num_dlen_skip = hr_req_cmd_valid & ((hr_req_eseg_bypass_cond & hr_req_beat_mask_lsb) | (hr_req_eseg_unbypass_cond & ~hr_vs3_done)) & ~hr_req_seg_num_dlen_hit & segbuf_packed_occupied;
assign hr_req_seg_num_dlen_en = hr_req_seg_num_dlen_skip | (hr_a_eseg_bypass_grant & segbuf_epacked_rlast) | (st_ualign_seg_wgrant & segbuf_epacked_rlast) | hr_req_seg_inst_last;
assign hr_req_seg_num_dlen_nx = (hr_req_seg_inst_last | (hr_req_ele_dlen_last & hr_req_seg_num_dlen_hit)) ? {ELE_DLEN_WIDTH{1'b0}} : hr_req_seg_num_dlen + {{ELE_DLEN_WIDTH - 1{1'b0}},1'b1};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_req_seg_num_dlen <= {ELE_DLEN_WIDTH{1'b0}};
    end
    else if (hr_req_seg_num_dlen_en) begin
        hr_req_seg_num_dlen <= hr_req_seg_num_dlen_nx;
    end
end

kv_zero_ext #(
    .OW(BUF_DEPTH_LOG2 + 1),
    .IW(VRF_LW + 1)
) u_hr_vd_sint_cnt_sel_zext (
    .out(hr_vd_sint_cnt_sel_zext),
    .in(hr_vd_sint_cnt_sel)
);
kv_vls_gen_ones #(
    .MAX_NUM(DLEN_LMUL),
    .N(BUF_DEPTH),
    .W(BUF_DEPTH_LOG2 + 1)
) u_vlsbuf_ld_return_ptr1 (
    .en(vlsbuf_ld_return_valid1),
    .in(vlsbuf_ld_return_ptr0_nx),
    .num(hr_vd_sint_cnt_sel_zext),
    .out(vlsbuf_ld_return_ptr1)
);
assign vlsbuf_ld_return_ptr0_nx = {hr_vd_buf_ptr[BUF_DEPTH - 2:0],hr_vd_buf_ptr[BUF_DEPTH - 1]};
assign hr_vd_sint_cnt = {2'b0,hr_vd_emul_cnt[VRF_LW - 1:1]};
assign hr_vd_sint_cnt_add1 = hr_vd_sint_cnt + {{VRF_LW{1'b0}},1'b1};
assign hr_vd_sint_cnt_sel = (hr_vd_emul_wlast & hr_vd_emul_cnt[0]) ? hr_vd_sint_cnt_add1 : hr_vd_sint_cnt;
assign vlsbuf_ld_return_valid0 = (vlsu_vd_wgrant & ~hr_vd_useg & ~hr_vd_uwiden) | (vlsu_vd_wgrant & ~hr_vd_useg & hr_vd_uwiden & (hr_vd_emul_cnt[0] | hr_vd_emul_wlast));
assign vlsbuf_ld_return_valid1 = (vlsu_vd_wgrant & ~hr_vd_useg & hr_vd_uwiden & hr_vd_emul_wlast & (hr_vd_emul_cnt != {VRF_LW{1'b0}}));
assign vlsbuf_st_return_cond = (hr_req_dlen_last_u & hr_req_ustride_nseg) | (hr_req_ele_dlen_last & hr_req_element_nseg);
assign vlsbuf_st_return_valid = (((hr_a_store_grant & hr_req_beat_mask_lsb & (hr_req_align | hr_req_element_nseg)) | st_ualign_nseg_wgrant) & vlsbuf_st_return_cond);
assign vlsbuf_ld_return_sel = ({BUF_DEPTH{vlsbuf_ld_return_valid0}} & hr_vd_buf_ptr) | vlsbuf_ld_return_ptr1;
assign vlsbuf_st_return_sel = ({BUF_DEPTH{vlsbuf_st_return_valid}} & vlsbuf_vs3_rptr);
assign vlsbuf_return_sel = vlsbuf_ld_return_sel | vlsbuf_st_return_sel | vlsbuf_ld_seg_return_sel;
assign buf_info_resp_wvalid = (hr_d_load_grant & ~hr_resp_element_seg & hr_resp_beat_mask_lsb);
assign buf_info_req_rvalid = (hr_a_store_grant & hr_req_beat_mask_lsb & (hr_req_element_nseg | (hr_req_align & hr_req_ustride_nseg))) | st_ualign_nseg_wgrant;
assign buf_info_resp_wsel = ({BUF_DEPTH{buf_info_resp_wvalid}} & hr_resp_buf_ptr) | vlsbuf_unpacked_wsel;
assign buf_info_resp_ualign_wsel = ({BUF_DEPTH{ld_ualign_rgrant}} & ld_ualign_rbuf_ptr);
assign buf_info_req_rsel = {BUF_DEPTH{buf_info_req_rvalid}} & hr_req_buf_ptr;
assign hr_req_ustride = hr_req_ctrl[29];
assign hr_req_element = hr_req_ctrl[28] | hr_req_ctrl[12];
assign hr_req_seg = hr_req_ctrl[20];
assign hr_req_ustride_seg = hr_req_ustride & hr_req_seg;
assign hr_req_element_seg = hr_req_element & hr_req_seg;
assign hr_req_ustride_nseg = hr_req_ustride & ~hr_req_seg;
assign hr_req_element_nseg = hr_req_element & ~hr_req_seg;
assign hr_req_non_seg = hr_req_ustride_nseg | hr_req_element_nseg;
assign hr_req_align = hr_req_ctrl[0];
assign hr_req_size = hr_req_ctrl[23 +:3];
assign hr_req_eew = hr_req_ctrl[30 +:3];
assign hr_req_eew8 = (hr_req_eew[1:0] == 2'b00) & ~hr_req_eew[2];
assign hr_req_eew16 = (hr_req_eew[1:0] == 2'b01);
assign hr_req_eew32 = (hr_req_eew[1:0] == 2'b10);
assign hr_req_eew64 = (hr_req_eew[1:0] == 2'b11) & (ELEN == 64);
assign hr_req_ele_dlen_last = hr_req_ctrl[8];
assign hr_req_ele_seg_first = hr_req_ctrl[9];
assign hr_req_ele_seg_last = hr_req_ctrl[10];
assign hr_req_element_byte_biu = hr_req_element_num_biu << hr_req_eew[1:0];
assign hr_req_mask_offset = hr_req_load ? hr_req_element_byte_biu : hr_req_umask_cnt_offset;
assign hr_req_mask_cnt = (hr_req_element_seg & hr_req_load) ? hr_req_skip ? {HR_BYTE_WIDTH{1'b0}} : ({HR_BYTE_WIDTH{hr_req_eew8}} & {{HR_BYTE_WIDTH - 1{1'b0}},1'd1}) | ({HR_BYTE_WIDTH{hr_req_eew16}} & {{HR_BYTE_WIDTH - 2{1'b0}},2'd2}) | ({HR_BYTE_WIDTH{hr_req_eew32}} & {{HR_BYTE_WIDTH - 3{1'b0}},3'd4}) | ({HR_BYTE_WIDTH{hr_req_eew64}} & {{HR_BYTE_WIDTH - 4{1'b0}},4'd8}) : hr_req_umask_cnt;
assign hr_req_align_data_out = hr_req_align_data_init << {hr_req_align_value,3'b0};
assign st_ualign_valid = hr_req_cmd_valid & hr_req_ustride_nseg & hr_payload_data_ready & hr_req_store & ~hr_req_align;
assign st_ualign_eseg_valid = hr_req_cmd_valid & hr_req_eseg_unbypass_cond & hr_req_seg_num_dlen_hit;
assign st_ualign_useg_valid = hr_req_cmd_valid & hr_req_useg_unbypass_cond;
assign st_ualign_seg_valid = st_ualign_eseg_valid | st_ualign_useg_valid;
assign st_ualign_nseg_wvalid = st_ualign_valid & ~hr_vs3_done;
assign st_ualign_seg_wvalid = st_ualign_seg_valid & ~hr_vs3_done & segbuf_packed_data_rgrant;
assign st_ualign_nseg_wgrant = st_ualign_nseg_wvalid & st_ualign_wready;
assign st_ualign_seg_wgrant = st_ualign_seg_wvalid & st_ualign_wready;
assign st_ualign_wvalid = st_ualign_nseg_wvalid | st_ualign_seg_wvalid;
assign st_ualign_wfirst = hr_vs3_rfirst;
assign st_ualign_wlast = hr_vs3_rlast;
assign st_ualign_wfirst_cnt = 2'd1;
assign st_ualign_cross_biu = hr_vs3_cross_biu_sel;
assign st_ualign_extra_biu = hr_vs3_extra_biu_sel;
assign st_ualign_hvm = hr_vs3_hvm_sel;
assign hr_req_ualign_rready = hr_a_store_grant & ~hr_req_align & hr_req_beat_mask_lsb;
generate
    if (BIU_DATA_WIDTH == 128) begin:gen_hr_req_ualign_rlast_128
        assign hr_req_ualign_rfirst = (hr_req_first | hr_req_ele_seg_first) & (((hr_req_beat_cnt == 2'd0) & hr_req_beat_mask[0]) | ((hr_req_beat_cnt == 2'd1) & (~hr_req_beat_mask[0])));
        assign hr_req_ualign_rlast = (hr_req_last | hr_req_ele_seg_last) & (hr_req_beat_last | (hr_req_beat_cnt == 2'd2) & ~hr_req_beat_mask[3]);
        assign segbuf_eseg_rlast = hr_req_ele_seg_last & (hr_req_beat_last | (hr_req_beat_cnt == 2'd2) & ~hr_req_beat_mask[3]);
    end
    else begin:gen_hr_req_ualign_rlast_256_512
        wire nds_unused_hr_req_beat_mask = |hr_req_beat_mask;
        assign hr_req_ualign_rfirst = (hr_req_first | hr_req_ele_seg_first) & hr_req_beat_first;
        assign hr_req_ualign_rlast = (hr_req_last | hr_req_ele_seg_last) & hr_req_beat_last;
        assign segbuf_eseg_rlast = hr_req_ele_seg_last & hr_req_beat_last;
    end
endgenerate
assign st_ualign_wgrant = st_ualign_wvalid & st_ualign_wready;
assign st_ualign_bwe_shift = st_ualign_bwe_sel << hr_req_align_value;
assign st_ualign_v0t_shift = st_ualign_v0t_init << hr_req_align_value;
assign st_ualign_biu_bwe = st_ualign_bwe_shift[BIU_MASK_WIDTH * 2 - 1:0] | {{BIU_MASK_WIDTH{1'b0}},st_ualign_bwe_shift[BIU_MASK_WIDTH * 2 +:BIU_MASK_WIDTH]};
assign st_ualign_hvm_bwe = st_ualign_bwe_shift[HVM_MASK_WIDTH * 2 - 1:0] | {{HVM_MASK_WIDTH{1'b0}},st_ualign_bwe_shift[HVM_MASK_WIDTH * 2 +:HVM_MASK_WIDTH]};
assign st_ualign_v0t_wdata = (st_ualign_v0t_shift[HR_MASK_WIDTH * 2 - 1:0] | {{HR_MASK_WIDTH{1'b0}},st_ualign_v0t_shift[HR_MASK_WIDTH * 2 +:HR_MASK_WIDTH]}) & st_ualign_bwe;
assign hr_req_ealign_data = ({BIU_DATA_WIDTH{hr_req_align_onehot_sel[0]}} & hr_req_align_data_wrap[BIU_DATA_WIDTH * 0 +:BIU_DATA_WIDTH]) | ({BIU_DATA_WIDTH{hr_req_align_onehot_sel[1]}} & hr_req_align_data_wrap[BIU_DATA_WIDTH * 1 +:BIU_DATA_WIDTH]);
assign hr_req_vm_ealign_data = ({HVM_DATA_WIDTH{hr_req_align_onehot_sel[0]}} & hr_req_align_data_wrap[HVM_DATA_WIDTH * 0 +:HVM_DATA_WIDTH]) | ({HVM_DATA_WIDTH{hr_req_align_onehot_sel[1]}} & hr_req_align_data_wrap[HVM_DATA_WIDTH * 1 +:HVM_DATA_WIDTH]);
assign hr_a_mask = hr_req_load ? {BIU_MASK_WIDTH{1'b1}} : (~hr_req_beat_mask_lsb) ? {BIU_MASK_WIDTH{1'b0}} : hr_req_mask[BIU_MASK_WIDTH - 1:0];
assign hr_req_prot = {1'b0,hr_req_ctrl[18],hr_req_ctrl[17]};
assign hr_req_axcache = hr_req_ctrl[1 +:4];
assign hr_req_load = hr_req_ctrl[13];
assign hr_req_store = hr_req_ctrl[27];
assign hr_req_putfull = hr_req_ctrl[19];
assign hr_req_putpart = ~hr_req_ctrl[19];
assign hr_a_store_grant = hr_req_store & hr_a_grant;
assign hr_vs3_buf_ptr_tl_en = ~hr_a_hvm & (st_ualign_nseg_wgrant | hr_vs3_done_clr | (hr_a_store_grant & hr_req_u_nseg_bypass_valid));
assign hr_vs3_buf_ptr_tl_nx = hr_vs3_done_clr ? {BUF_DEPTH{1'b0}} : (hr_vs3_rfirst & ~hr_vs3_rlast) ? hr_req_buf_ptr : (hr_vs3_buf_ptr_tl | hr_req_buf_ptr);
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_vs3_buf_ptr_tl <= {BUF_DEPTH{1'b0}};
    end
    else if (hr_vs3_buf_ptr_tl_en) begin
        hr_vs3_buf_ptr_tl <= hr_vs3_buf_ptr_tl_nx;
    end
end

assign hr_payload_data_ready = |(hr_req_buf_ptr & vlsbuf_ent_occupied);
assign hr_ustride_payload_ready = hr_req_ustride & hr_payload_data_ready;
assign hr_unbypass_payload_ready = (BIU_DATA_WIDTH == 512) | ((BIU_DATA_WIDTH != 512) & ((hr_req_buf_ptr_tl & (hr_vs3_buf_ptr_tl | vlsbuf_ent_occupied)) == hr_req_buf_ptr_tl));
assign hr_bypass_beat_ready = (((BIU_DATA_WIDTH == 512) | hr_a_hvm) & hr_ustride_payload_ready) | ((BIU_DATA_WIDTH != 512) & ((hr_req_buf_ptr_tl & (hr_vs3_buf_ptr_tl | vlsbuf_ent_occupied)) == hr_req_buf_ptr_tl));
assign hr_req_cmd_valid = (hr_req_valid | hr_req_skip);
assign hr_dummy_a_grant = hr_req_skip & (hr_req_u_nseg_bypass_ready | hr_req_u_nseg_unbypass_ready | hr_req_e_nseg_bypass_ready | hr_req_useg_bypass_ready | hr_req_eseg_bypass_ready | hr_req_useg_unbypass_ready | hr_req_eseg_unbypass_ready);
assign hr_a_valid = hr_req_valid & (hr_req_load | hr_req_u_nseg_bypass_ready | hr_req_u_nseg_unbypass_ready | hr_req_e_nseg_bypass_ready | hr_req_useg_bypass_ready | hr_req_eseg_bypass_ready | hr_req_useg_unbypass_ready | hr_req_eseg_unbypass_ready);
assign hr_req_u_nseg_bypass_cond = hr_req_store & hr_req_ustride_nseg & hr_req_align;
assign hr_req_u_nseg_unbypass_cond = hr_req_store & hr_req_ustride_nseg & ~hr_req_align;
assign hr_req_e_nseg_bypass_cond = hr_req_store & hr_req_element_nseg;
assign hr_req_eseg_bypass_cond = hr_req_store & hr_req_eseg_hp;
assign hr_req_eseg_unbypass_cond = hr_req_store & hr_req_ustride_mutation;
assign hr_req_useg_bypass_cond = hr_req_store & hr_req_ustride_seg & hr_req_align;
assign hr_req_useg_unbypass_cond = hr_req_store & hr_req_ustride_seg & ~hr_req_align;
assign hr_req_u_nseg_bypass_ready = hr_req_u_nseg_bypass_cond & hr_bypass_beat_ready;
assign hr_req_u_nseg_unbypass_ready = hr_req_u_nseg_unbypass_cond & ((hr_unbypass_payload_ready & ~hr_req_beat_mask_lsb) | (hr_req_ualign_rvalid & hr_req_beat_mask_lsb & (hr_unbypass_payload_ready | hr_a_hvm)));
assign hr_req_e_nseg_bypass_ready = hr_req_e_nseg_bypass_cond & hr_payload_data_ready;
assign hr_req_eseg_bypass_ready = hr_req_eseg_bypass_cond & packing & ((hr_req_beat_mask_lsb & hr_req_seg_num_dlen_hit & segbuf_packed_occupied) | (~hr_req_beat_mask_lsb));
assign hr_req_eseg_unbypass_ready = hr_req_eseg_unbypass_cond & packing & ((hr_req_beat_mask_lsb & hr_req_ualign_rvalid) | (~hr_req_beat_mask_lsb));
assign hr_req_useg_bypass_ready = hr_req_useg_bypass_cond & packing & ((hr_req_beat_mask_lsb & segbuf_packed_occupied) | (~hr_req_beat_mask_lsb));
assign hr_req_useg_unbypass_ready = hr_req_useg_unbypass_cond & packing & ((hr_req_beat_mask_lsb & hr_req_ualign_rvalid) | (~hr_req_beat_mask_lsb));
assign hr_req_u_nseg_bypass_valid = hr_req_u_nseg_bypass_cond & hr_req_beat_mask_lsb & hr_bypass_beat_ready;
assign hr_req_eseg_bypass_valid = hr_req_eseg_bypass_cond & hr_req_beat_mask_lsb & hr_req_seg_num_dlen_hit & segbuf_packed_occupied;
assign hr_req_eseg_unbypass_valid = hr_req_eseg_unbypass_cond & hr_req_beat_mask_lsb & hr_req_ualign_rvalid;
assign hr_req_useg_bypass_valid = hr_req_useg_bypass_cond & hr_req_beat_mask_lsb & segbuf_packed_occupied;
assign hr_req_useg_unbypass_valid = hr_req_useg_unbypass_cond & hr_req_beat_mask_lsb & hr_req_ualign_rvalid;
assign hr_a_eseg_bypass_grant = (hr_req_valid & hr_req_eseg_bypass_valid & hr_a_ready) | (hr_req_skip & hr_req_eseg_bypass_valid);
assign hr_a_useg_bypass_grant = (hr_req_valid & hr_req_useg_bypass_valid & hr_a_ready) | (hr_req_skip & hr_req_useg_bypass_valid);
assign hr_a_st_eseg_valid = hr_req_eseg_bypass_valid | hr_req_eseg_unbypass_valid | (hr_req_store & hr_req_element_seg & packing & ~hr_req_beat_mask_lsb);
assign hr_a_st_useg_valid = hr_req_useg_bypass_valid | hr_req_useg_unbypass_valid | (hr_req_store & hr_req_ustride_seg & packing & ~hr_req_beat_mask_lsb);
assign segbuf_packed_buf_clr = st_ualign_seg_wgrant | (hr_a_eseg_bypass_grant & hr_req_ele_seg_last) | hr_a_useg_bypass_grant | hr_req_seg_num_dlen_skip | hr_req_seg_inst_last;
assign segbuf_packed_buf_shift = st_ualign_seg_wgrant;
assign hr_a_st_eseg_grant = (hr_req_valid & hr_a_st_eseg_valid & hr_a_ready) | (hr_req_skip & hr_a_st_eseg_valid);
assign hr_a_st_useg_grant = (hr_req_valid & hr_a_st_useg_valid & hr_a_ready) | (hr_req_skip & hr_a_st_useg_valid);
assign hr_a_grant = (hr_a_valid & hr_a_ready) | hr_dummy_a_grant;
assign hr_req_num_en = hr_req_ptr_en;
assign hr_req_num_nx = hr_req_num + {{HR_DEPTH_LOG2 - 1{1'b0}},1'b1};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        hr_req_num <= {HR_DEPTH_LOG2{1'b0}};
    end
    else if (hr_req_num_en) begin
        hr_req_num <= hr_req_num_nx;
    end
end

generate
    if (HR_SOURCE_WIDTH == L2_SOURCE_WIDTH) begin:gen_nc_eq_source_length
        assign hr_a_source = hr_req_num;
        assign vlsu_vm_d_source = hr_vm_d_source;
    end
    else begin:gen_nc_neq_source_length
        assign hr_a_source = {{L2_SOURCE_WIDTH - HR_SOURCE_WIDTH{1'b0}},hr_req_num};
        assign vlsu_vm_d_source = {{L2_SOURCE_WIDTH - HR_SOURCE_WIDTH{1'b0}},hr_vm_d_source};
    end
endgenerate
assign hr_a_address = {hr_req_pa_base[BIU_BASE_WIDTH - 1:0],{BIU_OFFSET_WIDTH{1'b0}}};
assign hr_a_corrupt = 1'b0;
assign hr_a_opcode = ({3{hr_req_load}} & 3'd4) | ({3{hr_req_store & hr_req_putpart}} & 3'd1) | ({3{hr_req_store & hr_req_putfull}} & 3'd0);
assign hr_a_param = 3'd0;
assign hr_a_size = hr_req_size;
assign hr_a_user = {5'b0,hr_req_axcache,hr_req_prot};
assign hr_a_shareable = hr_req_ctrl[22];
assign hr_a_ncable = ~hr_a_hvm & ((hr_a_user[6:3] == 4'b0010) | (hr_a_user[6:3] == 4'b0011));
assign hr_a_cable = ~hr_a_hvm & ~hr_a_ncable;
assign hr_a_hvm = hr_req_ctrl[11];
assign hr_a_ready = (hr_a_ncable & vlsu_nc_a_ready) | (hr_a_cable & vlsu_cm_a_ready) | (hr_a_hvm & vlsu_vm_a_ready);
assign hr_d_ready = vlsu_vm_d_ready | vlsu_cm_d_ready | vlsu_nc_d_ready;
assign hr_d_grant = hr_d_valid & hr_d_ready;
assign hr_d_load = (channel_d_sel[0] & hr_vm_d_load) | (~channel_d_sel[0] & (hr_d_opcode == 3'd1));
assign hr_d_load_grant = (hr_d_grant & hr_d_load) | hr_dummy_d_grant;
assign hr_d_align_data = hr_resp_align_data_out[DLEN - 1:0];
assign hr_resp_align_data_out = hr_resp_align_data_in >> {hr_resp_align_value,3'b0};
assign hr_resp_eew = hr_resp_ctrl[30 +:3];
assign hr_resp_eew8 = (hr_resp_eew[1:0] == 2'b00);
assign hr_resp_eew16 = (hr_resp_eew[1:0] == 2'b01);
assign hr_resp_eew32 = (hr_resp_eew[1:0] == 2'b10);
assign hr_resp_eew64 = (hr_resp_eew[1:0] == 2'b11) & (ELEN == 64);
assign hr_resp_eew_onehot = {hr_resp_eew64,hr_resp_eew32,hr_resp_eew16,hr_resp_eew8};
assign hr_resp_ustride = hr_resp_ctrl[29];
assign hr_resp_element = hr_resp_ctrl[28] | hr_resp_ctrl[12];
assign hr_resp_seg = hr_resp_ctrl[20];
assign hr_resp_element_seg = hr_resp_element & hr_resp_seg;
assign hr_resp_ustride_nseg = hr_resp_ustride & ~hr_resp_seg;
assign hr_resp_element_nseg = hr_resp_element & ~hr_resp_seg;
assign hr_resp_align = hr_resp_ctrl[0];
assign hr_resp_cross_revert = hr_resp_ctrl[7];
assign unpacked_vd_beats = hr_resp_vd_beats;
assign unpacked_ctrl[1 +:3] = hr_resp_ctrl[14 +:3];
assign unpacked_ctrl[5 +:2] = hr_resp_eew[1:0];
assign unpacked_ctrl[4] = 1'b0;
assign unpacked_ctrl[0] = 1'b0;
assign unpacked_ctrl[7 +:4] = hr_resp_eew_onehot;
assign unpacked_nf_byte2element = hr_resp_umask_cnt >> hr_resp_eew[1:0];
assign unpacked_nf_cnt = unpacked_nf_byte2element[3:0];
assign segbuf_unpacked_data_wvalid = unpacked_req_en;
assign segbuf_unpacked_wdata = vlsu_vm_d_ready ? segbuf_unpacked_wdata_vm : segbuf_unpacked_wdata_biu;
generate
    if ((SEG_DATA_WIDTH / BIU_DATA_WIDTH) == 4) begin:gen_4_1_segbuf_unpacked_wdata_biu
        assign segbuf_unpacked_wdata_biu = {4{hr_d_align_data[BIU_DATA_WIDTH - 1:0]}};
    end
    else if ((SEG_DATA_WIDTH / BIU_DATA_WIDTH) == 2) begin:gen_2_1_segbuf_unpacked_wdata_biu
        assign segbuf_unpacked_wdata_biu = {2{hr_d_align_data[BIU_DATA_WIDTH - 1:0]}};
    end
    else if ((SEG_DATA_WIDTH / BIU_DATA_WIDTH) == 1) begin:gen_1_1_segbuf_unpacked_wdata_biu
        assign segbuf_unpacked_wdata_biu = hr_d_align_data[BIU_DATA_WIDTH - 1:0];
    end
    else if ((BIU_DATA_WIDTH / SEG_DATA_WIDTH) == 2) begin:gen_1_2_segbuf_unpacked_wdata_biu
        assign segbuf_unpacked_wdata_biu = hr_d_align_data[SEG_DATA_WIDTH - 1:0];
    end
endgenerate
generate
    if ((SEG_DATA_WIDTH / HVM_DATA_WIDTH) == 4) begin:gen_4_1_segbuf_unpacked_wdata_vm
        assign segbuf_unpacked_wdata_vm = {4{hr_d_align_data[HVM_DATA_WIDTH - 1:0]}};
    end
    else if ((SEG_DATA_WIDTH / HVM_DATA_WIDTH) == 2) begin:gen_2_1_segbuf_unpacked_wdata_vm
        assign segbuf_unpacked_wdata_vm = {2{hr_d_align_data[HVM_DATA_WIDTH - 1:0]}};
    end
    else if ((SEG_DATA_WIDTH / HVM_DATA_WIDTH) == 1) begin:gen_1_1_segbuf_unpacked_wdata_vm
        assign segbuf_unpacked_wdata_vm = hr_d_align_data[HVM_DATA_WIDTH - 1:0];
    end
    else if ((HVM_DATA_WIDTH / SEG_DATA_WIDTH) == 2) begin:gen_1_2_segbuf_unpacked_wdata_vm
        assign segbuf_unpacked_wdata_vm = hr_d_align_data[SEG_DATA_WIDTH - 1:0];
    end
    else if ((HVM_DATA_WIDTH / SEG_DATA_WIDTH) == 4) begin:gen_1_4_segbuf_unpacked_wdata_vm
        assign segbuf_unpacked_wdata_vm = hr_d_align_data[SEG_DATA_WIDTH - 1:0];
    end
endgenerate
assign unpacked_req_en = (hr_d_load_grant | hr_dummy_d_grant) & hr_resp_element_seg & hr_resp_beat_mask_lsb;
assign unpacked_start_buf_num = hr_resp_buf_num;
assign unpacked_start_buf_ptr = hr_resp_buf_ptr;
assign unpacked_element_num_dlen = hr_resp_element_num_dlen;
assign ustride_unpacked_vd_beats = hr_vd_beats;
assign ustride_unpacked_ctrl[1 +:3] = hr_vd_nf;
assign ustride_unpacked_ctrl[5 +:2] = hr_vd_eew[1:0];
assign ustride_unpacked_ctrl[4] = 1'b0;
assign ustride_unpacked_ctrl[0] = 1'b0;
assign ustride_unpacked_ctrl[7 +:4] = hr_vd_eew_onehot;
assign vlsu_vm_d_ready = channel_d_sel_dup[0] & hr_vm_d_ready;
assign vlsu_cm_d_ready = channel_d_sel_dup[1];
assign vlsu_nc_d_ready = channel_d_sel_dup[2];
assign vlsu_vm_d_grant = vlsu_vm_d_valid & vlsu_vm_d_ready;
assign channel_d_sel_dup_cur = (channel_d_sel_dup == DUMMY_D_EN) ? vlsu_vm_d_valid ? VM_D_EN : vlsu_cm_d_valid ? CM_D_EN : NC_D_EN : (channel_d_sel_dup == VM_D_EN) ? vlsu_cm_d_valid ? CM_D_EN : vlsu_nc_d_valid ? NC_D_EN : channel_d_sel_dup : (channel_d_sel_dup == CM_D_EN) ? vlsu_nc_d_valid ? NC_D_EN : vlsu_vm_d_valid ? VM_D_EN : channel_d_sel_dup : vlsu_vm_d_valid ? VM_D_EN : vlsu_cm_d_valid ? CM_D_EN : channel_d_sel_dup;
assign channel_d_sel_dup_en = (channel_d_sel_dup_nx != channel_d_sel_dup) | hr_dummy_d_valid_en;
assign channel_d_sel_dup_nx = hr_dummy_d_valid_set ? DUMMY_D_EN : channel_d_sel_dup_cur;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        channel_d_sel_dup <= VM_D_EN;
    end
    else if (channel_d_sel_dup_en) begin
        channel_d_sel_dup <= channel_d_sel_dup_nx;
    end
end

assign channel_d_sel_cur = (channel_d_sel == DUMMY_D_EN) ? vlsu_vm_d_valid ? VM_D_EN : vlsu_cm_d_valid ? CM_D_EN : NC_D_EN : (channel_d_sel == VM_D_EN) ? vlsu_cm_d_valid ? CM_D_EN : vlsu_nc_d_valid ? NC_D_EN : channel_d_sel : (channel_d_sel == CM_D_EN) ? vlsu_nc_d_valid ? NC_D_EN : vlsu_vm_d_valid ? VM_D_EN : channel_d_sel : vlsu_vm_d_valid ? VM_D_EN : vlsu_cm_d_valid ? CM_D_EN : channel_d_sel;
assign channel_d_sel_en = (channel_d_sel_nx != channel_d_sel) | hr_dummy_d_valid_en;
assign channel_d_sel_nx = hr_dummy_d_valid_set ? DUMMY_D_EN : channel_d_sel_cur;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        channel_d_sel <= VM_D_EN;
    end
    else if (channel_d_sel_en) begin
        channel_d_sel <= channel_d_sel_nx;
    end
end

assign channel_d_data_sel_en = channel_d_sel_en;
assign channel_d_data_sel_nx = {{BIU_DATA_WIDTH / 64{channel_d_sel_nx[2]}},{BIU_DATA_WIDTH / 64{channel_d_sel_nx[1]}}};
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        channel_d_data_sel <= {{BIU_DATA_WIDTH / 64{1'b0}},{BIU_DATA_WIDTH / 64{1'b0}}};
    end
    else if (channel_d_data_sel_en) begin
        channel_d_data_sel <= channel_d_data_sel_nx;
    end
end

assign hr_d_valid = ({1{channel_d_sel[0]}} & vlsu_vm_d_valid) | ({1{channel_d_sel[1]}} & vlsu_cm_d_valid) | ({1{channel_d_sel[2]}} & vlsu_nc_d_valid);
generate
    for (i = 0; i < (BIU_DATA_WIDTH / 64); i = i + 1) begin:gen_cm_nc_data_sel
        assign hr_d_data[(i * 64) +:64] = ({64{channel_d_data_sel[i]}} & vlsu_cm_d_data[(i * 64) +:64]) | ({64{channel_d_data_sel[(BIU_DATA_WIDTH / 64) + i]}} & vlsu_nc_d_data[(i * 64) +:64]);
    end
endgenerate
assign hr_d_opcode = ({3{channel_d_sel[1]}} & vlsu_cm_d_opcode) | ({3{channel_d_sel[2]}} & vlsu_nc_d_opcode);
assign hr_d_source = ({L2_SOURCE_WIDTH{channel_d_sel[1]}} & vlsu_cm_d_source) | ({L2_SOURCE_WIDTH{channel_d_sel[2]}} & vlsu_nc_d_source) | ({L2_SOURCE_WIDTH{channel_d_sel[0]}} & vlsu_vm_d_source);
assign vlsu_vm_async_bus_err = channel_d_sel[0] & (vlsu_vm_d_corrupt | vlsu_vm_d_denied | vlsu_vm_d_user[1]);
assign vlsu_nc_async_bus_err = channel_d_sel[2] & (vlsu_nc_d_corrupt | vlsu_nc_d_denied | vlsu_nc_d_user[1]);
assign vlsu_cm_async_err = channel_d_sel[1] & (vlsu_cm_d_corrupt | vlsu_cm_d_denied | vlsu_cm_d_user[1]);
assign vlsu_cm_async_ecc_error = vlsu_cm_async_err & vlsu_cm_d_cause[1];
assign vlsu_cm_async_bus_err = vlsu_cm_async_err & vlsu_cm_d_cause[0];
assign vlsu_cm_async_ecc_corr = channel_d_sel[1] & vlsu_cm_d_cause[3];
assign vlsu_cm_async_ecc_ramid = channel_d_sel[1] & vlsu_cm_d_cause[2];
assign vlsu_async_bus_err = vlsu_vm_async_bus_err | vlsu_cm_async_bus_err | vlsu_nc_async_bus_err;
assign vlsu_async_error_set = hr_d_grant;
assign vlsu_async_error_clr = ~hr_d_grant & (vlsu_async_bus_error | vlsu_async_ecc_error);
assign vlsu_async_error_en = vlsu_async_error_set | vlsu_async_error_clr;
assign vlsu_async_bus_error_nx = vlsu_async_error_set ? vlsu_async_bus_err : 1'b0;
assign vlsu_async_ecc_error_nx = vlsu_async_error_set ? vlsu_cm_async_ecc_error : 1'b0;
assign vlsu_async_ecc_corr_nx = vlsu_async_error_set ? vlsu_cm_async_ecc_corr : 1'b0;
assign vlsu_async_ecc_ramid_nx = vlsu_async_error_set ? vlsu_cm_async_ecc_ramid : 1'b0;
assign vlsu_async_ecc_read_nx = vlsu_async_error_set ? hr_d_load : 1'b0;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vlsu_async_bus_error <= 1'b0;
        vlsu_async_ecc_error <= 1'b0;
        vlsu_async_ecc_corr <= 1'b0;
        vlsu_async_ecc_ramid <= 1'b0;
        vlsu_async_ecc_read <= 1'b0;
    end
    else if (vlsu_async_error_en) begin
        vlsu_async_bus_error <= vlsu_async_bus_error_nx;
        vlsu_async_ecc_error <= vlsu_async_ecc_error_nx;
        vlsu_async_ecc_corr <= vlsu_async_ecc_corr_nx;
        vlsu_async_ecc_ramid <= vlsu_async_ecc_ramid_nx;
        vlsu_async_ecc_read <= vlsu_async_ecc_read_nx;
    end
end

assign vpu_ls_async_read_error = vlsu_async_bus_error & vlsu_async_ecc_read;
assign vpu_ls_async_write_error = vlsu_async_bus_error & ~vlsu_async_ecc_read;
assign vpu_ls_async_ecc_error = vlsu_async_ecc_error;
assign vpu_ls_async_ecc_corr = vlsu_async_ecc_corr;
assign vpu_ls_async_ecc_ramid = vlsu_async_ecc_ramid ? 4'd5 : 4'd4;
assign vpu_ls_async_ecc_read = vlsu_async_ecc_read;
assign vlsu_nc_a_address = hr_a_address;
assign vlsu_nc_a_corrupt = hr_a_corrupt;
assign vlsu_nc_a_data = hr_a_data;
assign vlsu_nc_a_mask = hr_a_mask;
assign vlsu_nc_a_opcode = hr_a_opcode;
assign vlsu_nc_a_param = hr_a_param;
assign vlsu_nc_a_size = hr_a_size;
assign vlsu_nc_a_source = hr_a_source;
assign vlsu_nc_a_user = hr_a_user;
assign vlsu_nc_a_valid = hr_a_valid & hr_a_ncable;
assign vlsu_cm_a_address = hr_a_address;
assign vlsu_cm_a_corrupt = hr_a_corrupt;
assign vlsu_cm_a_data = hr_a_data;
assign vlsu_cm_a_mask = hr_a_mask;
assign vlsu_cm_a_opcode = hr_a_opcode;
assign vlsu_cm_a_param = hr_a_param;
assign vlsu_cm_a_size = hr_a_size;
assign vlsu_cm_a_source = hr_a_source;
assign vlsu_cm_a_user = hr_a_user;
assign vlsu_cm_a_shareable = hr_a_shareable;
assign vlsu_cm_a_valid = hr_a_valid & hr_a_cable;
generate
    if (VLSU_SUPPORT_HVM == 1'b1) begin:gen_hvm_tl_a
        assign vlsu_vm_a_address = {hr_req_pa_base[HVM_BASE_WIDTH - 1:0],{HVM_OFFSET_WIDTH{1'b0}}};
        assign vlsu_vm_a_data = (hr_req_align | hr_req_element_nseg | hr_req_eseg_hp) ? hr_req_vm_ealign_data : hr_req_ualign_data_hvm;
        assign vlsu_vm_a_mask = hr_req_load ? {HVM_MASK_WIDTH{1'b1}} : hr_req_mask;
        assign vlsu_vm_a_opcode = hr_a_opcode;
        assign vlsu_vm_a_size = hr_a_size;
        assign vlsu_vm_a_valid = hr_a_valid & hr_a_hvm;
    end
    else begin:gen_hvm_tl_a_stub
        wire nds_unused_hr_req_vm_ealign_data = |hr_req_vm_ealign_data;
        wire nds_unused_hr_req_ualign_data_hvm = |hr_req_ualign_data_hvm;
        assign vlsu_vm_a_address = 1'b0;
        assign vlsu_vm_a_data = {DLEN{1'b0}};
        assign vlsu_vm_a_mask = {DMLEN{1'b0}};
        assign vlsu_vm_a_opcode = 3'b0;
        assign vlsu_vm_a_size = 3'b0;
        assign vlsu_vm_a_valid = 1'b0;
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

