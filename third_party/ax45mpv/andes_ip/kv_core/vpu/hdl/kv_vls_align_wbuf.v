// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_align_wbuf (
    vpu_vlsu_clk,
    vpu_reset_n,
    wvalid,
    wready,
    wfirst,
    wlast,
    wfirst_cnt,
    wlast_cnt,
    cross_biu,
    extra_biu,
    onehot_sel_w,
    wdata,
    extra_wdata,
    bwe,
    v0t_wdata,
    v0t_extra_wdata,
    hvm,
    onehot_sel_r,
    rvalid,
    rready,
    rfirst,
    rlast,
    rdata_xhvm,
    rdata_hvm,
    rmask,
    mask_clr
);
parameter DW = 1024;
parameter MW = 128;
parameter V0T_DW = 128;
parameter V0T_MW = 16;
parameter DLEN = 512;
parameter HR_DATA_WIDTH = 1024;
parameter HR_MASK_WIDTH = 128;
parameter BIU_DATA_WIDTH = 512;
parameter BIU_MASK_WIDTH = 64;
input vpu_vlsu_clk;
input vpu_reset_n;
input wvalid;
output wready;
input wfirst;
input wlast;
input [1:0] wfirst_cnt;
input [1:0] wlast_cnt;
input cross_biu;
input extra_biu;
input [1:0] onehot_sel_w;
input [DW - 1:0] wdata;
input [BIU_DATA_WIDTH - 1:0] extra_wdata;
input [MW - 1:0] bwe;
input [V0T_DW - 1:0] v0t_wdata;
input [BIU_MASK_WIDTH - 1:0] v0t_extra_wdata;
input hvm;
input [1:0] onehot_sel_r;
output rvalid;
input rready;
input rfirst;
input rlast;
output [BIU_DATA_WIDTH - 1:0] rdata_xhvm;
output [HR_DATA_WIDTH - 1:0] rdata_hvm;
output [HR_MASK_WIDTH - 1:0] rmask;
input [HR_MASK_WIDTH - 1:0] mask_clr;





