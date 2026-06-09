// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_packed_ctrl (
    vpu_vlsu_clk,
    vpu_reset_n,
    packed_req_en,
    packed_req_kill,
    packed_resp_finish,
    packed_vd_beats,
    packed_ctrl,
    packed_vl_minus1,
    packed_start_buf_ptr,
    vlsbuf_data_all,
    vlsbuf_packed_shift_sel,
    vlsbuf_packed_shift_eew_onehot,
    segbuf_packed_data_wvalid,
    segbuf_packed_data_wready,
    segbuf_packed_data_wlast,
    segbuf_packed_data_kill,
    segbuf_packed_wdata,
    segbuf_packed_data_bwe,
    hr_req_seg_inst_last,
    packing
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter DMLEN = 64;
parameter ELEN = 32;
parameter VRF_LW = 3;
parameter SEG_DATA_WIDTH = 256;
parameter SEG_MASK_WIDTH = 32;
parameter PACKED_DATA_WIDTH = 512;
parameter PACKED_MASK_WIDTH = 64;
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
parameter DLEN_BYTE_WIDTH = 7;
parameter NF_BYTE_WIDTH = 7;
parameter BUF_DEPTH = 8;
parameter ELE_DLEN_WIDTH = 6;
parameter ELE_CNT_WIDTH = 9;
localparam SEG_SEL_DEPTH = (SEG_DATA_WIDTH > DLEN) ? SEG_DATA_WIDTH / DLEN : 0;
localparam PACKED_FSM_BITS = 3;
localparam PACKED_FSM_INVALID = 0;
localparam PACKED_FSM_BUSY = 1;
localparam PACKED_FSM_LAST = 2;
localparam BYTE_WIDTH = (DLEN_BYTE_WIDTH >= NF_BYTE_WIDTH) ? DLEN_BYTE_WIDTH : NF_BYTE_WIDTH;
input vpu_vlsu_clk;
input vpu_reset_n;
input packed_req_en;
input packed_req_kill;
output packed_resp_finish;
input [VRF_LW - 1:0] packed_vd_beats;
input [11 - 1:0] packed_ctrl;
input [ELE_CNT_WIDTH - 1:0] packed_vl_minus1;
input [BUF_DEPTH - 1:0] packed_start_buf_ptr;
input [(DLEN * BUF_DEPTH) - 1:0] vlsbuf_data_all;
output [BUF_DEPTH - 1:0] vlsbuf_packed_shift_sel;
output [3:0] vlsbuf_packed_shift_eew_onehot;
output segbuf_packed_data_wvalid;
input segbuf_packed_data_wready;
output segbuf_packed_data_wlast;
output segbuf_packed_data_kill;
output [PACKED_DATA_WIDTH - 1:0] segbuf_packed_wdata;
output [PACKED_MASK_WIDTH - 1:0] segbuf_packed_data_bwe;
input hr_req_seg_inst_last;
output packing;





