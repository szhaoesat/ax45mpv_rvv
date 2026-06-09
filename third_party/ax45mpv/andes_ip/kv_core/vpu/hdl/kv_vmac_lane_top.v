// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_lane_top (
    vpu_reset_n,
    vpu_vmac_clk,
    lane_id,
    vmac_lane_cross_type,
    vmac_lane_shift_type,
    vmac_standby_ready,
    vmac_vs1_lane_cross_data,
    vmac_vs1_lane_share_data,
    vmac_vs1_lane_shift_data,
    vmac_vs2_lane_cross_data,
    vmac_vs2_lane_share_cross_data,
    vmac_vs2_lane_share_shift_data,
    vmac_vs2_lane_shift_data,
    vmac_cmt_kill,
    vmac_cmt_valid,
    vmac_cmt_op1,
    vmac_dispatch_ctrl,
    vmac_dispatch_frm,
    vmac_dispatch_op1,
    vmac_dispatch_op1_hazard,
    vmac_dispatch_ready,
    vmac_dispatch_v0t,
    vmac_dispatch_valid,
    vmac_dispatch_vd_len,
    vmac_dispatch_vxrm,
    vmac_vs1_rdata,
    vmac_vs1_rlast,
    vmac_vs1_rready,
    vmac_vs1_rvalid,
    vmac_vs2_rdata,
    vmac_vs2_rlast,
    vmac_vs2_rready,
    vmac_vs2_rvalid,
    vmac_vs3_rdata,
    vmac_vs3_rlast,
    vmac_vs3_rready,
    vmac_vs3_rvalid,
    vmac_flag_set,
    vmac_vd_wdata,
    vmac_vd_wmask,
    vmac_vd_wready,
    vmac_vd_wvalid
);
parameter FELEN = 64;
parameter IELEN = 64;
parameter XLEN = 64;
parameter FLEN = 64;
parameter VLEN = 1024;
parameter DLEN = 512;
parameter VFMAC_SUPPORT = 1;
parameter VIMAC_SUPPORT = 1;
parameter VRF_LW = 4;
input vpu_reset_n;
input vpu_vmac_clk;
input [31:0] lane_id;
output [3:0] vmac_lane_cross_type;
output [3:0] vmac_lane_shift_type;
output vmac_standby_ready;
input [31:0] vmac_vs1_lane_cross_data;
output [63:0] vmac_vs1_lane_share_data;
input [63:0] vmac_vs1_lane_shift_data;
input [31:0] vmac_vs2_lane_cross_data;
output [63:0] vmac_vs2_lane_share_cross_data;
output [63:0] vmac_vs2_lane_share_shift_data;
input [63:0] vmac_vs2_lane_shift_data;
input vmac_cmt_kill;
input vmac_cmt_valid;
input [(XLEN - 1):0] vmac_cmt_op1;
input [(58 - 1):0] vmac_dispatch_ctrl;
input [2:0] vmac_dispatch_frm;
input [(XLEN - 1):0] vmac_dispatch_op1;
input vmac_dispatch_op1_hazard;
output vmac_dispatch_ready;
input [(VLEN - 1):0] vmac_dispatch_v0t;
input vmac_dispatch_valid;
input [(VRF_LW - 1):0] vmac_dispatch_vd_len;
input [1:0] vmac_dispatch_vxrm;
input [63:0] vmac_vs1_rdata;
input vmac_vs1_rlast;
output vmac_vs1_rready;
input vmac_vs1_rvalid;
input [63:0] vmac_vs2_rdata;
input vmac_vs2_rlast;
output vmac_vs2_rready;
input vmac_vs2_rvalid;
input [63:0] vmac_vs3_rdata;
input vmac_vs3_rlast;
output vmac_vs3_rready;
input vmac_vs3_rvalid;
output [5:0] vmac_flag_set;
output [63:0] vmac_vd_wdata;
output [7:0] vmac_vd_wmask;
input vmac_vd_wready;
output vmac_vd_wvalid;