// 200c2048 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire [V0T_DW - 1:0] s3;
wire [V0T_DW - 1:0] s4;
reg [V0T_DW - 1:0] s5;
reg [BIU_MASK_WIDTH - 1:0] s6;
reg [BIU_DATA_WIDTH - 1:0] s7;
reg s8;
reg s9;
wire s10;
wire s11;
wire [DW - 1:0] s12;
wire [DW - 1:0] s13;
wire [MW - 1:0] s14;
wire s15;
wire s16;
reg [1:0] s17;
reg [1:0] s18;
wire s19;
wire s20;
wire s21;
wire s22;
wire s23;
wire s24;
wire s25;
wire s26;
wire s27;
wire s28;
wire s29;
wire [1:0] s30;
wire [1:0] s31;
wire [1:0] s32;
wire [1:0] s33;
reg [1:0] s34;
wire s35;
wire s36;
wire s37;
wire [1:0] s38;
wire [1:0] s39;
wire [1:0] s40;
wire [1:0] s41;
reg [1:0] s42;
reg s43;
wire s44;
wire s45;
wire s46;
wire s47;
reg s48;
wire s49;
wire s50;
wire s51;
wire s52;
wire nds_unused_rcnt_lo_minus;
wire nds_unused_rcnt_lo;
wire nds_unused_rcnt_hi_minus;
wire nds_unused_rcnt_hi;
kv_dff_bwe #(
    .BYTES(MW)
) u_data_buf (
    .clk(vpu_vlsu_clk),
    .bwe(s14),
    .d(s12),
    .q(s13)
);
assign s0 = (DLEN / BIU_DATA_WIDTH == 2) & ~hvm;
assign s1 = wvalid & wready;
assign s25 = s24 & wready;
assign s26 = s1 | s25;
assign s2 = rvalid & rready;
assign s24 = (s0 & s9) ? s8 : wvalid;
assign s15 = s1 & wfirst;
assign s16 = s1 & wlast;
assign s10 = (s0 & rlast & s2) ? 1'b0 : (s0 & wvalid & wlast) ? 1'b1 : s9;
assign s11 = (rlast & s2) ? 1'b0 : (wlast & s1 & ~extra_biu) ? 1'b0 : (s0 & wvalid) ? 1'b1 : s8;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s17 <= 2'd0;
    end
    else if (s15) begin
        s17 <= wfirst_cnt;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s18 <= 2'd0;
    end
    else if (s16) begin
        s18 <= wlast_cnt;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s5 <= {V0T_DW{1'b0}};
        s6 <= {BIU_MASK_WIDTH{1'b0}};
        s8 <= 1'b0;
        s9 <= 1'b0;
    end
    else if (s1 | s2) begin
        s5 <= s4;
        s6 <= v0t_extra_wdata;
        s8 <= s11;
        s9 <= s10;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s7 <= {BIU_DATA_WIDTH{1'b0}};
    end
    else if (s1) begin
        s7 <= extra_wdata;
    end
end

assign s46 = s44 | s45;
assign s47 = s44;
assign s44 = s1 & wfirst;
assign s45 = s2 & rfirst;
assign s51 = s49 | s50;
assign s52 = s49;
assign s49 = s1 & wlast;
assign s50 = s2 & rlast;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s43 <= 1'b0;
    end
    else if (s46) begin
        s43 <= s47;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s48 <= 1'b0;
    end
    else if (s51) begin
        s48 <= s52;
    end
end

assign s12 = wdata | ({HR_DATA_WIDTH * 2{s8}} & {{HR_DATA_WIDTH * 2 - BIU_DATA_WIDTH{1'b0}},s7[BIU_DATA_WIDTH - 1:0]});
assign s14 = {MW{s26}} & bwe;
assign s3[V0T_DW / 2 - 1:0] = s29 ? ~mask_clr & s5[V0T_DW / 2 - 1:0] : s5[V0T_DW / 2 - 1:0];
assign s3[V0T_DW - 1:V0T_DW / 2] = s37 ? ~mask_clr & s5[V0T_DW - 1:V0T_DW / 2] : s5[V0T_DW - 1:V0T_DW / 2];
assign s4 = ({V0T_DW{s26}} & v0t_wdata) | s3 | ({HR_MASK_WIDTH * 2{s8}} & {{HR_MASK_WIDTH * 2 - BIU_MASK_WIDTH{1'b0}},s6[BIU_MASK_WIDTH - 1:0]});
assign s20 = ~rfirst & ~rlast;
assign s21 = s43 & ((rfirst & (onehot_sel_r[0] & (s34 >= s17))) | (rfirst & (onehot_sel_r[1] & (s42 >= s17))));
assign s22 = s48 & ((rlast & (onehot_sel_r[0] & (s34 >= s18))) | (rlast & (onehot_sel_r[1] & (s42 >= s18))) | (rlast & s8));
assign s23 = s0 ? (s20 & (onehot_sel_r[0] & (s34 == 2'd1))) | (s20 & (onehot_sel_r[1] & (s42 == 2'd1))) : (s20 & (onehot_sel_r[0] & (s34 == 2'd2))) | (s20 & (onehot_sel_r[1] & (s42 == 2'd2)));
assign rvalid = s21 | s22 | s23;
assign rdata_xhvm = ({BIU_DATA_WIDTH{onehot_sel_r[0]}} & s13[BIU_DATA_WIDTH * 0 +:BIU_DATA_WIDTH]) | ({BIU_DATA_WIDTH{onehot_sel_r[1]}} & s13[BIU_DATA_WIDTH * 1 +:BIU_DATA_WIDTH]);
assign rdata_hvm = ({HR_DATA_WIDTH{onehot_sel_r[0]}} & s13[HR_DATA_WIDTH * 0 +:HR_DATA_WIDTH]) | ({HR_DATA_WIDTH{onehot_sel_r[1]}} & s13[HR_DATA_WIDTH * 1 +:HR_DATA_WIDTH]);
assign rmask = ({HR_MASK_WIDTH{onehot_sel_r[0]}} & s5[HR_MASK_WIDTH * 0 +:HR_MASK_WIDTH]) | ({HR_MASK_WIDTH{onehot_sel_r[1]}} & s5[HR_MASK_WIDTH * 1 +:HR_MASK_WIDTH]);
assign s19 = ~wfirst & ~wlast;
assign s30 = 2'd1;
assign s31 = rfirst ? s17 : rlast ? s18 : s0 ? 2'd1 : 2'd2;
assign s38 = 2'd1;
assign s39 = rfirst ? s17 : rlast ? s18 : s0 ? 2'd1 : 2'd2;
assign s28 = (s1 & (wfirst | ((wlast & cross_biu) & onehot_sel_w[1]) | (wlast & onehot_sel_w[0]) | s19)) | s25;
assign s29 = (s2 & onehot_sel_r[0]) | (s2 & rlast);
assign s27 = s28 | s29;
assign {nds_unused_rcnt_lo_minus,s32} = s34 - ({2{s29}} & s31);
assign {nds_unused_rcnt_lo,s33} = (rlast & s2) ? 3'd0 : s32 + ({2{s28}} & s30);
assign s36 = s1 & ((wfirst & ~wlast) | ((wlast & cross_biu) & onehot_sel_w[0]) | (wlast & onehot_sel_w[1]) | s19);
assign s37 = (s2 & onehot_sel_r[1]) | (s2 & rlast);
assign s35 = s36 | s37;
assign {nds_unused_rcnt_hi_minus,s40} = s42 - ({2{s37}} & s39);
assign {nds_unused_rcnt_hi,s41} = (rlast & s2) ? 3'd0 : s40 + ({2{s36}} & s38);
assign wready = s0 ? (s32 < 2'd1) & (s40 < 2'd1) : (s32 < 2'd2) & (s40 < 2'd2);
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s34 <= 2'b0;
    end
    else if (s27) begin
        s34 <= s33;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s42 <= 2'b0;
    end
    else if (s35) begin
        s42 <= s41;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

