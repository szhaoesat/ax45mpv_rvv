// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpu_pipe (
    vpu_valu_clk,
    vpu_vfmis_clk,
    vpu_vmac_clk,
    vpu_vace_clk,
    vpu_cmt_i0_op1,
    vpu_cmt_i1_op1,
    vpu_cmt_kill,
    vpu_cmt_valid,
    vpu_req_valid,
    vpu_vdiv_clk,
    vpu_vfdiv_clk,
    vpu_credit,
    vpu_req_c2nc,
    vpu_req_cmr_ctl,
    vpu_req_fp_mode,
    vpu_req_frm,
    vpu_req_i0_ctrl,
    vpu_req_i0_instr,
    vpu_req_i0_op1,
    vpu_req_i0_op2,
    vpu_req_i1_ctrl,
    vpu_req_i1_instr,
    vpu_req_i1_op1,
    vpu_req_i1_op2,
    vpu_req_ls_privilege,
    vpu_req_mdlmb_den,
    vpu_req_milmb_ien,
    vpu_req_mstatus_mxr,
    vpu_req_mstatus_sum,
    vpu_req_satp_mode,
    vpu_req_translate_en,
    vpu_req_vl,
    vpu_req_vstart,
    vpu_req_vtype,
    vpu_req_vxrm,
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
    vpu_block_pending,
    vpu_loadstore_pending,
    vpu_ls_ack_element,
    vpu_ls_ack_status,
    vpu_ls_ack_tval,
    vpu_ls_ack_valid,
    vpu_ls_async_ecc_corr,
    vpu_ls_async_ecc_error,
    vpu_ls_async_ecc_ramid,
    vpu_ls_async_ecc_read,
    vpu_ls_async_read_error,
    vpu_ls_async_write_error,
    vpu_pma_req_pa,
    vpu_pma_resp_fault,
    vpu_pma_resp_hvm,
    vpu_pma_resp_mtype,
    vpu_pma_resp_nosh,
    vpu_pmp_req_pa,
    vpu_pmp_resp_permission,
    vpu_vlsu_clk,
    vpu_vtlb_flush,
    vpu_vtlb_miss_data,
    vpu_vtlb_miss_req,
    vpu_vtlb_miss_resp,
    vpu_vtlb_miss_vpn,
    vpu_vmask_clk,
    vpu_vpermut_clk,
    vpu_init_rf,
    vpu_standby_ready,
    vpu_vace_standby_ready,
    vpu_valu_standby_ready,
    vpu_vdiv_standby_ready,
    vpu_vfdiv_standby_ready,
    vpu_vfmis_standby_ready,
    vpu_vlsu_standby_ready,
    vpu_vmac_standby_ready,
    vpu_vmask_standby_ready,
    vpu_vpermut_standby_ready,
    vpu_vsp_standby_ready,
    ace_streaming_data_in,
    ace_streaming_data_in_ready,
    ace_streaming_data_in_valid,
    ace_streaming_data_out,
    ace_streaming_data_out_bwe,
    ace_streaming_data_out_ready,
    ace_streaming_data_out_valid,
    cp_cpu_rdata,
    cp_cpu_rdata_ready,
    cp_cpu_rdata_valid,
    cpu_cp_wdata,
    cpu_cp_wdata_bwe,
    cpu_cp_wdata_ready,
    cpu_cp_wdata_valid,
    vpu_sp_ex_done,
    vpu_sp_ex_error,
    vpu_sp_ex_store,
    vpu_vsp_clk,
    vpu_fflags_set,
    vpu_srf_waddr,
    vpu_srf_wdata,
    vpu_srf_wfrf,
    vpu_srf_wready,
    vpu_srf_wvalid,
    vpu_vxsat_set,
    vpu_clk,
    vpu_reset_n
);
parameter FLEN = 64;
parameter VLEN = 512;
parameter DLEN = 512;
parameter VPERMUT_DLEN = 512;
parameter ELEN = 64;
parameter FELEN = 32;
parameter VMAC2_TYPE = 0;
parameter VSCB_DEPTH = 8;
parameter VRF_MUX = 32;
parameter VRF_BYPASS_DUP = 1;
parameter VALEN = 39;
parameter PALEN = 38;
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
parameter HVM_ADDR_WIDTH = 1;
parameter QMAC_SUPPORT_INT = 0;
parameter BF16_SUPPORT_INT = 0;
parameter ZVFBFMIN_SUPPORT_INT = 0;
parameter ZVFBFWMA_SUPPORT_INT = 0;
parameter VECTOR_SINT_SUPPORT_INT = 0;
parameter VECTOR_DOT_SUPPORT_INT = 0;
parameter VECTOR_PACKED_FP16_SUPPORT_INT = 0;
parameter INT4_VECTOR_LOAD_SUPPORT_INT = 0;
parameter ASP_DATA_WIDTH = 512;
parameter VSP_VEQ_DEPTH = 4;
parameter ACE_SP_MODE = 0;
parameter ACE_SP_WRITE_PORT = 3;
parameter ACE_STREAM_PORT = 0;
parameter RAR_SUPPORT = 0;
localparam VFDIV_DLEN = DLEN / 2;
localparam AGEN = VSCB_DEPTH;
localparam BYPASSW = 4;
localparam VRF_AW = (VLEN == DLEN) ? 5 : 6;
localparam VRF_LW = (VLEN == DLEN) ? 3 : 4;
input vpu_valu_clk;
input vpu_vfmis_clk;
input vpu_vmac_clk;
input vpu_vace_clk;
input [63:0] vpu_cmt_i0_op1;
input [63:0] vpu_cmt_i1_op1;
input [1:0] vpu_cmt_kill;
input vpu_cmt_valid;
input [1:0] vpu_req_valid;
input vpu_vdiv_clk;
input vpu_vfdiv_clk;
output [3:0] vpu_credit;
input vpu_req_c2nc;
input [1:0] vpu_req_cmr_ctl;
input [1:0] vpu_req_fp_mode;
input [2:0] vpu_req_frm;
input [(32 - 1):0] vpu_req_i0_ctrl;
input [31:0] vpu_req_i0_instr;
input [63:0] vpu_req_i0_op1;
input [63:0] vpu_req_i0_op2;
input [(32 - 1):0] vpu_req_i1_ctrl;
input [31:0] vpu_req_i1_instr;
input [63:0] vpu_req_i1_op1;
input [63:0] vpu_req_i1_op2;
input [1:0] vpu_req_ls_privilege;
input vpu_req_mdlmb_den;
input vpu_req_milmb_ien;
input vpu_req_mstatus_mxr;
input vpu_req_mstatus_sum;
input [3:0] vpu_req_satp_mode;
input vpu_req_translate_en;
input [10:0] vpu_req_vl;
input [9:0] vpu_req_vstart;
input [7:0] vpu_req_vtype;
input [1:0] vpu_req_vxrm;
output [(PALEN - 1):0] vlsu_cm_a_address;
output vlsu_cm_a_corrupt;
output [(VLSU_DATA_WIDTH - 1):0] vlsu_cm_a_data;
output [((VLSU_DATA_WIDTH / 8) - 1):0] vlsu_cm_a_mask;
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
input [(VLSU_DATA_WIDTH - 1):0] vlsu_cm_d_data;
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
output [(PALEN - 1):0] vlsu_nc_a_address;
output vlsu_nc_a_corrupt;
output [(VLSU_DATA_WIDTH - 1):0] vlsu_nc_a_data;
output [((VLSU_DATA_WIDTH / 8) - 1):0] vlsu_nc_a_mask;
output [2:0] vlsu_nc_a_opcode;
output [2:0] vlsu_nc_a_param;
input vlsu_nc_a_ready;
output [2:0] vlsu_nc_a_size;
output [(L2_SOURCE_WIDTH - 1):0] vlsu_nc_a_source;
output [11:0] vlsu_nc_a_user;
output vlsu_nc_a_valid;
input vlsu_nc_d_corrupt;
input [(VLSU_DATA_WIDTH - 1):0] vlsu_nc_d_data;
input vlsu_nc_d_denied;
input [2:0] vlsu_nc_d_opcode;
input [1:0] vlsu_nc_d_param;
output vlsu_nc_d_ready;
input [(TL_SINK_WIDTH - 1):0] vlsu_nc_d_sink;
input [2:0] vlsu_nc_d_size;
input [(L2_SOURCE_WIDTH - 1):0] vlsu_nc_d_source;
input [5:0] vlsu_nc_d_user;
input vlsu_nc_d_valid;
output [(HVM_ADDR_WIDTH - 1):0] vlsu_vm_a_address;
output [(DLEN - 1):0] vlsu_vm_a_data;
output [((DLEN / 8) - 1):0] vlsu_vm_a_mask;
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
output vpu_block_pending;
output vpu_loadstore_pending;
output [10:0] vpu_ls_ack_element;
output [(22 - 1):0] vpu_ls_ack_status;
output [63:0] vpu_ls_ack_tval;
output vpu_ls_ack_valid;
output vpu_ls_async_ecc_corr;
output vpu_ls_async_ecc_error;
output [3:0] vpu_ls_async_ecc_ramid;
output vpu_ls_async_ecc_read;
output vpu_ls_async_read_error;
output vpu_ls_async_write_error;
output [(PALEN - 1):0] vpu_pma_req_pa;
input vpu_pma_resp_fault;
input vpu_pma_resp_hvm;
input [3:0] vpu_pma_resp_mtype;
input vpu_pma_resp_nosh;
output [(PALEN - 1):0] vpu_pmp_req_pa;
input [3:0] vpu_pmp_resp_permission;
input vpu_vlsu_clk;
input vpu_vtlb_flush;
input [(13 + PALEN):0] vpu_vtlb_miss_data;
output vpu_vtlb_miss_req;
input vpu_vtlb_miss_resp;
output [(VALEN - 1):12] vpu_vtlb_miss_vpn;
input vpu_vmask_clk;
input vpu_vpermut_clk;
input vpu_init_rf;
output vpu_standby_ready;
output vpu_vace_standby_ready;
output vpu_valu_standby_ready;
output vpu_vdiv_standby_ready;
output vpu_vfdiv_standby_ready;
output vpu_vfmis_standby_ready;
output vpu_vlsu_standby_ready;
output vpu_vmac_standby_ready;
output vpu_vmask_standby_ready;
output vpu_vpermut_standby_ready;
output vpu_vsp_standby_ready;
input [(ASP_DATA_WIDTH - 1):0] ace_streaming_data_in;
output ace_streaming_data_in_ready;
input ace_streaming_data_in_valid;
output [(ASP_DATA_WIDTH - 1):0] ace_streaming_data_out;
output [(ASP_DATA_WIDTH / 8) - 1:0] ace_streaming_data_out_bwe;
input ace_streaming_data_out_ready;
output ace_streaming_data_out_valid;
input [(ASP_DATA_WIDTH - 1):0] cp_cpu_rdata;
output cp_cpu_rdata_ready;
input cp_cpu_rdata_valid;
output [(ASP_DATA_WIDTH - 1):0] cpu_cp_wdata;
output [(ASP_DATA_WIDTH / 8) - 1:0] cpu_cp_wdata_bwe;
input cpu_cp_wdata_ready;
output cpu_cp_wdata_valid;
input vpu_sp_ex_done;
input vpu_sp_ex_error;
input vpu_sp_ex_store;
input vpu_vsp_clk;
output [4:0] vpu_fflags_set;
output [4:0] vpu_srf_waddr;
output [63:0] vpu_srf_wdata;
output vpu_srf_wfrf;
input vpu_srf_wready;
output vpu_srf_wvalid;
output vpu_vxsat_set;
input vpu_clk;
input vpu_reset_n;





