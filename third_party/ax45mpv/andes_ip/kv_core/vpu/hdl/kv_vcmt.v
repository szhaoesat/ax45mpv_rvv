// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vcmt (
    vpu_clk,
    vpu_reset_n,
    vpu_req_valid,
    vpu_req_i0_fu,
    vpu_req_i1_fu,
    vpu_req_i0_srf,
    vpu_req_i1_srf,
    vpu_cmt_valid,
    vpu_cmt_kill,
    vpu_cmt_i0_op1,
    vpu_cmt_i1_op1,
    dis_i0_grant,
    dis_i1_grant,
    cmt_i0_grant,
    cmt_i0_kill,
    cmt_i1_grant,
    cmt_i1_kill,
    valu_cmt_valid,
    valu_cmt_kill,
    valu_cmt_op1,
    vlsu_cmt_valid,
    vlsu_cmt_kill,
    vsp_cmt_valid,
    vsp_cmt_op1,
    vsp_cmt_srf,
    vsp_cmt_kill,
    vmac_cmt_valid,
    vmac_cmt_kill,
    vmac_cmt_op1,
    vmac2_cmt_valid,
    vmac2_cmt_kill,
    vmac2_cmt_op1,
    vdiv_cmt_valid,
    vdiv_cmt_kill,
    vdiv_cmt_op1,
    vfmis_cmt_valid,
    vfmis_cmt_kill,
    vfmis_cmt_op1,
    vpermut_cmt_valid,
    vpermut_cmt_kill,
    vpermut_cmt_srf,
    vpermut_cmt_op1,
    vfdiv_cmt_valid,
    vfdiv_cmt_kill,
    vfdiv_cmt_op1,
    vmask_cmt_valid,
    vmask_cmt_kill,
    vmask_cmt_srf,
    vmask_cmt_op1,
    vace_cmt_valid,
    vace_cmt_kill,
    vace_cmt_op1
);
parameter VMAC2_TYPE = 0;
parameter AGEN = 8;
localparam XLEN = 64;
localparam FIFO_DEPTH = 6;
localparam FIFO_DW = 8;
localparam VPU_STATUS_BITS = 2;
localparam VPU_CTRL_BITS = 30;
input vpu_clk;
input vpu_reset_n;
input [1:0] vpu_req_valid;
input [11 - 1:0] vpu_req_i0_fu;
input [11 - 1:0] vpu_req_i1_fu;
input vpu_req_i0_srf;
input vpu_req_i1_srf;
input vpu_cmt_valid;
input [1:0] vpu_cmt_kill;
input [XLEN - 1:0] vpu_cmt_i0_op1;
input [XLEN - 1:0] vpu_cmt_i1_op1;
input dis_i0_grant;
input dis_i1_grant;
output cmt_i0_grant;
output cmt_i0_kill;
output cmt_i1_grant;
output cmt_i1_kill;
output valu_cmt_valid;
output valu_cmt_kill;
output [XLEN - 1:0] valu_cmt_op1;
output vlsu_cmt_valid;
output vlsu_cmt_kill;
output vsp_cmt_valid;
output [XLEN - 1:0] vsp_cmt_op1;
output vsp_cmt_srf;
output vsp_cmt_kill;
output vmac_cmt_valid;
output vmac_cmt_kill;
output [XLEN - 1:0] vmac_cmt_op1;
output vmac2_cmt_valid;
output vmac2_cmt_kill;
output [XLEN - 1:0] vmac2_cmt_op1;
output vdiv_cmt_valid;
output vdiv_cmt_kill;
output [XLEN - 1:0] vdiv_cmt_op1;
output vfmis_cmt_valid;
output vfmis_cmt_kill;
output [XLEN - 1:0] vfmis_cmt_op1;
output vpermut_cmt_valid;
output vpermut_cmt_kill;
output vpermut_cmt_srf;
output [XLEN - 1:0] vpermut_cmt_op1;
output vfdiv_cmt_valid;
output vfdiv_cmt_kill;
output [XLEN - 1:0] vfdiv_cmt_op1;
output vmask_cmt_valid;
output vmask_cmt_kill;
output vmask_cmt_srf;
output [XLEN - 1:0] vmask_cmt_op1;
output vace_cmt_valid;
output vace_cmt_kill;
output [XLEN - 1:0] vace_cmt_op1;





