// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmac_lane (
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
    f0_round_mode,
    f0_sew,
    f0_fp_mode,
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





// be8f63eb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (ELEN == 64) begin:gen_fmac_elen64
        kv_vfmac_elen64 #(
            .FLEN(64)
        ) u_vfmac_elen64 (
            .f4_wdata(wdata),
            .f4_flag_set(flag_set),
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .fpipe_stall(fpipe_stall),
            .f0_fp_mode(f0_fp_mode),
            .f0_byte_mask(f0_byte_mask),
            .f0_op1_data(f0_op1_data),
            .f0_op2_data(f0_op2_data),
            .f0_op3_data(f0_op3_data),
            .f0_valid(f0_valid),
            .f0_round_mode(f0_round_mode),
            .f0_sew(f0_sew),
            .f0_op1_sew64(f0_op1_sew64),
            .f0_op3_sew64(f0_op3_sew64),
            .f0_op1_sew32(f0_op1_sew32),
            .f0_op3_sew32(f0_op3_sew32),
            .f0_op1_sew16(f0_op1_sew16),
            .f0_op3_sew16(f0_op3_sew16),
            .f0_align_amount_adjustment(f0_align_amount_adjustment),
            .f0_mul_instr(f0_mul_instr),
            .f0_madd_instr(f0_madd_instr),
            .f0_msub_instr(f0_msub_instr),
            .f0_nmadd_instr(f0_nmadd_instr),
            .f0_nmsub_instr(f0_nmsub_instr)
        );
    end
    else begin:gen_fmac_elen32
        wire [4:0] s0;
        wire [4:0] s1;
        assign flag_set = s0 | s1;
        wire [63:0] s2 = {32'b0,f0_op1_data[31:0]};
        wire [63:0] s3 = {32'b0,f0_op1_data[63:32]};
        wire [63:0] s4 = {32'b0,f0_op2_data[31:0]};
        wire [63:0] s5 = {32'b0,f0_op2_data[63:32]};
        wire [63:0] s6 = {32'b0,f0_op3_data[31:0]};
        wire [63:0] s7 = {32'b0,f0_op3_data[63:32]};
        kv_vfmac_elen32 #(
            .FLEN(32)
        ) u_vfmac_elen32_0 (
            .f3_wdata(wdata[31:0]),
            .f3_flag_set(s0),
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .fpipe_stall(fpipe_stall),
            .f0_fp_mode(f0_fp_mode),
            .f0_byte_mask(f0_byte_mask[3:0]),
            .f0_op1_data(s2),
            .f0_op2_data(s4),
            .f0_op3_data(s6),
            .f0_valid(f0_valid),
            .f0_round_mode(f0_round_mode),
            .f0_sew(f0_sew),
            .f0_op1_sew32(f0_op1_sew32),
            .f0_op3_sew32(f0_op3_sew32),
            .f0_op1_sew16(f0_op1_sew16),
            .f0_op3_sew16(f0_op3_sew16),
            .f0_align_amount_adjustment(f0_align_amount_adjustment),
            .f0_mul_instr(f0_mul_instr),
            .f0_madd_instr(f0_madd_instr),
            .f0_msub_instr(f0_msub_instr),
            .f0_nmadd_instr(f0_nmadd_instr),
            .f0_nmsub_instr(f0_nmsub_instr)
        );
        kv_vfmac_elen32 #(
            .FLEN(32)
        ) u_vfmac_elen32_1 (
            .f3_wdata(wdata[63:32]),
            .f3_flag_set(s1),
            .vpu_vmac_clk(vpu_vmac_clk),
            .vpu_reset_n(vpu_reset_n),
            .fpipe_stall(fpipe_stall),
            .f0_fp_mode(f0_fp_mode),
            .f0_byte_mask(f0_byte_mask[7:4]),
            .f0_op1_data(s3),
            .f0_op2_data(s5),
            .f0_op3_data(s7),
            .f0_valid(f0_valid),
            .f0_round_mode(f0_round_mode),
            .f0_sew(f0_sew),
            .f0_op1_sew32(f0_op1_sew32),
            .f0_op3_sew32(f0_op3_sew32),
            .f0_op1_sew16(f0_op1_sew16),
            .f0_op3_sew16(f0_op3_sew16),
            .f0_align_amount_adjustment(f0_align_amount_adjustment),
            .f0_mul_instr(f0_mul_instr),
            .f0_madd_instr(f0_madd_instr),
            .f0_msub_instr(f0_msub_instr),
            .f0_nmadd_instr(f0_nmadd_instr),
            .f0_nmsub_instr(f0_nmsub_instr)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