// 3743117a rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire valu_dispatch_ready;
wire valu_standby_ready;
wire [(DLEN - 1):0] valu_vd_wdata;
wire [DLEN / 8 - 1:0] valu_vd_wmask;
wire valu_vd_wvalid;
wire valu_vs1_rready;
wire valu_vs2_rready;
wire valu_vs3_rready;
wire valu_vxsat_set;
wire vfmis_dispatch_ready;
wire [4:0] vfmis_fflags_set;
wire vfmis_standby_ready;
wire [(DLEN - 1):0] vfmis_vd_wdata;
wire [DLEN / 8 - 1:0] vfmis_vd_wmask;
wire vfmis_vd_wvalid;
wire vfmis_vs1_rready;
wire vfmis_vs2_rready;
wire vfmis_vs3_rready;
wire vmac2_dispatch_ready;
wire [4:0] vmac2_fflags_set;
wire [(DLEN - 1):0] vmac2_vd_wdata;
wire [DLEN / 8 - 1:0] vmac2_vd_wmask;
wire vmac2_vd_wvalid;
wire vmac2_vs1_rready;
wire vmac2_vs2_rready;
wire vmac2_vs3_rready;
wire vmac2_vxsat_set;
wire vmac_dispatch_ready;
wire [4:0] vmac_fflags_set;
wire vmac_standby_ready;
wire [(DLEN - 1):0] vmac_vd_wdata;
wire [DLEN / 8 - 1:0] vmac_vd_wmask;
wire vmac_vd_wvalid;
wire vmac_vs1_rready;
wire vmac_vs2_rready;
wire vmac_vs3_rready;
wire vmac_vxsat_set;
wire vace_dispatch_ready;
wire [4:0] vace_fflags_set;
wire [4:0] vace_srf_waddr;
wire [63:0] vace_srf_wdata;
wire vace_srf_wfrf;
wire vace_srf_wvalid;
wire vace_standby_ready;
wire [(DLEN - 1):0] vace_vd_wdata;
wire [(DLEN / 8) - 1:0] vace_vd_wmask;
wire vace_vd_wvalid;
wire vace_vs1_rready;
wire vace_vs2_rready;
wire vace_vs3_rready;
wire vace_vxsat_set;
wire cmt_i0_grant;
wire cmt_i0_kill;
wire cmt_i1_grant;
wire cmt_i1_kill;
wire vace_cmt_kill;
wire [63:0] vace_cmt_op1;
wire vace_cmt_valid;
wire valu_cmt_kill;
wire [63:0] valu_cmt_op1;
wire valu_cmt_valid;
wire vdiv_cmt_kill;
wire [63:0] vdiv_cmt_op1;
wire vdiv_cmt_valid;
wire vfdiv_cmt_kill;
wire [63:0] vfdiv_cmt_op1;
wire vfdiv_cmt_valid;
wire vfmis_cmt_kill;
wire [63:0] vfmis_cmt_op1;
wire vfmis_cmt_valid;
wire vlsu_cmt_kill;
wire vlsu_cmt_valid;
wire vmac2_cmt_kill;
wire [63:0] vmac2_cmt_op1;
wire vmac2_cmt_valid;
wire vmac_cmt_kill;
wire [63:0] vmac_cmt_op1;
wire vmac_cmt_valid;
wire vmask_cmt_kill;
wire [63:0] vmask_cmt_op1;
wire vmask_cmt_srf;
wire vmask_cmt_valid;
wire vpermut_cmt_kill;
wire [63:0] vpermut_cmt_op1;
wire vpermut_cmt_srf;
wire vpermut_cmt_valid;
wire vsp_cmt_kill;
wire [63:0] vsp_cmt_op1;
wire vsp_cmt_srf;
wire vsp_cmt_valid;
wire nds_unused_valu_vd_wlast;
wire nds_unused_vfdiv_vd_wlast;
wire nds_unused_vfdiv_vs1_rlast;
wire nds_unused_vfdiv_vs2_rlast;
wire nds_unused_vfmis_vd_wlast;
wire nds_unused_vmac2_vd_wlast;
wire nds_unused_vmac_vd_wlast;
wire nds_unused_vpermut_vd_wlast;
wire nds_unused_vpermut_vs1_rlast;
wire nds_unused_vpermut_vs2_rlast;
wire vace_vd_wlast;
wire vace_vd_wready;
wire [(DLEN - 1):0] vace_vs1_rdata;
wire vace_vs1_rlast;
wire vace_vs1_rvalid;
wire [(DLEN - 1):0] vace_vs2_rdata;
wire vace_vs2_rlast;
wire vace_vs2_rvalid;
wire [(DLEN - 1):0] vace_vs3_rdata;
wire vace_vs3_rlast;
wire vace_vs3_rvalid;
wire valu_vd_wready;
// ALU read data — raw from VRF, pipelined to ALU
wire [(DLEN - 1):0] valu_vs1_rdata_raw;
wire valu_vs1_rlast_raw;
wire valu_vs1_rvalid_raw;
wire [(DLEN - 1):0] valu_vs2_rdata_raw;
wire valu_vs2_rlast_raw;
wire valu_vs2_rvalid_raw;
wire [(DLEN - 1):0] valu_vs3_rdata_raw;
wire valu_vs3_rlast_raw;
wire valu_vs3_rvalid_raw;
wire [(DLEN - 1):0] valu_vs1_rdata;
wire valu_vs1_rlast;
wire valu_vs1_rvalid;
wire [(DLEN - 1):0] valu_vs2_rdata;
wire valu_vs2_rlast;
wire valu_vs2_rvalid;
wire [(DLEN - 1):0] valu_vs3_rdata;
wire valu_vs3_rlast;
wire valu_vs3_rvalid;
wire vdiv_vd_wlast;
wire vdiv_vd_wready;
wire [(DLEN - 1):0] vdiv_vs1_rdata;
wire vdiv_vs1_rlast;
wire vdiv_vs1_rvalid;
wire [(DLEN - 1):0] vdiv_vs2_rdata;
wire vdiv_vs2_rlast;
wire vdiv_vs2_rvalid;
wire vfdiv_vd_wready;
wire [(DLEN - 1):0] vfdiv_vs1_rdata;
wire vfdiv_vs1_rvalid;
wire [(DLEN - 1):0] vfdiv_vs2_rdata;
wire vfdiv_vs2_rvalid;
wire vfmis_vd_wready;
wire [(DLEN - 1):0] vfmis_vs1_rdata;
wire vfmis_vs1_rlast;
wire vfmis_vs1_rvalid;
wire [(DLEN - 1):0] vfmis_vs2_rdata;
wire vfmis_vs2_rlast;
wire vfmis_vs2_rvalid;
wire [(DLEN - 1):0] vfmis_vs3_rdata;
wire vfmis_vs3_rlast;
wire vfmis_vs3_rvalid;
wire vlsu_vd_wlast;
wire vlsu_vd_wready;
wire [(DLEN - 1):0] vlsu_vs2_rdata;
wire vlsu_vs2_rlast;
wire vlsu_vs2_rvalid;
wire [(DLEN - 1):0] vlsu_vs3_rdata;
wire vlsu_vs3_rlast;
wire vlsu_vs3_rvalid;
wire vmac2_vd_wready;
wire [(DLEN - 1):0] vmac2_vs1_rdata;
wire vmac2_vs1_rlast;
wire vmac2_vs1_rvalid;
wire [(DLEN - 1):0] vmac2_vs2_rdata;
wire vmac2_vs2_rlast;
wire vmac2_vs2_rvalid;
wire [(DLEN - 1):0] vmac2_vs3_rdata;
wire vmac2_vs3_rlast;
wire vmac2_vs3_rvalid;
wire vmac_vd_wready;
wire [(DLEN - 1):0] vmac_vs1_rdata;
wire vmac_vs1_rlast;
wire vmac_vs1_rvalid;
wire [(DLEN - 1):0] vmac_vs2_rdata;
wire vmac_vs2_rlast;
wire vmac_vs2_rvalid;
wire [(DLEN - 1):0] vmac_vs3_rdata;
wire vmac_vs3_rlast;
wire vmac_vs3_rvalid;
wire vmask_vd_wlast;
wire vmask_vd_wready;
wire [(DLEN - 1):0] vmask_vs1_rdata;
wire vmask_vs1_rlast;
wire vmask_vs1_rvalid;
wire [(DLEN - 1):0] vmask_vs2_rdata;
wire vmask_vs2_rlast;
wire vmask_vs2_rvalid;
wire [(DLEN - 1):0] vmask_vs3_rdata;
wire vmask_vs3_rlast;
wire vmask_vs3_rvalid;
wire vpermut_vd_wready;
wire [(DLEN - 1):0] vpermut_vs1_rdata;
wire vpermut_vs1_rvalid;
wire [(DLEN - 1):0] vpermut_vs2_rdata;
wire vpermut_vs2_rvalid;
wire vrf_r0_ready;
wire vrf_r10_ready;
wire vrf_r1_ready;
wire vrf_r2_ready;
wire vrf_r3_ready;
wire vrf_r4_ready;
wire vrf_r5_ready;
wire vrf_r6_ready;
wire vrf_r7_ready;
wire vrf_r8_ready;
wire vrf_r9_ready;
wire [(DLEN - 1):0] vrf_w0_data;
wire [(DLEN / 8) - 1:0] vrf_w0_mask;
wire vrf_w0_valid;
wire [(DLEN - 1):0] vrf_w1_data;
wire [(DLEN / 8) - 1:0] vrf_w1_mask;
wire vrf_w1_valid;
wire [(DLEN - 1):0] vrf_w2_data;
wire [(DLEN / 8) - 1:0] vrf_w2_mask;
wire vrf_w2_valid;
wire [(DLEN - 1):0] vrf_w3_data;
wire [(DLEN / 8) - 1:0] vrf_w3_mask;
wire vrf_w3_valid;
wire [(DLEN - 1):0] vrf_w4_data;
wire [(DLEN / 8) - 1:0] vrf_w4_mask;
wire vrf_w4_valid;
wire [(DLEN - 1):0] vrf_w5_data;
wire [(DLEN / 8) - 1:0] vrf_w5_mask;
wire vrf_w5_valid;
wire vsp_vd_wlast;
wire vsp_vd_wready;
wire [(DLEN - 1):0] vsp_vs3_rdata;
wire vsp_vs3_rlast;
wire vsp_vs3_rvalid;
wire [(11 - 1):0] dis_i0_fu;
wire dis_i0_grant;
wire [(VRF_AW - 1):0] dis_i0_vd_addr;
wire dis_i0_vd_en;
wire [(VRF_LW - 1):0] dis_i0_vd_len;
wire [(VRF_AW - 1):0] dis_i0_vs1_addr;
wire dis_i0_vs1_en;
wire [(VRF_LW - 1):0] dis_i0_vs1_len;
wire [(VRF_AW - 1):0] dis_i0_vs2_addr;
wire dis_i0_vs2_en;
wire [(VRF_LW - 1):0] dis_i0_vs2_len;
wire [(VRF_AW - 1):0] dis_i0_vs3_addr;
wire dis_i0_vs3_en;
wire [(VRF_LW - 1):0] dis_i0_vs3_len;
wire [(11 - 1):0] dis_i1_fu;
wire dis_i1_grant;
wire [(VRF_AW - 1):0] dis_i1_vd_addr;
wire dis_i1_vd_en;
wire [(VRF_LW - 1):0] dis_i1_vd_len;
wire [(VRF_AW - 1):0] dis_i1_vs1_addr;
wire dis_i1_vs1_en;
wire [(VRF_LW - 1):0] dis_i1_vs1_len;
wire [(VRF_AW - 1):0] dis_i1_vs2_addr;
wire dis_i1_vs2_en;
wire [(VRF_LW - 1):0] dis_i1_vs2_len;
wire [(VRF_AW - 1):0] dis_i1_vs3_addr;
wire dis_i1_vs3_en;
wire [(VRF_LW - 1):0] dis_i1_vs3_len;
wire [(VRF_LW - 1):0] nds_unused_valu_dispatch_vs1_len;
wire [(VRF_LW - 1):0] nds_unused_valu_dispatch_vs2_len;
wire [(VRF_LW - 1):0] nds_unused_valu_dispatch_vs3_len;
wire [(VRF_LW - 1):0] nds_unused_vdiv_dispatch_vd_len;
wire [(VRF_LW - 1):0] nds_unused_vdiv_dispatch_vs1_len;
wire [(VRF_LW - 1):0] nds_unused_vdiv_dispatch_vs2_len;
wire [(VRF_LW - 1):0] nds_unused_vfmis_dispatch_vs1_len;
wire [(VRF_LW - 1):0] nds_unused_vfmis_dispatch_vs2_len;
wire [(VRF_LW - 1):0] nds_unused_vfmis_dispatch_vs3_len;
wire [(VRF_LW - 1):0] nds_unused_vmac2_dispatch_vs1_len;
wire [(VRF_LW - 1):0] nds_unused_vmac2_dispatch_vs2_len;
wire [(VRF_LW - 1):0] nds_unused_vmac2_dispatch_vs3_len;
wire [(VRF_LW - 1):0] nds_unused_vmac_dispatch_vs1_len;
wire [(VRF_LW - 1):0] nds_unused_vmac_dispatch_vs2_len;
wire [(VRF_LW - 1):0] nds_unused_vmac_dispatch_vs3_len;
wire [86 - 1:0] vace_dispatch_ctrl;
wire [2:0] vace_dispatch_frm;
wire [63:0] vace_dispatch_op1;
wire vace_dispatch_op1_hazard;
wire [3:0] vace_dispatch_umisc_ctl;
wire vace_dispatch_valid;
wire [(VRF_LW - 1):0] vace_dispatch_vd_len;
wire [(VRF_LW - 1):0] vace_dispatch_vs1_len;
wire [(VRF_LW - 1):0] vace_dispatch_vs2_len;
wire [(VRF_LW - 1):0] vace_dispatch_vs3_len;
wire [1:0] vace_dispatch_vxrm;
wire [(58 - 1):0] valu_dispatch_ctrl;
wire [63:0] valu_dispatch_op1;
wire valu_dispatch_op1_hazard;
wire valu_dispatch_valid;
wire [(VRF_LW - 1):0] valu_dispatch_vd_len;
wire [1:0] valu_dispatch_vxrm;
wire [(30 - 1):0] vdiv_dispatch_ctrl;
wire [63:0] vdiv_dispatch_op1;
wire vdiv_dispatch_op1_hazard;
wire vdiv_dispatch_valid;
wire [(39 - 1):0] vfdiv_dispatch_ctrl;
wire [2:0] vfdiv_dispatch_frm;
wire [63:0] vfdiv_dispatch_op1;
wire vfdiv_dispatch_op1_hazard;
wire vfdiv_dispatch_valid;
wire [(VRF_LW - 1):0] vfdiv_dispatch_vd_len;
wire [(VRF_LW - 1):0] vfdiv_dispatch_vs1_len;
wire [(VRF_LW - 1):0] vfdiv_dispatch_vs2_len;
wire [(71 - 1):0] vfmis_dispatch_ctrl;
wire [2:0] vfmis_dispatch_frm;
wire [63:0] vfmis_dispatch_op1;
wire vfmis_dispatch_op1_hazard;
wire vfmis_dispatch_valid;
wire [(VRF_LW - 1):0] vfmis_dispatch_vd_len;
wire viq_i0_ready;
wire viq_i1_ready;
wire [(55 - 1):0] vlsu_dispatch_ctrl;
wire [63:0] vlsu_dispatch_op1;
wire [63:0] vlsu_dispatch_op2;
wire vlsu_dispatch_valid;
wire [(VRF_LW - 1):0] vlsu_dispatch_vd_len;
wire [(VRF_LW - 1):0] vlsu_dispatch_vs2_len;
wire [(VRF_LW - 1):0] vlsu_dispatch_vs3_len;
wire [(58 - 1):0] vmac2_dispatch_ctrl;
wire [2:0] vmac2_dispatch_frm;
wire [63:0] vmac2_dispatch_op1;
wire vmac2_dispatch_op1_hazard;
wire vmac2_dispatch_valid;
wire [(VRF_LW - 1):0] vmac2_dispatch_vd_len;
wire [1:0] vmac2_dispatch_vxrm;
wire [(58 - 1):0] vmac_dispatch_ctrl;
wire [2:0] vmac_dispatch_frm;
wire [63:0] vmac_dispatch_op1;
wire vmac_dispatch_op1_hazard;
wire vmac_dispatch_valid;
wire [(VRF_LW - 1):0] vmac_dispatch_vd_len;
wire [1:0] vmac_dispatch_vxrm;
wire [(44 - 1):0] vmask_dispatch_ctrl;
wire [63:0] vmask_dispatch_op1;
wire vmask_dispatch_op1_hazard;
wire vmask_dispatch_valid;
wire [(VRF_LW - 1):0] vmask_dispatch_vd_len;
wire [(VRF_LW - 1):0] vmask_dispatch_vs1_len;
wire [(VRF_LW - 1):0] vmask_dispatch_vs2_len;
wire [(VRF_LW - 1):0] vmask_dispatch_vs3_len;
wire [(41 - 1):0] vpermut_dispatch_ctrl;
wire [63:0] vpermut_dispatch_op1;
wire vpermut_dispatch_op1_hazard;
wire vpermut_dispatch_valid;
wire [(VRF_LW - 1):0] vpermut_dispatch_vd_len;
wire [(VRF_LW - 1):0] vpermut_dispatch_vs1_len;
wire [(VRF_LW - 1):0] vpermut_dispatch_vs2_len;
wire [(30 - 1):0] vsp_dispatch_ctrl;
wire [63:0] vsp_dispatch_op1;
wire vsp_dispatch_op1_hazard;
wire [63:0] vsp_dispatch_op2;
wire vsp_dispatch_valid;
wire [(VRF_LW - 1):0] vsp_dispatch_vd_len;
wire [(VRF_LW - 1):0] vsp_dispatch_vs3_len;
wire vdiv_dispatch_ready;
wire [(DLEN - 1):0] vdiv_vd_wdata;
wire [(DLEN / 8) - 1:0] vdiv_vd_wmask;
wire vdiv_vd_wvalid;
wire vdiv_vs1_rready;
wire vdiv_vs2_rready;
wire vfdiv_dispatch_ready;
wire [4:0] vfdiv_fflags_set;
wire vfdiv_standby_ready;
wire [(DLEN - 1):0] vfdiv_vd_wdata;
wire [(DLEN / 8) - 1:0] vfdiv_vd_wmask;
wire vfdiv_vd_wvalid;
wire vfdiv_vs1_rready;
wire vfdiv_vs2_rready;
wire [(81 - 1):0] viq_i0_ctrl;
wire [31:0] viq_i0_instr;
wire [63:0] viq_i0_op1;
wire [63:0] viq_i0_op2;
wire viq_i0_valid;
wire [(81 - 1):0] viq_i1_ctrl;
wire [31:0] viq_i1_instr;
wire [63:0] viq_i1_op1;
wire [63:0] viq_i1_op2;
wire viq_i1_valid;
wire [(11 - 1):0] viq_standby_ready;
wire [(11 - 1):0] vpu_req_i0_fu;
wire vpu_req_i0_srf;
wire [(11 - 1):0] vpu_req_i1_fu;
wire vpu_req_i1_srf;
wire vlsu_dispatch_ready;
wire [(DLEN - 1):0] vlsu_vd_wdata;
wire [(DLEN / 8) - 1:0] vlsu_vd_wmask;
wire vlsu_vd_wvalid;
wire vlsu_vs2_rready;
wire vlsu_vs3_rready;
wire vpu_vlsu_pending;
wire vmask_dispatch_ready;
wire [4:0] vmask_srf_waddr;
wire [63:0] vmask_srf_wdata;
wire vmask_srf_wfrf;
wire vmask_srf_wvalid;
wire vmask_standby_ready;
wire [(DLEN - 1):0] vmask_vd_wdata;
wire [(DLEN / 8) - 1:0] vmask_vd_wmask;
wire vmask_vd_wvalid;
wire vmask_vs1_rready;
wire vmask_vs2_rready;
wire vmask_vs3_rready;
wire vpermut_dispatch_ready;
wire [4:0] vpermut_srf_waddr;
wire [63:0] vpermut_srf_wdata;
wire vpermut_srf_wfrf;
wire vpermut_srf_wvalid;
wire vpermut_standby_ready;
wire [(DLEN - 1):0] vpermut_vd_wdata;
wire [(DLEN / 8) - 1:0] vpermut_vd_wmask;
wire vpermut_vd_wvalid;
wire vpermut_vs1_rready;
wire vpermut_vs2_rready;
wire [(VLEN - 1):0] v0t;
wire [(DLEN - 1):0] vrf_r0_data;
wire [(DLEN - 1):0] vrf_r10_data;
wire [(DLEN - 1):0] vrf_r1_data;
wire [(DLEN - 1):0] vrf_r2_data;
wire [(DLEN - 1):0] vrf_r3_data;
wire [(DLEN - 1):0] vrf_r4_data;
wire [(DLEN - 1):0] vrf_r5_data;
wire [(DLEN - 1):0] vrf_r6_data;
wire [(DLEN - 1):0] vrf_r7_data;
wire [(DLEN - 1):0] vrf_r8_data;
wire [(DLEN - 1):0] vrf_r9_data;
wire [(VLEN / 64 * 5) - 1:0] vrf_r0_addr;
wire vrf_r0_beat;
wire vrf_r0_bypass_en;
wire [(BYPASSW - 1):0] vrf_r0_bypass_sel;
wire [(11 - 1):0] vrf_r0_fu;
wire vrf_r0_last;
wire vrf_r0_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r10_addr;
wire vrf_r10_beat;
wire vrf_r10_bypass_en;
wire [(BYPASSW - 1):0] vrf_r10_bypass_sel;
wire [(11 - 1):0] vrf_r10_fu;
wire vrf_r10_last;
wire vrf_r10_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r1_addr;
wire vrf_r1_beat;
wire vrf_r1_bypass_en;
wire [(BYPASSW - 1):0] vrf_r1_bypass_sel;
wire [(11 - 1):0] vrf_r1_fu;
wire vrf_r1_last;
wire vrf_r1_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r2_addr;
wire vrf_r2_beat;
wire vrf_r2_bypass_en;
wire [(BYPASSW - 1):0] vrf_r2_bypass_sel;
wire [(11 - 1):0] vrf_r2_fu;
wire vrf_r2_last;
wire vrf_r2_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r3_addr;
wire vrf_r3_beat;
wire vrf_r3_bypass_en;
wire [(BYPASSW - 1):0] vrf_r3_bypass_sel;
wire [(11 - 1):0] vrf_r3_fu;
wire vrf_r3_last;
wire vrf_r3_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r4_addr;
wire vrf_r4_beat;
wire vrf_r4_bypass_en;
wire [(BYPASSW - 1):0] vrf_r4_bypass_sel;
wire [(11 - 1):0] vrf_r4_fu;
wire vrf_r4_last;
wire vrf_r4_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r5_addr;
wire vrf_r5_beat;
wire vrf_r5_bypass_en;
wire [(BYPASSW - 1):0] vrf_r5_bypass_sel;
wire [(11 - 1):0] vrf_r5_fu;
wire vrf_r5_last;
wire vrf_r5_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r6_addr;
wire vrf_r6_beat;
wire vrf_r6_bypass_en;
wire [(BYPASSW - 1):0] vrf_r6_bypass_sel;
wire [(11 - 1):0] vrf_r6_fu;
wire vrf_r6_last;
wire vrf_r6_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r7_addr;
wire vrf_r7_beat;
wire vrf_r7_bypass_en;
wire [(BYPASSW - 1):0] vrf_r7_bypass_sel;
wire [(11 - 1):0] vrf_r7_fu;
wire vrf_r7_last;
wire vrf_r7_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r8_addr;
wire vrf_r8_beat;
wire vrf_r8_bypass_en;
wire [(BYPASSW - 1):0] vrf_r8_bypass_sel;
wire [(11 - 1):0] vrf_r8_fu;
wire vrf_r8_last;
wire vrf_r8_valid;
wire [(VLEN / 64 * 5) - 1:0] vrf_r9_addr;
wire vrf_r9_beat;
wire vrf_r9_bypass_en;
wire [(BYPASSW - 1):0] vrf_r9_bypass_sel;
wire [(11 - 1):0] vrf_r9_fu;
wire vrf_r9_last;
wire vrf_r9_valid;
wire [(VRF_AW - 1):0] vrf_w0_addr;
wire vrf_w0_en;
wire [(11 - 1):0] vrf_w0_fu;
wire vrf_w0_last;
wire vrf_w0_ready;
wire [(VRF_AW - 1):0] vrf_w1_addr;
wire vrf_w1_en;
wire [(11 - 1):0] vrf_w1_fu;
wire vrf_w1_last;
wire vrf_w1_ready;
wire [(VRF_AW - 1):0] vrf_w2_addr;
wire vrf_w2_en;
wire [(11 - 1):0] vrf_w2_fu;
wire vrf_w2_last;
wire vrf_w2_ready;
wire [(VRF_AW - 1):0] vrf_w3_addr;
wire vrf_w3_en;
wire [(11 - 1):0] vrf_w3_fu;
wire vrf_w3_last;
wire vrf_w3_ready;
wire [(VRF_AW - 1):0] vrf_w4_addr;
wire vrf_w4_en;
wire [(11 - 1):0] vrf_w4_fu;
wire vrf_w4_last;
wire vrf_w4_ready;
wire [(VRF_AW - 1):0] vrf_w5_addr;
wire vrf_w5_en;
wire [(11 - 1):0] vrf_w5_fu;
wire vrf_w5_last;
wire vrf_w5_ready;
wire [(AGEN - 1):0] vscb_busy;
wire vscb_v0t_write_pending;
wire vsp_dispatch_ready;
wire [4:0] vsp_srf_waddr;
wire [63:0] vsp_srf_wdata;
wire vsp_srf_wfrf;
wire vsp_srf_wvalid;
wire vsp_standby_ready;
wire [(DLEN - 1):0] vsp_vd_wdata;
wire [(DLEN / 8) - 1:0] vsp_vd_wmask;
wire vsp_vd_wvalid;
wire vsp_vs3_rready;
wire srf_standby_ready;
wire vace_srf_wready;
wire vmask_srf_wready;
wire vpermut_srf_wready;
wire vsp_srf_wready;
kv_viq #(
    .VMAC2_TYPE(VMAC2_TYPE)
) u_viq (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vpu_req_valid(vpu_req_valid),
    .vpu_req_vtype(vpu_req_vtype),
    .vpu_req_fp_mode(vpu_req_fp_mode),
    .vpu_req_cmr_ctl(vpu_req_cmr_ctl),
    .vpu_req_vstart(vpu_req_vstart),
    .vpu_req_vl(vpu_req_vl),
    .vpu_req_frm(vpu_req_frm),
    .vpu_req_vxrm(vpu_req_vxrm),
    .vpu_req_ls_privilege(vpu_req_ls_privilege),
    .vpu_req_c2nc(vpu_req_c2nc),
    .vpu_req_milmb_ien(vpu_req_milmb_ien),
    .vpu_req_mdlmb_den(vpu_req_mdlmb_den),
    .vpu_req_mstatus_mxr(vpu_req_mstatus_mxr),
    .vpu_req_mstatus_sum(vpu_req_mstatus_sum),
    .vpu_req_translate_en(vpu_req_translate_en),
    .vpu_req_satp_mode(vpu_req_satp_mode),
    .vpu_req_i0_ctrl(vpu_req_i0_ctrl),
    .vpu_req_i0_instr(vpu_req_i0_instr),
    .vpu_req_i0_op1(vpu_req_i0_op1),
    .vpu_req_i0_op2(vpu_req_i0_op2),
    .vpu_req_i1_ctrl(vpu_req_i1_ctrl),
    .vpu_req_i1_instr(vpu_req_i1_instr),
    .vpu_req_i1_op1(vpu_req_i1_op1),
    .vpu_req_i1_op2(vpu_req_i1_op2),
    .vpu_credit(vpu_credit),
    .viq_standby_ready(viq_standby_ready),
    .vpu_req_i0_fu(vpu_req_i0_fu),
    .vpu_req_i1_fu(vpu_req_i1_fu),
    .vpu_req_i0_srf(vpu_req_i0_srf),
    .vpu_req_i1_srf(vpu_req_i1_srf),
    .viq_i0_valid(viq_i0_valid),
    .viq_i0_ready(viq_i0_ready),
    .viq_i0_ctrl(viq_i0_ctrl),
    .viq_i0_instr(viq_i0_instr),
    .viq_i0_op1(viq_i0_op1),
    .viq_i0_op2(viq_i0_op2),
    .viq_i1_valid(viq_i1_valid),
    .viq_i1_ready(viq_i1_ready),
    .viq_i1_ctrl(viq_i1_ctrl),
    .viq_i1_instr(viq_i1_instr),
    .viq_i1_op1(viq_i1_op1),
    .viq_i1_op2(viq_i1_op2)
);
kv_vdis #(
    .ACE_STREAM_PORT(ACE_STREAM_PORT),
    .AGEN(AGEN),
    .BF16_SUPPORT_INT(BF16_SUPPORT_INT),
    .DLEN(DLEN),
    .ELEN(ELEN),
    .FLEN(FLEN),
    .INT4_VECTOR_LOAD_SUPPORT_INT(INT4_VECTOR_LOAD_SUPPORT_INT),
    .PALEN(PALEN),
    .QMAC_SUPPORT_INT(QMAC_SUPPORT_INT),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .VALEN(VALEN),
    .VECTOR_DOT_SUPPORT_INT(VECTOR_DOT_SUPPORT_INT),
    .VECTOR_PACKED_FP16_SUPPORT_INT(VECTOR_PACKED_FP16_SUPPORT_INT),
    .VECTOR_SINT_SUPPORT_INT(VECTOR_SINT_SUPPORT_INT),
    .VLEN(VLEN),
    .VLSU_DATA_WIDTH(VLSU_DATA_WIDTH),
    .VMAC2_TYPE(VMAC2_TYPE),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW),
    .ZVFBFMIN_SUPPORT_INT(ZVFBFMIN_SUPPORT_INT),
    .ZVFBFWMA_SUPPORT_INT(ZVFBFWMA_SUPPORT_INT)
) u_vdis (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .viq_i0_valid(viq_i0_valid),
    .viq_i0_ready(viq_i0_ready),
    .viq_i0_ctrl(viq_i0_ctrl),
    .viq_i0_instr(viq_i0_instr),
    .viq_i0_op1(viq_i0_op1),
    .viq_i0_op2(viq_i0_op2),
    .viq_i1_valid(viq_i1_valid),
    .viq_i1_ready(viq_i1_ready),
    .viq_i1_ctrl(viq_i1_ctrl),
    .viq_i1_instr(viq_i1_instr),
    .viq_i1_op1(viq_i1_op1),
    .viq_i1_op2(viq_i1_op2),
    .vscb_busy(vscb_busy),
    .vscb_v0t_write_pending(vscb_v0t_write_pending),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_fu(dis_i0_fu),
    .dis_i0_vs1_en(dis_i0_vs1_en),
    .dis_i0_vs1_addr(dis_i0_vs1_addr),
    .dis_i0_vs1_len(dis_i0_vs1_len),
    .dis_i0_vs2_en(dis_i0_vs2_en),
    .dis_i0_vs2_addr(dis_i0_vs2_addr),
    .dis_i0_vs2_len(dis_i0_vs2_len),
    .dis_i0_vs3_en(dis_i0_vs3_en),
    .dis_i0_vs3_addr(dis_i0_vs3_addr),
    .dis_i0_vs3_len(dis_i0_vs3_len),
    .dis_i0_vd_en(dis_i0_vd_en),
    .dis_i0_vd_addr(dis_i0_vd_addr),
    .dis_i0_vd_len(dis_i0_vd_len),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_fu(dis_i1_fu),
    .dis_i1_vs1_en(dis_i1_vs1_en),
    .dis_i1_vs1_addr(dis_i1_vs1_addr),
    .dis_i1_vs1_len(dis_i1_vs1_len),
    .dis_i1_vs2_en(dis_i1_vs2_en),
    .dis_i1_vs2_addr(dis_i1_vs2_addr),
    .dis_i1_vs2_len(dis_i1_vs2_len),
    .dis_i1_vs3_en(dis_i1_vs3_en),
    .dis_i1_vs3_addr(dis_i1_vs3_addr),
    .dis_i1_vs3_len(dis_i1_vs3_len),
    .dis_i1_vd_en(dis_i1_vd_en),
    .dis_i1_vd_addr(dis_i1_vd_addr),
    .dis_i1_vd_len(dis_i1_vd_len),
    .valu_dispatch_valid(valu_dispatch_valid),
    .valu_dispatch_ready(valu_dispatch_ready),
    .valu_dispatch_ctrl(valu_dispatch_ctrl),
    .valu_dispatch_vxrm(valu_dispatch_vxrm),
    .valu_dispatch_op1_hazard(valu_dispatch_op1_hazard),
    .valu_dispatch_op1(valu_dispatch_op1),
    .valu_dispatch_vs1_len(nds_unused_valu_dispatch_vs1_len),
    .valu_dispatch_vs2_len(nds_unused_valu_dispatch_vs2_len),
    .valu_dispatch_vs3_len(nds_unused_valu_dispatch_vs3_len),
    .valu_dispatch_vd_len(valu_dispatch_vd_len),
    .vlsu_dispatch_valid(vlsu_dispatch_valid),
    .vlsu_dispatch_ready(vlsu_dispatch_ready),
    .vlsu_dispatch_ctrl(vlsu_dispatch_ctrl),
    .vlsu_dispatch_op1(vlsu_dispatch_op1),
    .vlsu_dispatch_op2(vlsu_dispatch_op2),
    .vlsu_dispatch_vs2_len(vlsu_dispatch_vs2_len),
    .vlsu_dispatch_vs3_len(vlsu_dispatch_vs3_len),
    .vlsu_dispatch_vd_len(vlsu_dispatch_vd_len),
    .vsp_dispatch_valid(vsp_dispatch_valid),
    .vsp_dispatch_ready(vsp_dispatch_ready),
    .vsp_dispatch_op1_hazard(vsp_dispatch_op1_hazard),
    .vsp_dispatch_ctrl(vsp_dispatch_ctrl),
    .vsp_dispatch_op1(vsp_dispatch_op1),
    .vsp_dispatch_op2(vsp_dispatch_op2),
    .vsp_dispatch_vs3_len(vsp_dispatch_vs3_len),
    .vsp_dispatch_vd_len(vsp_dispatch_vd_len),
    .vmac_dispatch_ctrl(vmac_dispatch_ctrl),
    .vmac_dispatch_frm(vmac_dispatch_frm),
    .vmac_dispatch_vxrm(vmac_dispatch_vxrm),
    .vmac_dispatch_op1(vmac_dispatch_op1),
    .vmac_dispatch_op1_hazard(vmac_dispatch_op1_hazard),
    .vmac_dispatch_ready(vmac_dispatch_ready),
    .vmac_dispatch_valid(vmac_dispatch_valid),
    .vmac_dispatch_vs1_len(nds_unused_vmac_dispatch_vs1_len),
    .vmac_dispatch_vs2_len(nds_unused_vmac_dispatch_vs2_len),
    .vmac_dispatch_vs3_len(nds_unused_vmac_dispatch_vs3_len),
    .vmac_dispatch_vd_len(vmac_dispatch_vd_len),
    .vmac2_dispatch_ctrl(vmac2_dispatch_ctrl),
    .vmac2_dispatch_frm(vmac2_dispatch_frm),
    .vmac2_dispatch_vxrm(vmac2_dispatch_vxrm),
    .vmac2_dispatch_op1(vmac2_dispatch_op1),
    .vmac2_dispatch_op1_hazard(vmac2_dispatch_op1_hazard),
    .vmac2_dispatch_ready(vmac2_dispatch_ready),
    .vmac2_dispatch_valid(vmac2_dispatch_valid),
    .vmac2_dispatch_vs1_len(nds_unused_vmac2_dispatch_vs1_len),
    .vmac2_dispatch_vs2_len(nds_unused_vmac2_dispatch_vs2_len),
    .vmac2_dispatch_vs3_len(nds_unused_vmac2_dispatch_vs3_len),
    .vmac2_dispatch_vd_len(vmac2_dispatch_vd_len),
    .vdiv_dispatch_ctrl(vdiv_dispatch_ctrl),
    .vdiv_dispatch_op1(vdiv_dispatch_op1),
    .vdiv_dispatch_op1_hazard(vdiv_dispatch_op1_hazard),
    .vdiv_dispatch_ready(vdiv_dispatch_ready),
    .vdiv_dispatch_valid(vdiv_dispatch_valid),
    .vdiv_dispatch_vs1_len(nds_unused_vdiv_dispatch_vs1_len),
    .vdiv_dispatch_vs2_len(nds_unused_vdiv_dispatch_vs2_len),
    .vdiv_dispatch_vd_len(nds_unused_vdiv_dispatch_vd_len),
    .vpermut_dispatch_ctrl(vpermut_dispatch_ctrl),
    .vpermut_dispatch_op1(vpermut_dispatch_op1),
    .vpermut_dispatch_op1_hazard(vpermut_dispatch_op1_hazard),
    .vpermut_dispatch_ready(vpermut_dispatch_ready),
    .vpermut_dispatch_valid(vpermut_dispatch_valid),
    .vpermut_dispatch_vs1_len(vpermut_dispatch_vs1_len),
    .vpermut_dispatch_vs2_len(vpermut_dispatch_vs2_len),
    .vpermut_dispatch_vd_len(vpermut_dispatch_vd_len),
    .vfmis_dispatch_ctrl(vfmis_dispatch_ctrl),
    .vfmis_dispatch_frm(vfmis_dispatch_frm),
    .vfmis_dispatch_op1(vfmis_dispatch_op1),
    .vfmis_dispatch_op1_hazard(vfmis_dispatch_op1_hazard),
    .vfmis_dispatch_ready(vfmis_dispatch_ready),
    .vfmis_dispatch_valid(vfmis_dispatch_valid),
    .vfmis_dispatch_vs1_len(nds_unused_vfmis_dispatch_vs1_len),
    .vfmis_dispatch_vs2_len(nds_unused_vfmis_dispatch_vs2_len),
    .vfmis_dispatch_vs3_len(nds_unused_vfmis_dispatch_vs3_len),
    .vfmis_dispatch_vd_len(vfmis_dispatch_vd_len),
    .vfdiv_dispatch_ctrl(vfdiv_dispatch_ctrl),
    .vfdiv_dispatch_op1(vfdiv_dispatch_op1),
    .vfdiv_dispatch_op1_hazard(vfdiv_dispatch_op1_hazard),
    .vfdiv_dispatch_ready(vfdiv_dispatch_ready),
    .vfdiv_dispatch_valid(vfdiv_dispatch_valid),
    .vfdiv_dispatch_vs1_len(vfdiv_dispatch_vs1_len),
    .vfdiv_dispatch_vs2_len(vfdiv_dispatch_vs2_len),
    .vfdiv_dispatch_vd_len(vfdiv_dispatch_vd_len),
    .vfdiv_dispatch_frm(vfdiv_dispatch_frm),
    .vmask_dispatch_ctrl(vmask_dispatch_ctrl),
    .vmask_dispatch_op1(vmask_dispatch_op1),
    .vmask_dispatch_op1_hazard(vmask_dispatch_op1_hazard),
    .vmask_dispatch_ready(vmask_dispatch_ready),
    .vmask_dispatch_valid(vmask_dispatch_valid),
    .vmask_dispatch_vs1_len(vmask_dispatch_vs1_len),
    .vmask_dispatch_vs2_len(vmask_dispatch_vs2_len),
    .vmask_dispatch_vs3_len(vmask_dispatch_vs3_len),
    .vmask_dispatch_vd_len(vmask_dispatch_vd_len),
    .vace_dispatch_ctrl(vace_dispatch_ctrl),
    .vace_dispatch_frm(vace_dispatch_frm),
    .vace_dispatch_vxrm(vace_dispatch_vxrm),
    .vace_dispatch_umisc_ctl(vace_dispatch_umisc_ctl),
    .vace_dispatch_op1(vace_dispatch_op1),
    .vace_dispatch_op1_hazard(vace_dispatch_op1_hazard),
    .vace_dispatch_ready(vace_dispatch_ready),
    .vace_dispatch_valid(vace_dispatch_valid),
    .vace_dispatch_vs1_len(vace_dispatch_vs1_len),
    .vace_dispatch_vs2_len(vace_dispatch_vs2_len),
    .vace_dispatch_vs3_len(vace_dispatch_vs3_len),
    .vace_dispatch_vd_len(vace_dispatch_vd_len)
);
kv_vscb #(
    .ACE_SP_WRITE_PORT(ACE_SP_WRITE_PORT),
    .AGEN(AGEN),
    .BYPASSW(BYPASSW),
    .VLEN(VLEN),
    .VMAC2_TYPE(VMAC2_TYPE),
    .VRF_AW(VRF_AW),
    .VRF_LW(VRF_LW)
) u_vscb (
    .vpu_standby_ready(vpu_standby_ready),
    .vpu_vlsu_standby_ready(vpu_vlsu_standby_ready),
    .vpu_valu_standby_ready(vpu_valu_standby_ready),
    .vpu_vfmis_standby_ready(vpu_vfmis_standby_ready),
    .vpu_vmac_standby_ready(vpu_vmac_standby_ready),
    .vpu_vfdiv_standby_ready(vpu_vfdiv_standby_ready),
    .vpu_vdiv_standby_ready(vpu_vdiv_standby_ready),
    .vpu_vmask_standby_ready(vpu_vmask_standby_ready),
    .vpu_vpermut_standby_ready(vpu_vpermut_standby_ready),
    .vpu_vace_standby_ready(vpu_vace_standby_ready),
    .vpu_vsp_standby_ready(vpu_vsp_standby_ready),
    .valu_standby_ready(valu_standby_ready),
    .vfmis_standby_ready(vfmis_standby_ready),
    .vmac_standby_ready(vmac_standby_ready),
    .vfdiv_standby_ready(vfdiv_standby_ready),
    .vmask_standby_ready(vmask_standby_ready),
    .vsp_standby_ready(vsp_standby_ready),
    .vpermut_standby_ready(vpermut_standby_ready),
    .vace_standby_ready(vace_standby_ready),
    .viq_standby_ready(viq_standby_ready),
    .srf_standby_ready(srf_standby_ready),
    .vpu_vlsu_pending(vpu_vlsu_pending),
    .vscb_busy(vscb_busy),
    .vscb_v0t_write_pending(vscb_v0t_write_pending),
    .dis_i0_grant(dis_i0_grant),
    .dis_i0_fu(dis_i0_fu),
    .dis_i0_vs1_en(dis_i0_vs1_en),
    .dis_i0_vs1_addr(dis_i0_vs1_addr),
    .dis_i0_vs1_len(dis_i0_vs1_len),
    .dis_i0_vs2_en(dis_i0_vs2_en),
    .dis_i0_vs2_addr(dis_i0_vs2_addr),
    .dis_i0_vs2_len(dis_i0_vs2_len),
    .dis_i0_vs3_en(dis_i0_vs3_en),
    .dis_i0_vs3_addr(dis_i0_vs3_addr),
    .dis_i0_vs3_len(dis_i0_vs3_len),
    .dis_i0_vd_en(dis_i0_vd_en),
    .dis_i0_vd_addr(dis_i0_vd_addr),
    .dis_i0_vd_len(dis_i0_vd_len),
    .dis_i1_grant(dis_i1_grant),
    .dis_i1_fu(dis_i1_fu),
    .dis_i1_vs1_en(dis_i1_vs1_en),
    .dis_i1_vs1_addr(dis_i1_vs1_addr),
    .dis_i1_vs1_len(dis_i1_vs1_len),
    .dis_i1_vs2_en(dis_i1_vs2_en),
    .dis_i1_vs2_addr(dis_i1_vs2_addr),
    .dis_i1_vs2_len(dis_i1_vs2_len),
    .dis_i1_vs3_en(dis_i1_vs3_en),
    .dis_i1_vs3_addr(dis_i1_vs3_addr),
    .dis_i1_vs3_len(dis_i1_vs3_len),
    .dis_i1_vd_en(dis_i1_vd_en),
    .dis_i1_vd_addr(dis_i1_vd_addr),
    .dis_i1_vd_len(dis_i1_vd_len),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .vrf_r0_valid(vrf_r0_valid),
    .vrf_r0_addr(vrf_r0_addr),
    .vrf_r0_beat(vrf_r0_beat),
    .vrf_r0_fu(vrf_r0_fu),
    .vrf_r0_bypass_sel(vrf_r0_bypass_sel),
    .vrf_r0_bypass_en(vrf_r0_bypass_en),
    .vrf_r0_last(vrf_r0_last),
    .vrf_r0_ready(vrf_r0_ready),
    .vrf_r1_valid(vrf_r1_valid),
    .vrf_r1_addr(vrf_r1_addr),
    .vrf_r1_beat(vrf_r1_beat),
    .vrf_r1_fu(vrf_r1_fu),
    .vrf_r1_bypass_sel(vrf_r1_bypass_sel),
    .vrf_r1_bypass_en(vrf_r1_bypass_en),
    .vrf_r1_last(vrf_r1_last),
    .vrf_r1_ready(vrf_r1_ready),
    .vrf_r2_valid(vrf_r2_valid),
    .vrf_r2_addr(vrf_r2_addr),
    .vrf_r2_beat(vrf_r2_beat),
    .vrf_r2_fu(vrf_r2_fu),
    .vrf_r2_bypass_sel(vrf_r2_bypass_sel),
    .vrf_r2_bypass_en(vrf_r2_bypass_en),
    .vrf_r2_last(vrf_r2_last),
    .vrf_r2_ready(vrf_r2_ready),
    .vrf_r3_valid(vrf_r3_valid),
    .vrf_r3_addr(vrf_r3_addr),
    .vrf_r3_beat(vrf_r3_beat),
    .vrf_r3_fu(vrf_r3_fu),
    .vrf_r3_bypass_sel(vrf_r3_bypass_sel),
    .vrf_r3_bypass_en(vrf_r3_bypass_en),
    .vrf_r3_last(vrf_r3_last),
    .vrf_r3_ready(vrf_r3_ready),
    .vrf_r4_valid(vrf_r4_valid),
    .vrf_r4_addr(vrf_r4_addr),
    .vrf_r4_beat(vrf_r4_beat),
    .vrf_r4_fu(vrf_r4_fu),
    .vrf_r4_bypass_sel(vrf_r4_bypass_sel),
    .vrf_r4_bypass_en(vrf_r4_bypass_en),
    .vrf_r4_last(vrf_r4_last),
    .vrf_r4_ready(vrf_r4_ready),
    .vrf_r5_valid(vrf_r5_valid),
    .vrf_r5_addr(vrf_r5_addr),
    .vrf_r5_beat(vrf_r5_beat),
    .vrf_r5_fu(vrf_r5_fu),
    .vrf_r5_bypass_sel(vrf_r5_bypass_sel),
    .vrf_r5_bypass_en(vrf_r5_bypass_en),
    .vrf_r5_last(vrf_r5_last),
    .vrf_r5_ready(vrf_r5_ready),
    .vrf_r6_valid(vrf_r6_valid),
    .vrf_r6_addr(vrf_r6_addr),
    .vrf_r6_beat(vrf_r6_beat),
    .vrf_r6_fu(vrf_r6_fu),
    .vrf_r6_bypass_sel(vrf_r6_bypass_sel),
    .vrf_r6_bypass_en(vrf_r6_bypass_en),
    .vrf_r6_last(vrf_r6_last),
    .vrf_r6_ready(vrf_r6_ready),
    .vrf_r7_valid(vrf_r7_valid),
    .vrf_r7_addr(vrf_r7_addr),
    .vrf_r7_beat(vrf_r7_beat),
    .vrf_r7_fu(vrf_r7_fu),
    .vrf_r7_bypass_sel(vrf_r7_bypass_sel),
    .vrf_r7_bypass_en(vrf_r7_bypass_en),
    .vrf_r7_last(vrf_r7_last),
    .vrf_r7_ready(vrf_r7_ready),
    .vrf_r8_valid(vrf_r8_valid),
    .vrf_r8_addr(vrf_r8_addr),
    .vrf_r8_beat(vrf_r8_beat),
    .vrf_r8_fu(vrf_r8_fu),
    .vrf_r8_bypass_sel(vrf_r8_bypass_sel),
    .vrf_r8_bypass_en(vrf_r8_bypass_en),
    .vrf_r8_last(vrf_r8_last),
    .vrf_r8_ready(vrf_r8_ready),
    .vrf_r9_valid(vrf_r9_valid),
    .vrf_r9_addr(vrf_r9_addr),
    .vrf_r9_beat(vrf_r9_beat),
    .vrf_r9_fu(vrf_r9_fu),
    .vrf_r9_bypass_sel(vrf_r9_bypass_sel),
    .vrf_r9_bypass_en(vrf_r9_bypass_en),
    .vrf_r9_last(vrf_r9_last),
    .vrf_r9_ready(vrf_r9_ready),
    .vrf_r10_valid(vrf_r10_valid),
    .vrf_r10_addr(vrf_r10_addr),
    .vrf_r10_beat(vrf_r10_beat),
    .vrf_r10_fu(vrf_r10_fu),
    .vrf_r10_bypass_sel(vrf_r10_bypass_sel),
    .vrf_r10_bypass_en(vrf_r10_bypass_en),
    .vrf_r10_last(vrf_r10_last),
    .vrf_r10_ready(vrf_r10_ready),
    .vrf_w0_valid(vrf_w0_valid),
    .vrf_w0_en(vrf_w0_en),
    .vrf_w0_addr(vrf_w0_addr),
    .vrf_w0_fu(vrf_w0_fu),
    .vrf_w0_last(vrf_w0_last),
    .vrf_w0_ready(vrf_w0_ready),
    .vrf_w1_valid(vrf_w1_valid),
    .vrf_w1_en(vrf_w1_en),
    .vrf_w1_addr(vrf_w1_addr),
    .vrf_w1_fu(vrf_w1_fu),
    .vrf_w1_last(vrf_w1_last),
    .vrf_w1_ready(vrf_w1_ready),
    .vrf_w2_valid(vrf_w2_valid),
    .vrf_w2_en(vrf_w2_en),
    .vrf_w2_addr(vrf_w2_addr),
    .vrf_w2_fu(vrf_w2_fu),
    .vrf_w2_last(vrf_w2_last),
    .vrf_w2_ready(vrf_w2_ready),
    .vrf_w3_valid(vrf_w3_valid),
    .vrf_w3_en(vrf_w3_en),
    .vrf_w3_addr(vrf_w3_addr),
    .vrf_w3_fu(vrf_w3_fu),
    .vrf_w3_last(vrf_w3_last),
    .vrf_w3_ready(vrf_w3_ready),
    .vrf_w4_valid(vrf_w4_valid),
    .vrf_w4_en(vrf_w4_en),
    .vrf_w4_addr(vrf_w4_addr),
    .vrf_w4_fu(vrf_w4_fu),
    .vrf_w4_last(vrf_w4_last),
    .vrf_w4_ready(vrf_w4_ready),
    .vrf_w5_valid(vrf_w5_valid),
    .vrf_w5_en(vrf_w5_en),
    .vrf_w5_addr(vrf_w5_addr),
    .vrf_w5_fu(vrf_w5_fu),
    .vrf_w5_last(vrf_w5_last),
    .vrf_w5_ready(vrf_w5_ready),
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n)
);
kv_vcmt #(
    .AGEN(AGEN),
    .VMAC2_TYPE(VMAC2_TYPE)
) u_vcmt (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .vpu_req_valid(vpu_req_valid),
    .vpu_req_i0_fu(vpu_req_i0_fu),
    .vpu_req_i1_fu(vpu_req_i1_fu),
    .vpu_req_i0_srf(vpu_req_i0_srf),
    .vpu_req_i1_srf(vpu_req_i1_srf),
    .vpu_cmt_valid(vpu_cmt_valid),
    .vpu_cmt_kill(vpu_cmt_kill),
    .vpu_cmt_i0_op1(vpu_cmt_i0_op1),
    .vpu_cmt_i1_op1(vpu_cmt_i1_op1),
    .dis_i0_grant(dis_i0_grant),
    .dis_i1_grant(dis_i1_grant),
    .cmt_i0_grant(cmt_i0_grant),
    .cmt_i0_kill(cmt_i0_kill),
    .cmt_i1_grant(cmt_i1_grant),
    .cmt_i1_kill(cmt_i1_kill),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_cmt_kill(valu_cmt_kill),
    .valu_cmt_op1(valu_cmt_op1),
    .vlsu_cmt_valid(vlsu_cmt_valid),
    .vlsu_cmt_kill(vlsu_cmt_kill),
    .vsp_cmt_valid(vsp_cmt_valid),
    .vsp_cmt_op1(vsp_cmt_op1),
    .vsp_cmt_srf(vsp_cmt_srf),
    .vsp_cmt_kill(vsp_cmt_kill),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_cmt_op1(vmac_cmt_op1),
    .vmac2_cmt_valid(vmac2_cmt_valid),
    .vmac2_cmt_kill(vmac2_cmt_kill),
    .vmac2_cmt_op1(vmac2_cmt_op1),
    .vdiv_cmt_valid(vdiv_cmt_valid),
    .vdiv_cmt_kill(vdiv_cmt_kill),
    .vdiv_cmt_op1(vdiv_cmt_op1),
    .vfmis_cmt_valid(vfmis_cmt_valid),
    .vfmis_cmt_kill(vfmis_cmt_kill),
    .vfmis_cmt_op1(vfmis_cmt_op1),
    .vpermut_cmt_valid(vpermut_cmt_valid),
    .vpermut_cmt_kill(vpermut_cmt_kill),
    .vpermut_cmt_srf(vpermut_cmt_srf),
    .vpermut_cmt_op1(vpermut_cmt_op1),
    .vfdiv_cmt_valid(vfdiv_cmt_valid),
    .vfdiv_cmt_kill(vfdiv_cmt_kill),
    .vfdiv_cmt_op1(vfdiv_cmt_op1),
    .vmask_cmt_valid(vmask_cmt_valid),
    .vmask_cmt_kill(vmask_cmt_kill),
    .vmask_cmt_srf(vmask_cmt_srf),
    .vmask_cmt_op1(vmask_cmt_op1),
    .vace_cmt_valid(vace_cmt_valid),
    .vace_cmt_kill(vace_cmt_kill),
    .vace_cmt_op1(vace_cmt_op1)
);
kv_vsrf #(
    .MAX_VSP_SRF(VSP_VEQ_DEPTH)
) u_vsrf (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .srf_standby_ready(srf_standby_ready),
    .vpermut_cmt_valid(vpermut_cmt_valid),
    .vpermut_cmt_kill(vpermut_cmt_kill),
    .vpermut_cmt_srf(vpermut_cmt_srf),
    .vmask_cmt_valid(vmask_cmt_valid),
    .vmask_cmt_kill(vmask_cmt_kill),
    .vmask_cmt_srf(vmask_cmt_srf),
    .vsp_cmt_valid(vsp_cmt_valid),
    .vsp_cmt_kill(vsp_cmt_kill),
    .vsp_cmt_srf(vsp_cmt_srf),
    .vpu_srf_wvalid(vpu_srf_wvalid),
    .vpu_srf_wready(vpu_srf_wready),
    .vpu_srf_wfrf(vpu_srf_wfrf),
    .vpu_srf_waddr(vpu_srf_waddr),
    .vpu_srf_wdata(vpu_srf_wdata),
    .vpermut_srf_wvalid(vpermut_srf_wvalid),
    .vpermut_srf_wready(vpermut_srf_wready),
    .vpermut_srf_wfrf(vpermut_srf_wfrf),
    .vpermut_srf_waddr(vpermut_srf_waddr),
    .vpermut_srf_wdata(vpermut_srf_wdata),
    .vmask_srf_wvalid(vmask_srf_wvalid),
    .vmask_srf_wready(vmask_srf_wready),
    .vmask_srf_wfrf(vmask_srf_wfrf),
    .vmask_srf_waddr(vmask_srf_waddr),
    .vmask_srf_wdata(vmask_srf_wdata),
    .vsp_srf_wvalid(vsp_srf_wvalid),
    .vsp_srf_wready(vsp_srf_wready),
    .vsp_srf_wfrf(vsp_srf_wfrf),
    .vsp_srf_waddr(vsp_srf_waddr),
    .vsp_srf_wdata(vsp_srf_wdata),
    .vace_srf_wvalid(vace_srf_wvalid),
    .vace_srf_wready(vace_srf_wready),
    .vace_srf_wfrf(vace_srf_wfrf),
    .vace_srf_waddr(vace_srf_waddr),
    .vace_srf_wdata(vace_srf_wdata),
    .vmac_fflags_set(vmac_fflags_set),
    .vmac2_fflags_set(vmac2_fflags_set),
    .vfmis_fflags_set(vfmis_fflags_set),
    .vfdiv_fflags_set(vfdiv_fflags_set),
    .vace_fflags_set(vace_fflags_set),
    .valu_vxsat_set(valu_vxsat_set),
    .vmac_vxsat_set(vmac_vxsat_set),
    .vmac2_vxsat_set(vmac2_vxsat_set),
    .vace_vxsat_set(vace_vxsat_set),
    .vpu_fflags_set(vpu_fflags_set),
    .vpu_vxsat_set(vpu_vxsat_set)
);
kv_vrf #(
    .DLEN(DLEN),
    .VLEN(VLEN),
    .VMAC2_TYPE(VMAC2_TYPE),
    .VRF_AW(VRF_AW),
    .VRF_MUX(VRF_MUX)
) u_vrf (
    .vpu_init_rf(vpu_init_rf),
    .v0t(v0t),
    .vrf_r0_addr(vrf_r0_addr),
    .vrf_r1_addr(vrf_r1_addr),
    .vrf_r2_addr(vrf_r2_addr),
    .vrf_r3_addr(vrf_r3_addr),
    .vrf_r4_addr(vrf_r4_addr),
    .vrf_r5_addr(vrf_r5_addr),
    .vrf_r6_addr(vrf_r6_addr),
    .vrf_r7_addr(vrf_r7_addr),
    .vrf_r8_addr(vrf_r8_addr),
    .vrf_r9_addr(vrf_r9_addr),
    .vrf_r10_addr(vrf_r10_addr),
    .vrf_r0_beat(vrf_r0_beat),
    .vrf_r1_beat(vrf_r1_beat),
    .vrf_r2_beat(vrf_r2_beat),
    .vrf_r3_beat(vrf_r3_beat),
    .vrf_r4_beat(vrf_r4_beat),
    .vrf_r5_beat(vrf_r5_beat),
    .vrf_r6_beat(vrf_r6_beat),
    .vrf_r7_beat(vrf_r7_beat),
    .vrf_r8_beat(vrf_r8_beat),
    .vrf_r9_beat(vrf_r9_beat),
    .vrf_r10_beat(vrf_r10_beat),
    .vrf_r0_data(vrf_r0_data),
    .vrf_r1_data(vrf_r1_data),
    .vrf_r2_data(vrf_r2_data),
    .vrf_r3_data(vrf_r3_data),
    .vrf_r4_data(vrf_r4_data),
    .vrf_r5_data(vrf_r5_data),
    .vrf_r6_data(vrf_r6_data),
    .vrf_r7_data(vrf_r7_data),
    .vrf_r8_data(vrf_r8_data),
    .vrf_r9_data(vrf_r9_data),
    .vrf_r10_data(vrf_r10_data),
    .vrf_w0_en(vrf_w0_en),
    .vrf_w1_en(vrf_w1_en),
    .vrf_w2_en(vrf_w2_en),
    .vrf_w3_en(vrf_w3_en),
    .vrf_w4_en(vrf_w4_en),
    .vrf_w0_addr(vrf_w0_addr),
    .vrf_w1_addr(vrf_w1_addr),
    .vrf_w2_addr(vrf_w2_addr),
    .vrf_w3_addr(vrf_w3_addr),
    .vrf_w4_addr(vrf_w4_addr),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w3_data(vrf_w3_data),
    .vrf_w4_data(vrf_w4_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_mask(vrf_w3_mask),
    .vrf_w4_mask(vrf_w4_mask),
    .vrf_w5_en(vrf_w5_en),
    .vrf_w5_addr(vrf_w5_addr),
    .vrf_w5_data(vrf_w5_data),
    .vrf_w5_mask(vrf_w5_mask),
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n)
);
kv_vconn #(
    .ACE_SP_WRITE_PORT(ACE_SP_WRITE_PORT),
    .BYPASSW(BYPASSW),
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN),
    .VMAC2_TYPE(VMAC2_TYPE)
) u_vconn (
    .vrf_r0_valid(vrf_r0_valid),
    .vrf_r0_ready(vrf_r0_ready),
    .vrf_r0_fu(vrf_r0_fu),
    .vrf_r0_bypass_sel(vrf_r0_bypass_sel),
    .vrf_r0_bypass_en(vrf_r0_bypass_en),
    .vrf_r0_last(vrf_r0_last),
    .vrf_r1_valid(vrf_r1_valid),
    .vrf_r1_ready(vrf_r1_ready),
    .vrf_r1_fu(vrf_r1_fu),
    .vrf_r1_bypass_sel(vrf_r1_bypass_sel),
    .vrf_r1_bypass_en(vrf_r1_bypass_en),
    .vrf_r1_last(vrf_r1_last),
    .vrf_r2_valid(vrf_r2_valid),
    .vrf_r2_ready(vrf_r2_ready),
    .vrf_r2_fu(vrf_r2_fu),
    .vrf_r2_bypass_sel(vrf_r2_bypass_sel),
    .vrf_r2_bypass_en(vrf_r2_bypass_en),
    .vrf_r2_last(vrf_r2_last),
    .vrf_r3_valid(vrf_r3_valid),
    .vrf_r3_ready(vrf_r3_ready),
    .vrf_r3_fu(vrf_r3_fu),
    .vrf_r3_bypass_sel(vrf_r3_bypass_sel),
    .vrf_r3_bypass_en(vrf_r3_bypass_en),
    .vrf_r3_last(vrf_r3_last),
    .vrf_r4_valid(vrf_r4_valid),
    .vrf_r4_ready(vrf_r4_ready),
    .vrf_r4_fu(vrf_r4_fu),
    .vrf_r4_bypass_sel(vrf_r4_bypass_sel),
    .vrf_r4_bypass_en(vrf_r4_bypass_en),
    .vrf_r4_last(vrf_r4_last),
    .vrf_r5_valid(vrf_r5_valid),
    .vrf_r5_ready(vrf_r5_ready),
    .vrf_r5_fu(vrf_r5_fu),
    .vrf_r5_bypass_sel(vrf_r5_bypass_sel),
    .vrf_r5_bypass_en(vrf_r5_bypass_en),
    .vrf_r5_last(vrf_r5_last),
    .vrf_r6_valid(vrf_r6_valid),
    .vrf_r6_ready(vrf_r6_ready),
    .vrf_r6_fu(vrf_r6_fu),
    .vrf_r6_bypass_sel(vrf_r6_bypass_sel),
    .vrf_r6_bypass_en(vrf_r6_bypass_en),
    .vrf_r6_last(vrf_r6_last),
    .vrf_r7_valid(vrf_r7_valid),
    .vrf_r7_ready(vrf_r7_ready),
    .vrf_r7_fu(vrf_r7_fu),
    .vrf_r7_bypass_sel(vrf_r7_bypass_sel),
    .vrf_r7_bypass_en(vrf_r7_bypass_en),
    .vrf_r7_last(vrf_r7_last),
    .vrf_w0_valid(vrf_w0_valid),
    .vrf_w0_fu(vrf_w0_fu),
    .vrf_w0_last(vrf_w0_last),
    .vrf_w0_ready(vrf_w0_ready),
    .vrf_w1_valid(vrf_w1_valid),
    .vrf_w1_fu(vrf_w1_fu),
    .vrf_w1_last(vrf_w1_last),
    .vrf_w1_ready(vrf_w1_ready),
    .vrf_w2_valid(vrf_w2_valid),
    .vrf_w2_fu(vrf_w2_fu),
    .vrf_w2_ready(vrf_w2_ready),
    .vrf_w2_last(vrf_w2_last),
    .vrf_w3_valid(vrf_w3_valid),
    .vrf_w3_fu(vrf_w3_fu),
    .vrf_w3_last(vrf_w3_last),
    .vrf_w3_ready(vrf_w3_ready),
    .vrf_w4_valid(vrf_w4_valid),
    .vrf_w4_fu(vrf_w4_fu),
    .vrf_w4_last(vrf_w4_last),
    .vrf_w4_ready(vrf_w4_ready),
    .vrf_r0_data(vrf_r0_data),
    .vrf_r1_data(vrf_r1_data),
    .vrf_r2_data(vrf_r2_data),
    .vrf_r3_data(vrf_r3_data),
    .vrf_r4_data(vrf_r4_data),
    .vrf_r5_data(vrf_r5_data),
    .vrf_r6_data(vrf_r6_data),
    .vrf_r7_data(vrf_r7_data),
    .vrf_w0_data(vrf_w0_data),
    .vrf_w1_data(vrf_w1_data),
    .vrf_w2_data(vrf_w2_data),
    .vrf_w3_data(vrf_w3_data),
    .vrf_w4_data(vrf_w4_data),
    .vrf_w0_mask(vrf_w0_mask),
    .vrf_w1_mask(vrf_w1_mask),
    .vrf_w2_mask(vrf_w2_mask),
    .vrf_w3_mask(vrf_w3_mask),
    .vrf_w4_mask(vrf_w4_mask),
    .vrf_r8_valid(vrf_r8_valid),
    .vrf_r8_ready(vrf_r8_ready),
    .vrf_r8_fu(vrf_r8_fu),
    .vrf_r8_bypass_sel(vrf_r8_bypass_sel),
    .vrf_r8_bypass_en(vrf_r8_bypass_en),
    .vrf_r8_last(vrf_r8_last),
    .vrf_r8_data(vrf_r8_data),
    .vrf_r9_valid(vrf_r9_valid),
    .vrf_r9_ready(vrf_r9_ready),
    .vrf_r9_fu(vrf_r9_fu),
    .vrf_r9_bypass_sel(vrf_r9_bypass_sel),
    .vrf_r9_bypass_en(vrf_r9_bypass_en),
    .vrf_r9_last(vrf_r9_last),
    .vrf_r9_data(vrf_r9_data),
    .vrf_r10_valid(vrf_r10_valid),
    .vrf_r10_ready(vrf_r10_ready),
    .vrf_r10_fu(vrf_r10_fu),
    .vrf_r10_bypass_sel(vrf_r10_bypass_sel),
    .vrf_r10_bypass_en(vrf_r10_bypass_en),
    .vrf_r10_last(vrf_r10_last),
    .vrf_r10_data(vrf_r10_data),
    .vrf_w5_valid(vrf_w5_valid),
    .vrf_w5_fu(vrf_w5_fu),
    .vrf_w5_last(vrf_w5_last),
    .vrf_w5_ready(vrf_w5_ready),
    .vrf_w5_data(vrf_w5_data),
    .vrf_w5_mask(vrf_w5_mask),
    .valu_vs1_rvalid(valu_vs1_rvalid_raw),
    .valu_vs1_rready(valu_vs1_rready),
    .valu_vs1_rdata(valu_vs1_rdata_raw),
    .valu_vs1_rlast(valu_vs1_rlast_raw),
    .valu_vs2_rvalid(valu_vs2_rvalid_raw),
    .valu_vs2_rready(valu_vs2_rready),
    .valu_vs2_rdata(valu_vs2_rdata_raw),
    .valu_vs2_rlast(valu_vs2_rlast_raw),
    .valu_vs3_rvalid(valu_vs3_rvalid_raw),
    .valu_vs3_rready(valu_vs3_rready),
    .valu_vs3_rdata(valu_vs3_rdata_raw),
    .valu_vs3_rlast(valu_vs3_rlast_raw),
    .valu_vd_wvalid(valu_vd_wvalid),
    .valu_vd_wready(valu_vd_wready),
    .valu_vd_wdata(valu_vd_wdata),
    .valu_vd_wmask(valu_vd_wmask),
    .valu_vd_wlast(nds_unused_valu_vd_wlast),
    .vmac_vs1_rvalid(vmac_vs1_rvalid),
    .vmac_vs1_rready(vmac_vs1_rready),
    .vmac_vs1_rdata(vmac_vs1_rdata),
    .vmac_vs1_rlast(vmac_vs1_rlast),
    .vmac_vs2_rvalid(vmac_vs2_rvalid),
    .vmac_vs2_rready(vmac_vs2_rready),
    .vmac_vs2_rdata(vmac_vs2_rdata),
    .vmac_vs2_rlast(vmac_vs2_rlast),
    .vmac_vs3_rvalid(vmac_vs3_rvalid),
    .vmac_vs3_rready(vmac_vs3_rready),
    .vmac_vs3_rdata(vmac_vs3_rdata),
    .vmac_vs3_rlast(vmac_vs3_rlast),
    .vmac_vd_wvalid(vmac_vd_wvalid),
    .vmac_vd_wready(vmac_vd_wready),
    .vmac_vd_wdata(vmac_vd_wdata),
    .vmac_vd_wmask(vmac_vd_wmask),
    .vmac_vd_wlast(nds_unused_vmac_vd_wlast),
    .vmac2_vs1_rvalid(vmac2_vs1_rvalid),
    .vmac2_vs1_rready(vmac2_vs1_rready),
    .vmac2_vs1_rdata(vmac2_vs1_rdata),
    .vmac2_vs1_rlast(vmac2_vs1_rlast),
    .vmac2_vs2_rvalid(vmac2_vs2_rvalid),
    .vmac2_vs2_rready(vmac2_vs2_rready),
    .vmac2_vs2_rdata(vmac2_vs2_rdata),
    .vmac2_vs2_rlast(vmac2_vs2_rlast),
    .vmac2_vs3_rvalid(vmac2_vs3_rvalid),
    .vmac2_vs3_rready(vmac2_vs3_rready),
    .vmac2_vs3_rdata(vmac2_vs3_rdata),
    .vmac2_vs3_rlast(vmac2_vs3_rlast),
    .vmac2_vd_wvalid(vmac2_vd_wvalid),
    .vmac2_vd_wready(vmac2_vd_wready),
    .vmac2_vd_wdata(vmac2_vd_wdata),
    .vmac2_vd_wmask(vmac2_vd_wmask),
    .vmac2_vd_wlast(nds_unused_vmac2_vd_wlast),
    .vfmis_vs1_rvalid(vfmis_vs1_rvalid),
    .vfmis_vs1_rready(vfmis_vs1_rready),
    .vfmis_vs1_rdata(vfmis_vs1_rdata),
    .vfmis_vs1_rlast(vfmis_vs1_rlast),
    .vfmis_vs2_rvalid(vfmis_vs2_rvalid),
    .vfmis_vs2_rready(vfmis_vs2_rready),
    .vfmis_vs2_rdata(vfmis_vs2_rdata),
    .vfmis_vs2_rlast(vfmis_vs2_rlast),
    .vfmis_vs3_rvalid(vfmis_vs3_rvalid),
    .vfmis_vs3_rready(vfmis_vs3_rready),
    .vfmis_vs3_rdata(vfmis_vs3_rdata),
    .vfmis_vs3_rlast(vfmis_vs3_rlast),
    .vfmis_vd_wvalid(vfmis_vd_wvalid),
    .vfmis_vd_wdata(vfmis_vd_wdata),
    .vfmis_vd_wmask(vfmis_vd_wmask),
    .vfmis_vd_wready(vfmis_vd_wready),
    .vfmis_vd_wlast(nds_unused_vfmis_vd_wlast),
    .vlsu_vs2_rvalid(vlsu_vs2_rvalid),
    .vlsu_vs2_rready(vlsu_vs2_rready),
    .vlsu_vs2_rdata(vlsu_vs2_rdata),
    .vlsu_vs2_rlast(vlsu_vs2_rlast),
    .vlsu_vs3_rvalid(vlsu_vs3_rvalid),
    .vlsu_vs3_rready(vlsu_vs3_rready),
    .vlsu_vs3_rdata(vlsu_vs3_rdata),
    .vlsu_vs3_rlast(vlsu_vs3_rlast),
    .vlsu_vd_wvalid(vlsu_vd_wvalid),
    .vlsu_vd_wready(vlsu_vd_wready),
    .vlsu_vd_wdata(vlsu_vd_wdata),
    .vlsu_vd_wmask(vlsu_vd_wmask),
    .vlsu_vd_wlast(vlsu_vd_wlast),
    .vsp_vs3_rvalid(vsp_vs3_rvalid),
    .vsp_vs3_rready(vsp_vs3_rready),
    .vsp_vs3_rdata(vsp_vs3_rdata),
    .vsp_vs3_rlast(vsp_vs3_rlast),
    .vsp_vd_wvalid(vsp_vd_wvalid),
    .vsp_vd_wready(vsp_vd_wready),
    .vsp_vd_wdata(vsp_vd_wdata),
    .vsp_vd_wmask(vsp_vd_wmask),
    .vsp_vd_wlast(vsp_vd_wlast),
    .vdiv_vs1_rvalid(vdiv_vs1_rvalid),
    .vdiv_vs1_rready(vdiv_vs1_rready),
    .vdiv_vs1_rdata(vdiv_vs1_rdata),
    .vdiv_vs1_rlast(vdiv_vs1_rlast),
    .vdiv_vs2_rvalid(vdiv_vs2_rvalid),
    .vdiv_vs2_rready(vdiv_vs2_rready),
    .vdiv_vs2_rdata(vdiv_vs2_rdata),
    .vdiv_vs2_rlast(vdiv_vs2_rlast),
    .vdiv_vd_wdata(vdiv_vd_wdata),
    .vdiv_vd_wmask(vdiv_vd_wmask),
    .vdiv_vd_wvalid(vdiv_vd_wvalid),
    .vdiv_vd_wready(vdiv_vd_wready),
    .vdiv_vd_wlast(vdiv_vd_wlast),
    .vpermut_vs1_rvalid(vpermut_vs1_rvalid),
    .vpermut_vs1_rready(vpermut_vs1_rready),
    .vpermut_vs1_rdata(vpermut_vs1_rdata),
    .vpermut_vs1_rlast(nds_unused_vpermut_vs1_rlast),
    .vpermut_vs2_rvalid(vpermut_vs2_rvalid),
    .vpermut_vs2_rready(vpermut_vs2_rready),
    .vpermut_vs2_rdata(vpermut_vs2_rdata),
    .vpermut_vs2_rlast(nds_unused_vpermut_vs2_rlast),
    .vpermut_vd_wdata(vpermut_vd_wdata),
    .vpermut_vd_wmask(vpermut_vd_wmask),
    .vpermut_vd_wvalid(vpermut_vd_wvalid),
    .vpermut_vd_wready(vpermut_vd_wready),
    .vpermut_vd_wlast(nds_unused_vpermut_vd_wlast),
    .vfdiv_vs1_rvalid(vfdiv_vs1_rvalid),
    .vfdiv_vs1_rready(vfdiv_vs1_rready),
    .vfdiv_vs1_rdata(vfdiv_vs1_rdata),
    .vfdiv_vs1_rlast(nds_unused_vfdiv_vs1_rlast),
    .vfdiv_vs2_rvalid(vfdiv_vs2_rvalid),
    .vfdiv_vs2_rready(vfdiv_vs2_rready),
    .vfdiv_vs2_rdata(vfdiv_vs2_rdata),
    .vfdiv_vs2_rlast(nds_unused_vfdiv_vs2_rlast),
    .vfdiv_vd_wdata(vfdiv_vd_wdata),
    .vfdiv_vd_wmask(vfdiv_vd_wmask),
    .vfdiv_vd_wvalid(vfdiv_vd_wvalid),
    .vfdiv_vd_wready(vfdiv_vd_wready),
    .vfdiv_vd_wlast(nds_unused_vfdiv_vd_wlast),
    .vmask_vs1_rvalid(vmask_vs1_rvalid),
    .vmask_vs1_rready(vmask_vs1_rready),
    .vmask_vs1_rdata(vmask_vs1_rdata),
    .vmask_vs1_rlast(vmask_vs1_rlast),
    .vmask_vs2_rvalid(vmask_vs2_rvalid),
    .vmask_vs2_rready(vmask_vs2_rready),
    .vmask_vs2_rdata(vmask_vs2_rdata),
    .vmask_vs2_rlast(vmask_vs2_rlast),
    .vmask_vs3_rvalid(vmask_vs3_rvalid),
    .vmask_vs3_rready(vmask_vs3_rready),
    .vmask_vs3_rdata(vmask_vs3_rdata),
    .vmask_vs3_rlast(vmask_vs3_rlast),
    .vmask_vd_wdata(vmask_vd_wdata),
    .vmask_vd_wmask(vmask_vd_wmask),
    .vmask_vd_wvalid(vmask_vd_wvalid),
    .vmask_vd_wready(vmask_vd_wready),
    .vmask_vd_wlast(vmask_vd_wlast),
    .vace_vs1_rvalid(vace_vs1_rvalid),
    .vace_vs1_rready(vace_vs1_rready),
    .vace_vs1_rdata(vace_vs1_rdata),
    .vace_vs1_rlast(vace_vs1_rlast),
    .vace_vs2_rvalid(vace_vs2_rvalid),
    .vace_vs2_rready(vace_vs2_rready),
    .vace_vs2_rdata(vace_vs2_rdata),
    .vace_vs2_rlast(vace_vs2_rlast),
    .vace_vs3_rvalid(vace_vs3_rvalid),
    .vace_vs3_rready(vace_vs3_rready),
    .vace_vs3_rdata(vace_vs3_rdata),
    .vace_vs3_rlast(vace_vs3_rlast),
    .vace_vd_wdata(vace_vd_wdata),
    .vace_vd_wmask(vace_vd_wmask),
    .vace_vd_wvalid(vace_vd_wvalid),
    .vace_vd_wready(vace_vd_wready),
    .vace_vd_wlast(vace_vd_wlast)
);
kv_vlsu #(
    .DLEN(DLEN),
    .DLM_BASE(DLM_BASE),
    .DLM_SIZE_KB(DLM_SIZE_KB),
    .ELEN(ELEN),
    .HVM_ADDR_WIDTH(HVM_ADDR_WIDTH),
    .HVM_BASE(HVM_BASE),
    .HVM_SIZE_KB(HVM_SIZE_KB),
    .ILM_BASE(ILM_BASE),
    .ILM_SIZE_KB(ILM_SIZE_KB),
    .L2_SOURCE_WIDTH(L2_SOURCE_WIDTH),
    .MMU_SCHEME_INT(MMU_SCHEME_INT),
    .PALEN(PALEN),
    .PMA_SUPPORT_INT(PMA_SUPPORT_INT),
    .PMP_SUPPORT_INT(PMP_SUPPORT_INT),
    .TL_SINK_WIDTH(TL_SINK_WIDTH),
    .VALEN(VALEN),
    .VLEN(VLEN),
    .VLSU_BUF_DEPTH(VLSU_BUF_DEPTH),
    .VLSU_DATA_WIDTH(VLSU_DATA_WIDTH),
    .VLSU_MSHR_DEPTH(VLSU_MSHR_DEPTH),
    .VRF_LW(VRF_LW),
    .VTLB_ENTRIES(VTLB_ENTRIES)
) u_vlsu (
    .vpu_block_pending(vpu_block_pending),
    .vpu_loadstore_pending(vpu_loadstore_pending),
    .vpu_vlsu_pending(vpu_vlsu_pending),
    .vlsu_cm_a_address(vlsu_cm_a_address),
    .vlsu_cm_a_corrupt(vlsu_cm_a_corrupt),
    .vlsu_cm_a_data(vlsu_cm_a_data),
    .vlsu_cm_a_mask(vlsu_cm_a_mask),
    .vlsu_cm_a_opcode(vlsu_cm_a_opcode),
    .vlsu_cm_a_param(vlsu_cm_a_param),
    .vlsu_cm_a_ready(vlsu_cm_a_ready),
    .vlsu_cm_a_shareable(vlsu_cm_a_shareable),
    .vlsu_cm_a_size(vlsu_cm_a_size),
    .vlsu_cm_a_source(vlsu_cm_a_source),
    .vlsu_cm_a_user(vlsu_cm_a_user),
    .vlsu_cm_a_valid(vlsu_cm_a_valid),
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
    .vlsu_hr_events(vlsu_hr_events),
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
    .vlsu_vd_wdata(vlsu_vd_wdata),
    .vlsu_vd_wlast(vlsu_vd_wlast),
    .vlsu_vd_wmask(vlsu_vd_wmask),
    .vlsu_vd_wready(vlsu_vd_wready),
    .vlsu_vd_wvalid(vlsu_vd_wvalid),
    .vlsu_vm_a_address(vlsu_vm_a_address),
    .vlsu_vm_a_data(vlsu_vm_a_data),
    .vlsu_vm_a_mask(vlsu_vm_a_mask),
    .vlsu_vm_a_opcode(vlsu_vm_a_opcode),
    .vlsu_vm_a_ready(vlsu_vm_a_ready),
    .vlsu_vm_a_size(vlsu_vm_a_size),
    .vlsu_vm_a_valid(vlsu_vm_a_valid),
    .vlsu_vm_d_corrupt(vlsu_vm_d_corrupt),
    .vlsu_vm_d_data(vlsu_vm_d_data),
    .vlsu_vm_d_denied(vlsu_vm_d_denied),
    .vlsu_vm_d_opcode(vlsu_vm_d_opcode),
    .vlsu_vm_d_ready(vlsu_vm_d_ready),
    .vlsu_vm_d_size(vlsu_vm_d_size),
    .vlsu_vm_d_valid(vlsu_vm_d_valid),
    .vpu_ls_async_ecc_corr(vpu_ls_async_ecc_corr),
    .vpu_ls_async_ecc_error(vpu_ls_async_ecc_error),
    .vpu_ls_async_ecc_ramid(vpu_ls_async_ecc_ramid),
    .vpu_ls_async_ecc_read(vpu_ls_async_ecc_read),
    .vpu_ls_async_read_error(vpu_ls_async_read_error),
    .vpu_ls_async_write_error(vpu_ls_async_write_error),
    .vlsu_vs2_rdata(vlsu_vs2_rdata),
    .vlsu_vs2_rvalid(vlsu_vs2_rvalid),
    .vlsu_ack_element(vpu_ls_ack_element),
    .vlsu_ack_status(vpu_ls_ack_status),
    .vlsu_ack_tval(vpu_ls_ack_tval),
    .vlsu_ack_valid(vpu_ls_ack_valid),
    .vlsu_cmt_kill(vlsu_cmt_kill),
    .vlsu_cmt_valid(vlsu_cmt_valid),
    .vlsu_dispatch_ctrl(vlsu_dispatch_ctrl),
    .vlsu_dispatch_op1(vlsu_dispatch_op1),
    .vlsu_dispatch_op2(vlsu_dispatch_op2),
    .vlsu_dispatch_ready(vlsu_dispatch_ready),
    .vlsu_dispatch_v0t(v0t),
    .vlsu_dispatch_valid(vlsu_dispatch_valid),
    .vlsu_dispatch_vd_len(vlsu_dispatch_vd_len),
    .vlsu_dispatch_vs2_len(vlsu_dispatch_vs2_len),
    .vlsu_dispatch_vs3_len(vlsu_dispatch_vs3_len),
    .vlsu_vs2_rlast(vlsu_vs2_rlast),
    .vlsu_vs2_rready(vlsu_vs2_rready),
    .vlsu_vs3_rdata(vlsu_vs3_rdata),
    .vlsu_vs3_rlast(vlsu_vs3_rlast),
    .vlsu_vs3_rready(vlsu_vs3_rready),
    .vlsu_vs3_rvalid(vlsu_vs3_rvalid),
    .vpu_pma_req_pa(vpu_pma_req_pa),
    .vpu_pma_resp_fault(vpu_pma_resp_fault),
    .vpu_pma_resp_hvm(vpu_pma_resp_hvm),
    .vpu_pma_resp_mtype(vpu_pma_resp_mtype),
    .vpu_pma_resp_nosh(vpu_pma_resp_nosh),
    .vpu_pmp_req_pa(vpu_pmp_req_pa),
    .vpu_pmp_resp_permission(vpu_pmp_resp_permission),
    .vpu_vtlb_flush(vpu_vtlb_flush),
    .vpu_vtlb_miss_data(vpu_vtlb_miss_data),
    .vpu_vtlb_miss_req(vpu_vtlb_miss_req),
    .vpu_vtlb_miss_resp(vpu_vtlb_miss_resp),
    .vpu_vtlb_miss_vpn(vpu_vtlb_miss_vpn),
    .vpu_vlsu_clk(vpu_vlsu_clk),
    .vpu_reset_n(vpu_reset_n)
);
generate
    if (ACE_STREAM_PORT == 1) begin:gen_vsp
        kv_vsp #(
            .ACE_SP_MODE(ACE_SP_MODE),
            .DLEN(DLEN),
            .RAR_SUPPORT(RAR_SUPPORT),
            .VEQ_DEPTH(VSP_VEQ_DEPTH),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .VSP_DATA_WIDTH(ASP_DATA_WIDTH)
        ) u_vsp (
            .vsp_standby_ready(vsp_standby_ready),
            .vsp_vd_wlast(vsp_vd_wlast),
            .ace_streaming_data_in(ace_streaming_data_in),
            .ace_streaming_data_in_ready(ace_streaming_data_in_ready),
            .ace_streaming_data_in_valid(ace_streaming_data_in_valid),
            .cp_cpu_rdata(cp_cpu_rdata),
            .cp_cpu_rdata_ready(cp_cpu_rdata_ready),
            .cp_cpu_rdata_valid(cp_cpu_rdata_valid),
            .vpu_reset_n(vpu_reset_n),
            .vpu_vsp_clk(vpu_vsp_clk),
            .vpu_sp_ex_done(vpu_sp_ex_done),
            .vpu_sp_ex_error(vpu_sp_ex_error),
            .vpu_sp_ex_store(vpu_sp_ex_store),
            .vsp_srf_waddr(vsp_srf_waddr),
            .vsp_srf_wdata(vsp_srf_wdata),
            .vsp_srf_wfrf(vsp_srf_wfrf),
            .vsp_srf_wready(vsp_srf_wready),
            .vsp_srf_wvalid(vsp_srf_wvalid),
            .ace_streaming_data_out(ace_streaming_data_out),
            .ace_streaming_data_out_bwe(ace_streaming_data_out_bwe),
            .ace_streaming_data_out_ready(ace_streaming_data_out_ready),
            .ace_streaming_data_out_valid(ace_streaming_data_out_valid),
            .cpu_cp_wdata(cpu_cp_wdata),
            .cpu_cp_wdata_bwe(cpu_cp_wdata_bwe),
            .cpu_cp_wdata_ready(cpu_cp_wdata_ready),
            .cpu_cp_wdata_valid(cpu_cp_wdata_valid),
            .vsp_vd_wready(vsp_vd_wready),
            .vsp_vd_wdata(vsp_vd_wdata),
            .vsp_vd_wvalid(vsp_vd_wvalid),
            .vsp_vd_wmask(vsp_vd_wmask),
            .vsp_cmt_kill(vsp_cmt_kill),
            .vsp_cmt_op1(vsp_cmt_op1),
            .vsp_cmt_valid(vsp_cmt_valid),
            .vsp_dispatch_ctrl(vsp_dispatch_ctrl),
            .vsp_dispatch_op1(vsp_dispatch_op1),
            .vsp_dispatch_op1_hazard(vsp_dispatch_op1_hazard),
            .vsp_dispatch_op2(vsp_dispatch_op2),
            .vsp_dispatch_ready(vsp_dispatch_ready),
            .vsp_dispatch_v0t(v0t),
            .vsp_dispatch_valid(vsp_dispatch_valid),
            .vsp_dispatch_vd_len(vsp_dispatch_vd_len),
            .vsp_dispatch_vs3_len(vsp_dispatch_vs3_len),
            .vsp_vs3_rdata(vsp_vs3_rdata),
            .vsp_vs3_rlast(vsp_vs3_rlast),
            .vsp_vs3_rready(vsp_vs3_rready),
            .vsp_vs3_rvalid(vsp_vs3_rvalid)
        );
    end
