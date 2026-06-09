// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vrf_wport (
    vpu_clk,
    vpu_reset_n,
    dis_age,
    dis_i0_grant,
    dis_i0_en,
    dis_i0_addr,
    dis_i0_len,
    dis_i0_fu,
    dis_i1_grant,
    dis_i1_en,
    dis_i1_addr,
    dis_i1_len,
    dis_i1_fu,
    cmt_i0_grant,
    cmt_i0_kill,
    cmt_i0_age,
    cmt_i1_grant,
    cmt_i1_kill,
    cmt_i1_age,
    ret_age_en,
    ent_valid_clr,
    ent_valid,
    ent_pending,
    ent_addr,
    ent_len,
    ent_fu,
    ent_committed,
    ent_age_mask,
    w_grant,
    w_age,
    w_age_mask,
    w_addr,
    w_last,
    w_pending,
    w_committed,
    w_fu
);
parameter AGEN = 8;
parameter VRF_AW = 5;
parameter VRF_LW = 3;
input vpu_clk;
input vpu_reset_n;
input [AGEN - 1:0] dis_age;
input dis_i0_grant;
input dis_i0_en;
input [VRF_AW - 1:0] dis_i0_addr;
input [VRF_LW - 1:0] dis_i0_len;
input [11 - 1:0] dis_i0_fu;
input dis_i1_grant;
input dis_i1_en;
input [VRF_AW - 1:0] dis_i1_addr;
input [VRF_LW - 1:0] dis_i1_len;
input [11 - 1:0] dis_i1_fu;
input cmt_i0_grant;
input cmt_i0_kill;
input [AGEN - 1:0] cmt_i0_age;
input cmt_i1_grant;
input cmt_i1_kill;
input [AGEN - 1:0] cmt_i1_age;
input ret_age_en;
input [AGEN - 1:0] ent_valid_clr;
input [AGEN - 1:0] ent_valid;
input [AGEN - 1:0] ent_pending;
input [(VRF_AW * AGEN) - 1:0] ent_addr;
input [(VRF_LW * AGEN) - 1:0] ent_len;
input [(11 * AGEN) - 1:0] ent_fu;
input [AGEN - 1:0] ent_committed;
input [(AGEN * AGEN) - 1:0] ent_age_mask;
input w_grant;
output [AGEN - 1:0] w_age;
output [AGEN - 1:0] w_age_mask;
output [VRF_AW - 1:0] w_addr;
output w_last;
output w_pending;
output w_committed;
output [11 - 1:0] w_fu;





