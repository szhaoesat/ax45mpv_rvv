// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vrf_rport (
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
    r_grant,
    r_age,
    r_age_mask,
    r_addr,
    vrf_r_addr,
    vrf_r_beat,
    r_last,
    r_pending,
    r_fu,
    r_bypass_sel,
    w0_pending,
    w1_pending,
    w2_pending,
    w3_pending,
    w4_pending,
    w0_addr,
    w1_addr,
    w2_addr,
    w3_addr,
    w4_addr,
    w0_age,
    w1_age,
    w2_age,
    w3_age,
    w4_age,
    w0_age_mask,
    w1_age_mask,
    w2_age_mask,
    w3_age_mask,
    w4_age_mask
);
parameter AGEN = 8;
parameter BYPASSW = 5;
parameter VRF_AW = 5;
parameter VRF_LW = 3;
parameter VLEN = 512;
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
input r_grant;
output [AGEN - 1:0] r_age;
output [AGEN - 1:0] r_age_mask;
output [VRF_AW - 1:0] r_addr;
output [(VLEN / 64 * 5) - 1:0] vrf_r_addr;
output vrf_r_beat;
output r_last;
output r_pending;
output [11 - 1:0] r_fu;
output [BYPASSW - 1:0] r_bypass_sel;
input w0_pending;
input w1_pending;
input w2_pending;
input w3_pending;
input w4_pending;
input [VRF_AW - 1:0] w0_addr;
input [VRF_AW - 1:0] w1_addr;
input [VRF_AW - 1:0] w2_addr;
input [VRF_AW - 1:0] w3_addr;
input [VRF_AW - 1:0] w4_addr;
input [AGEN - 1:0] w0_age;
input [AGEN - 1:0] w1_age;
input [AGEN - 1:0] w2_age;
input [AGEN - 1:0] w3_age;
input [AGEN - 1:0] w4_age;
input [AGEN - 1:0] w0_age_mask;
input [AGEN - 1:0] w1_age_mask;
input [AGEN - 1:0] w2_age_mask;
input [AGEN - 1:0] w3_age_mask;
input [AGEN - 1:0] w4_age_mask;