endgenerate
generate
    if (ACE_STREAM_PORT == 0) begin:gen_vsp_stub
        kv_vsp_stub #(
            .ACE_SP_MODE(ACE_SP_MODE),
            .DLEN(DLEN),
            .RAR_SUPPORT(RAR_SUPPORT),
            .VEQ_DEPTH(VSP_VEQ_DEPTH),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW),
            .VSP_DATA_WIDTH(ASP_DATA_WIDTH)
        ) u_vsp_stub (
            .vsp_standby_ready(vsp_standby_ready),
            .vsp_vd_wlast(vsp_vd_wlast),
            .ace_streaming_data_in(ace_streaming_data_in),
            .ace_streaming_data_in_ready(ace_streaming_data_in_ready),
            .ace_streaming_data_in_valid(ace_streaming_data_in_valid),
            .cp_cpu_rdata(cp_cpu_rdata),
            .cp_cpu_rdata_ready(cp_cpu_rdata_ready),
            .cp_cpu_rdata_valid(cp_cpu_rdata_valid),
            .vpu_vsp_clk(vpu_vsp_clk),
            .vpu_reset_n(vpu_reset_n),
            .vsp_srf_waddr(vsp_srf_waddr),
            .vsp_srf_wdata(vsp_srf_wdata),
            .vsp_srf_wfrf(vsp_srf_wfrf),
            .vsp_srf_wready(vsp_srf_wready),
            .vsp_srf_wvalid(vsp_srf_wvalid),
            .ace_streaming_data_out(ace_streaming_data_out),
            .ace_streaming_data_out_bwe(ace_streaming_data_out_bwe),
            .ace_streaming_data_out_ready(ace_streaming_data_out_ready),
            .ace_streaming_data_out_valid(ace_streaming_data_out_valid),
            .cpu_cp_wdata(cpu_cp_wdata),
            .cpu_cp_wdata_bwe(cpu_cp_wdata_bwe),
            .cpu_cp_wdata_ready(cpu_cp_wdata_ready),
            .cpu_cp_wdata_valid(cpu_cp_wdata_valid),
            .vsp_vd_wready(vsp_vd_wready),
            .vsp_vd_wdata(vsp_vd_wdata),
            .vsp_vd_wvalid(vsp_vd_wvalid),
            .vsp_vd_wmask(vsp_vd_wmask),
            .vpu_sp_ex_done(vpu_sp_ex_done),
            .vpu_sp_ex_store(vpu_sp_ex_store),
            .vpu_sp_ex_error(vpu_sp_ex_error),
            .vsp_cmt_kill(vsp_cmt_kill),
            .vsp_cmt_op1(vsp_cmt_op1),
            .vsp_cmt_valid(vsp_cmt_valid),
            .vsp_dispatch_ctrl(vsp_dispatch_ctrl),
            .vsp_dispatch_op1(vsp_dispatch_op1),
            .vsp_dispatch_op1_hazard(vsp_dispatch_op1_hazard),
            .vsp_dispatch_op2(vsp_dispatch_op2),
            .vsp_dispatch_ready(vsp_dispatch_ready),
            .vsp_dispatch_v0t(v0t),
            .vsp_dispatch_valid(vsp_dispatch_valid),
            .vsp_dispatch_vd_len(vsp_dispatch_vd_len),
            .vsp_dispatch_vs3_len(vsp_dispatch_vs3_len),
            .vsp_vs3_rdata(vsp_vs3_rdata),
            .vsp_vs3_rlast(vsp_vs3_rlast),
            .vsp_vs3_rready(vsp_vs3_rready),
            .vsp_vs3_rvalid(vsp_vs3_rvalid)
        );
    end
