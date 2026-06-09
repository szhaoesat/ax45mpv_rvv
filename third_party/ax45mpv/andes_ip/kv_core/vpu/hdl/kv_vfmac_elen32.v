// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmac_elen32 (
    f3_wdata,
    f3_flag_set,
    vpu_vmac_clk,
    vpu_reset_n,
    fpipe_stall,
    f0_fp_mode,
    f0_byte_mask,
    f0_op1_data,
    f0_op2_data,
    f0_op3_data,
    f0_valid,
    f0_round_mode,
    f0_sew,
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
parameter FLEN = 64;
input vpu_vmac_clk;
input vpu_reset_n;
input fpipe_stall;
input [3:0] f0_byte_mask;
input [63:0] f0_op1_data;
input [63:0] f0_op2_data;
input [63:0] f0_op3_data;
input f0_valid;
input [2:0] f0_round_mode;
input [1:0] f0_sew;
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
input f0_fp_mode;
output [31:0] f3_wdata;
output [4:0] f3_flag_set;





// 55d2f10c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [63:0] f1_op1_data;
reg [63:0] f1_op2_data;
reg [63:0] f1_op3_data;
reg f1_valid;
reg s0;
reg s1;
reg [2:0] f1_round_mode;
reg [1:0] f1_sew;
reg [1:0] s2;
reg [1:0] s3;
reg f1_op1_sew16;
reg f1_op3_sew16;
reg f1_mul_instr;
reg f1_madd_instr;
reg f1_msub_instr;
reg f1_nmadd_instr;
reg f1_nmsub_instr;
reg [3:0] s4;
reg f1_fp_mode;
reg f1_op1_hp;
reg f1_op3_hp;
reg f1_op1_bp;
reg f1_op3_bp;
reg f1_op1_sp;
reg f1_op3_sp;
wire s5;
wire s6;
wire s7;
wire s8;
assign s5 = f0_op1_sew16 & ~f0_fp_mode;
assign s7 = f0_op1_sew16 & f0_fp_mode;
assign s6 = f0_op3_sew16 & ~f0_fp_mode;
assign s8 = f0_op3_sew16 & f0_fp_mode;
wire s9 = f0_valid & ~fpipe_stall;
wire s10 = f1_valid & ~fpipe_stall;
wire s11 = s0 & ~fpipe_stall;
wire s12;
wire s13;
wire s14;
assign s12 = f0_valid & ~fpipe_stall | f1_valid & fpipe_stall;
assign s13 = f1_valid & ~fpipe_stall | s0 & fpipe_stall;
assign s14 = s0 & ~fpipe_stall | s1 & fpipe_stall;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_valid <= 1'b0;
        s0 <= 1'b0;
        s1 <= 1'b0;
    end
    else begin
        f1_valid <= s12;
        s0 <= s13;
        s1 <= s14;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_op1_data <= 64'b0;
        f1_op2_data <= 64'b0;
        f1_op3_data <= 64'b0;
        f1_round_mode <= 3'b0;
        f1_op1_sp <= 1'b0;
        f1_op3_sp <= 1'b0;
        f1_op1_hp <= 1'b0;
        f1_op3_hp <= 1'b0;
        f1_op1_bp <= 1'b0;
        f1_op3_bp <= 1'b0;
        f1_op1_sew16 <= 1'b0;
        f1_op3_sew16 <= 1'b0;
        f1_sew <= 2'b0;
        f1_mul_instr <= 1'b0;
        f1_madd_instr <= 1'b0;
        f1_msub_instr <= 1'b0;
        f1_nmadd_instr <= 1'b0;
        f1_nmsub_instr <= 1'b0;
        s4 <= 4'b0;
        f1_fp_mode <= 1'b0;
    end
    else if (s9) begin
        f1_op1_data <= f0_op1_data;
        f1_op2_data <= f0_op2_data;
        f1_op3_data <= f0_op3_data;
        f1_round_mode <= f0_round_mode;
        f1_op1_sp <= f0_op1_sew32;
        f1_op3_sp <= f0_op3_sew32;
        f1_op1_hp <= s5;
        f1_op3_hp <= s6;
        f1_op1_bp <= s7;
        f1_op3_bp <= s8;
        f1_op1_sew16 <= f0_op1_sew16;
        f1_op3_sew16 <= f0_op3_sew16;
        f1_sew <= f0_sew;
        f1_mul_instr <= f0_mul_instr;
        f1_madd_instr <= f0_madd_instr;
        f1_msub_instr <= f0_msub_instr;
        f1_nmadd_instr <= f0_nmadd_instr;
        f1_nmsub_instr <= f0_nmsub_instr;
        s4 <= f0_byte_mask;
        f1_fp_mode <= f0_fp_mode;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s2 <= 2'b0;
    end
    else if (s10) begin
        s2 <= f1_sew;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s3 <= 2'b0;
    end
    else if (s11) begin
        s3 <= s2;
    end
end

wire s15;
wire s16;
wire [1:0] nds_unused_result_type_p0;
wire [4:0] s17;
wire [4:0] s18;
wire s19;
wire s20;
wire [31:0] s21 = f1_op1_data[31:0];
wire [31:0] s22 = f1_op2_data[31:0];
wire [31:0] s23 = f1_op3_data[31:0];
wire [15:0] s24 = f1_op1_data[31:16];
wire [15:0] s25 = f1_op2_data[31:16];
wire [15:0] s26 = f1_op3_data[31:16];
wire [63:0] s27;
wire [15:0] s28;
assign f3_wdata = ({32{s3 == 2'b10}} & {s27[31:0]}) | ({32{s3 == 2'b01}} & {s28,s27[15:0]});
assign s19 = f1_valid & s4[0];
assign s20 = f1_valid & (f1_sew == 2'b01) & s4[2];
assign f3_flag_set = (s17 & {5{s15}}) | (s18 & {5{s16}});
kv_vfp_fmac #(
    .FLEN(32)
) u_fmac_pipe0 (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s21),
    .f1_op2_data(s22),
    .f1_op3_data(s23),
    .f1_valid(s19),
    .f1_round_mode(f1_round_mode),
    .f1_sew(f1_sew),
    .f1_op_mask(1'b1),
    .f1_op1_sp(f1_op1_sp),
    .f1_op3_sp(f1_op3_sp),
    .f1_op1_hp(f1_op1_hp),
    .f1_op3_hp(f1_op3_hp),
    .f1_op1_bp(f1_op1_bp),
    .f1_op3_bp(f1_op3_bp),
    .f1_op1_sew16(f1_op1_sew16),
    .f1_op3_sew16(f1_op3_sew16),
    .f1_mul_instr(f1_mul_instr),
    .f1_madd_instr(f1_madd_instr),
    .f1_msub_instr(f1_msub_instr),
    .f1_nmadd_instr(f1_nmadd_instr),
    .f1_nmsub_instr(f1_nmsub_instr),
    .f3_wdata(s27),
    .f3_wdata_en(s15),
    .f3_result_type(nds_unused_result_type_p0),
    .f3_flag_set(s17)
);
kv_vfp_fmac16 u_pipe1(
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s24),
    .f1_op2_data(s25),
    .f1_op3_data(s26),
    .f1_valid(s20),
    .f1_round_mode(f1_round_mode),
    .f1_mul_instr(f1_mul_instr),
    .f1_madd_instr(f1_madd_instr),
    .f1_msub_instr(f1_msub_instr),
    .f1_nmadd_instr(f1_nmadd_instr),
    .f1_nmsub_instr(f1_nmsub_instr),
    .f3_wdata(s28),
    .f3_wdata_en(s16),
    .f3_flag_set(s18)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