// 399faf6f rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [AGEN - 1:0] r_age;
wire [AGEN - 1:0] s0;
wire s1;
reg [AGEN - 1:0] r_age_mask;
wire [AGEN - 1:0] s2;
wire s3;
wire [AGEN - 1:0] s4;
wire [AGEN - 1:0] s5;
wire [AGEN - 1:0] s6;
wire [AGEN - 1:0] s7;
reg r_pending;
wire s8;
reg [11 - 1:0] r_fu;
wire [11 - 1:0] s9;
wire [11 - 1:0] s10;
wire [11 - 1:0] s11;
reg [VRF_AW - 1:0] r_addr;
wire [VRF_AW - 1:0] s12;
wire [VRF_AW - 1:0] s13;
wire [VRF_AW - 1:0] s14;
wire [VRF_AW - 1:0] s15;
wire s16;
reg [(VLEN / 64 * 5) - 1:0] vrf_r_addr;
reg vrf_r_beat;
reg [VRF_LW - 1:0] s17;
wire [VRF_LW - 1:0] s18 = s17 - {{(VRF_LW - 1){1'b0}},1'd1};
wire [VRF_LW - 1:0] s19;
wire [VRF_LW - 1:0] s20;
wire [VRF_LW - 1:0] s21;
wire [AGEN - 1:0] s22 = {dis_age[AGEN - 2:0],dis_age[AGEN - 1]};
wire [AGEN - 1:0] s23 = {dis_age[AGEN - 3:0],dis_age[AGEN - 1:AGEN - 2]};
wire [AGEN - 1:0] s24;
wire [AGEN - 1:0] s25;
wire s26;
wire s27 = r_grant & r_last;
wire s28 = cmt_i0_grant & cmt_i0_kill;
wire s29 = cmt_i1_grant & cmt_i1_kill;
wire s30 = |(r_age & cmt_i0_age);
wire s31 = |(r_age & cmt_i1_age);
wire s32;
assign s32 = (cmt_i0_grant & s30 & cmt_i0_kill) | (cmt_i1_grant & s31 & cmt_i1_kill);
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        r_age <= {{(AGEN - 1){1'b0}},1'b1};
        r_pending <= 1'b0;
    end
    else if (s1) begin
        r_age <= s0;
        r_pending <= s8;
    end
end

always @(posedge vpu_clk) begin
    if (s3) begin
        r_age_mask <= s2;
    end
end

always @(posedge vpu_clk) begin
    if (s1) begin
        r_fu <= s9;
    end
end

assign s1 = (dis_i0_grant & ~r_pending) | (dis_i1_grant & ~r_pending) | (s32 & r_pending) | s27;
assign s0 = s26 ? s25 : s24;
assign s24 = ~dis_i0_grant ? dis_age : dis_i0_en ? dis_age : ~dis_i1_grant ? s22 : dis_i1_en ? s22 : s23;
assign s8 = s26 | (dis_i0_grant & dis_i0_en) | (dis_i1_grant & dis_i1_en);
assign s11 = (dis_i0_grant & dis_i0_en) ? dis_i0_fu : dis_i1_fu;
assign s9 = s26 ? s10 : s11;
always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        r_addr <= {VRF_AW{1'd0}};
        s17 <= {VRF_LW{1'd0}};
    end
    else if (s16) begin
        r_addr <= s13;
        s17 <= s19;
    end
end

always @(posedge vpu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_r_addr <= {VLEN / 64{5'b0}};
        vrf_r_beat <= 1'b0;
    end
    else if (s16) begin
        vrf_r_addr <= {VLEN / 64{s13[VRF_AW - 1:VRF_AW - 5]}};
        vrf_r_beat <= s13[0];
    end
end

assign s16 = r_grant | (~r_pending & dis_i0_grant & dis_i0_en) | (~r_pending & dis_i1_grant & dis_i1_en) | s32;
assign {s19,s13} = (r_pending & ~r_last & ~s32) ? {s18,s12} : s26 ? {s21,s15} : {s20,s14};
assign s12 = r_addr + {{(VRF_AW - 1){1'b0}},1'b1};
assign s14 = (dis_i0_grant & dis_i0_en) ? dis_i0_addr : dis_i1_addr;
assign s20 = (dis_i0_grant & dis_i0_en) ? dis_i0_len : dis_i1_len;
assign r_last = ~|s17;
wire s33 = |(ent_pending & ~r_age);
wire s34 = |(ent_pending & ~r_age & ~cmt_i0_age);
wire s35 = |(ent_pending & ~r_age & ~cmt_i1_age);
wire s36 = |(ent_pending & ~r_age & ~cmt_i0_age & ~cmt_i1_age);
wire [AGEN - 1:0] s37 = ent_pending;
wire [AGEN - 1:0] s38 = ent_pending & ~cmt_i0_age;
wire [AGEN - 1:0] s39 = ent_pending & ~cmt_i1_age;
wire [AGEN - 1:0] s40 = ent_pending & ~cmt_i0_age & ~cmt_i1_age;
wire [AGEN - 1:0] s41;
wire [AGEN - 1:0] s42;
wire [AGEN - 1:0] s43;
wire [AGEN - 1:0] s44;
wire [VRF_AW - 1:0] s45;
wire [VRF_AW - 1:0] s46;
wire [VRF_AW - 1:0] s47;
wire [VRF_AW - 1:0] s48;
wire [11 - 1:0] s49;
wire [11 - 1:0] s50;
wire [11 - 1:0] s51;
wire [11 - 1:0] s52;
wire [AGEN - 1:0] s53;
wire [AGEN - 1:0] s54;
wire [AGEN - 1:0] s55;
wire [AGEN - 1:0] s56;
wire [VRF_LW - 1:0] s57;
wire [VRF_LW - 1:0] s58;
wire [VRF_LW - 1:0] s59;
wire [VRF_LW - 1:0] s60;
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_0 (
    .age_next(s41),
    .age(r_age),
    .pending(s37)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_1 (
    .age_next(s42),
    .age(r_age),
    .pending(s38)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_2 (
    .age_next(s43),
    .age(r_age),
    .pending(s39)
);
kv_vscb_age_next #(
    .AGEN(AGEN)
) u_pending_age_3 (
    .age_next(s44),
    .age(r_age),
    .pending(s40)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_0 (
    .out(s45),
    .sel(s41),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_1 (
    .out(s46),
    .sel(s42),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_2 (
    .out(s47),
    .sel(s43),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_AW)
) u_pending_addr_3 (
    .out(s48),
    .sel(s44),
    .in(ent_addr)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_0 (
    .out(s57),
    .sel(s41),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_1 (
    .out(s58),
    .sel(s42),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_2 (
    .out(s59),
    .sel(s43),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(VRF_LW)
) u_pending_len_3 (
    .out(s60),
    .sel(s44),
    .in(ent_len)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_0 (
    .out(s53),
    .sel(s41),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_1 (
    .out(s54),
    .sel(s42),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_2 (
    .out(s55),
    .sel(s43),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(AGEN)
) u_pending_age_mask_3 (
    .out(s56),
    .sel(s44),
    .in(ent_age_mask)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_0 (
    .out(s49),
    .sel(s41),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_1 (
    .out(s50),
    .sel(s42),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_2 (
    .out(s51),
    .sel(s43),
    .in(ent_fu)
);
kv_mux_onehot #(
    .N(AGEN),
    .W(11)
) u_pending_fu_3 (
    .out(s52),
    .sel(s44),
    .in(ent_fu)
);
kv_mux #(
    .N(4),
    .W(1 + VRF_AW + VRF_LW + AGEN + 11 + AGEN)
) u_next (
    .out({s26,s15,s21,s7,s10,s25}),
    .sel({s29,s28}),
    .in({s36,s48,s60,s56,s52,s44,s35,s47,s59,s55,s51,s43,s34,s46,s58,s54,s50,s42,s33,s45,s57,s53,s49,s41})
);
assign s3 = (dis_i0_grant & ~r_pending) | (dis_i1_grant & ~r_pending) | (s32 & r_pending) | s27 | ret_age_en;
assign s6 = s7 & ~ent_valid_clr;
assign s4 = (ent_valid & ~ent_valid_clr) | ({AGEN{~(dis_i0_grant & dis_i0_en)}} & dis_age);
assign s5 = r_age_mask & ~ent_valid_clr;
assign s2 = (r_pending & ~s27 & ~s32) ? s5 : s26 ? s6 : s4;
assign r_bypass_sel[0] = w0_pending & (r_addr == w0_addr) & |(r_age_mask & w0_age & ~w0_age_mask);
assign r_bypass_sel[1] = w1_pending & (r_addr == w1_addr) & |(r_age_mask & w1_age & ~w1_age_mask);
assign r_bypass_sel[2] = w2_pending & (r_addr == w2_addr) & |(r_age_mask & w2_age & ~w2_age_mask);
assign r_bypass_sel[3] = w3_pending & (r_addr == w3_addr) & |(r_age_mask & w3_age & ~w3_age_mask);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