endgenerate

// =========================================================================
// Pipeline registers on 512-bit ALU source operand read data
// Breaks combinational path: VRF → kv_vconn → ALU
// Uses simple registers since VLEN=DLEN=512 (single-beat reads)
// =========================================================================
reg [(DLEN - 1):0] valu_vs1_rdata_pipe;
reg                valu_vs1_rlast_pipe;
reg                valu_vs1_rvalid_pipe;
reg [(DLEN - 1):0] valu_vs2_rdata_pipe;
reg                valu_vs2_rlast_pipe;
reg                valu_vs2_rvalid_pipe;
reg [(DLEN - 1):0] valu_vs3_rdata_pipe;
reg                valu_vs3_rlast_pipe;
reg                valu_vs3_rvalid_pipe;

always_ff @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        valu_vs1_rvalid_pipe <= 1'b0;
        valu_vs2_rvalid_pipe <= 1'b0;
        valu_vs3_rvalid_pipe <= 1'b0;
    end else begin
        // VS1 — register when valid and backpressured (or pipeline slot free)
        if (valu_vs1_rvalid_raw && valu_vs1_rready) begin
            valu_vs1_rvalid_pipe <= 1'b1;
            valu_vs1_rdata_pipe  <= valu_vs1_rdata_raw;
            valu_vs1_rlast_pipe  <= valu_vs1_rlast_raw;
        end else if (valu_vs1_rvalid_pipe && valu_vs1_rready) begin
            valu_vs1_rvalid_pipe <= 1'b0;
        end
        // VS2
        if (valu_vs2_rvalid_raw && valu_vs2_rready) begin
            valu_vs2_rvalid_pipe <= 1'b1;
            valu_vs2_rdata_pipe  <= valu_vs2_rdata_raw;
            valu_vs2_rlast_pipe  <= valu_vs2_rlast_raw;
        end else if (valu_vs2_rvalid_pipe && valu_vs2_rready) begin
            valu_vs2_rvalid_pipe <= 1'b0;
        end
        // VS3
        if (valu_vs3_rvalid_raw && valu_vs3_rready) begin
            valu_vs3_rvalid_pipe <= 1'b1;
            valu_vs3_rdata_pipe  <= valu_vs3_rdata_raw;
            valu_vs3_rlast_pipe  <= valu_vs3_rlast_raw;
        end else if (valu_vs3_rvalid_pipe && valu_vs3_rready) begin
            valu_vs3_rvalid_pipe <= 1'b0;
        end
    end
