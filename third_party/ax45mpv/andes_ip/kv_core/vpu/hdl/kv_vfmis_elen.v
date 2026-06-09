// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_elen (
    clk,
    rstn,
    vfmis_f1_ex_ctrl,
    vfmis_f1_ex_frm,
    vfmis_f1_op1,
    vfmis_vs1_src,
    vfmis_vs2_src,
    vfmis_vs2_wide_src,
    vfmis_f1_byte_mask,
    vfmis_f1_nrr_byte_mask,
    vfmis_f1_valid,
    vfmis_f2_stall,
    vfmis_f1_wdata,
    vfmis_f1_cmp_bit,
    vfmis_f1_flag_set,
    vfmis_f2_wdata,
    vfmis_f2_narrow_wdata,
    vfmis_f2_flag_set
);
parameter XLEN = 64;
parameter ELEN = 64;
parameter FELEN = 64;
parameter IELEN = 64;
localparam ELEN_BYTE = ELEN / 8;
input clk;
input rstn;
input [71 - 1:0] vfmis_f1_ex_ctrl;
input [2:0] vfmis_f1_ex_frm;
input [XLEN - 1:0] vfmis_f1_op1;
input [ELEN - 1:0] vfmis_vs1_src;
input [ELEN - 1:0] vfmis_vs2_src;
input [ELEN - 1:0] vfmis_vs2_wide_src;
input [ELEN_BYTE - 1:0] vfmis_f1_byte_mask;
input [ELEN_BYTE - 1:0] vfmis_f1_nrr_byte_mask;
input vfmis_f1_valid;
input vfmis_f2_stall;
output [ELEN - 1:0] vfmis_f1_wdata;
output [ELEN / 16 - 1:0] vfmis_f1_cmp_bit;
output [4:0] vfmis_f1_flag_set;
output [ELEN - 1:0] vfmis_f2_wdata;
output [ELEN / 2 - 1:0] vfmis_f2_narrow_wdata;
output [4:0] vfmis_f2_flag_set;





