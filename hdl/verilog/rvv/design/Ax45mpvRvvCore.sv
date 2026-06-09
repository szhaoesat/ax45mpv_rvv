// Copyright 2025 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Ax45mpvRvvCore — adapter that replaces CoralNPU's RVV backend with Andes
// AX45MPV kv_vpu (VLEN=DLEN=512).  The RvvFrontEnd is kept; RVVCmd signals
// are translated into the flat vpu_req_* interface that kv_vpu consumes.
// NOTE: include files (rvv_backend_define.svh, rvv_backend.svh) are inlined
// into the monolithic RvvCoreMiniAxi.sv by Chisel emit-verilog. They are NOT
// included here to avoid Verilator include-path resolution errors.
// For standalone VCS compilation, add the files via +incdir+ or -y flags.
module Ax45mpvRvvCore #(parameter N = 4,
                        parameter CMD_BUFFER_MAX_CAPACITY = 16,
                        type RegDataT=logic [31:0],
                        type VRegDataT=logic [`VLEN-1:0],
                        type RegAddrT=logic [4:0],
                        type MaskT=logic [`VLENB-1:0]
                        )
(
  input clk,
  input rstn,

  input logic [`VSTART_WIDTH-1:0] vstart,
  input logic [1:0] vxrm,
  input logic vxsat,
  input logic [2:0] frm,

  // Instruction input.
  input logic [N-1:0] inst_valid,
  input RVVInstruction [N-1:0] inst_data,
  output logic [N-1:0] inst_ready,

  // Register file input
  input logic [(2*N)-1:0] reg_read_valid,
  input RegDataT [(2*N)-1:0] reg_read_data,

  // Floating point register file input
  input RegDataT [N-1:0] freg_read_data,

  // Scalar Regfile writeback for configuration functions.
  output logic [N-1:0] reg_write_valid,
  output RegAddrT [N-1:0] reg_write_addr,
  output RegDataT [N-1:0] reg_write_data,

  // Scalar Regfile writeback for non-configuration functions.
  output logic async_rd_valid,
  output RegAddrT async_rd_addr,
  output RegDataT async_rd_data,
  input logic async_rd_ready,

  // Floating Point Regfile writeback.
  output logic async_frd_valid,
  output RegAddrT async_frd_addr,
  output RegDataT async_frd_data,
  input logic async_frd_ready,

  // RVV to LSU
  output  logic     [`NUM_LSU-1:0] uop_lsu_valid_rvv2lsu,
  output  logic     [`NUM_LSU-1:0] uop_lsu_idx_valid_rvv2lsu,
  output  RegAddrT  [`NUM_LSU-1:0] uop_lsu_idx_addr_rvv2lsu,
  output  VRegDataT [`NUM_LSU-1:0] uop_lsu_idx_data_rvv2lsu,
  output  logic     [`NUM_LSU-1:0] uop_lsu_vregfile_valid_rvv2lsu,
  output  RegAddrT  [`NUM_LSU-1:0] uop_lsu_vregfile_addr_rvv2lsu,
  output  VRegDataT [`NUM_LSU-1:0] uop_lsu_vregfile_data_rvv2lsu,
  output  logic     [`NUM_LSU-1:0] uop_lsu_v0_valid_rvv2lsu,
  output  MaskT     [`NUM_LSU-1:0] uop_lsu_v0_data_rvv2lsu,
  input   logic     [`NUM_LSU-1:0] uop_lsu_ready_lsu2rvv,

  // LSU to RVV
  input  logic     [`NUM_LSU-1:0] uop_lsu_valid_lsu2rvv,
  input  RegAddrT  [`NUM_LSU-1:0] uop_lsu_addr_lsu2rvv,
  input  VRegDataT [`NUM_LSU-1:0] uop_lsu_wdata_lsu2rvv,
  input  logic     [`NUM_LSU-1:0] uop_lsu_last_lsu2rvv,
  output logic     [`NUM_LSU-1:0] uop_lsu_ready_rvv2lsu,

  // Vector CSR writeback
  output vcsr_valid,
  output RVVConfigState vector_csr,
  input vcsr_ready,

  // Config state
  output config_state_valid,
  output RVVConfigState config_state,

  // Idle
  output logic rvv_idle,
  output logic [$clog2(2*N + 1)-1:0] queue_capacity,

  // Writeback from reorder buffer
  output ROB2RT_t [`NUM_RT_UOP-1:0] rd_rob2rt_o,
  output logic    [`NUM_RT_UOP-1:0] rd_valid_rob2rt_o,

  // Trap output
  output logic trap_valid_o,
  output RVVInstruction trap_data_o,

  // VXSAT update from backend
  output logic                            wr_vxsat_valid_o,
  output logic    [`VCSR_VXSAT_WIDTH-1:0] wr_vxsat_o
);

  // =========================================================================
  // RvvFrontEnd — kept as-is from the original CoralNPU design.
  // Handles vsetvl, instruction assembly, config state, and trap detection.
  // =========================================================================
  logic [N-1:0] frontend_cmd_valid;
  RVVCmd [N-1:0] frontend_cmd_data;
  logic [$clog2(2*N + 1)-1:0] queue_capacity_internal;

  RvvFrontEnd#(.N(N)) frontend(
      .clk(clk),
      .rstn(rstn),
      .vstart_i(vstart),
      .vxrm_i(vxrm),
      .vxsat_i(vxsat),
      .frm_i(frm),
      .inst_valid_i(inst_valid),
      .inst_data_i(inst_data),
      .inst_ready_o(inst_ready),
      .reg_read_valid_i(reg_read_valid),
      .reg_read_data_i(reg_read_data),
      .freg_read_data_i(freg_read_data),
      .reg_write_valid_o(reg_write_valid),
      .reg_write_addr_o(reg_write_addr),
      .reg_write_data_o(reg_write_data),
      .cmd_valid_o(frontend_cmd_valid),
      .cmd_data_o(frontend_cmd_data),
      .queue_capacity_i(queue_capacity_internal),
      .queue_capacity_o(queue_capacity),
      .trap_valid_o(trap_valid_o),
      .trap_data_o(trap_data_o),
      .config_state_valid(config_state_valid),
      .config_state(config_state)
  );

  // =========================================================================
  // Backpressure from kv_vpu credit system
  // =========================================================================
  // kv_vpu outputs vpu_credit[3:0] to signal available queue slots.
  // We use this to throttle the frontend.

  // =========================================================================
  // Andes kv_vpu instantiation
  // =========================================================================
  // kv_vpu parameters: VLEN=512, DLEN=512, FELEN=32, FLEN=64 (IEEE-754 binary64
  // for scalar FPU; vector FP uses FELEN=32).  See config.inc for overrides.

  // --- kv_vpu request signals (derived from RVVCmd) ---
  localparam int KV_VPU_LANES = 2;  // dual-issue
  logic [KV_VPU_LANES-1:0]               vpu_req_valid;
  logic [(32*KV_VPU_LANES-1):0]          vpu_req_ctrl;    // packed: [63:32]=i1, [31:0]=i0
  logic [(32*KV_VPU_LANES-1):0]          vpu_req_instr;   // packed
  logic [(64*KV_VPU_LANES-1):0]          vpu_req_op1;     // packed rs1 data
  logic [(64*KV_VPU_LANES-1):0]          vpu_req_op2;     // packed rs2 data (tie 0)
  logic [7:0]                            vpu_req_vtype;
  logic [10:0]                           vpu_req_vl;
  logic [9:0]                            vpu_req_vstart;
  logic [1:0]                            vpu_req_fp_mode;
  logic [2:0]                            vpu_req_frm;
  logic [1:0]                            vpu_req_vxrm;
  logic [3:0]                            vpu_credit;

  // --- kv_vpu commit interface (from scalar core) ---
  logic [63:0]  vpu_cmt_i0_op1;
  logic [63:0]  vpu_cmt_i1_op1;
  logic [1:0]   vpu_cmt_kill;
  logic         vpu_cmt_valid;

  // --- kv_vpu VLSU memory interfaces (TileLink-like) ---
  // Coherent memory channel A
  logic [38-1:0]   vlsu_cm_a_address;      // PALEN=38
  logic            vlsu_cm_a_corrupt;
  logic [255:0]    vlsu_cm_a_data;          // VLSU_DATA_WIDTH=256
  logic [31:0]     vlsu_cm_a_mask;          // (VLSU_DATA_WIDTH/8)-1
  logic [2:0]      vlsu_cm_a_opcode;
  logic [2:0]      vlsu_cm_a_param;
  logic            vlsu_cm_a_ready;
  logic            vlsu_cm_a_shareable;
  logic [2:0]      vlsu_cm_a_size;
  logic [3:0]      vlsu_cm_a_source;        // L2_SOURCE_WIDTH=4
  logic [11:0]     vlsu_cm_a_user;
  logic            vlsu_cm_a_valid;

  // Coherent memory channel D
  logic [3:0]      vlsu_cm_d_cause;
  logic            vlsu_cm_d_corrupt;
  logic [255:0]    vlsu_cm_d_data;
  logic            vlsu_cm_d_denied;
  logic [2:0]      vlsu_cm_d_opcode;
  logic [1:0]      vlsu_cm_d_param;
  logic            vlsu_cm_d_ready;
  logic [1:0]      vlsu_cm_d_sink;           // TL_SINK_WIDTH=2
  logic [2:0]      vlsu_cm_d_size;
  logic [3:0]      vlsu_cm_d_source;
  logic [5:0]      vlsu_cm_d_user;
  logic            vlsu_cm_d_valid;

  // Non-coherent memory channel A
  logic [38-1:0]   vlsu_nc_a_address;
  logic            vlsu_nc_a_corrupt;
  logic [255:0]    vlsu_nc_a_data;
  logic [31:0]     vlsu_nc_a_mask;
  logic [2:0]      vlsu_nc_a_opcode;
  logic [2:0]      vlsu_nc_a_param;
  logic            vlsu_nc_a_ready;
  logic [2:0]      vlsu_nc_a_size;
  logic [3:0]      vlsu_nc_a_source;
  logic [11:0]     vlsu_nc_a_user;
  logic            vlsu_nc_a_valid;

  // Non-coherent memory channel D
  logic            vlsu_nc_d_corrupt;
  logic [255:0]    vlsu_nc_d_data;
  logic            vlsu_nc_d_denied;
  logic [2:0]      vlsu_nc_d_opcode;
  logic [1:0]      vlsu_nc_d_param;
  logic            vlsu_nc_d_ready;
  logic [1:0]      vlsu_nc_d_sink;
  logic [2:0]      vlsu_nc_d_size;
  logic [3:0]      vlsu_nc_d_source;
  logic [5:0]      vlsu_nc_d_user;
  logic            vlsu_nc_d_valid;

  // HVM (virtual memory) channel — unused, tie off
  logic [0:0]      vlsu_vm_a_address;
  logic [511:0]    vlsu_vm_a_data;
  logic [63:0]     vlsu_vm_a_mask;
  logic [2:0]      vlsu_vm_a_opcode;
  logic            vlsu_vm_a_ready;
  logic [2:0]      vlsu_vm_a_size;
  logic            vlsu_vm_a_valid;
  logic            vlsu_vm_d_corrupt;
  logic [511:0]    vlsu_vm_d_data;
  logic            vlsu_vm_d_denied;
  logic [2:0]      vlsu_vm_d_opcode;
  logic            vlsu_vm_d_ready;
  logic [2:0]      vlsu_vm_d_size;
  logic            vlsu_vm_d_valid;

  // --- kv_vpu outputs (to be mapped to RvvCore outputs) ---
  logic         vpu_block_pending;
  logic         vpu_loadstore_pending;
  logic [10:0]  vpu_ls_ack_element;
  logic [21:0]  vpu_ls_ack_status;
  logic [63:0]  vpu_ls_ack_tval;
  logic         vpu_ls_ack_valid;
  logic         vpu_ls_async_ecc_corr;
  logic         vpu_ls_async_ecc_error;
  logic [3:0]   vpu_ls_async_ecc_ramid;
  logic         vpu_ls_async_ecc_read;
  logic         vpu_ls_async_read_error;
  logic         vpu_ls_async_write_error;

  // PMA/PMP (tied off — CoralNPU handles address translation in its own LSU)
  logic [38-1:0] vpu_pma_req_pa;
  logic          vpu_pma_resp_fault;
  logic          vpu_pma_resp_hvm;
  logic [3:0]    vpu_pma_resp_mtype;
  logic          vpu_pma_resp_nosh;
  logic [38-1:0] vpu_pmp_req_pa;
  logic [3:0]    vpu_pmp_resp_permission;

  // TLB (tied off)
  logic          vpu_vtlb_flush;
  logic [51:0]   vpu_vtlb_miss_data;  // 13+PALEN=51
  logic          vpu_vtlb_miss_req;
  logic          vpu_vtlb_miss_resp;
  logic [38-13:0] vpu_vtlb_miss_vpn;  // VALEN-1:12 = 38-1:12 = 37:12 → 26 bits

  // Standby / idle
  logic         vpu_standby_ready;
  logic         vpu_vace_standby_ready;
  logic         vpu_valu_standby_ready;
  logic         vpu_vdiv_standby_ready;
  logic         vpu_vfdiv_standby_ready;
  logic         vpu_vfmis_standby_ready;
  logic         vpu_vlsu_standby_ready;
  logic         vpu_vmac_standby_ready;
  logic         vpu_vmask_standby_ready;
  logic         vpu_vpermut_standby_ready;
  logic         vpu_vsp_standby_ready;

  // Clock per functional unit (all tied to single clk)
  // VSP / ACE streaming port (tied off)
  logic [511:0] ace_streaming_data_in;
  logic         ace_streaming_data_in_ready;
  logic         ace_streaming_data_in_valid;
  logic [511:0] ace_streaming_data_out;
  logic [63:0]  ace_streaming_data_out_bwe;
  logic         ace_streaming_data_out_ready;
  logic         ace_streaming_data_out_valid;
  logic [511:0] cp_cpu_rdata;
  logic         cp_cpu_rdata_ready;
  logic         cp_cpu_rdata_valid;
  logic [511:0] cpu_cp_wdata;
  logic [63:0]  cpu_cp_wdata_bwe;
  logic         cpu_cp_wdata_ready;
  logic         cpu_cp_wdata_valid;
  logic         vpu_sp_ex_done;
  logic         vpu_sp_ex_error;
  logic         vpu_sp_ex_store;
  logic         vpu_init_rf;

  // Scalar/FP writeback from kv_vpu
  logic [4:0]   vpu_fflags_set;
  logic [4:0]   vpu_srf_waddr;
  logic [63:0]  vpu_srf_wdata;
  logic         vpu_srf_wfrf;
  logic         vpu_srf_wready;
  logic         vpu_srf_wvalid;
  logic         vpu_vxsat_set;

  // Commit pulse generation — auto-commit after request acceptance
  reg ax45_cmt_valid_pulse;
  reg ax45_req_accepted_r;

  // =========================================================================
   // kv_vpu instantiation

  // VLSU hr events
  logic [63:0]  vlsu_hr_events;

  // Additional kv_vpu input controls
  logic         vpu_req_c2nc;
  logic [1:0]   vpu_req_cmr_ctl;
  logic [1:0]   vpu_req_ls_privilege;
  logic         vpu_req_mdlmb_den;
  logic         vpu_req_milmb_ien;
  logic         vpu_req_mstatus_mxr;
  logic         vpu_req_mstatus_sum;
  logic [3:0]   vpu_req_satp_mode;
  logic         vpu_req_translate_en;

  // =========================================================================
  // kv_vpu instantiation
  // =========================================================================
  kv_vpu #(
      .FLEN(64),
      .VLEN(`VLEN),
      .DLEN(512),
      .VPERMUT_DLEN(512),
      .ELEN(64),
      .FELEN(32),
      .VMAC2_TYPE(0),
      .VSCB_DEPTH(8),
      .VRF_MUX(32),
      .VRF_BYPASS_DUP(1),
      .VALEN(38),
      .PALEN(38),
      .TL_SINK_WIDTH(2),
      .L2_SOURCE_WIDTH(4),
      .VLSU_DATA_WIDTH(256),
      .VLSU_MSHR_DEPTH(16),
      .VLSU_BUF_DEPTH(8),
      .VTLB_ENTRIES(8),
      .MMU_SCHEME_INT(0),
      .PMA_SUPPORT_INT(0),
      .PMP_SUPPORT_INT(0),
      .ILM_BASE(64'h0000_0000),
      .DLM_BASE(64'h0020_0000),
      .HVM_BASE(64'h0030_0000),
      .ILM_SIZE_KB(0),
      .DLM_SIZE_KB(0),
      .HVM_SIZE_KB(0),
      .HVM_ADDR_WIDTH(1),
      .QMAC_SUPPORT_INT(0),
      .BF16_SUPPORT_INT(1),      // Zfbfmin
      .ZVFBFMIN_SUPPORT_INT(1),  // Zvfbfmin
      .ZVFBFWMA_SUPPORT_INT(0),
      .VECTOR_SINT_SUPPORT_INT(0),
      .VECTOR_DOT_SUPPORT_INT(0),
      .VECTOR_PACKED_FP16_SUPPORT_INT(0),
      .INT4_VECTOR_LOAD_SUPPORT_INT(0),
      .ASP_DATA_WIDTH(512),
      .VSP_VEQ_DEPTH(4),
      .ACE_SP_MODE(0),
      .ACE_SP_WRITE_PORT(3),
      .ACE_STREAM_PORT(0),
      .RAR_SUPPORT(0)
  ) u_kv_vpu (
      .vpu_valu_clk(clk),
      .vpu_vfmis_clk(clk),
      .vpu_vmac_clk(clk),
      .vpu_vace_clk(clk),
      .vpu_vdiv_clk(clk),
      .vpu_vfdiv_clk(clk),
      .vpu_vlsu_clk(clk),
      .vpu_vmask_clk(clk),
      .vpu_vpermut_clk(clk),
      .vpu_vsp_clk(clk),
      .vpu_clk(clk),
      .vpu_reset_n(rstn),

      // Commit interface — auto-commit: pulse cmt_valid after accepting a request
      .vpu_cmt_i0_op1(64'b0),
      .vpu_cmt_i1_op1(64'b0),
      .vpu_cmt_kill(2'b0),
      .vpu_cmt_valid(ax45_cmt_valid_pulse),

      // VPU request interface — driven from RVVCmd
      .vpu_req_valid(vpu_req_valid),
      .vpu_req_i0_ctrl(vpu_req_ctrl[31:0]),
      .vpu_req_i1_ctrl(vpu_req_ctrl[63:32]),
      .vpu_req_i0_instr(vpu_req_instr[31:0]),
      .vpu_req_i1_instr(vpu_req_instr[63:32]),
      .vpu_req_i0_op1(vpu_req_op1[63:0]),
      .vpu_req_i1_op1(vpu_req_op1[127:64]),
      .vpu_req_i0_op2(vpu_req_op2[63:0]),
      .vpu_req_i1_op2(vpu_req_op2[127:64]),
      .vpu_req_vtype(vpu_req_vtype),
      .vpu_req_vl(vpu_req_vl),
      .vpu_req_vstart(vpu_req_vstart),
      .vpu_req_fp_mode(vpu_req_fp_mode),
      .vpu_req_frm(vpu_req_frm),
      .vpu_req_vxrm(vpu_req_vxrm),
      .vpu_credit(vpu_credit),
      .vpu_req_c2nc(vpu_req_c2nc),
      .vpu_req_cmr_ctl(vpu_req_cmr_ctl),
      .vpu_req_ls_privilege(vpu_req_ls_privilege),
      .vpu_req_mdlmb_den(vpu_req_mdlmb_den),
      .vpu_req_milmb_ien(vpu_req_milmb_ien),
      .vpu_req_mstatus_mxr(vpu_req_mstatus_mxr),
      .vpu_req_mstatus_sum(vpu_req_mstatus_sum),
      .vpu_req_satp_mode(vpu_req_satp_mode),
      .vpu_req_translate_en(vpu_req_translate_en),

      // VLSU coherent memory — tied off (no external coherent memory)
      .vlsu_cm_a_address(vlsu_cm_a_address),
      .vlsu_cm_a_corrupt(vlsu_cm_a_corrupt),
      .vlsu_cm_a_data(vlsu_cm_a_data),
      .vlsu_cm_a_mask(vlsu_cm_a_mask),
      .vlsu_cm_a_opcode(vlsu_cm_a_opcode),
      .vlsu_cm_a_param(vlsu_cm_a_param),
      .vlsu_cm_a_ready(1'b0),        // no coherent responder
      .vlsu_cm_a_shareable(vlsu_cm_a_shareable),
      .vlsu_cm_a_size(vlsu_cm_a_size),
      .vlsu_cm_a_source(vlsu_cm_a_source),
      .vlsu_cm_a_user(vlsu_cm_a_user),
      .vlsu_cm_a_valid(vlsu_cm_a_valid),
      .vlsu_cm_d_cause(4'b0),
      .vlsu_cm_d_corrupt(1'b0),
      .vlsu_cm_d_data(256'b0),
      .vlsu_cm_d_denied(1'b0),
      .vlsu_cm_d_opcode(3'b0),
      .vlsu_cm_d_param(2'b0),
      .vlsu_cm_d_ready(vlsu_cm_d_ready),
      .vlsu_cm_d_sink(2'b0),
      .vlsu_cm_d_size(3'b0),
      .vlsu_cm_d_source(4'b0),
      .vlsu_cm_d_user(6'b0),
      .vlsu_cm_d_valid(1'b0),

      // VLSU non-coherent memory — tied off
      .vlsu_nc_a_address(vlsu_nc_a_address),
      .vlsu_nc_a_corrupt(vlsu_nc_a_corrupt),
      .vlsu_nc_a_data(vlsu_nc_a_data),
      .vlsu_nc_a_mask(vlsu_nc_a_mask),
      .vlsu_nc_a_opcode(vlsu_nc_a_opcode),
      .vlsu_nc_a_param(vlsu_nc_a_param),
      .vlsu_nc_a_ready(1'b0),        // no non-coherent responder
      .vlsu_nc_a_size(vlsu_nc_a_size),
      .vlsu_nc_a_source(vlsu_nc_a_source),
      .vlsu_nc_a_user(vlsu_nc_a_user),
      .vlsu_nc_a_valid(vlsu_nc_a_valid),
      .vlsu_nc_d_corrupt(1'b0),
      .vlsu_nc_d_data(256'b0),
      .vlsu_nc_d_denied(1'b0),
      .vlsu_nc_d_opcode(3'b0),
      .vlsu_nc_d_param(2'b0),
      .vlsu_nc_d_ready(vlsu_nc_d_ready),
      .vlsu_nc_d_sink(2'b0),
      .vlsu_nc_d_size(3'b0),
      .vlsu_nc_d_source(4'b0),
      .vlsu_nc_d_user(6'b0),
      .vlsu_nc_d_valid(1'b0),

      // VLSU HVM — tied off
      .vlsu_vm_a_address(vlsu_vm_a_address),
      .vlsu_vm_a_data(vlsu_vm_a_data),
      .vlsu_vm_a_mask(vlsu_vm_a_mask),
      .vlsu_vm_a_opcode(vlsu_vm_a_opcode),
      .vlsu_vm_a_ready(1'b0),
      .vlsu_vm_a_size(vlsu_vm_a_size),
      .vlsu_vm_a_valid(vlsu_vm_a_valid),
      .vlsu_vm_d_corrupt(1'b0),
      .vlsu_vm_d_data(512'b0),
      .vlsu_vm_d_denied(1'b0),
      .vlsu_vm_d_opcode(3'b0),
      .vlsu_vm_d_ready(vlsu_vm_d_ready),
      .vlsu_vm_d_size(3'b0),
      .vlsu_vm_d_valid(1'b0),
      .vlsu_hr_events(vlsu_hr_events),

      // Status
      .vpu_block_pending(vpu_block_pending),
      .vpu_loadstore_pending(vpu_loadstore_pending),
      .vpu_ls_ack_element(vpu_ls_ack_element),
      .vpu_ls_ack_status(vpu_ls_ack_status),
      .vpu_ls_ack_tval(vpu_ls_ack_tval),
      .vpu_ls_ack_valid(vpu_ls_ack_valid),
      .vpu_ls_async_ecc_corr(vpu_ls_async_ecc_corr),
      .vpu_ls_async_ecc_error(vpu_ls_async_ecc_error),
      .vpu_ls_async_ecc_ramid(vpu_ls_async_ecc_ramid),
      .vpu_ls_async_ecc_read(vpu_ls_async_ecc_read),
      .vpu_ls_async_read_error(vpu_ls_async_read_error),
      .vpu_ls_async_write_error(vpu_ls_async_write_error),

      // PMA/PMP — tied off (CoralNPU's scalar LSU handles address translation)
      .vpu_pma_req_pa(vpu_pma_req_pa),
      .vpu_pma_resp_fault(1'b0),
      .vpu_pma_resp_hvm(1'b0),
      .vpu_pma_resp_mtype(4'b0),
      .vpu_pma_resp_nosh(1'b0),
      .vpu_pmp_req_pa(vpu_pmp_req_pa),
      .vpu_pmp_resp_permission(4'hF),  // full permission

      // TLB — tied off
      .vpu_vtlb_flush(1'b0),
      .vpu_vtlb_miss_data(52'b0),
      .vpu_vtlb_miss_req(vpu_vtlb_miss_req),
      .vpu_vtlb_miss_resp(1'b0),
      .vpu_vtlb_miss_vpn(vpu_vtlb_miss_vpn),
      .vpu_init_rf(1'b0),

      // Standby / idle
      .vpu_standby_ready(vpu_standby_ready),
      .vpu_vace_standby_ready(vpu_vace_standby_ready),
      .vpu_valu_standby_ready(vpu_valu_standby_ready),
      .vpu_vdiv_standby_ready(vpu_vdiv_standby_ready),
      .vpu_vfdiv_standby_ready(vpu_vfdiv_standby_ready),
      .vpu_vfmis_standby_ready(vpu_vfmis_standby_ready),
      .vpu_vlsu_standby_ready(vpu_vlsu_standby_ready),
      .vpu_vmac_standby_ready(vpu_vmac_standby_ready),
      .vpu_vmask_standby_ready(vpu_vmask_standby_ready),
      .vpu_vpermut_standby_ready(vpu_vpermut_standby_ready),
      .vpu_vsp_standby_ready(vpu_vsp_standby_ready),

      // ACE streaming port — tied off (ACE_STREAM_PORT=0 → kv_vsp_stub)
      .ace_streaming_data_in(512'b0),
      .ace_streaming_data_in_ready(ace_streaming_data_in_ready),
      .ace_streaming_data_in_valid(1'b0),
      .ace_streaming_data_out(ace_streaming_data_out),
      .ace_streaming_data_out_bwe(ace_streaming_data_out_bwe),
      .ace_streaming_data_out_ready(1'b0),
      .ace_streaming_data_out_valid(ace_streaming_data_out_valid),
      .cp_cpu_rdata(512'b0),
      .cp_cpu_rdata_ready(cp_cpu_rdata_ready),
      .cp_cpu_rdata_valid(1'b0),
      .cpu_cp_wdata(cpu_cp_wdata),
      .cpu_cp_wdata_bwe(cpu_cp_wdata_bwe),
      .cpu_cp_wdata_ready(1'b0),
      .cpu_cp_wdata_valid(cpu_cp_wdata_valid),
      .vpu_sp_ex_done(1'b0),
      .vpu_sp_ex_error(1'b0),
      .vpu_sp_ex_store(1'b0),

      // Scalar/FP writeback
      .vpu_fflags_set(vpu_fflags_set),
      .vpu_srf_waddr(vpu_srf_waddr),
      .vpu_srf_wdata(vpu_srf_wdata),
      .vpu_srf_wfrf(vpu_srf_wfrf),
      .vpu_srf_wready(vpu_srf_wready),
      .vpu_srf_wvalid(vpu_srf_wvalid),
      .vpu_vxsat_set(vpu_vxsat_set)
  );

  // =========================================================================
  // PIPELINE REGISTER — RvvFrontEnd → kv_vpu request path
  // =========================================================================
  // Inserts 1 cycle of latency to break the combinational path from instruction
  // decode (RvvFrontEnd) to the kv_vpu request interface, splitting the
  // critical path at the adapter boundary.
  //
  // Timing: N=decode, N+1=registered output to kv_vpu, N+2=commit pulse

  // Decode stage — combinational logic producing pending values
  wire [2:0]  inst_funct3  = frontend_cmd_data[0].bits[7:5];
  wire [5:0]  inst_funct6  = frontend_cmd_data[0].bits[24:19];
  wire [2:0]  inst_opcode_enum = frontend_cmd_data[0].opcode;
  wire        pending_valid = frontend_cmd_valid[0] && (vpu_credit > 0);

  wire vace_en  = (inst_funct3 == 3'd1);
  wire valu_en  = (inst_funct3 == 3'd0) || (inst_funct3 == 3'd2) ||
                  (inst_funct3 == 3'd3) || (inst_funct3 == 3'd4) ||
                  (inst_funct3 == 3'd6);
  wire vdiv_en  = valu_en && (inst_funct6[5:2] == 4'b1000);
  wire vlsu_en  = (inst_opcode_enum == 2'd0) || (inst_opcode_enum == 2'd1);

  wire [31:0] pending_ctrl = {
      1'b0, 3'b0,3'b0,3'b0,3'b0,3'b0,3'b0,2'b0,
      1'b0,1'b0,1'b0, vlsu_en, 1'b0,1'b0,1'b0,1'b0,
      vdiv_en, valu_en, vace_en
  };

  wire [31:0] pending_instr = (inst_opcode_enum == 2'd0) ? {frontend_cmd_data[0].bits, 7'h03} :
                              (inst_opcode_enum == 2'd1) ? {frontend_cmd_data[0].bits, 7'h23} :
                                                           {frontend_cmd_data[0].bits, 7'h57};

  wire [7:0] pending_vtype = {
      frontend_cmd_data[0].arch_state.vill,
      frontend_cmd_data[0].arch_state.ma,
      frontend_cmd_data[0].arch_state.ta,
      frontend_cmd_data[0].arch_state.sew,
      frontend_cmd_data[0].arch_state.lmul
  };

  // Pipeline registers — break combinational path here
  reg         req_valid_r;
  reg [31:0]  req_instr_r;
  reg [31:0]  req_ctrl_r;
  reg [63:0]  req_op1_r;
  reg [7:0]   req_vtype_r;
  reg [10:0]  req_vl_r;
  reg [9:0]   req_vstart_r;
  reg [1:0]   req_vxrm_r;
  reg [2:0]   req_frm_r;

  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      req_valid_r  <= 1'b0;
      req_instr_r  <= 32'b0;
      req_ctrl_r   <= 32'b0;
      req_op1_r    <= 64'b0;
      req_vtype_r  <= 8'b0;
      req_vl_r     <= 11'b0;
      req_vstart_r <= 10'b0;
      req_vxrm_r   <= 2'b0;
      req_frm_r    <= 3'b0;
    end else begin
      req_valid_r  <= pending_valid;
      req_instr_r  <= pending_instr;
      req_ctrl_r   <= pending_ctrl;
      req_op1_r    <= {32'b0, frontend_cmd_data[0].rs1};
      req_vtype_r  <= pending_vtype;
      req_vl_r     <= frontend_cmd_data[0].arch_state.vl;
      req_vstart_r <= frontend_cmd_data[0].arch_state.vstart;
      req_vxrm_r   <= frontend_cmd_data[0].arch_state.xrm;
`ifdef ZVE32F_ON
      req_frm_r    <= frontend_cmd_data[0].arch_state.frm;
`endif
    end
  end

  // Registered output to kv_vpu (1 cycle after RvvFrontEnd decode)
  assign vpu_req_valid[0]    = req_valid_r;
  assign vpu_req_instr[31:0] = req_instr_r;
  assign vpu_req_ctrl[31:0]  = req_ctrl_r;
  assign vpu_req_op1[63:0]   = req_op1_r;
  assign vpu_req_vtype       = req_vtype_r;
  assign vpu_req_vl          = req_vl_r;
  assign vpu_req_vstart      = req_vstart_r;
  assign vpu_req_vxrm        = req_vxrm_r;
`ifdef ZVE32F_ON
  assign vpu_req_frm         = req_frm_r;
`endif

  // Lane 1 tied off (single-issue)
  assign vpu_req_valid[1]    = 1'b0;
  assign vpu_req_ctrl[63:32] = 32'b0;
  assign vpu_req_instr[63:32]= 32'b0;
  assign vpu_req_op1[127:64] = 64'b0;
  assign vpu_req_op2         = 128'b0;
  assign vpu_req_fp_mode     = 2'b0;

  // =========================================================================
  // Commit pulse — tracks registered request through 2-stage shift
  // =========================================================================
  // Pipeline: N=pending, N+1=vpu_req_valid, N+2=cmt_valid
  reg cmt_stage1_r;

  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      ax45_cmt_valid_pulse <= 1'b0;
      ax45_req_accepted_r  <= 1'b0;
      cmt_stage1_r         <= 1'b0;
    end else begin
      ax45_cmt_valid_pulse <= ax45_req_accepted_r;
      ax45_req_accepted_r  <= cmt_stage1_r;
      cmt_stage1_r         <= req_valid_r;
    end
  end

  // =========================================================================

  // Backpressure: throttle frontend based on vpu_credit
  always_comb begin
    // Simple credit-based backpressure
    if (vpu_credit > 2*N)
      queue_capacity_internal = 2*N;
    else
      queue_capacity_internal = {1'b0, vpu_credit};
  end

  // =========================================================================
  assign uop_lsu_valid_rvv2lsu      = '0;
  assign uop_lsu_idx_valid_rvv2lsu  = '0;
  assign uop_lsu_idx_addr_rvv2lsu   = '0;
  assign uop_lsu_idx_data_rvv2lsu   = '0;
  assign uop_lsu_vregfile_valid_rvv2lsu = '0;
  assign uop_lsu_vregfile_addr_rvv2lsu  = '0;
  assign uop_lsu_vregfile_data_rvv2lsu  = '0;
  assign uop_lsu_v0_valid_rvv2lsu   = '0;
  assign uop_lsu_v0_data_rvv2lsu    = '0;
  assign uop_lsu_ready_rvv2lsu      = '0;

  // =========================================================================
  // =========================================================================
  // OUTPUT PIPELINE REGISTER — kv_vpu writeback → RvvCore outputs
  // =========================================================================
  // Registers the scalar/FP writeback signals to break combinational paths
  // from kv_vpu's internal writeback logic to the CoralNPU register file ports.
  // Adds 1 cycle of latency with proper handshaking.

  reg         wb_rd_valid_r;
  reg [4:0]   wb_rd_addr_r;
  reg [31:0]  wb_rd_data_r;
  reg         wb_frd_valid_r;
  reg [4:0]   wb_frd_addr_r;
  reg [31:0]  wb_frd_data_r;

  always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      wb_rd_valid_r  <= 1'b0;
      wb_rd_addr_r   <= '0;
      wb_rd_data_r   <= '0;
      wb_frd_valid_r <= 1'b0;
      wb_frd_addr_r  <= '0;
      wb_frd_data_r  <= '0;
    end else begin
      // Scalar register writeback (non-FP)
      wb_rd_valid_r  <= vpu_srf_wvalid && !vpu_srf_wfrf;
      wb_rd_addr_r   <= vpu_srf_waddr;
      wb_rd_data_r   <= vpu_srf_wdata[31:0];
      // FP register writeback
      wb_frd_valid_r <= vpu_srf_wvalid && vpu_srf_wfrf;
      wb_frd_addr_r  <= vpu_srf_waddr;
      wb_frd_data_r  <= vpu_srf_wdata[31:0];
    end
  end

  assign async_rd_valid  = wb_rd_valid_r;
  assign async_rd_addr   = wb_rd_addr_r;
  assign async_rd_data   = wb_rd_data_r;
  assign async_frd_valid = wb_frd_valid_r;
  assign async_frd_addr  = wb_frd_addr_r;
  assign async_frd_data  = wb_frd_data_r;
  assign vpu_srf_wready = async_rd_ready;  // kv_vpu needs ready for handshake

  // =========================================================================
  assign vcsr_valid = 1'b0;   // TBD: map vpu_vxsat_set → vcsr update
  assign vector_csr = '0;
  // =========================================================================
  // Idle
  // =========================================================================
  assign rvv_idle = vpu_standby_ready && (frontend_cmd_valid == 0);

  // =========================================================================
  // ROB writeback — tie off (kv_vpu commits internally; CoralNPU ROB unused)
  // =========================================================================
  assign rd_rob2rt_o      = '0;
  assign rd_valid_rob2rt_o = '0;

  // =========================================================================
  // VXSAT
  // =========================================================================
  assign wr_vxsat_valid_o = vpu_vxsat_set;
  assign wr_vxsat_o       = 1'b1;

  // =========================================================================
  // Unused kv_vpu control inputs — tie to inactive
  // =========================================================================
  assign vpu_req_c2nc         = 1'b0;
  assign vpu_req_cmr_ctl      = 2'b0;
  assign vpu_req_ls_privilege = 2'b0;
  assign vpu_req_mdlmb_den    = 1'b0;
  assign vpu_req_milmb_ien    = 1'b0;
  assign vpu_req_mstatus_mxr  = 1'b0;
  assign vpu_req_mstatus_sum  = 1'b0;
  assign vpu_req_satp_mode    = 4'b0;
  assign vpu_req_translate_en = 1'b0;

endmodule