end

assign valu_vs1_rdata  = valu_vs1_rdata_pipe;
assign valu_vs1_rlast  = valu_vs1_rlast_pipe;
assign valu_vs1_rvalid = valu_vs1_rvalid_pipe;
assign valu_vs2_rdata  = valu_vs2_rdata_pipe;
assign valu_vs2_rlast  = valu_vs2_rlast_pipe;
assign valu_vs2_rvalid = valu_vs2_rvalid_pipe;
assign valu_vs3_rdata  = valu_vs3_rdata_pipe;
assign valu_vs3_rlast  = valu_vs3_rlast_pipe;
assign valu_vs3_rvalid = valu_vs3_rvalid_pipe;

// =========================================================================
kv_vpu_lane_top #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .FELEN(FELEN),
    .VLEN(VLEN),
    .VMAC2_TYPE(VMAC2_TYPE),
    .VRF_LW(VRF_LW)
) u_lane_top (
    .vmac_fflags_set(vmac_fflags_set),
    .vmac2_fflags_set(vmac2_fflags_set),
    .vfmis_fflags_set(vfmis_fflags_set),
    .valu_vxsat_set(valu_vxsat_set),
    .vmac_vxsat_set(vmac_vxsat_set),
    .vmac2_vxsat_set(vmac2_vxsat_set),
    .valu_standby_ready(valu_standby_ready),
    .vmac_standby_ready(vmac_standby_ready),
    .vfmis_standby_ready(vfmis_standby_ready),
    .valu_cmt_kill(valu_cmt_kill),
    .valu_cmt_op1(valu_cmt_op1),
    .valu_cmt_valid(valu_cmt_valid),
    .valu_dispatch_ctrl(valu_dispatch_ctrl),
    .valu_dispatch_vd_len(valu_dispatch_vd_len),
    .valu_dispatch_vxrm(valu_dispatch_vxrm),
    .valu_dispatch_op1(valu_dispatch_op1),
    .valu_dispatch_op1_hazard(valu_dispatch_op1_hazard),
    .valu_dispatch_ready(valu_dispatch_ready),
    .valu_dispatch_v0t(v0t),
    .valu_dispatch_valid(valu_dispatch_valid),
    .valu_vd_wdata(valu_vd_wdata),
    .valu_vd_wmask(valu_vd_wmask),
    .valu_vd_wready(valu_vd_wready),
    .valu_vd_wvalid(valu_vd_wvalid),
    .valu_vs1_rdata(valu_vs1_rdata),
    .valu_vs1_rlast(valu_vs1_rlast),
    .valu_vs1_rready(valu_vs1_rready),
    .valu_vs1_rvalid(valu_vs1_rvalid),
    .valu_vs2_rdata(valu_vs2_rdata),
    .valu_vs2_rlast(valu_vs2_rlast),
    .valu_vs2_rready(valu_vs2_rready),
    .valu_vs2_rvalid(valu_vs2_rvalid),
    .valu_vs3_rdata(valu_vs3_rdata),
    .valu_vs3_rlast(valu_vs3_rlast),
    .valu_vs3_rready(valu_vs3_rready),
    .valu_vs3_rvalid(valu_vs3_rvalid),
    .vfmis_cmt_kill(vfmis_cmt_kill),
    .vfmis_cmt_op1(vfmis_cmt_op1),
    .vfmis_cmt_valid(vfmis_cmt_valid),
    .vfmis_dispatch_ctrl(vfmis_dispatch_ctrl),
    .vfmis_dispatch_vd_len(vfmis_dispatch_vd_len),
    .vfmis_dispatch_frm(vfmis_dispatch_frm),
    .vfmis_dispatch_op1(vfmis_dispatch_op1),
    .vfmis_dispatch_op1_hazard(vfmis_dispatch_op1_hazard),
    .vfmis_dispatch_ready(vfmis_dispatch_ready),
    .vfmis_dispatch_v0t(v0t),
    .vfmis_dispatch_valid(vfmis_dispatch_valid),
    .vfmis_vd_wdata(vfmis_vd_wdata),
    .vfmis_vd_wmask(vfmis_vd_wmask),
    .vfmis_vd_wready(vfmis_vd_wready),
    .vfmis_vd_wvalid(vfmis_vd_wvalid),
    .vfmis_vs1_rdata(vfmis_vs1_rdata),
    .vfmis_vs1_rready(vfmis_vs1_rready),
    .vfmis_vs1_rvalid(vfmis_vs1_rvalid),
    .vfmis_vs1_rlast(vfmis_vs1_rlast),
    .vfmis_vs2_rdata(vfmis_vs2_rdata),
    .vfmis_vs2_rready(vfmis_vs2_rready),
    .vfmis_vs2_rvalid(vfmis_vs2_rvalid),
    .vfmis_vs2_rlast(vfmis_vs2_rlast),
    .vfmis_vs3_rdata(vfmis_vs3_rdata),
    .vfmis_vs3_rready(vfmis_vs3_rready),
    .vfmis_vs3_rvalid(vfmis_vs3_rvalid),
    .vfmis_vs3_rlast(vfmis_vs3_rlast),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_cmt_op1(vmac_cmt_op1),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_dispatch_ctrl(vmac_dispatch_ctrl),
    .vmac_dispatch_vd_len(vmac_dispatch_vd_len),
    .vmac_dispatch_frm(vmac_dispatch_frm),
    .vmac_dispatch_vxrm(vmac_dispatch_vxrm),
    .vmac_dispatch_op1(vmac_dispatch_op1),
    .vmac_dispatch_op1_hazard(vmac_dispatch_op1_hazard),
    .vmac_dispatch_ready(vmac_dispatch_ready),
    .vmac_dispatch_v0t(v0t),
    .vmac_dispatch_valid(vmac_dispatch_valid),
    .vmac_vd_wdata(vmac_vd_wdata),
    .vmac_vd_wmask(vmac_vd_wmask),
    .vmac_vd_wready(vmac_vd_wready),
    .vmac_vd_wvalid(vmac_vd_wvalid),
    .vmac_vs1_rdata(vmac_vs1_rdata),
    .vmac_vs1_rlast(vmac_vs1_rlast),
    .vmac_vs1_rready(vmac_vs1_rready),
    .vmac_vs1_rvalid(vmac_vs1_rvalid),
    .vmac_vs2_rdata(vmac_vs2_rdata),
    .vmac_vs2_rlast(vmac_vs2_rlast),
    .vmac_vs2_rready(vmac_vs2_rready),
    .vmac_vs2_rvalid(vmac_vs2_rvalid),
    .vmac_vs3_rdata(vmac_vs3_rdata),
    .vmac_vs3_rlast(vmac_vs3_rlast),
    .vmac_vs3_rready(vmac_vs3_rready),
    .vmac_vs3_rvalid(vmac_vs3_rvalid),
    .vmac2_cmt_kill(vmac2_cmt_kill),
    .vmac2_cmt_op1(vmac2_cmt_op1),
    .vmac2_cmt_valid(vmac2_cmt_valid),
    .vmac2_dispatch_ctrl(vmac2_dispatch_ctrl),
    .vmac2_dispatch_vd_len(vmac2_dispatch_vd_len),
    .vmac2_dispatch_frm(vmac2_dispatch_frm),
    .vmac2_dispatch_vxrm(vmac2_dispatch_vxrm),
    .vmac2_dispatch_op1(vmac2_dispatch_op1),
    .vmac2_dispatch_op1_hazard(vmac2_dispatch_op1_hazard),
    .vmac2_dispatch_ready(vmac2_dispatch_ready),
    .vmac2_dispatch_v0t(v0t),
    .vmac2_dispatch_valid(vmac2_dispatch_valid),
    .vmac2_vd_wdata(vmac2_vd_wdata),
    .vmac2_vd_wmask(vmac2_vd_wmask),
    .vmac2_vd_wready(vmac2_vd_wready),
    .vmac2_vd_wvalid(vmac2_vd_wvalid),
    .vmac2_vs1_rdata(vmac2_vs1_rdata),
    .vmac2_vs1_rready(vmac2_vs1_rready),
    .vmac2_vs1_rvalid(vmac2_vs1_rvalid),
    .vmac2_vs1_rlast(vmac2_vs1_rlast),
    .vmac2_vs2_rdata(vmac2_vs2_rdata),
    .vmac2_vs2_rready(vmac2_vs2_rready),
    .vmac2_vs2_rvalid(vmac2_vs2_rvalid),
    .vmac2_vs2_rlast(vmac2_vs2_rlast),
    .vmac2_vs3_rdata(vmac2_vs3_rdata),
    .vmac2_vs3_rready(vmac2_vs3_rready),
    .vmac2_vs3_rvalid(vmac2_vs3_rvalid),
    .vmac2_vs3_rlast(vmac2_vs3_rlast),
    .vpu_valu_clk(vpu_valu_clk),
    .vpu_vfmis_clk(vpu_vfmis_clk),
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n)
);
kv_vdiv #(
    .DLEN(DLEN),
    .ELEN(ELEN),
    .VLEN(VLEN)
) u_vdiv (
    .vpu_vdiv_clk(vpu_vdiv_clk),
    .vpu_reset_n(vpu_reset_n),
    .vdiv_dispatch_valid(vdiv_dispatch_valid),
    .vdiv_dispatch_op1(vdiv_dispatch_op1),
    .vdiv_dispatch_ctrl(vdiv_dispatch_ctrl),
    .vdiv_dispatch_v0t(v0t),
    .vdiv_dispatch_op1_hazard(vdiv_dispatch_op1_hazard),
    .vdiv_dispatch_ready(vdiv_dispatch_ready),
    .vdiv_cmt_valid(vdiv_cmt_valid),
    .vdiv_cmt_kill(vdiv_cmt_kill),
    .vdiv_cmt_op1(vdiv_cmt_op1),
    .vdiv_vs1_rdata(vdiv_vs1_rdata),
    .vdiv_vs1_rready(vdiv_vs1_rready),
    .vdiv_vs1_rvalid(vdiv_vs1_rvalid),
    .vdiv_vs1_rlast(vdiv_vs1_rlast),
    .vdiv_vs2_rdata(vdiv_vs2_rdata),
    .vdiv_vs2_rready(vdiv_vs2_rready),
    .vdiv_vs2_rvalid(vdiv_vs2_rvalid),
    .vdiv_vs2_rlast(vdiv_vs2_rlast),
    .vdiv_vd_wvalid(vdiv_vd_wvalid),
    .vdiv_vd_wready(vdiv_vd_wready),
    .vdiv_vd_wdata(vdiv_vd_wdata),
    .vdiv_vd_wmask(vdiv_vd_wmask),
    .vdiv_vd_wlast(vdiv_vd_wlast)
);
kv_vpermut #(
    .DLEN(DLEN),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VECTOR_SINT_SUPPORT_INT(VECTOR_SINT_SUPPORT_INT),
    .VLEN(VLEN),
    .VPERMUT_DLEN(VPERMUT_DLEN),
    .VRF_LW(VRF_LW)
) u_vpermut (
    .vpu_vpermut_clk(vpu_vpermut_clk),
    .vpu_reset_n(vpu_reset_n),
    .vpermut_standby_ready(vpermut_standby_ready),
    .vpermut_dispatch_valid(vpermut_dispatch_valid),
    .vpermut_dispatch_op1(vpermut_dispatch_op1),
    .vpermut_dispatch_ctrl(vpermut_dispatch_ctrl),
    .vpermut_dispatch_v0t(v0t),
    .vpermut_dispatch_op1_hazard(vpermut_dispatch_op1_hazard),
    .vpermut_dispatch_vs1_len(vpermut_dispatch_vs1_len),
    .vpermut_dispatch_vs2_len(vpermut_dispatch_vs2_len),
    .vpermut_dispatch_vd_len(vpermut_dispatch_vd_len),
    .vpermut_dispatch_ready(vpermut_dispatch_ready),
    .vpermut_cmt_valid(vpermut_cmt_valid),
    .vpermut_cmt_kill(vpermut_cmt_kill),
    .vpermut_cmt_op1(vpermut_cmt_op1),
    .vpermut_vs1_rdata(vpermut_vs1_rdata),
    .vpermut_vs1_rready(vpermut_vs1_rready),
    .vpermut_vs1_rvalid(vpermut_vs1_rvalid),
    .vpermut_vs2_rdata(vpermut_vs2_rdata),
    .vpermut_vs2_rready(vpermut_vs2_rready),
    .vpermut_vs2_rvalid(vpermut_vs2_rvalid),
    .vpermut_vd_wvalid(vpermut_vd_wvalid),
    .vpermut_vd_wready(vpermut_vd_wready),
    .vpermut_vd_wdata(vpermut_vd_wdata),
    .vpermut_vd_wmask(vpermut_vd_wmask),
    .vpermut_srf_wvalid(vpermut_srf_wvalid),
    .vpermut_srf_wready(vpermut_srf_wready),
    .vpermut_srf_wfrf(vpermut_srf_wfrf),
    .vpermut_srf_waddr(vpermut_srf_waddr),
    .vpermut_srf_wdata(vpermut_srf_wdata)
);
generate
    if (FELEN == 0) begin:gen_vfdiv_stub
        kv_vfdiv_stub #(
            .DLEN(DLEN),
            .ELEN(FELEN),
            .FLEN(FLEN),
            .VFDIV_DLEN(VFDIV_DLEN),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW)
        ) u_vfdiv_stub (
            .vpu_vfdiv_clk(vpu_vfdiv_clk),
            .vpu_reset_n(vpu_reset_n),
            .vfdiv_standby_ready(vfdiv_standby_ready),
            .vfdiv_cmt_kill(vfdiv_cmt_kill),
            .vfdiv_cmt_valid(vfdiv_cmt_valid),
            .vfdiv_cmt_op1(vfdiv_cmt_op1),
            .vfdiv_dispatch_ctrl(vfdiv_dispatch_ctrl),
            .vfdiv_dispatch_vd_len(vfdiv_dispatch_vd_len),
            .vfdiv_dispatch_vs1_len(vfdiv_dispatch_vs1_len),
            .vfdiv_dispatch_vs2_len(vfdiv_dispatch_vs2_len),
            .vfdiv_dispatch_op1(vfdiv_dispatch_op1),
            .vfdiv_dispatch_op1_hazard(vfdiv_dispatch_op1_hazard),
            .vfdiv_dispatch_ready(vfdiv_dispatch_ready),
            .vfdiv_dispatch_v0t(v0t),
            .vfdiv_dispatch_valid(vfdiv_dispatch_valid),
            .vfdiv_dispatch_frm(vfdiv_dispatch_frm),
            .vfdiv_vs1_rdata(vfdiv_vs1_rdata),
            .vfdiv_vs1_rready(vfdiv_vs1_rready),
            .vfdiv_vs1_rvalid(vfdiv_vs1_rvalid),
            .vfdiv_vs2_rdata(vfdiv_vs2_rdata),
            .vfdiv_vs2_rready(vfdiv_vs2_rready),
            .vfdiv_vs2_rvalid(vfdiv_vs2_rvalid),
            .vfdiv_fflags_set(vfdiv_fflags_set),
            .vfdiv_vd_wdata(vfdiv_vd_wdata),
            .vfdiv_vd_wmask(vfdiv_vd_wmask),
            .vfdiv_vd_wready(vfdiv_vd_wready),
            .vfdiv_vd_wvalid(vfdiv_vd_wvalid)
        );
    end
