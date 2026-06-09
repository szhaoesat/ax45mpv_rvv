// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmac_elen64 (
    f4_wdata,
    f4_flag_set,
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
parameter FLEN = 64;
input vpu_vmac_clk;
input vpu_reset_n;
input fpipe_stall;
input [7:0] f0_byte_mask;
input f0_fp_mode;
input [63:0] f0_op1_data;
input [63:0] f0_op2_data;
input [63:0] f0_op3_data;
input f0_valid;
input [2:0] f0_round_mode;
input [1:0] f0_sew;
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
output [63:0] f4_wdata;
output [4:0] f4_flag_set;





// 4cbbf2e5 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [63:0] f1_op1_data;
reg [63:0] f1_op2_data;
reg [63:0] f1_op3_data;
reg f1_valid;
reg s0;
reg s1;
reg s2;
reg [2:0] f1_round_mode;
reg [1:0] f1_sew;
reg [1:0] s3;
reg [1:0] s4;
reg [1:0] s5;
reg f1_op1_dp;
reg f1_op3_dp;
reg f1_op1_sp;
reg f1_op3_sp;
reg f1_op1_hp;
reg f1_op3_hp;
reg f1_op1_bp;
reg f1_op3_bp;
reg f1_op1_sew16;
reg f1_op3_sew16;
reg [10:0] f1_align_amount_adjustment;
reg f1_mul_instr;
reg f1_madd_instr;
reg f1_msub_instr;
reg f1_nmadd_instr;
reg f1_nmsub_instr;
reg [7:0] s6;
reg f1_fp_mode;
wire s7;
wire s8;
wire s9;
wire s10;
assign s7 = f0_op1_sew16 & ~f0_fp_mode;
assign s9 = f0_op1_sew16 & f0_fp_mode;
assign s8 = f0_op3_sew16 & ~f0_fp_mode;
assign s10 = f0_op3_sew16 & f0_fp_mode;
wire s11 = f0_valid & ~fpipe_stall;
wire s12 = f1_valid & ~fpipe_stall;
wire s13 = s0 & ~fpipe_stall;
wire s14 = s1 & ~fpipe_stall;
wire s15;
wire s16;
wire s17;
wire s18;
assign s15 = f0_valid & ~fpipe_stall | f1_valid & fpipe_stall;
assign s16 = f1_valid & ~fpipe_stall | s0 & fpipe_stall;
assign s17 = s0 & ~fpipe_stall | s1 & fpipe_stall;
assign s18 = s1 & ~fpipe_stall | s2 & fpipe_stall;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_valid <= 1'b0;
        s0 <= 1'b0;
        s1 <= 1'b0;
        s2 <= 1'b0;
    end
    else begin
        f1_valid <= s15;
        s0 <= s16;
        s1 <= s17;
        s2 <= s18;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        f1_op1_data <= 64'b0;
        f1_op2_data <= 64'b0;
        f1_op3_data <= 64'b0;
        f1_round_mode <= 3'b0;
        f1_sew <= 2'b0;
        f1_op1_dp <= 1'b0;
        f1_op3_dp <= 1'b0;
        f1_op1_sp <= 1'b0;
        f1_op3_sp <= 1'b0;
        f1_op1_hp <= 1'b0;
        f1_op3_hp <= 1'b0;
        f1_op1_bp <= 1'b0;
        f1_op3_bp <= 1'b0;
        f1_op1_sew16 <= 1'b0;
        f1_op3_sew16 <= 1'b0;
        f1_mul_instr <= 1'b0;
        f1_madd_instr <= 1'b0;
        f1_msub_instr <= 1'b0;
        f1_nmadd_instr <= 1'b0;
        f1_nmsub_instr <= 1'b0;
        f1_align_amount_adjustment <= 11'b0;
        s6 <= 8'b0;
        f1_fp_mode <= 1'b0;
    end
    else if (s11) begin
        f1_op1_data <= f0_op1_data;
        f1_op2_data <= f0_op2_data;
        f1_op3_data <= f0_op3_data;
        f1_round_mode <= f0_round_mode;
        f1_sew <= f0_sew;
        f1_op1_dp <= f0_op1_sew64;
        f1_op3_dp <= f0_op3_sew64;
        f1_op1_sp <= f0_op1_sew32;
        f1_op3_sp <= f0_op3_sew32;
        f1_op1_hp <= s7;
        f1_op3_hp <= s8;
        f1_op1_bp <= s9;
        f1_op3_bp <= s10;
        f1_op1_sew16 <= f0_op1_sew16;
        f1_op3_sew16 <= f0_op3_sew16;
        f1_mul_instr <= f0_mul_instr;
        f1_madd_instr <= f0_madd_instr;
        f1_msub_instr <= f0_msub_instr;
        f1_nmadd_instr <= f0_nmadd_instr;
        f1_nmsub_instr <= f0_nmsub_instr;
        f1_align_amount_adjustment <= f0_align_amount_adjustment;
        s6 <= f0_byte_mask;
        f1_fp_mode <= f0_fp_mode;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s3 <= 2'b0;
    end
    else if (s12) begin
        s3 <= f1_sew;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s4 <= 2'b0;
    end
    else if (s13) begin
        s4 <= s3;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s5 <= 2'b0;
    end
    else if (s14) begin
        s5 <= s4;
    end