// 970d72d4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [4:0] vfmac_flag_set;
wire [63:0] vfmac_wdata;
wire vimac_vxsat_set;
wire [63:0] vimac_wdata;
wire fpipe_stall;
wire ipipe_stall;
wire veq_ex_ready;
wire veq_ex_v0t_srl_dlen;
wire veq_ex_v0t_srl_element;
wire [10:0] vfmac_f0_align_amount_adjustment;
wire [7:0] vfmac_f0_byte_mask;
wire vfmac_f0_fp_mode;
wire vfmac_f0_madd_instr;
wire vfmac_f0_msub_instr;
wire vfmac_f0_mul_instr;
wire vfmac_f0_nmadd_instr;
wire vfmac_f0_nmsub_instr;
wire [63:0] vfmac_f0_op1_data;
wire vfmac_f0_op1_sew16;
wire vfmac_f0_op1_sew32;
wire vfmac_f0_op1_sew64;
wire [63:0] vfmac_f0_op2_data;
wire [63:0] vfmac_f0_op3_data;
wire vfmac_f0_op3_sew16;
wire vfmac_f0_op3_sew32;
wire vfmac_f0_op3_sew64;
wire [2:0] vfmac_f0_round_mode;
wire vfmac_f0_valid;
wire [1:0] vfmac_f0_vd_eew;
wire vimac_f0_instr_qmac;
wire vimac_f0_instr_vd4dot;
wire vimac_f0_instr_vsmul;
wire [7:0] vimac_f0_mask_byte8;
wire vimac_f0_negmul;
wire [63:0] vimac_f0_op1_data;
wire [63:0] vimac_f0_op2_data;
wire [63:0] vimac_f0_op3_data;
wire vimac_f0_op_sign;
wire vimac_f0_op_wide;
wire vimac_f0_ret_hi;
wire [1:0] vimac_f0_sew;
wire vimac_f0_src_sign;
wire vimac_f0_valid;
wire [1:0] vimac_f0_xrm;
wire vrf_vd_kill;
wire vrf_vd_rd;
wire [63:0] vrf_vd_wdata;
wire vrf_vd_wr;
wire vrf_vs1_kill;
wire vrf_vs1_rd;
wire [63:0] vrf_vs1_wdata;
wire vrf_vs1_wr;
wire vrf_vs2_kill;
wire vrf_vs2_rd;
wire [63:0] vrf_vs2_wdata;
wire vrf_vs2_wr;
wire [63:0] wb_us_bit_wen;
wire wb_us_cmtted;
wire [5:0] wb_us_flag;
wire wb_us_flag_clr;
wire wb_us_flag_update;
wire wb_us_last;
wire [7:0] wb_us_mask_wdata;
wire wb_us_skip;
wire wb_us_valid;
wire [63:0] wb_us_wdata;
wire veq_ex_cmt;
wire [(58 - 1):0] veq_ex_ctrl;
wire veq_ex_flush;
wire [2:0] veq_ex_frm;
wire [4:0] veq_ex_id;
wire [(58 - 1):0] veq_ex_nxt_ctrl;
wire veq_ex_nxt_valid;
wire [(XLEN - 1):0] veq_ex_op1;
wire veq_ex_op1_valid;
wire [DLEN / 8 - 1:0] veq_ex_v0t;
wire veq_ex_valid;
wire [(VRF_LW - 1):0] veq_ex_vd_len;
wire [1:0] veq_ex_vxrm;
wire vrf_vd_last;
wire [63:0] vrf_vd_rdata;
wire vrf_vd_valid;
wire vrf_vs1_last;
wire [63:0] vrf_vs1_rdata;
wire vrf_vs1_valid;
wire vrf_vs2_last;
wire [63:0] vrf_vs2_rdata;
wire vrf_vs2_valid;
wire exs_nxt_cmt;
wire wb_standby;
wire wb_us_ready;
kv_vmac_ctrl #(
    .DLEN(DLEN),
    .FELEN(FELEN),
    .IELEN(IELEN),
    .VFMAC_SUPPORT(VFMAC_SUPPORT),
    .VIMAC_SUPPORT(VIMAC_SUPPORT),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vmac_ctrl (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .lane_id(lane_id),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_standby_ready(vmac_standby_ready),
    .wb_standby(wb_standby),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_wdata(wb_us_wdata),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_us_skip(wb_us_skip),
    .wb_us_flag_update(wb_us_flag_update),
    .wb_us_flag(wb_us_flag),
    .wb_us_flag_clr(wb_us_flag_clr),
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_wr(vrf_vd_wr),
    .vrf_vd_wdata(vrf_vd_wdata),
    .vrf_vd_rdata(vrf_vd_rdata),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_frm(veq_ex_frm),
    .veq_ex_vxrm(veq_ex_vxrm),
    .veq_ex_op1(veq_ex_op1),
    .veq_ex_v0t(veq_ex_v0t),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_id(veq_ex_id),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_v0t_srl_dlen(veq_ex_v0t_srl_dlen),
    .veq_ex_v0t_srl_element(veq_ex_v0t_srl_element),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl),
    .fpipe_stall(fpipe_stall),
    .ipipe_stall(ipipe_stall),
    .vmac_vs2_lane_share_cross_data(vmac_vs2_lane_share_cross_data),
    .vmac_vs2_lane_share_shift_data(vmac_vs2_lane_share_shift_data),
    .vmac_vs1_lane_share_data(vmac_vs1_lane_share_data),
    .vmac_lane_shift_type(vmac_lane_shift_type),
    .vmac_vs2_lane_shift_data(vmac_vs2_lane_shift_data),
    .vmac_vs1_lane_shift_data(vmac_vs1_lane_shift_data),
    .vmac_lane_cross_type(vmac_lane_cross_type),
    .vmac_vs2_lane_cross_data(vmac_vs2_lane_cross_data),
    .vmac_vs1_lane_cross_data(vmac_vs1_lane_cross_data),
    .vimac_f0_valid(vimac_f0_valid),
    .vimac_f0_sew(vimac_f0_sew),
    .vimac_f0_xrm(vimac_f0_xrm),
    .vimac_f0_op1_data(vimac_f0_op1_data),
    .vimac_f0_op2_data(vimac_f0_op2_data),
    .vimac_f0_op3_data(vimac_f0_op3_data),
    .vimac_f0_mask_byte8(vimac_f0_mask_byte8),
    .vimac_f0_negmul(vimac_f0_negmul),
    .vimac_f0_op_wide(vimac_f0_op_wide),
    .vimac_f0_op_sign(vimac_f0_op_sign),
    .vimac_f0_src_sign(vimac_f0_src_sign),
    .vimac_f0_instr_qmac(vimac_f0_instr_qmac),
    .vimac_f0_instr_vsmul(vimac_f0_instr_vsmul),
    .vimac_f0_instr_vd4dot(vimac_f0_instr_vd4dot),
    .vimac_f0_ret_hi(vimac_f0_ret_hi),
    .vimac_wdata(vimac_wdata),
    .vimac_vxsat_set(vimac_vxsat_set),
    .vfmac_f0_byte_mask(vfmac_f0_byte_mask),
    .vfmac_f0_op1_data(vfmac_f0_op1_data),
    .vfmac_f0_op2_data(vfmac_f0_op2_data),
    .vfmac_f0_op3_data(vfmac_f0_op3_data),
    .vfmac_f0_valid(vfmac_f0_valid),
    .vfmac_f0_round_mode(vfmac_f0_round_mode),
    .vfmac_f0_vd_eew(vfmac_f0_vd_eew),
    .vfmac_f0_fp_mode(vfmac_f0_fp_mode),
    .vfmac_f0_op1_sew64(vfmac_f0_op1_sew64),
    .vfmac_f0_op3_sew64(vfmac_f0_op3_sew64),
    .vfmac_f0_op1_sew32(vfmac_f0_op1_sew32),
    .vfmac_f0_op3_sew32(vfmac_f0_op3_sew32),
    .vfmac_f0_op1_sew16(vfmac_f0_op1_sew16),
    .vfmac_f0_op3_sew16(vfmac_f0_op3_sew16),
    .vfmac_f0_mul_instr(vfmac_f0_mul_instr),
    .vfmac_f0_madd_instr(vfmac_f0_madd_instr),
    .vfmac_f0_msub_instr(vfmac_f0_msub_instr),
    .vfmac_f0_nmadd_instr(vfmac_f0_nmadd_instr),
    .vfmac_f0_nmsub_instr(vfmac_f0_nmsub_instr),
    .vfmac_f0_align_amount_adjustment(vfmac_f0_align_amount_adjustment),
    .exs_nxt_cmt(exs_nxt_cmt),
    .vfmac_wdata(vfmac_wdata),
    .vfmac_flag_set(vfmac_flag_set)
);
kv_vmac_veq #(
    .DLEN(DLEN),
    .FLEN(FLEN),
    .VLEN(VLEN),
    .VRF_LW(VRF_LW),
    .XLEN(XLEN)
) u_vmac_veq (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .vmac_dispatch_valid(vmac_dispatch_valid),
    .vmac_dispatch_ready(vmac_dispatch_ready),
    .vmac_dispatch_ctrl(vmac_dispatch_ctrl),
    .vmac_dispatch_vd_len(vmac_dispatch_vd_len),
    .vmac_dispatch_frm(vmac_dispatch_frm),
    .vmac_dispatch_vxrm(vmac_dispatch_vxrm),
    .vmac_dispatch_op1_hazard(vmac_dispatch_op1_hazard),
    .vmac_dispatch_op1(vmac_dispatch_op1),
    .vmac_dispatch_v0t(vmac_dispatch_v0t),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_cmt_op1(vmac_cmt_op1),
    .veq_ex_nxt_valid(veq_ex_nxt_valid),
    .veq_ex_nxt_ctrl(veq_ex_nxt_ctrl),
    .veq_ex_valid(veq_ex_valid),
    .veq_ex_flush(veq_ex_flush),
    .veq_ex_ready(veq_ex_ready),
    .veq_ex_ctrl(veq_ex_ctrl),
    .veq_ex_vd_len(veq_ex_vd_len),
    .veq_ex_frm(veq_ex_frm),
    .veq_ex_vxrm(veq_ex_vxrm),
    .veq_ex_op1_valid(veq_ex_op1_valid),
    .veq_ex_op1(veq_ex_op1),
    .veq_ex_id(veq_ex_id),
    .veq_ex_v0t(veq_ex_v0t),
    .veq_ex_cmt(veq_ex_cmt),
    .veq_ex_v0t_srl_dlen(veq_ex_v0t_srl_dlen),
    .veq_ex_v0t_srl_element(veq_ex_v0t_srl_element)
);
kv_vmac_wb #(
    .DLEN(64)
) u_vmac_wb (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .wb_standby(wb_standby),
    .exs_nxt_cmt(exs_nxt_cmt),
    .wb_us_valid(wb_us_valid),
    .wb_us_ready(wb_us_ready),
    .wb_us_wdata(wb_us_wdata),
    .wb_us_bit_wen(wb_us_bit_wen),
    .wb_us_mask_wdata(wb_us_mask_wdata),
    .wb_us_cmtted(wb_us_cmtted),
    .wb_us_last(wb_us_last),
    .wb_us_skip(wb_us_skip),
    .wb_us_flag(wb_us_flag),
    .wb_us_flag_clr(wb_us_flag_clr),
    .wb_us_flag_update(wb_us_flag_update),
    .vmac_cmt_valid(vmac_cmt_valid),
    .vmac_cmt_kill(vmac_cmt_kill),
    .vmac_flag_set(vmac_flag_set),
    .vmac_vd_wvalid(vmac_vd_wvalid),
    .vmac_vd_wdata(vmac_vd_wdata),
    .vmac_vd_wmask(vmac_vd_wmask),
    .vmac_vd_wready(vmac_vd_wready)
);
kv_vmac_vrf_buf u_vmac_vrf_buf(
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
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
    .vrf_vs1_valid(vrf_vs1_valid),
    .vrf_vs1_rd(vrf_vs1_rd),
    .vrf_vs1_last(vrf_vs1_last),
    .vrf_vs1_kill(vrf_vs1_kill),
    .vrf_vs1_wr(vrf_vs1_wr),
    .vrf_vs1_wdata(vrf_vs1_wdata),
    .vrf_vs1_rdata(vrf_vs1_rdata),
    .vrf_vs2_valid(vrf_vs2_valid),
    .vrf_vs2_rd(vrf_vs2_rd),
    .vrf_vs2_last(vrf_vs2_last),
    .vrf_vs2_kill(vrf_vs2_kill),
    .vrf_vs2_wr(vrf_vs2_wr),
    .vrf_vs2_wdata(vrf_vs2_wdata),
    .vrf_vs2_rdata(vrf_vs2_rdata),
    .vrf_vd_valid(vrf_vd_valid),
    .vrf_vd_rd(vrf_vd_rd),
    .vrf_vd_last(vrf_vd_last),
    .vrf_vd_kill(vrf_vd_kill),
    .vrf_vd_wr(vrf_vd_wr),
    .vrf_vd_wdata(vrf_vd_wdata),
    .vrf_vd_rdata(vrf_vd_rdata)
);
generate
    if (VFMAC_SUPPORT == 1) begin:gen_vfmac_lane
        kv_vfmac_lane #(
            .ELEN(FELEN)
        ) u_vfmac_lane (
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .fpipe_stall(fpipe_stall),
            .f0_byte_mask(vfmac_f0_byte_mask),
            .f0_op1_data(vfmac_f0_op1_data),
            .f0_op2_data(vfmac_f0_op2_data),
            .f0_op3_data(vfmac_f0_op3_data),
            .f0_valid(vfmac_f0_valid),
            .f0_round_mode(vfmac_f0_round_mode),
            .f0_sew(vfmac_f0_vd_eew),
            .f0_fp_mode(vfmac_f0_fp_mode),
            .f0_op1_sew64(vfmac_f0_op1_sew64),
            .f0_op3_sew64(vfmac_f0_op3_sew64),
            .f0_op1_sew32(vfmac_f0_op1_sew32),
            .f0_op3_sew32(vfmac_f0_op3_sew32),
            .f0_op1_sew16(vfmac_f0_op1_sew16),
            .f0_op3_sew16(vfmac_f0_op3_sew16),
            .f0_align_amount_adjustment(vfmac_f0_align_amount_adjustment),
            .f0_mul_instr(vfmac_f0_mul_instr),
            .f0_madd_instr(vfmac_f0_madd_instr),
            .f0_msub_instr(vfmac_f0_msub_instr),
            .f0_nmadd_instr(vfmac_f0_nmadd_instr),
            .f0_nmsub_instr(vfmac_f0_nmsub_instr),
            .wdata(vfmac_wdata),
            .flag_set(vfmac_flag_set)
        );
    end