endgenerate
generate
    if (FELEN != 0) begin:gen_vfdiv
        kv_vfdiv #(
            .DLEN(DLEN),
            .ELEN(FELEN),
            .FLEN(FLEN),
            .VFDIV_DLEN(VFDIV_DLEN),
            .VLEN(VLEN),
            .VRF_LW(VRF_LW)
        ) u_vfdiv (
            .vfdiv_standby_ready(vfdiv_standby_ready),
            .vpu_vfdiv_clk(vpu_vfdiv_clk),
            .vpu_reset_n(vpu_reset_n),
            .vfdiv_cmt_kill(vfdiv_cmt_kill),
            .vfdiv_cmt_valid(vfdiv_cmt_valid),
            .vfdiv_cmt_op1(vfdiv_cmt_op1),
            .vfdiv_dispatch_ctrl(vfdiv_dispatch_ctrl),
            .vfdiv_dispatch_frm(vfdiv_dispatch_frm),
            .vfdiv_dispatch_op1(vfdiv_dispatch_op1),
            .vfdiv_dispatch_op1_hazard(vfdiv_dispatch_op1_hazard),
            .vfdiv_dispatch_ready(vfdiv_dispatch_ready),
            .vfdiv_dispatch_v0t(v0t),
            .vfdiv_dispatch_valid(vfdiv_dispatch_valid),
            .vfdiv_dispatch_vd_len(vfdiv_dispatch_vd_len),
            .vfdiv_dispatch_vs1_len(vfdiv_dispatch_vs1_len),
            .vfdiv_dispatch_vs2_len(vfdiv_dispatch_vs2_len),
            .vfdiv_vs1_rdata(vfdiv_vs1_rdata),
            .vfdiv_vs1_rready(vfdiv_vs1_rready),
            .vfdiv_vs1_rvalid(vfdiv_vs1_rvalid),
            .vfdiv_vs2_rdata(vfdiv_vs2_rdata),
            .vfdiv_vs2_rready(vfdiv_vs2_rready),
            .vfdiv_vs2_rvalid(vfdiv_vs2_rvalid),
            .vfdiv_fflags_set(vfdiv_fflags_set),
            .vfdiv_vd_wdata(vfdiv_vd_wdata),
            .vfdiv_vd_wmask(vfdiv_vd_wmask),
            .vfdiv_vd_wready(vfdiv_vd_wready),
            .vfdiv_vd_wvalid(vfdiv_vd_wvalid)
        );
    end
