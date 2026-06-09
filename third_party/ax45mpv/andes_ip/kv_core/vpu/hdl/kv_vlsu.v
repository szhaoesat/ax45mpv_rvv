// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vlsu (
    vpu_block_pending,
    vpu_loadstore_pending,
    vpu_vlsu_pending,
    vlsu_cm_a_address,
    vlsu_cm_a_corrupt,
    vlsu_cm_a_data,
    vlsu_cm_a_mask,
    vlsu_cm_a_opcode,
    vlsu_cm_a_param,
    vlsu_cm_a_ready,
    vlsu_cm_a_shareable,
    vlsu_cm_a_size,
    vlsu_cm_a_source,
    vlsu_cm_a_user,
    vlsu_cm_a_valid,
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
    vlsu_hr_events,
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
    vlsu_vd_wdata,
    vlsu_vd_wlast,
    vlsu_vd_wmask,
    vlsu_vd_wready,
    vlsu_vd_wvalid,
    vlsu_vm_a_address,
    vlsu_vm_a_data,
    vlsu_vm_a_mask,
    vlsu_vm_a_opcode,
    vlsu_vm_a_ready,
    vlsu_vm_a_size,
    vlsu_vm_a_valid,
    vlsu_vm_d_corrupt,
    vlsu_vm_d_data,
    vlsu_vm_d_denied,
    vlsu_vm_d_opcode,
    vlsu_vm_d_ready,
    vlsu_vm_d_size,
    vlsu_vm_d_valid,
    vpu_ls_async_ecc_corr,
    vpu_ls_async_ecc_error,
    vpu_ls_async_ecc_ramid,
    vpu_ls_async_ecc_read,
    vpu_ls_async_read_error,
    vpu_ls_async_write_error,
    vlsu_vs2_rdata,
    vlsu_vs2_rvalid,
    vlsu_ack_element,
    vlsu_ack_status,
    vlsu_ack_tval,
    vlsu_ack_valid,
    vlsu_cmt_kill,
    vlsu_cmt_valid,
    vlsu_dispatch_ctrl,
    vlsu_dispatch_op1,
    vlsu_dispatch_op2,
    vlsu_dispatch_ready,
    vlsu_dispatch_v0t,
    vlsu_dispatch_valid,
    vlsu_dispatch_vd_len,
    vlsu_dispatch_vs2_len,
    vlsu_dispatch_vs3_len,
    vlsu_vs2_rlast,
    vlsu_vs2_rready,
    vlsu_vs3_rdata,
    vlsu_vs3_rlast,
    vlsu_vs3_rready,
    vlsu_vs3_rvalid,
    vpu_pma_req_pa,
    vpu_pma_resp_fault,
    vpu_pma_resp_hvm,
    vpu_pma_resp_mtype,
    vpu_pma_resp_nosh,
    vpu_pmp_req_pa,
    vpu_pmp_resp_permission,
    vpu_vtlb_flush,
    vpu_vtlb_miss_data,
    vpu_vtlb_miss_req,
    vpu_vtlb_miss_resp,
    vpu_vtlb_miss_vpn,
    vpu_vlsu_clk,
    vpu_reset_n
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
parameter VALEN = 39;
parameter PALEN = 38;
parameter VRF_LW = 3;
parameter TL_SINK_WIDTH = 2;
parameter L2_SOURCE_WIDTH = 4;
parameter VLSU_DATA_WIDTH = 256;
parameter VLSU_MSHR_DEPTH = 16;
parameter VLSU_BUF_DEPTH = 8;
parameter VTLB_ENTRIES = 8;
parameter MMU_SCHEME_INT = 0;
parameter PMA_SUPPORT_INT = 0;
parameter PMP_SUPPORT_INT = 0;
parameter ILM_BASE = 64'h0000_0000;
parameter DLM_BASE = 64'h0020_0000;
parameter HVM_BASE = 64'h0030_0000;
parameter ILM_SIZE_KB = 0;
parameter DLM_SIZE_KB = 0;
parameter HVM_SIZE_KB = 0;
parameter HVM_ADDR_WIDTH = 16;
localparam VLSU_ADDR_WIDTH = PALEN;
localparam XLEN = 64;
localparam DMLEN = DLEN / 8;
localparam VLSQ_DEPTH = 4;
localparam UOPQ_DEPTH = 8;
localparam VS2Q_DEPTH = 1;
localparam VS2Q_DEPTH_LOG2 = $clog2(VS2Q_DEPTH);
localparam HR_DEPTH = VLSU_MSHR_DEPTH;
localparam HR_DEPTH_LOG2 = $clog2(HR_DEPTH);
localparam BUF_DEPTH = VLSU_BUF_DEPTH * (VLEN / DLEN);
localparam BUF_DEPTH_LOG2 = $clog2(BUF_DEPTH);
localparam IFIFO_DEPTH = VLSU_BUF_DEPTH * (VLEN / DLEN);
localparam ELE_DLEN_WIDTH = $clog2(DLEN / 8);
localparam ELE_CNT_WIDTH = $clog2(VLEN);
localparam SEW8_DLEN_WIDTH = $clog2(DLEN / 8);
localparam SEW16_DLEN_WIDTH = $clog2(DLEN / 16);
localparam SEW32_DLEN_WIDTH = $clog2(DLEN / 32);
localparam SEW64_DLEN_WIDTH = $clog2(DLEN / 64);
localparam MAX_BYTE_WIDTH = $clog2(VLEN) + 1;
localparam BEAT_CNT_WIDTH = (VLSU_DATA_WIDTH == 512) ? 1 : $clog2(512 / VLSU_DATA_WIDTH);
localparam DLEN_BYTE_WIDTH = $clog2(DLEN / 8) + 1;
localparam NF_BYTE_WIDTH = $clog2(ELEN) + 1;
localparam CL_OFFSET_WIDTH = $clog2(512 / 8);
localparam CL_BASE_WIDTH = PALEN - CL_OFFSET_WIDTH;
localparam CL_BYTE_WIDTH = $clog2(512 / 8) + 1;
localparam BIU_OFFSET_WIDTH = $clog2(VLSU_DATA_WIDTH / 8);
localparam BIU_BASE_WIDTH = PALEN - BIU_OFFSET_WIDTH;
localparam BIU_BYTE_WIDTH = $clog2(VLSU_DATA_WIDTH / 8) + 1;
localparam BIU_DATA_WIDTH = VLSU_DATA_WIDTH;
localparam BIU_MASK_WIDTH = VLSU_DATA_WIDTH / 8;
localparam HVM_DATA_WIDTH = (HVM_SIZE_KB != 0) ? DLEN : BIU_DATA_WIDTH;
localparam HVM_MASK_WIDTH = (HVM_SIZE_KB != 0) ? DMLEN : BIU_MASK_WIDTH;
localparam HVM_OFFSET_WIDTH = $clog2(HVM_DATA_WIDTH / 8);
localparam HVM_BASE_WIDTH = (HVM_SIZE_KB != 0) ? HVM_ADDR_WIDTH - HVM_OFFSET_WIDTH : BIU_BASE_WIDTH;
localparam HVM_BYTE_WIDTH = $clog2(HVM_DATA_WIDTH / 8) + 1;
localparam HR_OFFSET_WIDTH = ((HVM_OFFSET_WIDTH > BIU_OFFSET_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_OFFSET_WIDTH : BIU_OFFSET_WIDTH;
localparam HR_BASE_WIDTH = ((HVM_BASE_WIDTH > BIU_BASE_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_BASE_WIDTH : BIU_BASE_WIDTH;
localparam HR_BYTE_WIDTH = ((HVM_BYTE_WIDTH > BIU_BYTE_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_BYTE_WIDTH : BIU_BYTE_WIDTH;
localparam HR_DATA_WIDTH = ((HVM_DATA_WIDTH > BIU_DATA_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_DATA_WIDTH : BIU_DATA_WIDTH;
localparam HR_MASK_WIDTH = ((HVM_MASK_WIDTH > BIU_MASK_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_MASK_WIDTH : BIU_MASK_WIDTH;
localparam HR_SOURCE_WIDTH = $clog2(VLSU_MSHR_DEPTH);
localparam HR_MAX_BYTE_WIDTH = ((HVM_BYTE_WIDTH > CL_BYTE_WIDTH) & (HVM_SIZE_KB != 0)) ? HVM_BYTE_WIDTH : CL_BYTE_WIDTH;
localparam VPN_WIDTH = VALEN - 12;
localparam PPN_WIDTH = PALEN - 12;
localparam EXTVALEN = (MMU_SCHEME_INT != 0) ? VALEN + 1 : VALEN;
localparam SEG_DATA_WIDTH = ELEN * 8;
localparam SEG_MASK_WIDTH = ELEN;
localparam PACKED_DATA_WIDTH = (DLEN >= SEG_DATA_WIDTH) ? DLEN : SEG_DATA_WIDTH;
localparam PACKED_MASK_WIDTH = PACKED_DATA_WIDTH / 8;
localparam VLSU_SUPPORT_HVM = (HVM_SIZE_KB != 0);
localparam BUF_UCNT_WIDTH = VRF_LW - 1;
localparam BUF_INFO_DW = (2 ** BUF_UCNT_WIDTH) * 2;
localparam VLSU_BYPASS_EN = (VLEN < 1024) ? 1 : 0;
localparam SEG_PRESYNC = 0;
localparam SATP_MODE_BARE = 4'h0;
localparam SATP_MODE_SV39 = 4'h8;
localparam SATP_MODE_SV48 = 4'h9;
output vpu_block_pending;
output vpu_loadstore_pending;
output vpu_vlsu_pending;
output [(VLSU_ADDR_WIDTH - 1):0] vlsu_cm_a_address;
output vlsu_cm_a_corrupt;
output [(BIU_DATA_WIDTH - 1):0] vlsu_cm_a_data;
output [(BIU_MASK_WIDTH - 1):0] vlsu_cm_a_mask;
output [2:0] vlsu_cm_a_opcode;
output [2:0] vlsu_cm_a_param;
input vlsu_cm_a_ready;
output vlsu_cm_a_shareable;
output [2:0] vlsu_cm_a_size;
output [(L2_SOURCE_WIDTH - 1):0] vlsu_cm_a_source;
output [11:0] vlsu_cm_a_user;
output vlsu_cm_a_valid;
input [(4 - 1):0] vlsu_cm_d_cause;
input vlsu_cm_d_corrupt;
input [(BIU_DATA_WIDTH - 1):0] vlsu_cm_d_data;
input vlsu_cm_d_denied;
input [2:0] vlsu_cm_d_opcode;
input [1:0] vlsu_cm_d_param;
output vlsu_cm_d_ready;
input [(TL_SINK_WIDTH - 1):0] vlsu_cm_d_sink;
input [2:0] vlsu_cm_d_size;
input [(L2_SOURCE_WIDTH - 1):0] vlsu_cm_d_source;
input [5:0] vlsu_cm_d_user;
input vlsu_cm_d_valid;
output [(64 - 1):0] vlsu_hr_events;
output [(VLSU_ADDR_WIDTH - 1):0] vlsu_nc_a_address;
output vlsu_nc_a_corrupt;
output [(BIU_DATA_WIDTH - 1):0] vlsu_nc_a_data;
output [(BIU_MASK_WIDTH - 1):0] vlsu_nc_a_mask;
output [2:0] vlsu_nc_a_opcode;
output [2:0] vlsu_nc_a_param;
input vlsu_nc_a_ready;
output [2:0] vlsu_nc_a_size;
output [(L2_SOURCE_WIDTH - 1):0] vlsu_nc_a_source;
output [11:0] vlsu_nc_a_user;
output vlsu_nc_a_valid;
input vlsu_nc_d_corrupt;
input [(BIU_DATA_WIDTH - 1):0] vlsu_nc_d_data;
input vlsu_nc_d_denied;
input [2:0] vlsu_nc_d_opcode;
input [1:0] vlsu_nc_d_param;
output vlsu_nc_d_ready;
input [(TL_SINK_WIDTH - 1):0] vlsu_nc_d_sink;
input [2:0] vlsu_nc_d_size;
input [(L2_SOURCE_WIDTH - 1):0] vlsu_nc_d_source;
input [5:0] vlsu_nc_d_user;
input vlsu_nc_d_valid;
output [(DLEN - 1):0] vlsu_vd_wdata;
input vlsu_vd_wlast;
output [(DLEN / 8) - 1:0] vlsu_vd_wmask;
input vlsu_vd_wready;
output vlsu_vd_wvalid;
output [(HVM_ADDR_WIDTH - 1):0] vlsu_vm_a_address;
output [(DLEN - 1):0] vlsu_vm_a_data;
output [(DMLEN - 1):0] vlsu_vm_a_mask;
output [2:0] vlsu_vm_a_opcode;
input vlsu_vm_a_ready;
output [2:0] vlsu_vm_a_size;
output vlsu_vm_a_valid;
input vlsu_vm_d_corrupt;
input [(DLEN - 1):0] vlsu_vm_d_data;
input vlsu_vm_d_denied;
input [2:0] vlsu_vm_d_opcode;
output vlsu_vm_d_ready;
input [2:0] vlsu_vm_d_size;
input vlsu_vm_d_valid;
output vpu_ls_async_ecc_corr;
output vpu_ls_async_ecc_error;
output [3:0] vpu_ls_async_ecc_ramid;
output vpu_ls_async_ecc_read;
output vpu_ls_async_read_error;
output vpu_ls_async_write_error;
input [(DLEN - 1):0] vlsu_vs2_rdata;
input vlsu_vs2_rvalid;
output [10:0] vlsu_ack_element;
output [(22 - 1):0] vlsu_ack_status;
output [63:0] vlsu_ack_tval;
output vlsu_ack_valid;
input vlsu_cmt_kill;
input vlsu_cmt_valid;
input [(55 - 1):0] vlsu_dispatch_ctrl;
input [(XLEN - 1):0] vlsu_dispatch_op1;
input [(XLEN - 1):0] vlsu_dispatch_op2;
output vlsu_dispatch_ready;
input [(VLEN - 1):0] vlsu_dispatch_v0t;
input vlsu_dispatch_valid;
input [(VRF_LW - 1):0] vlsu_dispatch_vd_len;
input [(VRF_LW - 1):0] vlsu_dispatch_vs2_len;
input [(VRF_LW - 1):0] vlsu_dispatch_vs3_len;
input vlsu_vs2_rlast;
output vlsu_vs2_rready;
input [(DLEN - 1):0] vlsu_vs3_rdata;
input vlsu_vs3_rlast;
output vlsu_vs3_rready;
input vlsu_vs3_rvalid;
output [(PALEN - 1):0] vpu_pma_req_pa;
input vpu_pma_resp_fault;
input vpu_pma_resp_hvm;
input [3:0] vpu_pma_resp_mtype;
input vpu_pma_resp_nosh;
output [(PALEN - 1):0] vpu_pmp_req_pa;
input [3:0] vpu_pmp_resp_permission;
input vpu_vtlb_flush;
input [(13 + PALEN):0] vpu_vtlb_miss_data;
output vpu_vtlb_miss_req;
input vpu_vtlb_miss_resp;
output [(VALEN - 1):12] vpu_vtlb_miss_vpn;
input vpu_vlsu_clk;
input vpu_reset_n;





// 3e557cec rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire vlsu_load_pending;
wire vlsu_store_pending;
wire vlsu_store_pending_clk;
wire [(BUF_DEPTH_LOG2 - 1):0] claim_buf_resp_num;
wire [(BUF_DEPTH - 1):0] claim_buf_resp_ptr;
wire claim_vbuf_ready;
wire uop_claim_buf_grant;
wire [(BUF_DEPTH_LOG2 - 1):0] uop_claim_buf_resp_num;
wire [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_data_all;
wire [(BUF_DEPTH - 1):0] vlsbuf_ent_mask_ready;
wire [(BUF_DEPTH - 1):0] vlsbuf_ent_mask_ready_nx;
wire [(BUF_DEPTH - 1):0] vlsbuf_ent_occupied;
wire [(BUF_DEPTH - 1):0] vlsbuf_ent_return_last;
wire [(DMLEN - 1):0] vlsbuf_vd_byte_mask;
wire [(DLEN - 1):0] vlsbuf_vd_rdata;
wire [(DMLEN - 1):0] vlsbuf_vs3_byte_mask;
wire [(DLEN - 1):0] vlsbuf_vs3_rdata;
wire vlsu_buf_pending;
wire hr_req_seg_inst_last;
wire hr_vd_buf_ptr_dup_en;
wire [(BUF_DEPTH - 1):0] hr_vd_buf_ptr_dup_nx;
wire [(BUF_DEPTH - 1):0] hr_vd_mask_buf_ptr_dup_nx;
wire segbuf_packed_buf_clr;
wire segbuf_packed_buf_shift;
wire segbuf_packed_data_rlast;
wire segbuf_unpacked_data_wvalid;
wire [(SEG_DATA_WIDTH - 1):0] segbuf_unpacked_wdata;
wire [(11 - 1):0] unpacked_ctrl;
wire [(ELE_DLEN_WIDTH - 1):0] unpacked_element_num_dlen;
wire [3:0] unpacked_nf_cnt;
wire unpacked_req_en;
wire [(BUF_DEPTH_LOG2 - 1):0] unpacked_start_buf_num;
wire [(BUF_DEPTH - 1):0] unpacked_start_buf_ptr;
wire [(VRF_LW - 1):0] unpacked_vd_beats;
wire uop_req_grant;
wire ustride_seg_data_clr;
wire ustride_seg_data_done;
wire [(11 - 1):0] ustride_unpacked_ctrl;
wire ustride_unpacked_req;
wire [(BUF_DEPTH_LOG2 - 1):0] ustride_unpacked_start_buf_num;
wire [(VRF_LW - 1):0] ustride_unpacked_vd_beats;
wire [(BUF_DEPTH - 1):0] vlsbuf_return_sel;
wire [(BUF_DEPTH - 1):0] vlsbuf_useg_rptr;
wire [(DMLEN - 1):0] vlsbuf_vd_bwe;
wire [(BUF_DEPTH - 1):0] vlsbuf_vd_dlen_done;
wire [(DMLEN - 1):0] vlsbuf_vd_element_bwe;
wire [(BUF_DEPTH - 1):0] vlsbuf_vd_element_bwe_wsel;
wire [(DMLEN - 1):0] vlsbuf_vd_ualign_bwe;
wire [(DLEN - 1):0] vlsbuf_vd_ualign_wdata;
wire vlsbuf_vd_ualign_write_dlen_last;
wire [(BUF_DEPTH - 1):0] vlsbuf_vd_ualign_wsel;
wire [(DLEN - 1):0] vlsbuf_vd_wdata;
wire vlsbuf_vd_write_dlen_last;
wire [(BUF_DEPTH - 1):0] vlsbuf_vd_wsel;
wire [(BUF_DEPTH - 1):0] vlsbuf_vs3_rptr;
wire vlshr_block_cmd_hvm;
wire vlshr_block_cmd_nhvm;
wire vlshr_load_pending;
wire vlshr_store_pending;
wire vlshr_store_pending_hvm;
wire vlshr_store_pending_nhvm;
wire segbuf_packed_data_wready;
wire segbuf_packed_occupied;
wire [(DLEN - 1):0] segbuf_packed_rdata;
wire packed_resp_finish;
wire packing;
wire [(PACKED_MASK_WIDTH - 1):0] segbuf_packed_data_bwe;
wire segbuf_packed_data_kill;
wire segbuf_packed_data_wlast;
wire segbuf_packed_data_wvalid;
wire [(PACKED_DATA_WIDTH - 1):0] segbuf_packed_wdata;
wire [3:0] vlsbuf_packed_shift_eew_onehot;
wire [(BUF_DEPTH - 1):0] vlsbuf_packed_shift_sel;
wire segbuf_unpacked_data_rready;
wire segbuf_unpacked_data_wready;
wire [(SEG_DATA_WIDTH - 1):0] segbuf_unpacked_rdata;
wire segbuf_unpacked_data_rvalid;
wire unpacked_resp_finish;
wire [(DMLEN - 1):0] vlsbuf_unpacked_bwe;
wire [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_unpacked_data_all;
wire [(BUF_DEPTH - 1):0] vlsbuf_unpacked_wsel;
wire [BUF_DEPTH * BUF_INFO_DW - 1:0] buf_info_init_value;
wire [(BUF_DEPTH - 1):0] buf_info_init_wsel;
wire [(BUF_DEPTH_LOG2 - 1):0] uop_claim_buf_size;
wire uop_claim_buf_valid;
wire uop_req_align;
wire [1:0] uop_req_align_onehot_sel;
wire [(HR_OFFSET_WIDTH - 1):0] uop_req_align_value;
wire [(BEAT_CNT_WIDTH - 1):0] uop_req_beat_cnt;
wire [3:0] uop_req_beat_mask;
wire uop_req_buf_cross_revert;
wire [(BUF_DEPTH_LOG2 - 1):0] uop_req_buf_num;
wire uop_req_buf_opt;
wire [(BUF_DEPTH - 1):0] uop_req_buf_ptr;
wire [(BUF_DEPTH - 1):0] uop_req_buf_ptr_tl;
wire uop_req_bypass;
wire [(HR_MAX_BYTE_WIDTH - 1):0] uop_req_byte;
wire [(25 - 1):0] uop_req_ctrl;
wire uop_req_dlen_beat;
wire uop_req_ele_dlen_last;
wire uop_req_ele_seg_first;
wire uop_req_ele_seg_last;
wire [(ELE_DLEN_WIDTH - 1):0] uop_req_element_num_dlen;
wire uop_req_element_sel;
wire uop_req_eseg_hp;
wire uop_req_first;
wire uop_req_last;
wire [(HR_BYTE_WIDTH - 1):0] uop_req_mask_cnt;
wire [3:0] uop_req_nf_cnt;
wire [(PALEN - 1):0] uop_req_pa;
wire uop_req_putfull;
wire [(BUF_DEPTH - 1):0] uop_req_seg_buf_ptr;
wire [2:0] uop_req_size;
wire uop_req_skip;
wire [3:0] uop_req_st_beat_mask;
wire uop_req_ucross;
wire uop_req_uextra;
wire [(HR_OFFSET_WIDTH - 1):0] uop_req_umask_offset;
wire uop_req_ustride_mutation;
wire uop_req_valid;
wire [(VRF_LW - 1):0] uop_req_vd_beats;
wire [(VRF_LW - 1):0] uop_req_vd_buf_beats;
wire [(VRF_LW - 1):0] uop_req_vd_emul_len;
wire [(VRF_LW - 1):0] uop_req_vd_seg_beats;
wire uopq_block_cmd;
wire uopq_load_pending;
wire uopq_store_pending;
wire [(BUF_DEPTH - 1):0] vlsbuf_uop_claim_sel;
wire vlsq2uop_cmt_grant;
wire vlsq_req_ready;
wire useg_occupied;
wire [(DLEN - 1):0] ustride_seg_rdata;
wire [(BUF_DEPTH * DLEN) - 1:0] vlsbuf_ustride_unpacked_data_all;
wire [(BUF_DEPTH - 1):0] vlsbuf_ustride_unpacked_wsel;
wire [(DLEN - 1):0] vlsq_req_vs2_addr;
wire vlsq_req_vs2_rready;
wire vs2q_not_full;
wire claim_buf_reset;
wire [BUF_DEPTH * BUF_UCNT_WIDTH - 1:0] claim_vbuf_cnt;
wire [(BUF_DEPTH_LOG2 - 1):0] claim_vbuf_size;
wire claim_vbuf_valid;
wire [(11 - 1):0] packed_ctrl;
wire packed_req_en;
wire packed_req_kill;
wire [(BUF_DEPTH - 1):0] packed_start_buf_ptr;
wire [(VRF_LW - 1):0] packed_vd_beats;
wire [(ELE_CNT_WIDTH - 1):0] packed_vl_minus1;
wire [(BUF_DEPTH - 1):0] vlsbuf_kill_sel;
wire [(DLEN - 1):0] vlsbuf_vs3_wdata;
wire [(BUF_DEPTH - 1):0] vlsbuf_vs3_wsel;
wire [(DMLEN - 1):0] vlsq2buf_byte_mask;
wire [(BUF_DEPTH - 1):0] vlsq2buf_byte_mask_wptr;
wire vlsq2buf_req_valid;
wire vlsq2uop_cmt_buf_valid;
wire vlsq2uop_cmt_kill;
wire [(BUF_DEPTH_LOG2 - 1):0] vlsq2uop_cmt_start_buf_num;
wire vlsq2uop_cmt_valid;
wire vlsq2vtlb_cmt_kill;
wire vlsq2vtlb_cmt_valid;
wire [(VALEN - 1):0] vlsq2vtlb_req_va;
wire vlsq2vtlb_req_va2pa_en;
wire vlsq2vtlb_req_valid;
wire vlsq_block_cmd;
wire vlsq_load_pending;
wire vlsq_req_alive;
wire [11:0] vlsq_req_base_offset;
wire [(MAX_BYTE_WIDTH - 1):0] vlsq_req_byte;
wire vlsq_req_cross_4k;
wire vlsq_req_cross_4k_d1;
wire vlsq_req_cross_4k_d1_kill;
wire [(28 - 1):0] vlsq_req_ctrl;
wire vlsq_req_dlen_last;
wire [(ELE_DLEN_WIDTH - 1):0] vlsq_req_element_num_dlen;
wire vlsq_req_first;
wire vlsq_req_hvm;
wire vlsq_req_last;
wire [3:0] vlsq_req_mtype;
wire [(PALEN - 1):0] vlsq_req_pa;
wire vlsq_req_prestart_cross;
wire vlsq_req_shareable;
wire [(MAX_BYTE_WIDTH - 1):0] vlsq_req_total_byte;
wire vlsq_req_valid;
wire [(VRF_LW - 1):0] vlsq_req_vd_beats;
wire [(VRF_LW - 1):0] vlsq_req_vd_emul_len;
wire [(VRF_LW - 1):0] vlsq_req_vd_seg_beats;
wire vlsq_req_vs2_dlen_last;
wire vlsq_req_vs2_kill;
wire [(VS2Q_DEPTH - 1):0] vlsq_req_vs2_ptr;
wire vlsq_req_vs2_shift_valid;
wire [1:0] vlsq_req_vs2_shift_value;
wire [(MAX_BYTE_WIDTH - 1):0] vlsq_req_vstart_byte;
wire vlsq_req_widen_alive;
wire vlsq_store_pending;
wire vlsq_vs2_accept;
wire vlsq_vs2_dummy_rready;
wire vlsq2vtlb_req_ready;
wire [(35 - 1):0] vlsq2vtlb_resp_data;
wire [(PPN_WIDTH - 1):0] vlsq2vtlb_resp_ppn;
assign vlsu_load_pending = vlsq_load_pending | uopq_load_pending | vlshr_load_pending;
assign vlsu_store_pending_clk = vlsq_store_pending | uopq_store_pending | vlshr_store_pending;
assign vlsu_store_pending = vlsq_store_pending | uopq_store_pending | vlshr_store_pending_hvm | vlshr_store_pending_nhvm;
assign vpu_loadstore_pending = vlsu_load_pending | vlsu_store_pending;
assign vpu_block_pending = vlsq_block_cmd | uopq_block_cmd | vlshr_block_cmd_hvm | vlshr_block_cmd_nhvm | vlsu_store_pending;
assign vpu_vlsu_pending = vlsu_load_pending | vlsu_store_pending_clk | vlsu_buf_pending;
kv_vlsq #(
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .BUF_UCNT_WIDTH(BUF_UCNT_WIDTH),
    .DLEN(DLEN),
    .DLM_BASE(DLM_BASE),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .DMLEN(DMLEN),
    .ELEN(ELEN),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .EXTVALEN(EXTVALEN),
    .HR_OFFSET_WIDTH(HR_OFFSET_WIDTH),
    .HVM_BASE(HVM_BASE),
    .HVM_SIZE_KB(HVM_SIZE_KB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .MAX_BYTE_WIDTH(MAX_BYTE_WIDTH),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .SEG_PRESYNC(SEG_PRESYNC),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .VALEN(VALEN),
    .VLEN(VLEN),
    .VLSQ_DEPTH(VLSQ_DEPTH),
    .VRF_LW(VRF_LW),
    .VS2Q_DEPTH_LOG2(VS2Q_DEPTH_LOG2),
    .XLEN(XLEN)
) u_vlsq (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vlsq_load_pending(vlsq_load_pending),
    .vlsq_store_pending(vlsq_store_pending),
    .vlsq_block_cmd(vlsq_block_cmd),
    .vlsu_dispatch_valid(vlsu_dispatch_valid),
    .vlsu_dispatch_ready(vlsu_dispatch_ready),
    .vlsu_dispatch_ctrl(vlsu_dispatch_ctrl),
    .vlsu_dispatch_op1(vlsu_dispatch_op1),
    .vlsu_dispatch_op2(vlsu_dispatch_op2),
    .vlsu_dispatch_v0t(vlsu_dispatch_v0t),
    .vlsu_dispatch_vs2_len(vlsu_dispatch_vs2_len),
    .vlsu_dispatch_vs3_len(vlsu_dispatch_vs3_len),
    .vlsu_dispatch_vd_len(vlsu_dispatch_vd_len),
    .vlsu_vs3_rvalid(vlsu_vs3_rvalid),
    .vlsu_vs3_rdata(vlsu_vs3_rdata),
    .vlsu_vs3_rlast(vlsu_vs3_rlast),
    .vlsu_vs3_rready(vlsu_vs3_rready),
    .vlsu_cmt_valid(vlsu_cmt_valid),
    .vlsu_cmt_kill(vlsu_cmt_kill),
    .vlsu_ack_valid(vlsu_ack_valid),
    .vlsu_ack_status(vlsu_ack_status),
    .vlsu_ack_tval(vlsu_ack_tval),
    .vlsu_ack_element(vlsu_ack_element),
    .vlsq_req_valid(vlsq_req_valid),
    .vlsq_req_ready(vlsq_req_ready),
    .vlsq_req_first(vlsq_req_first),
    .vlsq_req_last(vlsq_req_last),
    .vlsq_req_ctrl(vlsq_req_ctrl),
    .vlsq_req_vd_emul_len(vlsq_req_vd_emul_len),
    .vlsq_req_vd_beats(vlsq_req_vd_beats),
    .vlsq_req_vd_seg_beats(vlsq_req_vd_seg_beats),
    .vlsq_req_byte(vlsq_req_byte),
    .vlsq_req_total_byte(vlsq_req_total_byte),
    .vlsq_req_element_num_dlen(vlsq_req_element_num_dlen),
    .vlsq_req_alive(vlsq_req_alive),
    .vlsq_req_widen_alive(vlsq_req_widen_alive),
    .vlsq_req_dlen_last(vlsq_req_dlen_last),
    .vlsq_req_pa(vlsq_req_pa),
    .vlsq_req_base_offset(vlsq_req_base_offset),
    .vlsq_req_vstart_byte(vlsq_req_vstart_byte),
    .vlsq_req_prestart_cross(vlsq_req_prestart_cross),
    .vlsq_req_mtype(vlsq_req_mtype),
    .vlsq_req_shareable(vlsq_req_shareable),
    .vlsq_req_hvm(vlsq_req_hvm),
    .vlsq2uop_cmt_valid(vlsq2uop_cmt_valid),
    .vlsq2uop_cmt_grant(vlsq2uop_cmt_grant),
    .vlsq2uop_cmt_buf_valid(vlsq2uop_cmt_buf_valid),
    .vlsq2uop_cmt_kill(vlsq2uop_cmt_kill),
    .vlsq2uop_cmt_start_buf_num(vlsq2uop_cmt_start_buf_num),
    .vlsq_req_cross_4k(vlsq_req_cross_4k),
    .vlsq_req_cross_4k_d1(vlsq_req_cross_4k_d1),
    .vlsq_req_cross_4k_d1_kill(vlsq_req_cross_4k_d1_kill),
    .vlsq_vs2_accept(vlsq_vs2_accept),
    .vs2q_not_full(vs2q_not_full),
    .vlsq_vs2_dummy_rready(vlsq_vs2_dummy_rready),
    .vlsq_req_vs2_rready(vlsq_req_vs2_rready),
    .vlsq_req_vs2_addr(vlsq_req_vs2_addr),
    .vlsq_req_vs2_kill(vlsq_req_vs2_kill),
    .vlsq_req_vs2_dlen_last(vlsq_req_vs2_dlen_last),
    .vlsq_req_vs2_ptr(vlsq_req_vs2_ptr),
    .vlsq_req_vs2_shift_valid(vlsq_req_vs2_shift_valid),
    .vlsq_req_vs2_shift_value(vlsq_req_vs2_shift_value),
    .vlsu_vs2_rvalid(vlsu_vs2_rvalid),
    .vlsu_vs2_rready(vlsu_vs2_rready),
    .vlsu_vs2_rlast(vlsu_vs2_rlast),
    .claim_vbuf_valid(claim_vbuf_valid),
    .claim_vbuf_size(claim_vbuf_size),
    .claim_vbuf_cnt(claim_vbuf_cnt),
    .claim_vbuf_ready(claim_vbuf_ready),
    .claim_buf_reset(claim_buf_reset),
    .claim_buf_resp_num(claim_buf_resp_num),
    .claim_buf_resp_ptr(claim_buf_resp_ptr),
    .vlsbuf_vs3_wsel(vlsbuf_vs3_wsel),
    .vlsbuf_vs3_wdata(vlsbuf_vs3_wdata),
    .vlsbuf_ent_occupied(vlsbuf_ent_occupied),
    .packed_req_en(packed_req_en),
    .packed_req_kill(packed_req_kill),
    .packed_resp_finish(packed_resp_finish),
    .packed_vd_beats(packed_vd_beats),
    .packed_ctrl(packed_ctrl),
    .packed_vl_minus1(packed_vl_minus1),
    .packed_start_buf_ptr(packed_start_buf_ptr),
    .vlsbuf_kill_sel(vlsbuf_kill_sel),
    .vlsbuf_ent_mask_ready(vlsbuf_ent_mask_ready),
    .vlsq2buf_req_valid(vlsq2buf_req_valid),
    .vlsq2buf_byte_mask_wptr(vlsq2buf_byte_mask_wptr),
    .vlsq2buf_byte_mask(vlsq2buf_byte_mask),
    .vlsq2vtlb_req_valid(vlsq2vtlb_req_valid),
    .vlsq2vtlb_req_ready(vlsq2vtlb_req_ready),
    .vlsq2vtlb_req_va(vlsq2vtlb_req_va),
    .vlsq2vtlb_req_va2pa_en(vlsq2vtlb_req_va2pa_en),
    .vlsq2vtlb_cmt_valid(vlsq2vtlb_cmt_valid),
    .vlsq2vtlb_cmt_kill(vlsq2vtlb_cmt_kill),
    .vlsq2vtlb_resp_ppn(vlsq2vtlb_resp_ppn),
    .vlsq2vtlb_resp_data(vlsq2vtlb_resp_data)
);
kv_vls_packed_ctrl #(
    .BUF_DEPTH(BUF_DEPTH),
    .DLEN(DLEN),
    .DLEN_BYTE_WIDTH(DLEN_BYTE_WIDTH),
    .DMLEN(DMLEN),
    .ELEN(ELEN),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .NF_BYTE_WIDTH(NF_BYTE_WIDTH),
    .PACKED_DATA_WIDTH(PACKED_DATA_WIDTH),
    .PACKED_MASK_WIDTH(PACKED_MASK_WIDTH),
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .SEG_MASK_WIDTH(SEG_MASK_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW)
) u_vls_packed_ctrl (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .packed_req_en(packed_req_en),
    .packed_req_kill(packed_req_kill),
    .packed_resp_finish(packed_resp_finish),
    .packed_vd_beats(packed_vd_beats),
    .packed_ctrl(packed_ctrl),
    .packed_vl_minus1(packed_vl_minus1),
    .packed_start_buf_ptr(packed_start_buf_ptr),
    .vlsbuf_data_all(vlsbuf_data_all),
    .vlsbuf_packed_shift_sel(vlsbuf_packed_shift_sel),
    .vlsbuf_packed_shift_eew_onehot(vlsbuf_packed_shift_eew_onehot),
    .segbuf_packed_data_wvalid(segbuf_packed_data_wvalid),
    .segbuf_packed_data_wready(segbuf_packed_data_wready),
    .segbuf_packed_data_wlast(segbuf_packed_data_wlast),
    .segbuf_packed_data_kill(segbuf_packed_data_kill),
    .segbuf_packed_wdata(segbuf_packed_wdata),
    .segbuf_packed_data_bwe(segbuf_packed_data_bwe),
    .hr_req_seg_inst_last(hr_req_seg_inst_last),
    .packing(packing)
);
kv_vls_packed_buf #(
    .DLEN(DLEN),
    .PACKED_DATA_WIDTH(PACKED_DATA_WIDTH),
    .PACKED_MASK_WIDTH(PACKED_MASK_WIDTH),
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .SEG_MASK_WIDTH(SEG_MASK_WIDTH)
) u_vls_packed_buf (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .segbuf_packed_data_wvalid(segbuf_packed_data_wvalid),
    .segbuf_packed_data_wready(segbuf_packed_data_wready),
    .segbuf_packed_data_wlast(segbuf_packed_data_wlast),
    .segbuf_packed_data_kill(segbuf_packed_data_kill),
    .segbuf_packed_wdata(segbuf_packed_wdata),
    .segbuf_packed_data_bwe(segbuf_packed_data_bwe),
    .segbuf_packed_buf_clr(segbuf_packed_buf_clr),
    .segbuf_packed_buf_shift(segbuf_packed_buf_shift),
    .segbuf_packed_data_rlast(segbuf_packed_data_rlast),
    .segbuf_packed_occupied(segbuf_packed_occupied),
    .segbuf_packed_rdata(segbuf_packed_rdata)
);
kv_vls_unpacked_ctrl #(
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .DLEN(DLEN),
    .DMLEN(DMLEN),
    .ELEN(ELEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW)
) u_vls_unpacked_ctrl (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .unpacked_req_en(unpacked_req_en),
    .unpacked_resp_finish(unpacked_resp_finish),
    .unpacked_vd_beats(unpacked_vd_beats),
    .unpacked_ctrl(unpacked_ctrl),
    .unpacked_nf_cnt(unpacked_nf_cnt),
    .unpacked_element_num_dlen(unpacked_element_num_dlen),
    .unpacked_start_buf_num(unpacked_start_buf_num),
    .unpacked_start_buf_ptr(unpacked_start_buf_ptr),
    .segbuf_unpacked_data_rvalid(segbuf_unpacked_data_rvalid),
    .segbuf_unpacked_data_rready(segbuf_unpacked_data_rready),
    .segbuf_unpacked_rdata(segbuf_unpacked_rdata),
    .vlsbuf_unpacked_wsel(vlsbuf_unpacked_wsel),
    .vlsbuf_unpacked_data_all(vlsbuf_unpacked_data_all),
    .vlsbuf_unpacked_bwe(vlsbuf_unpacked_bwe)
);
kv_vls_unpacked_buf #(
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .SEG_MASK_WIDTH(SEG_MASK_WIDTH)
) u_vls_unpacked_buf (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .segbuf_unpacked_data_wvalid(segbuf_unpacked_data_wvalid),
    .segbuf_unpacked_data_wready(segbuf_unpacked_data_wready),
    .segbuf_unpacked_wdata(segbuf_unpacked_wdata),
    .segbuf_unpacked_data_rvalid(segbuf_unpacked_data_rvalid),
    .segbuf_unpacked_data_rready(segbuf_unpacked_data_rready),
    .segbuf_unpacked_rdata(segbuf_unpacked_rdata)
);
kv_vls_ustride_unpacked #(
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .DLEN(DLEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW)
) u_vls_ustride_unpacked (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .ustride_unpacked_req(ustride_unpacked_req),
    .ustride_unpacked_vd_beats(ustride_unpacked_vd_beats),
    .ustride_unpacked_ctrl(ustride_unpacked_ctrl),
    .ustride_unpacked_start_buf_num(ustride_unpacked_start_buf_num),
    .ustride_seg_rdata(ustride_seg_rdata),
    .ustride_seg_data_clr(ustride_seg_data_clr),
    .ustride_seg_data_done(ustride_seg_data_done),
    .vlsbuf_useg_rptr(vlsbuf_useg_rptr),
    .useg_occupied(useg_occupied),
    .vlsbuf_data_all(vlsbuf_data_all),
    .vlsbuf_ustride_unpacked_wsel(vlsbuf_ustride_unpacked_wsel),
    .vlsbuf_ustride_unpacked_data_all(vlsbuf_ustride_unpacked_data_all)
);
kv_vls_vs2q #(
    .DLEN(DLEN),
    .VS2Q_DEPTH(VS2Q_DEPTH)
) u_vls_vs2q (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vlsu_vs2_rdata(vlsu_vs2_rdata),
    .vlsu_vs2_rvalid(vlsu_vs2_rvalid),
    .vlsq_req_vs2_rready(vlsq_req_vs2_rready),
    .vlsq_req_vs2_addr(vlsq_req_vs2_addr),
    .vlsq_vs2_accept(vlsq_vs2_accept),
    .vs2q_not_full(vs2q_not_full),
    .vlsq_vs2_dummy_rready(vlsq_vs2_dummy_rready),
    .vlsq_req_vs2_kill(vlsq_req_vs2_kill),
    .vlsq_req_vs2_dlen_last(vlsq_req_vs2_dlen_last),
    .vlsq_req_vs2_ptr(vlsq_req_vs2_ptr),
    .vlsq_req_vs2_shift_valid(vlsq_req_vs2_shift_valid),
    .vlsq_req_vs2_shift_value(vlsq_req_vs2_shift_value)
);
kv_vls_uop #(
    .BEAT_CNT_WIDTH(BEAT_CNT_WIDTH),
    .BIU_BASE_WIDTH(BIU_BASE_WIDTH),
    .BIU_BYTE_WIDTH(BIU_BYTE_WIDTH),
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BIU_OFFSET_WIDTH(BIU_OFFSET_WIDTH),
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .BUF_INFO_DW(BUF_INFO_DW),
    .CL_BASE_WIDTH(CL_BASE_WIDTH),
    .CL_BYTE_WIDTH(CL_BYTE_WIDTH),
    .CL_OFFSET_WIDTH(CL_OFFSET_WIDTH),
    .DLEN(DLEN),
    .DLEN_BYTE_WIDTH(DLEN_BYTE_WIDTH),
    .DMLEN(DMLEN),
    .ELEN(ELEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .HR_BYTE_WIDTH(HR_BYTE_WIDTH),
    .HR_MAX_BYTE_WIDTH(HR_MAX_BYTE_WIDTH),
    .HR_OFFSET_WIDTH(HR_OFFSET_WIDTH),
    .HVM_BASE_WIDTH(HVM_BASE_WIDTH),
    .HVM_BYTE_WIDTH(HVM_BYTE_WIDTH),
    .HVM_DATA_WIDTH(HVM_DATA_WIDTH),
    .HVM_OFFSET_WIDTH(HVM_OFFSET_WIDTH),
    .MAX_BYTE_WIDTH(MAX_BYTE_WIDTH),
    .NF_BYTE_WIDTH(NF_BYTE_WIDTH),
    .PALEN(PALEN),
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .UOPQ_DEPTH(UOPQ_DEPTH),
    .VALEN(VALEN),
    .VLEN(VLEN),
    .VLSU_SUPPORT_HVM(VLSU_SUPPORT_HVM),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vls_uop (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .uopq_load_pending(uopq_load_pending),
    .uopq_store_pending(uopq_store_pending),
    .uopq_block_cmd(uopq_block_cmd),
    .vlsq_req_valid(vlsq_req_valid),
    .vlsq_req_ready(vlsq_req_ready),
    .vlsq_req_first(vlsq_req_first),
    .vlsq_req_last(vlsq_req_last),
    .vlsq_req_pa(vlsq_req_pa),
    .vlsq_req_base_offset(vlsq_req_base_offset),
    .vlsq_req_vstart_byte(vlsq_req_vstart_byte),
    .vlsq_req_prestart_cross(vlsq_req_prestart_cross),
    .vlsq_req_mtype(vlsq_req_mtype),
    .vlsq_req_shareable(vlsq_req_shareable),
    .vlsq_req_hvm(vlsq_req_hvm),
    .vlsq_req_ctrl(vlsq_req_ctrl),
    .vlsq_req_vd_emul_len(vlsq_req_vd_emul_len),
    .vlsq_req_vd_beats(vlsq_req_vd_beats),
    .vlsq_req_vd_seg_beats(vlsq_req_vd_seg_beats),
    .vlsq_req_byte(vlsq_req_byte),
    .vlsq_req_total_byte(vlsq_req_total_byte),
    .vlsq_req_element_num_dlen(vlsq_req_element_num_dlen),
    .vlsq_req_alive(vlsq_req_alive),
    .vlsq_req_widen_alive(vlsq_req_widen_alive),
    .vlsq_req_dlen_last(vlsq_req_dlen_last),
    .vlsq_req_cross_4k(vlsq_req_cross_4k),
    .vlsq_req_cross_4k_d1(vlsq_req_cross_4k_d1),
    .vlsq_req_cross_4k_d1_kill(vlsq_req_cross_4k_d1_kill),
    .vlsq2uop_cmt_valid(vlsq2uop_cmt_valid),
    .vlsq2uop_cmt_grant(vlsq2uop_cmt_grant),
    .vlsq2uop_cmt_kill(vlsq2uop_cmt_kill),
    .vlsq2uop_cmt_buf_valid(vlsq2uop_cmt_buf_valid),
    .vlsq2uop_cmt_start_buf_num(vlsq2uop_cmt_start_buf_num),
    .uop_req_valid(uop_req_valid),
    .uop_req_grant(uop_req_grant),
    .uop_req_pa(uop_req_pa),
    .uop_req_ctrl(uop_req_ctrl),
    .uop_req_vd_emul_len(uop_req_vd_emul_len),
    .uop_req_vd_beats(uop_req_vd_beats),
    .uop_req_vd_seg_beats(uop_req_vd_seg_beats),
    .uop_req_vd_buf_beats(uop_req_vd_buf_beats),
    .uop_req_size(uop_req_size),
    .uop_req_putfull(uop_req_putfull),
    .uop_req_beat_cnt(uop_req_beat_cnt),
    .uop_req_buf_opt(uop_req_buf_opt),
    .uop_req_buf_cross_revert(uop_req_buf_cross_revert),
    .uop_req_buf_num(uop_req_buf_num),
    .uop_req_buf_ptr(uop_req_buf_ptr),
    .uop_req_element_num_dlen(uop_req_element_num_dlen),
    .uop_req_mask_cnt(uop_req_mask_cnt),
    .uop_req_byte(uop_req_byte),
    .uop_req_nf_cnt(uop_req_nf_cnt),
    .uop_req_first(uop_req_first),
    .uop_req_last(uop_req_last),
    .uop_req_ele_dlen_last(uop_req_ele_dlen_last),
    .uop_req_ele_seg_first(uop_req_ele_seg_first),
    .uop_req_ele_seg_last(uop_req_ele_seg_last),
    .uop_req_skip(uop_req_skip),
    .uop_req_dlen_beat(uop_req_dlen_beat),
    .uop_req_align(uop_req_align),
    .uop_req_bypass(uop_req_bypass),
    .uop_req_seg_buf_ptr(uop_req_seg_buf_ptr),
    .uop_req_buf_ptr_tl(uop_req_buf_ptr_tl),
    .uop_req_ucross(uop_req_ucross),
    .uop_req_uextra(uop_req_uextra),
    .uop_req_element_sel(uop_req_element_sel),
    .uop_req_align_value(uop_req_align_value),
    .uop_req_umask_offset(uop_req_umask_offset),
    .uop_req_align_onehot_sel(uop_req_align_onehot_sel),
    .uop_req_beat_mask(uop_req_beat_mask),
    .uop_req_st_beat_mask(uop_req_st_beat_mask),
    .uop_req_eseg_hp(uop_req_eseg_hp),
    .uop_req_ustride_mutation(uop_req_ustride_mutation),
    .uop_claim_buf_valid(uop_claim_buf_valid),
    .uop_claim_buf_size(uop_claim_buf_size),
    .uop_claim_buf_grant(uop_claim_buf_grant),
    .uop_claim_buf_resp_num(uop_claim_buf_resp_num),
    .vlsbuf_uop_claim_sel(vlsbuf_uop_claim_sel),
    .buf_info_init_wsel(buf_info_init_wsel),
    .buf_info_init_value(buf_info_init_value)
);
kv_vls_hr #(
    .BEAT_CNT_WIDTH(BEAT_CNT_WIDTH),
    .BIU_BASE_WIDTH(BIU_BASE_WIDTH),
    .BIU_BYTE_WIDTH(BIU_BYTE_WIDTH),
    .BIU_DATA_WIDTH(BIU_DATA_WIDTH),
    .BIU_MASK_WIDTH(BIU_MASK_WIDTH),
    .BIU_OFFSET_WIDTH(BIU_OFFSET_WIDTH),
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .BUF_INFO_DW(BUF_INFO_DW),
    .CL_BASE_WIDTH(CL_BASE_WIDTH),
    .CL_BYTE_WIDTH(CL_BYTE_WIDTH),
    .CL_OFFSET_WIDTH(CL_OFFSET_WIDTH),
    .DLEN(DLEN),
    .DLEN_BYTE_WIDTH(DLEN_BYTE_WIDTH),
    .DMLEN(DMLEN),
    .ELEN(ELEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .HR_BASE_WIDTH(HR_BASE_WIDTH),
    .HR_BYTE_WIDTH(HR_BYTE_WIDTH),
    .HR_DATA_WIDTH(HR_DATA_WIDTH),
    .HR_DEPTH(HR_DEPTH),
    .HR_DEPTH_LOG2(HR_DEPTH_LOG2),
    .HR_MASK_WIDTH(HR_MASK_WIDTH),
    .HR_MAX_BYTE_WIDTH(HR_MAX_BYTE_WIDTH),
    .HR_OFFSET_WIDTH(HR_OFFSET_WIDTH),
    .HR_SOURCE_WIDTH(HR_SOURCE_WIDTH),
    .HVM_ADDR_WIDTH(HVM_ADDR_WIDTH),
    .HVM_BASE_WIDTH(HVM_BASE_WIDTH),
    .HVM_DATA_WIDTH(HVM_DATA_WIDTH),
    .HVM_MASK_WIDTH(HVM_MASK_WIDTH),
    .HVM_OFFSET_WIDTH(HVM_OFFSET_WIDTH),
    .IFIFO_DEPTH(IFIFO_DEPTH),
    .L2_SOURCE_WIDTH(L2_SOURCE_WIDTH),
    .NF_BYTE_WIDTH(NF_BYTE_WIDTH),
    .PALEN(PALEN),
    .SEG_DATA_WIDTH(SEG_DATA_WIDTH),
    .SEG_MASK_WIDTH(SEG_MASK_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .VLEN(VLEN),
    .VLSU_ADDR_WIDTH(VLSU_ADDR_WIDTH),
    .VLSU_BYPASS_EN(VLSU_BYPASS_EN),
    .VLSU_SUPPORT_HVM(VLSU_SUPPORT_HVM),
    .VRF_LW(VRF_LW)
) u_vls_hr (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vlshr_load_pending(vlshr_load_pending),
    .vlshr_store_pending(vlshr_store_pending),
    .vlshr_store_pending_hvm(vlshr_store_pending_hvm),
    .vlshr_store_pending_nhvm(vlshr_store_pending_nhvm),
    .vlshr_block_cmd_hvm(vlshr_block_cmd_hvm),
    .vlshr_block_cmd_nhvm(vlshr_block_cmd_nhvm),
    .vlsu_hr_events(vlsu_hr_events),
    .uop_req_valid(uop_req_valid),
    .uop_req_grant(uop_req_grant),
    .uop_req_pa(uop_req_pa),
    .uop_req_ctrl(uop_req_ctrl),
    .uop_req_vd_emul_len(uop_req_vd_emul_len),
    .uop_req_vd_beats(uop_req_vd_beats),
    .uop_req_vd_seg_beats(uop_req_vd_seg_beats),
    .uop_req_vd_buf_beats(uop_req_vd_buf_beats),
    .uop_req_size(uop_req_size),
    .uop_req_beat_cnt(uop_req_beat_cnt),
    .uop_req_buf_opt(uop_req_buf_opt),
    .uop_req_buf_cross_revert(uop_req_buf_cross_revert),
    .uop_req_buf_num(uop_req_buf_num),
    .uop_req_buf_ptr(uop_req_buf_ptr),
    .uop_req_seg_buf_ptr(uop_req_seg_buf_ptr),
    .uop_req_buf_ptr_tl(uop_req_buf_ptr_tl),
    .uop_req_element_num_dlen(uop_req_element_num_dlen),
    .uop_req_first(uop_req_first),
    .uop_req_last(uop_req_last),
    .uop_req_skip(uop_req_skip),
    .uop_req_putfull(uop_req_putfull),
    .uop_req_ele_dlen_last(uop_req_ele_dlen_last),
    .uop_req_ele_seg_first(uop_req_ele_seg_first),
    .uop_req_ele_seg_last(uop_req_ele_seg_last),
    .uop_req_dlen_beat(uop_req_dlen_beat),
    .uop_req_align(uop_req_align),
    .uop_req_bypass(uop_req_bypass),
    .uop_req_ucross(uop_req_ucross),
    .uop_req_uextra(uop_req_uextra),
    .uop_req_mask_cnt(uop_req_mask_cnt),
    .uop_req_byte(uop_req_byte),
    .uop_req_nf_cnt(uop_req_nf_cnt),
    .uop_req_element_sel(uop_req_element_sel),
    .uop_req_align_value(uop_req_align_value),
    .uop_req_umask_offset(uop_req_umask_offset),
    .uop_req_align_onehot_sel(uop_req_align_onehot_sel),
    .uop_req_beat_mask(uop_req_beat_mask),
    .uop_req_st_beat_mask(uop_req_st_beat_mask),
    .uop_req_eseg_hp(uop_req_eseg_hp),
    .uop_req_ustride_mutation(uop_req_ustride_mutation),
    .buf_info_init_wsel(buf_info_init_wsel),
    .buf_info_init_value(buf_info_init_value),
    .vlsu_cm_a_address(vlsu_cm_a_address),
    .vlsu_cm_a_corrupt(vlsu_cm_a_corrupt),
    .vlsu_cm_a_data(vlsu_cm_a_data),
    .vlsu_cm_a_mask(vlsu_cm_a_mask),
    .vlsu_cm_a_opcode(vlsu_cm_a_opcode),
    .vlsu_cm_a_param(vlsu_cm_a_param),
    .vlsu_cm_a_ready(vlsu_cm_a_ready),
    .vlsu_cm_a_size(vlsu_cm_a_size),
    .vlsu_cm_a_source(vlsu_cm_a_source),
    .vlsu_cm_a_user(vlsu_cm_a_user),
    .vlsu_cm_a_shareable(vlsu_cm_a_shareable),
    .vlsu_cm_a_valid(vlsu_cm_a_valid),
    .vlsu_nc_a_address(vlsu_nc_a_address),
    .vlsu_nc_a_corrupt(vlsu_nc_a_corrupt),
    .vlsu_nc_a_data(vlsu_nc_a_data),
    .vlsu_nc_a_mask(vlsu_nc_a_mask),
    .vlsu_nc_a_opcode(vlsu_nc_a_opcode),
    .vlsu_nc_a_param(vlsu_nc_a_param),
    .vlsu_nc_a_ready(vlsu_nc_a_ready),
    .vlsu_nc_a_size(vlsu_nc_a_size),
    .vlsu_nc_a_source(vlsu_nc_a_source),
    .vlsu_nc_a_user(vlsu_nc_a_user),
    .vlsu_nc_a_valid(vlsu_nc_a_valid),
    .vlsu_vm_a_address(vlsu_vm_a_address),
    .vlsu_vm_a_data(vlsu_vm_a_data),
    .vlsu_vm_a_mask(vlsu_vm_a_mask),
    .vlsu_vm_a_opcode(vlsu_vm_a_opcode),
    .vlsu_vm_a_ready(vlsu_vm_a_ready),
    .vlsu_vm_a_size(vlsu_vm_a_size),
    .vlsu_vm_a_valid(vlsu_vm_a_valid),
    .vlsu_cm_d_cause(vlsu_cm_d_cause),
    .vlsu_cm_d_corrupt(vlsu_cm_d_corrupt),
    .vlsu_cm_d_data(vlsu_cm_d_data),
    .vlsu_cm_d_denied(vlsu_cm_d_denied),
    .vlsu_cm_d_opcode(vlsu_cm_d_opcode),
    .vlsu_cm_d_param(vlsu_cm_d_param),
    .vlsu_cm_d_ready(vlsu_cm_d_ready),
    .vlsu_cm_d_sink(vlsu_cm_d_sink),
    .vlsu_cm_d_size(vlsu_cm_d_size),
    .vlsu_cm_d_source(vlsu_cm_d_source),
    .vlsu_cm_d_user(vlsu_cm_d_user),
    .vlsu_cm_d_valid(vlsu_cm_d_valid),
    .vlsu_nc_d_corrupt(vlsu_nc_d_corrupt),
    .vlsu_nc_d_data(vlsu_nc_d_data),
    .vlsu_nc_d_denied(vlsu_nc_d_denied),
    .vlsu_nc_d_opcode(vlsu_nc_d_opcode),
    .vlsu_nc_d_param(vlsu_nc_d_param),
    .vlsu_nc_d_ready(vlsu_nc_d_ready),
    .vlsu_nc_d_sink(vlsu_nc_d_sink),
    .vlsu_nc_d_size(vlsu_nc_d_size),
    .vlsu_nc_d_source(vlsu_nc_d_source),
    .vlsu_nc_d_user(vlsu_nc_d_user),
    .vlsu_nc_d_valid(vlsu_nc_d_valid),
    .vlsu_vm_d_corrupt(vlsu_vm_d_corrupt),
    .vlsu_vm_d_data(vlsu_vm_d_data),
    .vlsu_vm_d_denied(vlsu_vm_d_denied),
    .vlsu_vm_d_opcode(vlsu_vm_d_opcode),
    .vlsu_vm_d_ready(vlsu_vm_d_ready),
    .vlsu_vm_d_size(vlsu_vm_d_size),
    .vlsu_vm_d_valid(vlsu_vm_d_valid),
    .vlsbuf_vs3_rptr(vlsbuf_vs3_rptr),
    .vlsbuf_vs3_rdata(vlsbuf_vs3_rdata),
    .vlsbuf_vs3_byte_mask(vlsbuf_vs3_byte_mask),
    .vlsbuf_vd_wsel(vlsbuf_vd_wsel),
    .vlsbuf_vd_write_dlen_last(vlsbuf_vd_write_dlen_last),
    .vlsbuf_vd_wdata(vlsbuf_vd_wdata),
    .vlsbuf_vd_bwe(vlsbuf_vd_bwe),
    .vlsbuf_vd_dlen_done(vlsbuf_vd_dlen_done),
    .vlsbuf_vd_ualign_wsel(vlsbuf_vd_ualign_wsel),
    .vlsbuf_vd_ualign_write_dlen_last(vlsbuf_vd_ualign_write_dlen_last),
    .vlsbuf_vd_ualign_wdata(vlsbuf_vd_ualign_wdata),
    .vlsbuf_vd_ualign_bwe(vlsbuf_vd_ualign_bwe),
    .vlsbuf_vd_rdata(vlsbuf_vd_rdata),
    .vlsbuf_vd_byte_mask(vlsbuf_vd_byte_mask),
    .vlsbuf_ent_occupied(vlsbuf_ent_occupied),
    .vlsbuf_ent_mask_ready(vlsbuf_ent_mask_ready),
    .vlsbuf_ent_mask_ready_nx(vlsbuf_ent_mask_ready_nx),
    .vlsbuf_ent_return_last(vlsbuf_ent_return_last),
    .vlsbuf_vd_element_bwe_wsel(vlsbuf_vd_element_bwe_wsel),
    .vlsbuf_vd_element_bwe(vlsbuf_vd_element_bwe),
    .vlsbuf_return_sel(vlsbuf_return_sel),
    .hr_vd_buf_ptr_dup_en(hr_vd_buf_ptr_dup_en),
    .hr_vd_buf_ptr_dup_nx(hr_vd_buf_ptr_dup_nx),
    .hr_vd_mask_buf_ptr_dup_nx(hr_vd_mask_buf_ptr_dup_nx),
    .unpacked_req_en(unpacked_req_en),
    .unpacked_resp_finish(unpacked_resp_finish),
    .unpacked_vd_beats(unpacked_vd_beats),
    .unpacked_ctrl(unpacked_ctrl),
    .unpacked_nf_cnt(unpacked_nf_cnt),
    .unpacked_element_num_dlen(unpacked_element_num_dlen),
    .unpacked_start_buf_num(unpacked_start_buf_num),
    .unpacked_start_buf_ptr(unpacked_start_buf_ptr),
    .segbuf_unpacked_data_wvalid(segbuf_unpacked_data_wvalid),
    .segbuf_unpacked_data_wready(segbuf_unpacked_data_wready),
    .segbuf_unpacked_wdata(segbuf_unpacked_wdata),
    .vlsbuf_unpacked_wsel(vlsbuf_unpacked_wsel),
    .ustride_unpacked_req(ustride_unpacked_req),
    .ustride_unpacked_vd_beats(ustride_unpacked_vd_beats),
    .ustride_unpacked_ctrl(ustride_unpacked_ctrl),
    .ustride_unpacked_start_buf_num(ustride_unpacked_start_buf_num),
    .vlsbuf_useg_rptr(vlsbuf_useg_rptr),
    .useg_occupied(useg_occupied),
    .ustride_seg_rdata(ustride_seg_rdata),
    .ustride_seg_data_clr(ustride_seg_data_clr),
    .ustride_seg_data_done(ustride_seg_data_done),
    .hr_req_seg_inst_last(hr_req_seg_inst_last),
    .packing(packing),
    .segbuf_packed_data_rlast(segbuf_packed_data_rlast),
    .segbuf_packed_buf_clr(segbuf_packed_buf_clr),
    .segbuf_packed_buf_shift(segbuf_packed_buf_shift),
    .segbuf_packed_occupied(segbuf_packed_occupied),
    .segbuf_packed_rdata(segbuf_packed_rdata),
    .vlsu_vd_wvalid(vlsu_vd_wvalid),
    .vlsu_vd_wready(vlsu_vd_wready),
    .vlsu_vd_wlast(vlsu_vd_wlast),
    .vlsu_vd_wdata(vlsu_vd_wdata),
    .vlsu_vd_wmask(vlsu_vd_wmask),
    .vpu_ls_async_read_error(vpu_ls_async_read_error),
    .vpu_ls_async_write_error(vpu_ls_async_write_error),
    .vpu_ls_async_ecc_error(vpu_ls_async_ecc_error),
    .vpu_ls_async_ecc_corr(vpu_ls_async_ecc_corr),
    .vpu_ls_async_ecc_ramid(vpu_ls_async_ecc_ramid),
    .vpu_ls_async_ecc_read(vpu_ls_async_ecc_read)
);
kv_vls_buf #(
    .BUF_DEPTH(BUF_DEPTH),
    .BUF_DEPTH_LOG2(BUF_DEPTH_LOG2),
    .BUF_UCNT_WIDTH(BUF_UCNT_WIDTH),
    .DLEN(DLEN),
    .DMLEN(DMLEN),
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .VLEN(VLEN)
) u_vls_buf (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vlsu_buf_pending(vlsu_buf_pending),
    .claim_vbuf_valid(claim_vbuf_valid),
    .claim_vbuf_size(claim_vbuf_size),
    .claim_vbuf_cnt(claim_vbuf_cnt),
    .claim_vbuf_ready(claim_vbuf_ready),
    .claim_buf_resp_num(claim_buf_resp_num),
    .claim_buf_resp_ptr(claim_buf_resp_ptr),
    .claim_buf_reset(claim_buf_reset),
    .uop_claim_buf_valid(uop_claim_buf_valid),
    .uop_claim_buf_size(uop_claim_buf_size),
    .uop_claim_buf_grant(uop_claim_buf_grant),
    .uop_claim_buf_resp_num(uop_claim_buf_resp_num),
    .vlsbuf_uop_claim_sel(vlsbuf_uop_claim_sel),
    .vlsbuf_return_sel(vlsbuf_return_sel),
    .vlsbuf_kill_sel(vlsbuf_kill_sel),
    .vlsbuf_vs3_wsel(vlsbuf_vs3_wsel),
    .vlsbuf_vs3_wdata(vlsbuf_vs3_wdata),
    .vlsbuf_vs3_rptr(vlsbuf_vs3_rptr),
    .vlsbuf_vs3_rdata(vlsbuf_vs3_rdata),
    .vlsbuf_vs3_byte_mask(vlsbuf_vs3_byte_mask),
    .vlsbuf_vd_wsel(vlsbuf_vd_wsel),
    .vlsbuf_vd_write_dlen_last(vlsbuf_vd_write_dlen_last),
    .vlsbuf_vd_wdata(vlsbuf_vd_wdata),
    .vlsbuf_vd_bwe(vlsbuf_vd_bwe),
    .vlsbuf_vd_dlen_done(vlsbuf_vd_dlen_done),
    .vlsbuf_vd_rdata(vlsbuf_vd_rdata),
    .vlsbuf_vd_byte_mask(vlsbuf_vd_byte_mask),
    .vlsbuf_vd_ualign_wsel(vlsbuf_vd_ualign_wsel),
    .vlsbuf_vd_ualign_write_dlen_last(vlsbuf_vd_ualign_write_dlen_last),
    .vlsbuf_vd_ualign_wdata(vlsbuf_vd_ualign_wdata),
    .vlsbuf_vd_ualign_bwe(vlsbuf_vd_ualign_bwe),
    .vlsbuf_vd_element_bwe_wsel(vlsbuf_vd_element_bwe_wsel),
    .vlsbuf_vd_element_bwe(vlsbuf_vd_element_bwe),
    .hr_vd_buf_ptr_dup_en(hr_vd_buf_ptr_dup_en),
    .hr_vd_buf_ptr_dup_nx(hr_vd_buf_ptr_dup_nx),
    .hr_vd_mask_buf_ptr_dup_nx(hr_vd_mask_buf_ptr_dup_nx),
    .vlsbuf_ent_occupied(vlsbuf_ent_occupied),
    .vlsbuf_ent_mask_ready(vlsbuf_ent_mask_ready),
    .vlsbuf_ent_mask_ready_nx(vlsbuf_ent_mask_ready_nx),
    .vlsbuf_ent_return_last(vlsbuf_ent_return_last),
    .vlsq2buf_req_valid(vlsq2buf_req_valid),
    .vlsq2buf_byte_mask_wptr(vlsq2buf_byte_mask_wptr),
    .vlsq2buf_byte_mask(vlsq2buf_byte_mask),
    .vlsbuf_data_all(vlsbuf_data_all),
    .vlsbuf_packed_shift_sel(vlsbuf_packed_shift_sel),
    .vlsbuf_packed_shift_eew_onehot(vlsbuf_packed_shift_eew_onehot),
    .vlsbuf_unpacked_wsel(vlsbuf_unpacked_wsel),
    .vlsbuf_unpacked_data_all(vlsbuf_unpacked_data_all),
    .vlsbuf_unpacked_bwe(vlsbuf_unpacked_bwe),
    .vlsbuf_ustride_unpacked_wsel(vlsbuf_ustride_unpacked_wsel),
    .vlsbuf_ustride_unpacked_data_all(vlsbuf_ustride_unpacked_data_all)
);
kv_vtlb #(
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .PMA_SUPPORT_INT(PMA_SUPPORT_INT),
    .PMP_SUPPORT_INT(PMP_SUPPORT_INT),
    .PPN_WIDTH(PPN_WIDTH),
    .VALEN(VALEN),
    .VPN_WIDTH(VPN_WIDTH),
    .VTLB_ENTRIES(VTLB_ENTRIES)
) u_vtlb (
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vpu_vtlb_flush(vpu_vtlb_flush),
    .vlsq2vtlb_req_valid(vlsq2vtlb_req_valid),
    .vlsq2vtlb_req_ready(vlsq2vtlb_req_ready),
    .vlsq2vtlb_req_va2pa_en(vlsq2vtlb_req_va2pa_en),
    .vlsq2vtlb_req_va(vlsq2vtlb_req_va),
    .vlsq2vtlb_cmt_valid(vlsq2vtlb_cmt_valid),
    .vlsq2vtlb_cmt_kill(vlsq2vtlb_cmt_kill),
    .vlsq2vtlb_resp_ppn(vlsq2vtlb_resp_ppn),
    .vlsq2vtlb_resp_data(vlsq2vtlb_resp_data),
    .vpu_pma_req_pa(vpu_pma_req_pa),
    .vpu_pma_resp_fault(vpu_pma_resp_fault),
    .vpu_pma_resp_hvm(vpu_pma_resp_hvm),
    .vpu_pma_resp_mtype(vpu_pma_resp_mtype),
    .vpu_pma_resp_nosh(vpu_pma_resp_nosh),
    .vpu_pmp_req_pa(vpu_pmp_req_pa),
    .vpu_pmp_resp_permission(vpu_pmp_resp_permission),
    .vpu_vtlb_miss_req(vpu_vtlb_miss_req),
    .vpu_vtlb_miss_vpn(vpu_vtlb_miss_vpn),
    .vpu_vtlb_miss_resp(vpu_vtlb_miss_resp),
    .vpu_vtlb_miss_data(vpu_vtlb_miss_data)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

