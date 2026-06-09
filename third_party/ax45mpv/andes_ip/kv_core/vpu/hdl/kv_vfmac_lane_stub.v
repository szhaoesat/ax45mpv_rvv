// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmac_lane_stub (
    wdata,
    flag_set,
    vpu_vmac_clk,
    vpu_reset_n,
    fpipe_stall,
    f0_byte_mask,
    f0_op1_data,
    f0_op2_data,
    f0_op3_data,
    f0_valid,
    f0_fp_mode,
    f0_round_mode,
    f0_sew,
    f0_op1_sew64,
    f0_op3_sew64,
    f0_op1_sew32,
    f0_op3_sew32,
    f0_op1_sew16,
    f0_op3_sew16,
    f0_align_amount_adjustment,
    f0_mul_instr,
    f0_madd_instr,
    f0_msub_instr,
    f0_nmadd_instr,
    f0_nmsub_instr
);
parameter ELEN = 64;
input vpu_vmac_clk;
input vpu_reset_n;
input fpipe_stall;
input [7:0] f0_byte_mask;
input [63:0] f0_op1_data;
input [63:0] f0_op2_data;
input [63:0] f0_op3_data;
input f0_valid;
input [2:0] f0_round_mode;
input [1:0] f0_sew;
input f0_fp_mode;
input f0_op1_sew64;
input f0_op3_sew64;
input f0_op1_sew32;
input f0_op3_sew32;
input f0_op1_sew16;
input f0_op3_sew16;
input [10:0] f0_align_amount_adjustment;
input f0_mul_instr;
input f0_madd_instr;
input f0_msub_instr;
input f0_nmadd_instr;
input f0_nmsub_instr;
output [63:0] wdata;
output [4:0] flag_set;





// 4e282c88 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


assign wdata = 64'b0;
assign flag_set = 5'b0;
wire nds_unused_input = vpu_vmac_clk | vpu_reset_n | fpipe_stall | (|f0_byte_mask) | (|f0_op1_data) | (|f0_op2_data) | (|f0_op3_data) | f0_valid | (|f0_round_mode) | (|f0_sew) | f0_fp_mode | f0_op1_sew64 | f0_op3_sew64 | f0_op1_sew32 | f0_op3_sew32 | f0_op1_sew16 | f0_op3_sew16 | (|f0_align_amount_adjustment) | f0_mul_instr | f0_madd_instr | f0_msub_instr | f0_nmadd_instr | f0_nmsub_instr;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