// 099f7f84 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
reg [PACKED_FSM_BITS - 1:0] s1;
reg [PACKED_FSM_BITS - 1:0] s2;
wire s3;
wire s4;
wire s5;
wire [3:0] s6;
wire s7;
wire s8;
wire [2:0] s9;
wire [3:0] s10;
wire s11;
wire s12;
wire s13;
wire s14;
wire s15;
wire s16;
wire s17;
wire [1:0] s18;
wire [3:0] s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire [BUF_DEPTH - 1:0] s28;
wire [BUF_DEPTH - 1:0] s29;
wire s30;
wire [BUF_DEPTH - 1:0] s31;
wire [BUF_DEPTH - 1:0] s32;
wire [BUF_DEPTH - 1:0] s33;
wire [BUF_DEPTH - 1:0] s34;
wire [BUF_DEPTH - 1:0] s35;
wire [BUF_DEPTH - 1:0] s36;
wire [BUF_DEPTH - 1:0] s37;
wire [BUF_DEPTH - 1:0] s38;
wire s39;
wire [BUF_DEPTH - 1:0] s40;
wire [BUF_DEPTH - 1:0] s41;
wire [BUF_DEPTH - 1:0] s42;
wire [BUF_DEPTH - 1:0] s43;
wire [BUF_DEPTH - 1:0] s44;
wire [BUF_DEPTH - 1:0] s45;
wire [BUF_DEPTH - 1:0] s46;
wire [BUF_DEPTH - 1:0] s47;
reg [BUF_DEPTH - 1:0] s48;
reg [BUF_DEPTH - 1:0] s49;
reg [BUF_DEPTH - 1:0] s50;
reg [BUF_DEPTH - 1:0] s51;
reg [BUF_DEPTH - 1:0] s52;
reg [BUF_DEPTH - 1:0] s53;
reg [BUF_DEPTH - 1:0] s54;
reg [BUF_DEPTH - 1:0] s55;
wire [DLEN - 1:0] s56;
wire [DLEN - 1:0] s57;
wire [DLEN - 1:0] s58;
wire [DLEN - 1:0] s59;
wire [DLEN - 1:0] s60;
wire [DLEN - 1:0] s61;
wire [DLEN - 1:0] s62;
wire [DLEN - 1:0] s63;
wire [(8 * 8) - 1:0] s64;
wire [(8 * 16) - 1:0] s65;
wire [(8 * 32) - 1:0] s66;
wire [(8 * 64) - 1:0] s67;
wire [SEG_DATA_WIDTH - 1:0] s68;
wire [SEG_DATA_WIDTH - 1:0] s69;
wire [SEG_DATA_WIDTH - 1:0] s70;
wire [SEG_DATA_WIDTH - 1:0] s71;
wire [SEG_DATA_WIDTH - 1:0] s72;
wire [7:0] s73;
wire [15:0] s74;
wire [31:0] s75;
wire [63:0] s76;
wire [SEG_MASK_WIDTH - 1:0] s77;
wire [SEG_MASK_WIDTH - 1:0] s78;
wire [SEG_MASK_WIDTH - 1:0] s79;
wire [SEG_MASK_WIDTH - 1:0] s80;
wire [SEG_MASK_WIDTH - 1:0] s81;
wire s82;
wire s83;
wire s84;
wire [ELE_CNT_WIDTH - 1:0] s85;
wire [ELE_CNT_WIDTH - 1:0] s86;
reg [ELE_CNT_WIDTH - 1:0] s87;
wire [ELE_DLEN_WIDTH - 1:0] s88;
wire [ELE_DLEN_WIDTH - 1:0] s89;
wire [ELE_DLEN_WIDTH - 1:0] s90;
wire [ELE_CNT_WIDTH - 1:0] s91;
wire s92;
wire [7:0] s93;
wire [7:0] s94;
wire [7:0] s95;
wire [7:0] s96;
wire [7:0] s97;
wire [7:0] s98;
wire [7:0] s99;
wire [7:0] s100;
wire [7:0] s101;
wire [7:0] s102;
wire [DLEN_BYTE_WIDTH - 1:0] s103;
wire [DLEN - 1:0] s104;
wire [DLEN - 1:0] s105;
wire [DLEN - 1:0] s106;
wire [DMLEN - 1:0] s107;
wire [DMLEN - 1:0] s108;
wire [DMLEN - 1:0] s109;
wire s110;
wire s111;
wire s112;
wire [3:0] s113;
wire s114;
wire s115;
wire s116;
wire s117;
wire s118;
wire [DLEN_BYTE_WIDTH - 1:0] s119;
wire [DLEN_BYTE_WIDTH - 1:0] s120;
wire [BYTE_WIDTH - 1:0] s121;
wire s122;
wire [NF_BYTE_WIDTH - 1:0] s123;
wire [7:0] s124;
wire s125;
wire s126;
wire [DLEN_BYTE_WIDTH - 1:0] s127;
wire [DLEN_BYTE_WIDTH - 1:0] s128;
wire [DLEN_BYTE_WIDTH - 1:0] s129;
reg [DLEN_BYTE_WIDTH - 1:0] s130;
wire s131;
wire [ELE_DLEN_WIDTH - 1:0] s132;
wire [ELE_DLEN_WIDTH - 1:0] s133;
wire [DLEN_BYTE_WIDTH - 1:0] s134;
wire [DLEN_BYTE_WIDTH - 1:0] s135;
wire [3:0] s136;
reg [DLEN_BYTE_WIDTH - 1:0] s137;
reg [NF_BYTE_WIDTH - 1:0] s138;
reg s139;
reg [ELE_DLEN_WIDTH - 1:0] s140;
reg [ELE_DLEN_WIDTH - 1:0] s141;
wire s142;
wire s143;
wire [3:0] s144;
wire [3:0] s145;
reg [3:0] s146;
reg [3:0] s147;
wire s148;
wire s149;
wire [BYTE_WIDTH - 1:0] s150;
wire [BYTE_WIDTH - 1:0] s151;
wire [DLEN_BYTE_WIDTH - 1:0] s152;
wire [DLEN_BYTE_WIDTH - 1:0] s153;
wire [DLEN - 1:0] s154;
wire [DMLEN - 1:0] s155;
wire [SEG_DATA_WIDTH - 1:0] s156;
wire [SEG_MASK_WIDTH - 1:0] s157;
wire [PACKED_DATA_WIDTH - 1:0] s158;
wire [PACKED_MASK_WIDTH - 1:0] s159;
wire [PACKED_DATA_WIDTH - 1:0] s160;
wire [PACKED_MASK_WIDTH - 1:0] s161;
wire nds_unused_ov1;
wire nds_unused_ov2;
wire nds_unused_ov3;
wire nds_unused_ov4;
wire [BUF_DEPTH - 1:0] nds_unused_seg_buf_ptr;
kv_vls_seg_xptr #(
    .VLEN(VLEN),
    .DLEN(DLEN),
    .BUF_DEPTH(BUF_DEPTH)
) u_vlsbuf_seg_rptr (
    .nf_add1(s10),
    .emul_len(s6),
    .start_ptr(packed_start_buf_ptr),
    .seg_ptr(nds_unused_seg_buf_ptr),
    .xptr0(s31),
    .xptr1(s32),
    .xptr2(s33),
    .xptr3(s34),
    .xptr4(s35),
    .xptr5(s36),
    .xptr6(s37),
    .xptr7(s38)
);
kv_vls_element_remap #(
    .ELE_DLEN_WIDTH(ELE_DLEN_WIDTH),
    .ELE_CNT_WIDTH(ELE_CNT_WIDTH),
    .SEW8_DLEN_WIDTH(SEW8_DLEN_WIDTH),
    .SEW16_DLEN_WIDTH(SEW16_DLEN_WIDTH),
    .SEW32_DLEN_WIDTH(SEW32_DLEN_WIDTH),
    .SEW64_DLEN_WIDTH(SEW64_DLEN_WIDTH)
) u_packed_element_cnt_remap (
    .element_num(s87),
    .eew_onehot(s19),
    .element_num_remap(s88)
);
kv_vls_total_element_num #(
    .POWER2(0),
    .ELEN(ELEN),
    .ELE_NUM_WIDTH(ELE_DLEN_WIDTH),
    .WIDTH(DLEN)
) u_hr_seg_element_num_dlen (
    .eew_onehot({1'b0,s19}),
    .total_element_num(s89)
);
kv_zero_ext #(
    .OW(ELE_CNT_WIDTH),
    .IW(ELE_DLEN_WIDTH)
) u_packed_element_num_dlen_zext (
    .out(s91),
    .in(s89)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data0 (
    .out(s56),
    .sel(s48),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data1 (
    .out(s57),
    .sel(s49),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data2 (
    .out(s58),
    .sel(s50),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data3 (
    .out(s59),
    .sel(s51),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data4 (
    .out(s60),
    .sel(s52),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data5 (
    .out(s61),
    .sel(s53),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data6 (
    .out(s62),
    .sel(s54),
    .in(vlsbuf_data_all)
);
kv_mux_onehot #(
    .N(BUF_DEPTH),
    .W(DLEN)
) u_seg_data7 (
    .out(s63),
    .sel(s55),
    .in(vlsbuf_data_all)
);
kv_zero_ext #(
    .OW(SEG_DATA_WIDTH),
    .IW(8 * 8)
) u_seg_eew8_data_zext (
    .out(s68),
    .in(s64)
);
kv_zero_ext #(
    .OW(SEG_DATA_WIDTH),
    .IW(16 * 8)
) u_seg_eew16_data_zext (
    .out(s69),
    .in(s65)
);
kv_zero_ext #(
    .OW(SEG_DATA_WIDTH),
    .IW(32 * 8)
) u_seg_eew32_data_zext (
    .out(s70),
    .in(s66)
);
kv_zero_ext #(
    .OW(SEG_MASK_WIDTH),
    .IW(8)
) u_seg_eew8_bwe_zext (
    .out(s77),
    .in(s73)
);
kv_zero_ext #(
    .OW(SEG_MASK_WIDTH),
    .IW(16)
) u_seg_eew16_bwe_zext (
    .out(s78),
    .in(s74)
);
kv_zero_ext #(
    .OW(SEG_MASK_WIDTH),
    .IW(32)
) u_seg_eew32_bwe_zext (
    .out(s79),
    .in(s75)
);
generate
    if (ELEN == 32) begin:gen_elen32_segdata
        assign s71 = {SEG_DATA_WIDTH{1'b0}};
        assign s80 = {SEG_MASK_WIDTH{1'b0}};
        wire nds_unused_seg_eew64_data = |s67;
        wire nds_unused_seg_eew64_bwe = |s76;
    end
    else begin:gen_elen64_segdata
        kv_zero_ext #(
            .OW(SEG_DATA_WIDTH),
            .IW(64 * 8)
        ) u_seg_eew64_data_zext (
            .out(s71),
            .in(s67)
        );
        kv_zero_ext #(
            .OW(SEG_MASK_WIDTH),
            .IW(64)
        ) u_seg_eew64_bwe_zext (
            .out(s80),
            .in(s76)
        );
    end
endgenerate
generate
    if (DLEN >= SEG_DATA_WIDTH) begin:gen_segbuf_element_zext
        kv_zero_ext #(
            .OW(PACKED_DATA_WIDTH),
            .IW(SEG_DATA_WIDTH)
        ) u_packed_element_wdata_zext (
            .out(s160),
            .in(s156)
        );
        kv_zero_ext #(
            .OW(PACKED_MASK_WIDTH),
            .IW(SEG_MASK_WIDTH)
        ) u_packed_element_bwe_zext (
            .out(s161),
            .in(s157)
        );
        assign s158 = s154;
        assign s159 = s155;
    end
    else begin:gen_segbuf_ustride_zext
        kv_zero_ext #(
            .OW(PACKED_DATA_WIDTH),
            .IW(DLEN)
        ) u_packed_ustride_wdata_zext (
            .out(s158),
            .in(s154)
        );
        kv_zero_ext #(
            .OW(PACKED_MASK_WIDTH),
            .IW(DMLEN)
        ) u_packed_ustride_bwe_zext (
            .out(s159),
            .in(s155)
        );
        assign s160 = s156;
        assign s161 = s157;
    end