end

wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire [1:0] nds_unused_result_type_p0;
wire [1:0] nds_unused_result_type_p2;
wire [4:0] s26;
wire [4:0] s27;
wire [4:0] s28;
wire [4:0] s29;
reg [4:0] s30;
reg [4:0] s31;
reg [4:0] s32;
wire [4:0] s33;
wire [4:0] s34;
wire [4:0] s35;
wire s36;
wire s37;
wire s38;
wire s39;
wire [63:0] s40 = f1_op1_data[63:0];
wire [63:0] s41 = f1_op2_data[63:0];
wire [63:0] s42 = f1_op3_data[63:0];
wire [15:0] s43 = f1_op1_data[31:16];
wire [15:0] s44 = f1_op2_data[31:16];
wire [15:0] s45 = f1_op3_data[31:16];
wire [31:0] s46 = f1_op1_data[63:32];
wire [31:0] s47 = f1_op2_data[63:32];
wire [31:0] s48 = f1_op3_data[63:32];
wire [15:0] s49 = f1_op1_data[63:48];
wire [15:0] s50 = f1_op2_data[63:48];
wire [15:0] s51 = f1_op3_data[63:48];
wire [63:0] s52;
wire [15:0] s53;
wire [63:0] s54;
wire [15:0] s55;
reg [15:0] s56;
reg [31:0] s57;
reg [15:0] s58;
assign f4_wdata = ({64{s5 == 2'b11}} & s52) | ({64{s5 == 2'b10}} & {s57,s52[31:0]}) | ({64{s5 == 2'b01}} & {s58,s57[15:0],s56,s52[15:0]});
assign s36 = f1_valid & s6[0];
assign s37 = f1_valid & (f1_sew == 2'b01) & s6[2];
assign s38 = f1_valid & (f1_sew != 2'b11) & s6[4];
assign s39 = f1_valid & (f1_sew == 2'b01) & s6[6];
assign f4_flag_set = (s26 & {5{s22}}) | s30 | s31 | s32;
assign s19 = s23 & ~fpipe_stall;
assign s20 = s24 & ~fpipe_stall;
assign s21 = s25 & ~fpipe_stall;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s56 <= 16'b0;
    end
    else if (s19) begin
        s56 <= s53;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s57 <= 32'b0;
    end
    else if (s20) begin
        s57 <= s54[31:0];
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s58 <= 16'b0;
    end
    else if (s21) begin
        s58 <= s55;
    end
end

assign s33 = {5{s23}} & s27;
assign s34 = {5{s24}} & s28;
assign s35 = {5{s25}} & s29;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s30 <= 5'b0;
        s31 <= 5'b0;
        s32 <= 5'b0;
    end
    else if (~fpipe_stall) begin
        s30 <= s33;
        s31 <= s34;
        s32 <= s35;
    end
end

kv_vfp_fmac64 #(
    .FLEN(64)
) u_fmac_pipe0 (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s40),
    .f1_op2_data(s41),
    .f1_op3_data(s42),
    .f1_valid(s36),
    .f1_round_mode(f1_round_mode),
    .f1_sew(f1_sew),
    .f1_op_mask(1'b1),
    .f1_op1_dp(f1_op1_dp),
    .f1_op3_dp(f1_op3_dp),
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
    .f1_align_amount_adjustment(f1_align_amount_adjustment),
    .f4_wdata(s52[63:0]),
    .f4_wdata_en(s22),
    .f4_result_type(nds_unused_result_type_p0),
    .f4_flag_set(s26)
);
kv_vfp_fmac16 u_pipe1(
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s43),
    .f1_op2_data(s44),
    .f1_op3_data(s45),
    .f1_valid(s37),
    .f1_round_mode(f1_round_mode),
    .f1_mul_instr(f1_mul_instr),
    .f1_madd_instr(f1_madd_instr),
    .f1_msub_instr(f1_msub_instr),
    .f1_nmadd_instr(f1_nmadd_instr),
    .f1_nmsub_instr(f1_nmsub_instr),
    .f3_wdata(s53),
    .f3_wdata_en(s23),
    .f3_flag_set(s27)
);
kv_vfp_fmac #(
    .FLEN(32)
) u_pipe2 (
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s46),
    .f1_op2_data(s47),
    .f1_op3_data(s48),
    .f1_valid(s38),
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
    .f3_wdata(s54),
    .f3_wdata_en(s24),
    .f3_result_type(nds_unused_result_type_p2),
    .f3_flag_set(s28)
);
kv_vfp_fmac16 u_pipe3(
    .vpu_vmac_clk(vpu_vmac_clk),
    .vpu_reset_n(vpu_reset_n),
    .fpipe_stall(fpipe_stall),
    .f1_fp_mode(f1_fp_mode),
    .f1_op1_data(s49),
    .f1_op2_data(s50),
    .f1_op3_data(s51),
    .f1_valid(s39),
    .f1_round_mode(f1_round_mode),
    .f1_mul_instr(f1_mul_instr),
    .f1_madd_instr(f1_madd_instr),
    .f1_msub_instr(f1_msub_instr),
    .f1_nmadd_instr(f1_nmadd_instr),
    .f1_nmsub_instr(f1_nmsub_instr),
    .f3_wdata(s55),
    .f3_wdata_en(s25),
    .f3_flag_set(s29)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