endgenerate
generate
    if (VFMAC_SUPPORT == 0) begin:gen_vfmac_lane_stub
        kv_vfmac_lane_stub #(
            .ELEN(FELEN)
        ) u_vfmac_lane_stub (
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .fpipe_stall(fpipe_stall),
            .f0_byte_mask(vfmac_f0_byte_mask),
            .f0_op1_data(vfmac_f0_op1_data),
            .f0_op2_data(vfmac_f0_op2_data),
            .f0_op3_data(vfmac_f0_op3_data),
            .f0_valid(vfmac_f0_valid),
            .f0_round_mode(vfmac_f0_round_mode),
            .f0_sew(vfmac_f0_vd_eew),
            .f0_fp_mode(vfmac_f0_fp_mode),
            .f0_op1_sew64(vfmac_f0_op1_sew64),
            .f0_op3_sew64(vfmac_f0_op3_sew64),
            .f0_op1_sew32(vfmac_f0_op1_sew32),
            .f0_op3_sew32(vfmac_f0_op3_sew32),
            .f0_op1_sew16(vfmac_f0_op1_sew16),
            .f0_op3_sew16(vfmac_f0_op3_sew16),
            .f0_align_amount_adjustment(vfmac_f0_align_amount_adjustment),
            .f0_mul_instr(vfmac_f0_mul_instr),
            .f0_madd_instr(vfmac_f0_madd_instr),
            .f0_msub_instr(vfmac_f0_msub_instr),
            .f0_nmadd_instr(vfmac_f0_nmadd_instr),
            .f0_nmsub_instr(vfmac_f0_nmsub_instr),
            .wdata(vfmac_wdata),
            .flag_set(vfmac_flag_set)
        );
    end