// 27e32c43 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [71 - 1:0] f1_ex_ctrl = vfmis_f1_ex_ctrl;
wire [2:0] f1_ex_frm = vfmis_f1_ex_frm;
wire [ELEN - 1:0] s0 = vfmis_vs1_src;
wire [ELEN - 1:0] s1 = vfmis_vs2_src;
wire [ELEN - 1:0] s2 = vfmis_vs2_wide_src;
wire [3:0] s3 = f1_ex_ctrl[31 +:4];
wire s4 = f1_ex_ctrl[70];
wire s5 = f1_ex_ctrl[24];
wire [1:0] s6 = f1_ex_ctrl[26 +:2];
reg [71 - 1:0] s7;
wire s8;
wire [XLEN - 1:0] s9 = vfmis_f1_op1;
wire f1_valid = vfmis_f1_valid;
wire f2_stall = vfmis_f2_stall;
assign s8 = f1_valid & ~f2_stall & f1_ex_ctrl[43];
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        s7 <= {71{1'b0}};
    end
    else if (s8) begin
        s7 <= f1_ex_ctrl;
    end
end

wire [63:0] s10;
wire [63:0] nds_unused_pipe0_f2_narrow_wdata;
wire [4:0] s11;
wire [63:0] s12;
wire s13;
wire [4:0] s14;
wire [63:0] s15;
wire [4:0] s16;
wire [63:0] s17;
wire s18;
wire [4:0] s19;
wire [63:0] s20;
wire [63:0] nds_unused_pipe2_f2_narrow_wdata;
wire [4:0] s21;
wire [63:0] s22;
wire s23;
wire [4:0] s24;
wire [63:0] s25;
wire [4:0] s26;
wire [63:0] s27;
wire s28;
wire [4:0] s29;
wire [63:0] s30;
wire [63:0] s31;
wire [15:0] s32;
wire [15:0] s33;
wire [15:0] s34;
wire [15:0] s35;
assign s32 = f1_ex_ctrl[35] ? {{8{s2[7]}},s2[7:0]} : {{8{1'b0}},s2[7:0]};
assign s33 = f1_ex_ctrl[35] ? {{8{s2[15]}},s2[15:8]} : {{8{1'b0}},s2[15:8]};
assign s34 = f1_ex_ctrl[35] ? {{8{s2[23]}},s2[23:16]} : {{8{1'b0}},s2[23:16]};
assign s35 = f1_ex_ctrl[35] ? {{8{s2[31]}},s2[31:24]} : {{8{1'b0}},s2[31:24]};
generate
    if (ELEN == 64) begin:gen_pipe0_elen64
        assign s30 = s4 ? s3[0] ? {48'b0,s32} : s2 : s1;
        assign s31 = ({64{s6[0]}} & s0) | ({64{s6[1]}} & s9[63:0]);
    end
    else begin:gen_pipe0_elen32
        assign s30 = s4 ? s3[0] ? {48'b0,s32} : {32'b0,s2} : {32'b0,s1};
        assign s31 = ({64{s6[0]}} & {32'b0,s0[31:0]}) | ({64{s6[1]}} & s9);
    end
endgenerate
wire [71 - 1:0] s36 = f1_ex_ctrl;
wire [2:0] s37 = f1_ex_frm;
wire s38 = s5 ? vfmis_f1_nrr_byte_mask[0] : vfmis_f1_byte_mask[0];
wire s39 = f1_ex_ctrl[35];
wire s40 = ~|s6;
wire [1:0] nds_unused_result_type0;
wire [1:0] nds_unused_result_type1;
kv_vfp_fmis #(
    .FELEN(FELEN),
    .IELEN(IELEN)
) u_pipe0 (
    .f2_narr_wdata(nds_unused_pipe0_f2_narrow_wdata),
    .f2_wdata(s10),
    .f2_flag_set(s11),
    .f2_result_type(nds_unused_result_type0),
    .f1_wdata(s12),
    .f1_flag_set(s14),
    .f1_cmp_bit(s13),
    .f1_op1_data(s30),
    .f1_op2_data(s31),
    .f1_valid(f1_valid),
    .f1_op2_nanbox_check_en(s6[1]),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(s36),
    .f1_ex_frm(s37),
    .f1_vmask(s38),
    .f1_sign(s39),
    .f1_op1_invalid(1'b0),
    .f1_op2_invalid(s40),
    .f2_stall(f2_stall),
    .vpu_vfmis_clk(clk),
    .vpu_reset_n(rstn)
);
wire [63:0] s41 = s4 ? {48'b0,s33} : {48'b0,s1[31:16]};
wire [63:0] s42 = ({64{s6[0]}} & {48'b0,s0[31:16]}) | ({64{s6[1]}} & s9);
wire [71 - 1:0] s43 = f1_ex_ctrl;
wire [2:0] s44 = f1_ex_frm;
wire s45 = (vfmis_f1_byte_mask[2] & s3[1] & ~s4 & ~s5) | (vfmis_f1_byte_mask[2] & s3[0] & s4) | (vfmis_f1_nrr_byte_mask[2] & s3[1] & s5);
wire s46 = f1_ex_ctrl[35];
wire s47 = ~|s6;
wire [63:0] nds_unused_pipe1_f2_narrow_wdata;
kv_vfp_fmis #(
    .FELEN(16),
    .IELEN(16)
) u_pipe1 (
    .f2_narr_wdata(nds_unused_pipe1_f2_narrow_wdata),
    .f2_wdata(s15),
    .f2_flag_set(s16),
    .f2_result_type(nds_unused_result_type1),
    .f1_wdata(s17),
    .f1_flag_set(s19),
    .f1_cmp_bit(s18),
    .f1_op1_data(s41),
    .f1_op2_data(s42),
    .f1_valid(f1_valid),
    .f1_op2_nanbox_check_en(s6[1]),
    .f1_ediv(2'b0),
    .f1_ex_ctrl(s43),
    .f1_ex_frm(s44),
    .f1_vmask(s45),
    .f1_sign(s46),
    .f1_op1_invalid(1'b0),
    .f1_op2_invalid(s47),
    .f2_stall(f2_stall),
    .vpu_vfmis_clk(clk),
    .vpu_reset_n(rstn)
);
generate
    if (ELEN == 64) begin:gen_pipe2_elen64
        wire [63:0] s48 = s4 ? s3[0] ? {48'b0,s34} : {48'b0,s2[31:16]} : {32'b0,s1[63:32]};
        wire [63:0] s49 = ({64{s6[0]}} & {32'b0,s0[63:32]}) | ({64{s6[1]}} & s9);
        wire [71 - 1:0] s50 = f1_ex_ctrl;
        wire [2:0] s51 = f1_ex_frm;
        wire s52 = (vfmis_f1_byte_mask[4] & ~s5 & ~s4 & ~s3[3]) | (vfmis_f1_byte_mask[4] & s4 & s3[0]) | (vfmis_f1_byte_mask[4] & s4 & s3[1]) | (vfmis_f1_nrr_byte_mask[4] & s5 & s3[1]) | (vfmis_f1_nrr_byte_mask[4] & s5 & s3[2]);
        wire s53 = f1_ex_ctrl[35];
        wire s54 = ~|s6;
        wire [1:0] nds_unused_result_type2;
        kv_vfp_fmis #(
            .FELEN(32),
            .IELEN(IELEN)
        ) u_pipe2 (
            .f2_narr_wdata(nds_unused_pipe2_f2_narrow_wdata),
            .f2_wdata(s20),
            .f2_flag_set(s21),
            .f2_result_type(nds_unused_result_type2),
            .f1_wdata(s22),
            .f1_flag_set(s24),
            .f1_cmp_bit(s23),
            .f1_op1_data(s48),
            .f1_op2_data(s49),
            .f1_valid(f1_valid),
            .f1_op2_nanbox_check_en(s6[1]),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(s50),
            .f1_ex_frm(s51),
            .f1_vmask(s52),
            .f1_sign(s53),
            .f1_op1_invalid(1'b0),
            .f1_op2_invalid(s54),
            .f2_stall(f2_stall),
            .vpu_vfmis_clk(clk),
            .vpu_reset_n(rstn)
        );
    end
    else begin:gen_pipe2_elen32
        assign nds_unused_pipe2_f2_narrow_wdata = 64'b0;
        assign s20 = 64'b0;
        assign s21 = 5'b0;
        assign s22 = 64'b0;
        assign s24 = 5'b0;
        assign s23 = 1'b0;
    end
endgenerate
generate
    if (ELEN == 64) begin:gen_pipe3_elen64
        wire [63:0] s55 = s4 ? {48'b0,s35} : {48'b0,s1[63:48]};
        wire [63:0] s56 = ({64{s6[0]}} & {48'b0,s0[63:48]}) | ({64{s6[1]}} & s9);
        wire [71 - 1:0] s57 = f1_ex_ctrl;
        wire [2:0] s58 = f1_ex_frm;
        wire s59 = (vfmis_f1_byte_mask[6] & s3[1] & ~s4 & ~s5) | (vfmis_f1_byte_mask[6] & s3[0] & s4) | (vfmis_f1_nrr_byte_mask[6] & s3[1] & s5);
        wire s60 = f1_ex_ctrl[35];
        wire s61 = ~|s6;
        wire [63:0] nds_unused_pipe3_f2_narrow_wdata;
        wire [1:0] nds_unused_result_type3;
        kv_vfp_fmis #(
            .FELEN(16),
            .IELEN(16)
        ) u_pipe3 (
            .f2_narr_wdata(nds_unused_pipe3_f2_narrow_wdata),
            .f2_wdata(s25),
            .f2_flag_set(s26),
            .f2_result_type(nds_unused_result_type3),
            .f1_wdata(s27),
            .f1_flag_set(s29),
            .f1_cmp_bit(s28),
            .f1_op1_data(s55),
            .f1_op2_data(s56),
            .f1_valid(f1_valid),
            .f1_op2_nanbox_check_en(s6[1]),
            .f1_ediv(2'b0),
            .f1_ex_ctrl(s57),
            .f1_ex_frm(s58),
            .f1_vmask(s59),
            .f1_sign(s60),
            .f1_op1_invalid(1'b0),
            .f1_op2_invalid(s61),
            .f2_stall(f2_stall),
            .vpu_vfmis_clk(clk),
            .vpu_reset_n(rstn)
        );
    end
    else begin:gen_pipe3_elen32
        assign s25 = 64'b0;
        assign s26 = 5'b0;
        assign s27 = 64'b0;
        assign s29 = 5'b0;
        assign s28 = 1'b0;
    end
endgenerate
wire [3:0] s62 = s7[31 +:4];
wire s63 = s7[70];
generate
    if (ELEN == 64) begin:gen_result_elen64
        assign vfmis_f1_wdata = ({64{s3[3] & ~s4}} & s12) | ({64{s3[2] & s4}} & s12) | ({64{s3[2] & ~s4}} & {s22[31:0],s12[31:0]}) | ({64{s3[1] & s4}} & {s22[31:0],s12[31:0]}) | ({64{s3[1] & ~s4}} & {s27[15:0],s22[15:0],s17[15:0],s12[15:0]});
        assign vfmis_f1_flag_set = s14 | ({5{s3[1]}} & s19) | ({5{s3[2] | s3[1]}} & s24) | ({5{s3[1]}} & s29);
        assign vfmis_f1_cmp_bit = {4{s3[3] & s13}} | ({4{s3[2]}} & {{2{s23}},{2{s13}}}) | ({4{s3[1]}} & {s28,s23,s18,s13});
        assign vfmis_f2_wdata = ({64{s62[3] & ~s63}} & s10) | ({64{s62[2] & ~s63}} & {s20[31:0],s10[31:0]}) | ({64{s62[2] & s63}} & s10) | ({64{s62[1] & ~s63}} & {s25[15:0],s20[15:0],s15[15:0],s10[15:0]}) | ({64{s62[1] & s63}} & {s20[31:0],s10[31:0]}) | ({64{s62[0] & s63}} & {s25[15:0],s20[15:0],s15[15:0],s10[15:0]});
        assign vfmis_f2_narrow_wdata = ({32{s62[3]}} & s10[31:0]) | ({32{s62[2]}} & {s20[15:0],s10[15:0]}) | ({32{s62[1]}} & {s25[7:0],s20[7:0],s15[7:0],s10[7:0]});
        assign vfmis_f2_flag_set = ({5{s62[3]}} & s11) | ({5{s62[2] & s63}} & s11) | ({5{s62[2] & ~s63}} & (s11 | s21)) | ({5{s62[1] & s63}} & (s11 | s21)) | ({5{s62[1] & ~s63}} & (s11 | s16 | s21 | s26)) | ({5{s62[0] & s63}} & (s11 | s16 | s21 | s26));
    end
    else begin:gen_result_elen32
        wire nds_unused_wire = (|s22) | (|s27) | (|s23) | (|s28) | (|s34) | (|s35) | (|s24) | (|s29) | (|s20) | (|s25) | (|s21) | (|s26);
        assign vfmis_f1_wdata = ({32{s3[2]}} & {s12[31:0]}) | ({32{s3[1] & s4}} & {s12[31:0]}) | ({32{s3[1] & ~s4}} & {s17[15:0],s12[15:0]});
        assign vfmis_f1_flag_set = s14 | ({5{s3[1]}} & s19);
        assign vfmis_f1_cmp_bit = ({2{s3[2]}} & {2{s13}}) | ({2{s3[1]}} & {s18,s13});
        assign vfmis_f2_wdata = ({32{s62[2]}} & s10[31:0]) | ({32{s62[1] & ~s63}} & {s15[15:0],s10[15:0]}) | ({32{s62[1] & s63}} & {s10[31:0]}) | ({32{s62[0] & s63}} & {s15[15:0],s10[15:0]});
        assign vfmis_f2_narrow_wdata = ({16{s62[2]}} & {s10[15:0]}) | ({16{s62[1]}} & {s15[7:0],s10[7:0]});
        assign vfmis_f2_flag_set = ({5{s62[2]}} & s11) | ({5{s62[1] & s63}} & s11) | ({5{s62[1] & ~s63}} & (s11 | s16)) | ({5{s62[0] & s63}} & (s11 | s16));
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