endgenerate
kv_vmask #(
    .DLEN(DLEN),
    .RAR_SUPPORT(RAR_SUPPORT),
    .VLEN(VLEN)
) u_vmask (
    .vpu_vmask_clk(vpu_vmask_clk),
    .vpu_reset_n(vpu_reset_n),
    .vmask_standby_ready(vmask_standby_ready),
    .vmask_dispatch_valid(vmask_dispatch_valid),
    .vmask_dispatch_op1(vmask_dispatch_op1),
    .vmask_dispatch_ctrl(vmask_dispatch_ctrl),
    .vmask_dispatch_v0t(v0t),
    .vmask_dispatch_op1_hazard(vmask_dispatch_op1_hazard),
    .vmask_dispatch_vd_len(vmask_dispatch_vd_len),
    .vmask_dispatch_vs1_len(vmask_dispatch_vs1_len),
    .vmask_dispatch_vs2_len(vmask_dispatch_vs2_len),
    .vmask_dispatch_vs3_len(vmask_dispatch_vs3_len),
    .vmask_dispatch_ready(vmask_dispatch_ready),
    .vmask_cmt_valid(vmask_cmt_valid),
    .vmask_cmt_kill(vmask_cmt_kill),
    .vmask_cmt_op1(vmask_cmt_op1),
    .vmask_vs1_rdata(vmask_vs1_rdata),
    .vmask_vs1_rready(vmask_vs1_rready),
    .vmask_vs1_rvalid(vmask_vs1_rvalid),
    .vmask_vs1_rlast(vmask_vs1_rlast),
    .vmask_vs2_rdata(vmask_vs2_rdata),
    .vmask_vs2_rready(vmask_vs2_rready),
    .vmask_vs2_rvalid(vmask_vs2_rvalid),
    .vmask_vs2_rlast(vmask_vs2_rlast),
    .vmask_vs3_rdata(vmask_vs3_rdata),
    .vmask_vs3_rready(vmask_vs3_rready),
    .vmask_vs3_rvalid(vmask_vs3_rvalid),
    .vmask_vs3_rlast(vmask_vs3_rlast),
    .vmask_vd_wvalid(vmask_vd_wvalid),
    .vmask_vd_wready(vmask_vd_wready),
    .vmask_vd_wdata(vmask_vd_wdata),
    .vmask_vd_wmask(vmask_vd_wmask),
    .vmask_vd_wlast(vmask_vd_wlast),
    .vmask_srf_wvalid(vmask_srf_wvalid),
    .vmask_srf_wready(vmask_srf_wready),
    .vmask_srf_wfrf(vmask_srf_wfrf),
    .vmask_srf_waddr(vmask_srf_waddr),
    .vmask_srf_wdata(vmask_srf_wdata)
);
vace #(
    .DLEN(DLEN),
    .VACE_CTRL_BITS(86),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW)
) u_vace (
    .vace_clk(vpu_vace_clk),
    .vace_reset_n(vpu_reset_n),
    .vace_standby_ready(vace_standby_ready),
    .vace_fflags_set(vace_fflags_set),
    .vace_vxsat_set(vace_vxsat_set),
    .vace_dispatch_valid(vace_dispatch_valid),
    .vace_dispatch_op1(vace_dispatch_op1),
    .vace_dispatch_ctrl(vace_dispatch_ctrl),
    .vace_dispatch_frm(vace_dispatch_frm),
    .vace_dispatch_vxrm(vace_dispatch_vxrm),
    .vace_dispatch_umisc_ctl(vace_dispatch_umisc_ctl),
    .vace_dispatch_v0t(v0t),
    .vace_dispatch_op1_hazard(vace_dispatch_op1_hazard),
    .vace_dispatch_ready(vace_dispatch_ready),
    .vace_dispatch_vd_len(vace_dispatch_vd_len),
    .vace_dispatch_vs1_len(vace_dispatch_vs1_len),
    .vace_dispatch_vs2_len(vace_dispatch_vs2_len),
    .vace_dispatch_vs3_len(vace_dispatch_vs3_len),
    .vace_cmt_valid(vace_cmt_valid),
    .vace_cmt_kill(vace_cmt_kill),
    .vace_cmt_op1(vace_cmt_op1),
    .vace_vs1_rdata(vace_vs1_rdata),
    .vace_vs1_rready(vace_vs1_rready),
    .vace_vs1_rvalid(vace_vs1_rvalid),
    .vace_vs1_rlast(vace_vs1_rlast),
    .vace_vs2_rdata(vace_vs2_rdata),
    .vace_vs2_rready(vace_vs2_rready),
    .vace_vs2_rvalid(vace_vs2_rvalid),
    .vace_vs2_rlast(vace_vs2_rlast),
    .vace_vs3_rdata(vace_vs3_rdata),
    .vace_vs3_rready(vace_vs3_rready),
    .vace_vs3_rvalid(vace_vs3_rvalid),
    .vace_vs3_rlast(vace_vs3_rlast),
    .vace_vd_wvalid(vace_vd_wvalid),
    .vace_vd_wready(vace_vd_wready),
    .vace_vd_wdata(vace_vd_wdata),
    .vace_vd_wmask(vace_vd_wmask),
    .vace_vd_wlast(vace_vd_wlast),
    .vace_srf_wvalid(vace_srf_wvalid),
    .vace_srf_wready(vace_srf_wready),
    .vace_srf_wfrf(vace_srf_wfrf),
    .vace_srf_waddr(vace_srf_waddr),
    .vace_srf_wdata(vace_srf_wdata)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