endgenerate
generate
    if (VIMAC_SUPPORT == 1) begin:gen_vimac_lane
        kv_vimac_lane #(
            .ELEN(IELEN)
        ) u_vimac_lane (
            .clk(vpu_vmac_clk),
            .rstn(vpu_reset_n),
            .vsew(vimac_f0_sew),
            .vxrm(vimac_f0_xrm),
            .vmac_valid(vimac_f0_valid),
            .vmac_mask_byte8(vimac_f0_mask_byte8),
            .vmac_negmul(vimac_f0_negmul),
            .vmac_op_wide(vimac_f0_op_wide),
            .vmac_op_sign(vimac_f0_op_sign),
            .vmac_src_sign(vimac_f0_src_sign),
            .vmac_instr_qmac(vimac_f0_instr_qmac),
            .vmac_instr_vsmul(vimac_f0_instr_vsmul),
            .vmac_instr_vd4dot(vimac_f0_instr_vd4dot),
            .vmac_ret_hi(vimac_f0_ret_hi),
            .vmac_src64_1(vimac_f0_op1_data),
            .vmac_src64_2(vimac_f0_op2_data),
            .vmac_src64_3(vimac_f0_op3_data),
            .vmac_stall(ipipe_stall),
            .vmac_data64(vimac_wdata),
            .vmac_vxsat_set(vimac_vxsat_set)
        );
    end