// abe9b8a0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [AGEN - 1:0] w_age;
wire [AGEN - 1:0] s0;
wire s1;
reg [AGEN - 1:0] w_age_mask;
wire [AGEN - 1:0] s2;
wire s3;
wire [AGEN - 1:0] s4;
wire [AGEN - 1:0] s5;
wire [AGEN - 1:0] s6;
wire [AGEN - 1:0] s7;
reg w_pending;
wire s8;
reg [11 - 1:0] w_fu;
wire [11 - 1:0] s9;
wire [11 - 1:0] s10;
wire [11 - 1:0] s11;
reg [VRF_AW - 1:0] w_addr;
wire [VRF_AW - 1:0] s12;
wire [VRF_AW - 1:0] s13;
wire s14;
wire [VRF_AW - 1:0] s15;
wire [VRF_AW - 1:0] s16;
reg [VRF_LW - 1:0] s17;
wire [VRF_LW - 1:0] s18 = s17 - {{(VRF_LW - 1){1'b0}},1'd1};
wire [VRF_LW - 1:0] s19;
wire [VRF_LW - 1:0] s20;
wire [VRF_LW - 1:0] s21;
reg w_committed;
wire s22;
wire s23;
wire s24;
wire s25;
wire [AGEN - 1:0] s26 = {dis_age[AGEN - 2:0],dis_age[AGEN - 1]};
wire [AGEN - 1:0] s27 = {dis_age[AGEN - 3:0],dis_age[AGEN - 1:AGEN - 2]};
wire [AGEN - 1:0] s28;
wire [AGEN - 1:0] s29;
wire s30;
wire s31 = w_grant & w_last;
wire s32 = cmt_i0_grant & cmt_i0_kill;
wire s33 = cmt_i1_grant & cmt_i1_kill;
wire s34 = |(w_age & cmt_i0_age);
wire s35 = |(w_age & cmt_i1_age);
wire [AGEN - 1:0] s36;
wire [AGEN - 1:0] s37;
wire s38;
assign s37 = ({AGEN{cmt_i0_grant}} & cmt_i0_age) | ({AGEN{cmt_i1_grant}} & cmt_i1_age);
assign s38 = (cmt_i0_grant & s34 & cmt_i0_kill) | (cmt_i1_grant & s35 & cmt_i1_kill);
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        w_age <= {{(AGEN - 1){1'b0}},1'b1};
        w_pending <= 1'b0;
    end
    else if (s1) begin
        w_age <= s0;
        w_pending <= s8;
    end
end

always @(posedge vpu_clk) begin
    if (s3) begin
        w_age_mask <= s2;
    end
end

always @(posedge vpu_clk) begin
    if (s1) begin
        w_fu <= s9;
    end
end

assign s1 = (dis_i0_grant & ~w_pending) | (dis_i1_grant & ~w_pending) | (s38 & w_pending) | s31;
assign s0 = s30 ? s29 : s28;
assign s28 = ~dis_i0_grant ? dis_age : dis_i0_en ? dis_age : ~dis_i1_grant ? s26 : dis_i1_en ? s26 : s27;
assign s8 = s30 | (dis_i0_grant & dis_i0_en) | (dis_i1_grant & dis_i1_en);
assign s11 = (dis_i0_grant & dis_i0_en) ? dis_i0_fu : dis_i1_fu;
assign s9 = s30 ? s10 : s11;
assign s36 = ent_committed | s37;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        w_committed <= 1'b0;
    end
    else if (s22) begin
        w_committed <= s23;
    end
end

assign s22 = s25 | (dis_i0_grant & ~w_pending) | (dis_i1_grant & ~w_pending) | s38 | s31;
assign s25 = (cmt_i0_grant & s34 & ~cmt_i0_kill) | (cmt_i1_grant & s35 & ~cmt_i1_kill);
assign s23 = s25 | (s30 & s24);
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        w_addr <= {VRF_AW{1'd0}};
        s17 <= {VRF_LW{1'd0}};
    end
    else if (s14) begin
        w_addr <= s13;
        s17 <= s19;
    end
end

assign s14 = w_grant | (~w_pending & dis_i0_grant & dis_i0_en) | (~w_pending & dis_i1_grant & dis_i1_en) | s38;
assign {s19,s13} = (w_pending & ~w_last & ~s38) ? {s18,s12} : s30 ? {s21,s16} : {s20,s15};
assign s12 = w_addr + {{(VRF_AW - 1){1'b0}},1'b1};
assign s15 = (dis_i0_grant & dis_i0_en) ? dis_i0_addr : dis_i1_addr;
assign s20 = (dis_i0_grant & dis_i0_en) ? dis_i0_len : dis_i1_len;
assign w_last = ~|s17;
wire s39 = |(ent_pending & ~w_age);
wire s40 = |(ent_pending & ~w_age & ~cmt_i0_age);
wire s41 = |(ent_pending & ~w_age & ~cmt_i1_age);
wire s42 = |(ent_pending & ~w_age & ~cmt_i0_age & ~cmt_i1_age);
wire [AGEN - 1:0] s43 = ent_pending;
wire [AGEN - 1:0] s44 = ent_pending & ~cmt_i0_age;
wire [AGEN - 1:0] s45 = ent_pending & ~cmt_i1_age;
wire [AGEN - 1:0] s46 = ent_pending & ~cmt_i0_age & ~cmt_i1_age;
wire [AGEN - 1:0] s47;
wire [AGEN - 1:0] s48;
wire [AGEN - 1:0] s49;
wire [AGEN - 1:0] s50;
wire [VRF_AW - 1:0] s51;
wire [VRF_AW - 1:0] s52;
wire [VRF_AW - 1:0] s53;
wire [VRF_AW - 1:0] s54;
wire [11 - 1:0] s55;
wire [11 - 1:0] s56;
wire [11 - 1:0] s57;
wire [11 - 1:0] s58;
wire [AGEN - 1:0] s59;
wire [AGEN - 1:0] s60;
wire [AGEN - 1:0] s61;
wire [AGEN - 1:0] s62;
wire [VRF_LW - 1:0] s63;
wire [VRF_LW - 1:0] s64;
wire [VRF_LW - 1:0] s65;
wire [VRF_LW - 1:0] s66;
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_0 (
    .age_next(s47),
    .age(w_age),
    .pending(s43)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_1 (
    .age_next(s48),
    .age(w_age),
    .pending(s44)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_2 (
    .age_next(s49),
    .age(w_age),
    .pending(s45)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_3 (
    .age_next(s50),
    .age(w_age),
    .pending(s46)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_0 (
    .out(s51),
    .sel(s47),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_1 (
    .out(s52),
    .sel(s48),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_2 (
    .out(s53),
    .sel(s49),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_3 (
    .out(s54),
    .sel(s50),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_0 (
    .out(s63),
    .sel(s47),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_1 (
    .out(s64),
    .sel(s48),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_2 (
    .out(s65),
    .sel(s49),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_3 (
    .out(s66),
    .sel(s50),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_0 (
    .out(s59),
    .sel(s47),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_1 (
    .out(s60),
    .sel(s48),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_2 (
    .out(s61),
    .sel(s49),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_3 (
    .out(s62),
    .sel(s50),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_0 (
    .out(s55),
    .sel(s47),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_1 (
    .out(s56),
    .sel(s48),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_2 (
    .out(s57),
    .sel(s49),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_3 (
    .out(s58),
    .sel(s50),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(1)
) u_pending_committed (
    .out(s24),
    .sel(s29),
    .in(s36)
);
kv_mux #(
    .N(4),
    .W(1 + VRF_AW + VRF_LW + AGEN + 11 + AGEN)
) u_next (
    .out({s30,s16,s21,s7,s10,s29}),
    .sel({s33,s32}),
    .in({s42,s54,s66,s62,s58,s50,s41,s53,s65,s61,s57,s49,s40,s52,s64,s60,s56,s48,s39,s51,s63,s59,s55,s47})
);
assign s3 = (dis_i0_grant & ~w_pending) | (dis_i1_grant & ~w_pending) | (s38 & w_pending) | s31 | ret_age_en;
assign s6 = s7 & ~ent_valid_clr;
assign s4 = (ent_valid & ~ent_valid_clr) | ({AGEN{~(dis_i0_grant & dis_i0_en)}} & dis_age);
assign s5 = w_age_mask & ~ent_valid_clr;
assign s2 = (w_pending & ~s31 & ~s38) ? s5 : s30 ? s6 : s4;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