// 9414e504 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire dis_i0_grant;
wire dis_i1_grant;
wire buf_i0_valid;
wire s0;
wire s1;
wire s2;
wire s3;
wire cmt_i0_kill;
wire cmt_i1_kill;
wire s4;
wire s5;
wire [XLEN - 1:0] s6;
wire [XLEN - 1:0] s7;
wire [XLEN - 1:0] s8;
wire [XLEN - 1:0] s9;
wire [11 - 1:0] s10;
wire [11 - 1:0] s11;
wire [11 - 1:0] s12;
wire [11 - 1:0] s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26 = ~s24;
wire s27 = ~s25 | ~s22 | s26;
wire cmt_i0_grant;
wire cmt_i1_grant;
wire s28;
wire s29;
wire s30 = 1'b0;
wire s31 = 1'b0;
wire [XLEN - 1:0] s32 = {XLEN{1'b0}};
wire [XLEN - 1:0] s33 = {XLEN{1'b0}};
wire s34 = 1'b0;
wire s35 = 1'b0;
wire s36 = 1'b0;
wire s37 = 1'b0;
wire s38 = 1'b0;
wire [11 - 1:0] s39 = {11{1'b0}};
wire [11 - 1:0] s40 = {11{1'b0}};
wire s41 = 1'b0;
wire s42 = 1'b0;
wire s43 = 1'b0;
wire s44 = 1'b0;
wire [XLEN - 1:0] s45 = {XLEN{1'b0}};
wire [XLEN - 1:0] s46 = {XLEN{1'b0}};
wire s47 = 1'b0;
kv_vcmt_buf u_cmt_buf(
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
    .buf_i0_valid(s0),
    .buf_i0_ready(s2),
    .buf_i0_op1(s8),
    .buf_i0_fu(s12),
    .buf_i0_srf(s16),
    .buf_i0_kill(s4),
    .buf_i1_valid(s1),
    .buf_i1_ready(s3),
    .buf_i1_op1(s9),
    .buf_i1_fu(s13),
    .buf_i1_srf(s17),
    .buf_i1_kill(s5)
);
assign s2 = ~s26 & s22;
assign s3 = ~s27 & s23;
assign s20 = s0 & ~s26;
assign s21 = s1 & ~s27;
assign s22 = s12[1] | s12[2] | s12[0] | s12[3] | s12[4] | s12[5] | s12[6] | s12[8] | s12[7] | s12[9] | s12[10];
assign s23 = (~s12[1] & s13[1]) | (~s12[2] & s13[2]) | (~s12[0] & s13[0]) | (~s12[3] & s13[3]) | (~s12[4] & s13[4]) | (~s12[5] & s13[5]) | (~s12[6] & s13[6]) | (~s12[8] & s13[8]) | (~s12[7] & s13[7]) | (~s12[9] & s13[9]) | (~s12[10] & s13[10]);
assign buf_i0_valid = ~{s34} ? s0 : s47;
assign cmt_i0_grant = ~s34 ? s28 : s35;
assign cmt_i1_grant = ~s34 ? s29 : s36;
assign s18 = ~{s34} ? s20 : s37;
assign s19 = ~{s34} ? s21 : s38;
assign s6 = (~s30 & ~s34) ? s8 : s34 ? s45 : s32;
assign s7 = (~s31 & ~s34) ? s9 : s34 ? s46 : s33;
assign s10 = ~{s34} ? s12 : s39;
assign s11 = ~{s34} ? s13 : s40;
assign cmt_i0_kill = ~{s34} ? s4 : s41;
assign cmt_i1_kill = ~{s34} ? s5 : s42;
assign s14 = ~{s34} ? s16 : s43;
assign s15 = ~{s34} ? s17 : s44;
kv_vcmt_dis #(
    .AGEN(AGEN)
) u_cmt_dis (
    .vpu_clk(vpu_clk),
    .vpu_reset_n(vpu_reset_n),
    .dis_i0_grant(dis_i0_grant),
    .dis_i1_grant(dis_i1_grant),
    .cmt_i0_grant(s28),
    .cmt_i1_grant(s29),
    .cmt_i0_dispatched(s24),
    .cmt_i1_dispatched(s25)
);
assign s28 = s20 & s22;
assign s29 = s21 & s23;
assign valu_cmt_valid = (s18 & s10[0]) | (s19 & s11[0]);
assign valu_cmt_op1 = (buf_i0_valid & s10[0]) ? s6 : s7;
assign valu_cmt_kill = (buf_i0_valid & s10[0]) ? cmt_i0_kill : cmt_i1_kill;
assign vlsu_cmt_valid = (s18 & s10[1]) | (s19 & s11[1]);
assign vlsu_cmt_kill = (buf_i0_valid & s10[1]) ? cmt_i0_kill : cmt_i1_kill;
assign vsp_cmt_valid = (s18 & s10[2]) | (s19 & s11[2]);
assign vsp_cmt_op1 = (buf_i0_valid & s10[2]) ? s6 : s7;
assign vsp_cmt_kill = (buf_i0_valid & s10[2]) ? cmt_i0_kill : cmt_i1_kill;
assign vsp_cmt_srf = (buf_i0_valid & s10[2]) ? s14 : s15;
assign vmac_cmt_valid = (s18 & s10[3]) | (s19 & s11[3]);
assign vmac_cmt_op1 = (buf_i0_valid & s10[3]) ? s6 : s7;
assign vmac_cmt_kill = (buf_i0_valid & s10[3]) ? cmt_i0_kill : cmt_i1_kill;
generate
    if (VMAC2_TYPE != 0) begin:gen_vmac2_cmt
        assign vmac2_cmt_valid = (s18 & s10[10]) | (s19 & s11[10]);
        assign vmac2_cmt_op1 = (buf_i0_valid & s10[10]) ? s6 : s7;
        assign vmac2_cmt_kill = (buf_i0_valid & s10[10]) ? cmt_i0_kill : cmt_i1_kill;
    end
    else begin:gen_vmac2_cmt_stub
        assign vmac2_cmt_valid = 1'b0;
        assign vmac2_cmt_op1 = {XLEN{1'b0}};
        assign vmac2_cmt_kill = 1'b0;
    end
endgenerate
assign vdiv_cmt_valid = (s18 & s10[4]) | (s19 & s11[4]);
assign vdiv_cmt_op1 = (buf_i0_valid & s10[4]) ? s6 : s7;
assign vdiv_cmt_kill = (buf_i0_valid & s10[4]) ? cmt_i0_kill : cmt_i1_kill;
assign vfmis_cmt_valid = (s18 & s10[5]) | (s19 & s11[5]);
assign vfmis_cmt_op1 = (buf_i0_valid & s10[5]) ? s6 : s7;
assign vfmis_cmt_kill = (buf_i0_valid & s10[5]) ? cmt_i0_kill : cmt_i1_kill;
assign vpermut_cmt_valid = (s18 & s10[6]) | (s19 & s11[6]);
assign vpermut_cmt_op1 = (buf_i0_valid & s10[6]) ? s6 : s7;
assign vpermut_cmt_kill = (buf_i0_valid & s10[6]) ? cmt_i0_kill : cmt_i1_kill;
assign vpermut_cmt_srf = (buf_i0_valid & s10[6]) ? s14 : s15;
assign vfdiv_cmt_valid = (s18 & s10[7]) | (s19 & s11[7]);
assign vfdiv_cmt_op1 = (buf_i0_valid & s10[7]) ? s6 : s7;
assign vfdiv_cmt_kill = (buf_i0_valid & s10[7]) ? cmt_i0_kill : cmt_i1_kill;
assign vmask_cmt_valid = (s18 & s10[8]) | (s19 & s11[8]);
assign vmask_cmt_op1 = (buf_i0_valid & s10[8]) ? s6 : s7;
assign vmask_cmt_kill = (buf_i0_valid & s10[8]) ? cmt_i0_kill : cmt_i1_kill;
assign vmask_cmt_srf = (buf_i0_valid & s10[8]) ? s14 : s15;
assign vace_cmt_valid = (s18 & s10[9]) | (s19 & s11[9]);
assign vace_cmt_op1 = (buf_i0_valid & s10[9]) ? s6 : s7;
assign vace_cmt_kill = (buf_i0_valid & s10[9]) ? cmt_i0_kill : cmt_i1_kill;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