endgenerate
generate
    if (VIMAC_SUPPORT == 0) begin:gen_vimac_lane_stub
        kv_vimac_lane_stub #(
            .ELEN(IELEN)
        ) u_vimac_lane_stub (
            .clk(vpu_vmac_clk),
            .rstn(vpu_reset_n),
            .vsew(vimac_f0_sew),
            .vxrm(vimac_f0_xrm),
            .vmac_valid(vimac_f0_valid),
            .vmac_mask_byte8(vimac_f0_mask_byte8),
            .vmac_negmul(vimac_f0_negmul),
            .vmac_op_wide(vimac_f0_op_wide),
            .vmac_op_sign(vimac_f0_op_sign),
            .vmac_src_sign(vimac_f0_src_sign),
            .vmac_instr_qmac(vimac_f0_instr_qmac),
            .vmac_instr_vsmul(vimac_f0_instr_vsmul),
            .vmac_instr_vd4dot(vimac_f0_instr_vd4dot),
            .vmac_ret_hi(vimac_f0_ret_hi),
            .vmac_src64_1(vimac_f0_op1_data),
            .vmac_src64_2(vimac_f0_op2_data),
            .vmac_src64_3(vimac_f0_op3_data),
            .vmac_stall(ipipe_stall),
            .vmac_data64(vimac_wdata),
            .vmac_vxsat_set(vimac_vxsat_set)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