endgenerate
generate
    if (DLEN_BYTE_WIDTH >= NF_BYTE_WIDTH) begin:gen_nf_remain_cnt_zext
        kv_zero_ext #(
            .OW(BYTE_WIDTH),
            .IW(NF_BYTE_WIDTH)
        ) u_packed_nf_remain_cnt_zext (
            .out(s150),
            .in(s138)
        );
    end
    else begin:gen_nf_remain_cnt_zext_stub
        assign s150 = s138;
    end
endgenerate
kv_zero_ext #(
    .OW(4),
    .IW(VRF_LW)
) u_packed_vd_beats_zext (
    .out(s6),
    .in(packed_vd_beats)
);
kv_zero_ext #(
    .OW(8),
    .IW(NF_BYTE_WIDTH)
) u_packed_nf_remain_cnt_nx_zext8 (
    .out(s124),
    .in(s123)
);
assign s11 = (s9 == 3'd1);
assign s12 = (s9 == 3'd2);
assign s13 = (s9 == 3'd3);
assign s14 = (s9 == 3'd4);
assign s15 = (s9 == 3'd5);
assign s16 = (s9 == 3'd6);
assign s17 = (s9 == 3'd7);
assign s7 = packed_ctrl[4];
assign s8 = packed_ctrl[0];
assign s9 = packed_ctrl[1 +:3];
assign s10 = {1'b0,s9} + 4'b0001;
assign s18 = packed_ctrl[5 +:2];
assign s19 = packed_ctrl[7 +:4];
assign s20 = s19[0];
assign s21 = s19[1];
assign s22 = s19[2];
assign s23 = s19[3];
assign packing = ~s4;
assign s5 = packed_req_en & s4;
assign s3 = s1[PACKED_FSM_BUSY];
assign s4 = s1[PACKED_FSM_INVALID];
assign s92 = s84 & s24;
assign packed_resp_finish = (s1[PACKED_FSM_LAST] | s3) & hr_req_seg_inst_last;
always @* begin
    s2 = {PACKED_FSM_BITS{1'b0}};
    case (1'b1)
        s1[PACKED_FSM_INVALID]: begin
            s0 = packed_req_en & ~packed_req_kill;
            s2[PACKED_FSM_BUSY] = 1'b1;
        end
        s1[PACKED_FSM_BUSY]: begin
            s0 = s92 | packed_req_kill | hr_req_seg_inst_last;
            if (packed_req_kill | hr_req_seg_inst_last) begin
                s2[PACKED_FSM_INVALID] = 1'b1;
            end
            else begin
                s2[PACKED_FSM_LAST] = 1'b1;
            end
        end
        s1[PACKED_FSM_LAST]: begin
            s0 = hr_req_seg_inst_last | packed_req_kill;
            s2[PACKED_FSM_INVALID] = 1'b1;
        end
        default: begin
            s0 = 1'b0;
            s2 = {PACKED_FSM_BITS{1'b0}};
        end
    endcase
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= {{PACKED_FSM_BITS - 1{1'b0}},1'b1};
    end
    else if (s0) begin
        s1 <= s2;
    end
end

assign s39 = s5 | (s25 & s30);
assign s40 = s5 ? s31 : {s48[BUF_DEPTH - 2:0],s48[BUF_DEPTH - 1]};
assign s41 = s5 ? s32 : {s49[BUF_DEPTH - 2:0],s49[BUF_DEPTH - 1]};
assign s42 = s5 ? s33 : {s50[BUF_DEPTH - 2:0],s50[BUF_DEPTH - 1]};
assign s43 = s5 ? s34 : {s51[BUF_DEPTH - 2:0],s51[BUF_DEPTH - 1]};
assign s44 = s5 ? s35 : {s52[BUF_DEPTH - 2:0],s52[BUF_DEPTH - 1]};
assign s45 = s5 ? s36 : {s53[BUF_DEPTH - 2:0],s53[BUF_DEPTH - 1]};
assign s46 = s5 ? s37 : {s54[BUF_DEPTH - 2:0],s54[BUF_DEPTH - 1]};
assign s47 = s5 ? s38 : {s55[BUF_DEPTH - 2:0],s55[BUF_DEPTH - 1]};
always @(posedge vpu_vlsu_clk) begin
    if (s39) begin
        s48 <= s40;
        s49 <= s41;
        s50 <= s42;
        s51 <= s43;
        s52 <= s44;
        s53 <= s45;
        s54 <= s46;
        s55 <= s47;
    end
end

assign s90 = (packed_vl_minus1 < s91) ? packed_vl_minus1[ELE_DLEN_WIDTH - 1:0] : s89;
assign s30 = s84 & (s90 == s88);
assign s29 = s48 | s49 | s50 | s51 | s52 | s53 | s54 | s55;
assign s28 = s29;
assign s27 = s82;
assign vlsbuf_packed_shift_sel = {BUF_DEPTH{s27}} & s28;
assign vlsbuf_packed_shift_eew_onehot = packed_ctrl[7 +:4];
assign s93 = {6'b0,{2{1'b1}}};
assign s94 = {5'b0,{3{1'b1}}};
assign s95 = {4'b0,{4{1'b1}}};
assign s96 = {3'b0,{5{1'b1}}};
assign s97 = {2'b0,{6{1'b1}}};
assign s98 = {1'b0,{7{1'b1}}};
assign s99 = {{8{1'b1}}};
assign s100 = ({8{s11}} & s93) | ({8{s12}} & s94) | ({8{s13}} & s95) | ({8{s14}} & s96) | ({8{s15}} & s97) | ({8{s16}} & s98) | ({8{s17}} & s99);
assign s73 = s100;
genvar m;
generate
    for (m = 0; m < 8; m = m + 1) begin:gen_seg_element_data_bwe
        assign s74[(m * 2) + 1:m * 2] = {2{s100[m]}};
        assign s75[(m * 4) + 3:m * 4] = {4{s100[m]}};
        assign s76[(m * 8) + 7:m * 8] = {8{s100[m]}};
    end
endgenerate
assign s64 = {s63[7:0],s62[7:0],s61[7:0],s60[7:0],s59[7:0],s58[7:0],s57[7:0],s56[7:0]};
assign s65 = {s63[15:0],s62[15:0],s61[15:0],s60[15:0],s59[15:0],s58[15:0],s57[15:0],s56[15:0]};
assign s66 = {s63[31:0],s62[31:0],s61[31:0],s60[31:0],s59[31:0],s58[31:0],s57[31:0],s56[31:0]};
assign s67 = {s63[63:0],s62[63:0],s61[63:0],s60[63:0],s59[63:0],s58[63:0],s57[63:0],s56[63:0]};
assign s72 = ({SEG_DATA_WIDTH{s20}} & s68) | ({SEG_DATA_WIDTH{s21}} & s69) | ({SEG_DATA_WIDTH{s22}} & s70) | ({SEG_DATA_WIDTH{s23}} & s71);
assign s81 = ({SEG_MASK_WIDTH{s20}} & s77) | ({SEG_MASK_WIDTH{s21}} & s78) | ({SEG_MASK_WIDTH{s22}} & s79) | ({SEG_MASK_WIDTH{s23}} & s80);
assign s24 = (s87 == packed_vl_minus1) | hr_req_seg_inst_last;
assign segbuf_packed_data_wvalid = s3;
assign s25 = segbuf_packed_data_wvalid & segbuf_packed_data_wready;
assign segbuf_packed_data_wlast = (s7 & s26) | s8;
assign segbuf_packed_data_kill = ~s4 & (packed_req_kill | hr_req_seg_inst_last);
assign segbuf_packed_wdata = s7 ? s158 : s160;
assign segbuf_packed_data_bwe = s7 ? s159 : s161;
assign s82 = s25 & ((s7 & s149) | s8);
assign s83 = segbuf_packed_data_kill | hr_req_seg_inst_last;
assign s84 = s82 | s83;
assign s86 = s87 + {{ELE_CNT_WIDTH - 1{1'b0}},1'b1};
assign s85 = (s24 | s83) ? {ELE_CNT_WIDTH{1'b0}} : s86;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s87 <= {ELE_CNT_WIDTH{1'b0}};
    end
    else if (s84) begin
        s87 <= s85;
    end
end

assign s156 = s72;
assign s157 = s81;
assign s154 = s139 ? s105 : s106;
assign s155 = s139 ? s108 : s109;
assign s105 = s104 >> {s140,3'b0};
assign s106 = s104 << {s141,3'b0};
assign s108 = s107 >> s140;
assign s109 = s107 << s141;
generate
    if (SEG_DATA_WIDTH > DLEN) begin:gen_ustride_data_mux_sel
        kv_mux_onehot #(
            .N(SEG_SEL_DEPTH),
            .W(DLEN)
        ) u_packed_ustride_data_sel (
            .out(s104),
            .sel(s146[SEG_SEL_DEPTH - 1:0]),
            .in(s72)
        );
        kv_mux_onehot #(
            .N(SEG_SEL_DEPTH),
            .W(DMLEN)
        ) u_packed_ustride_bwe_sel (
            .out(s107),
            .sel(s146[SEG_SEL_DEPTH - 1:0]),
            .in(s81)
        );
    end
    else begin:gen_ustride_data_sel
        kv_zero_ext #(
            .OW(DLEN),
            .IW(SEG_DATA_WIDTH)
        ) u_packed_ustride_data_sel (
            .out(s104),
            .in(s72)
        );
        kv_zero_ext #(
            .OW(DMLEN),
            .IW(SEG_MASK_WIDTH)
        ) u_packed_ustride_bwe_sel (
            .out(s107),
            .in(s81)
        );
    end
endgenerate
assign s101 = (DLEN == 128) ? 8'd16 : (DLEN == 256) ? 8'd32 : (DLEN == 512) ? 8'd64 : 8'd128;
assign s103 = s101[DLEN_BYTE_WIDTH - 1:0];
assign s102 = s10 << s18;
assign s110 = ((DLEN == 256) & s23 & (s14 | s15 | s16 | s17)) | ((DLEN == 128) & s22 & (s14 | s15 | s16 | s17)) | ((DLEN == 128) & s23 & (s12 | s13));
assign s111 = ((DLEN == 128) & s23 & (s14 | s15));
assign s112 = ((DLEN == 128) & s23 & (s16 | s17));
assign s113 = s110 ? 4'b0010 : s111 ? 4'b0100 : s112 ? 4'b1000 : 4'b0001;
assign s114 = (s137 == s130);
assign s115 = (s137 > s130);
assign s116 = (s137 < s130);
assign s117 = s115 | s114;
assign s148 = s146 == s147;
kv_zero_ext #(
    .OW(DLEN_BYTE_WIDTH),
    .IW(ELE_DLEN_WIDTH)
) u_packed_sl_value_zext (
    .out(s134),
    .in(s141)
);
kv_zero_ext #(
    .OW(BYTE_WIDTH),
    .IW(DLEN_BYTE_WIDTH)
) u_nf_offer_sel_zext (
    .out(s121),
    .in(s120)
);
assign {nds_unused_ov1,s152} = s130 - s137;
assign {nds_unused_ov2,s153} = s137 - s130;
assign {nds_unused_ov3,s135} = s134 + s130;
assign s120 = s116 ? s137 : s130;
assign {nds_unused_ov4,s151} = s150 - s121;
assign s118 = s5 | s25;
assign s122 = s5 | (s117 & s148);
assign s119 = s5 ? s103[DLEN_BYTE_WIDTH - 1:0] : s115 ? s153[DLEN_BYTE_WIDTH - 1:0] : s103[DLEN_BYTE_WIDTH - 1:0];
assign s123 = s122 ? s102[NF_BYTE_WIDTH - 1:0] : s151[NF_BYTE_WIDTH - 1:0];
assign s131 = s5 ? 1'b1 : s115 ? 1'b0 : 1'b1;
assign s132 = s5 ? {ELE_DLEN_WIDTH{1'b0}} : s116 ? s137[ELE_DLEN_WIDTH - 1:0] : {ELE_DLEN_WIDTH{1'b0}};
assign s133 = s5 ? {ELE_DLEN_WIDTH{1'b0}} : s115 ? s135[ELE_DLEN_WIDTH - 1:0] : {ELE_DLEN_WIDTH{1'b0}};
assign s144 = s5 ? 4'b0001 : s142 ? s145 : s143 ? s146 : 4'b0001;
assign s143 = s116;
assign s142 = s117 & ~s148;
assign s136 = s113;
assign s145 = {s146[2:0],s146[3]};
assign s149 = s148 & (s115 | s114);
assign s26 = s116 | s114 | (s24 & s148 & s117);
assign s128 = (s102 > s101) ? s103 : s102[DLEN_BYTE_WIDTH - 1:0];
assign s129 = (s124 > s101) ? s103 : s124[DLEN_BYTE_WIDTH - 1:0];
assign s125 = s117 & ~s148 & (s144 != s146);
assign s126 = s117 & s148;
assign s127 = s5 ? s128 : s125 ? s129 : s126 ? s128 : s152[DLEN_BYTE_WIDTH - 1:0];
always @(posedge vpu_vlsu_clk) begin
    if (s118) begin
        s137 <= s119;
        s138 <= s123;
        s130 <= s127;
        s139 <= s131;
        s140 <= s132;
        s141 <= s133;
        s146 <= s144;
        s147 <= s136;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

