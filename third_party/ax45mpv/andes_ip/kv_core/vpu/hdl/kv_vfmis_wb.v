// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_wb (
    vpu_vfmis_clk,
    vpu_reset_n,
    vfmis_flag_set,
    wb_standby,
    wb_us_flag_update,
    wb_us_flag_clr,
    wb_us_flag,
    wb_us_skip,
    wb_us_valid,
    wb_us_ready,
    wb_us_wdata_src0,
    wb_us_wdata_src1,
    wb_us_wdata_src2,
    wb_us_src,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    exs_nxt_cmt,
    vfmis_cmt_valid,
    vfmis_cmt_kill,
    vfmis_vd_wvalid,
    vfmis_vd_wdata,
    vfmis_vd_wmask,
    vfmis_vd_wready
);
parameter DLEN = 512;
localparam DBLEN = DLEN / 8;
input vpu_vfmis_clk;
input vpu_reset_n;
output wb_standby;
output exs_nxt_cmt;
output [4:0] vfmis_flag_set;
input wb_us_valid;
output wb_us_ready;
input [4:0] wb_us_flag;
input wb_us_skip;
input wb_us_flag_update;
input wb_us_flag_clr;
input [DLEN - 1:0] wb_us_wdata_src0;
input [DLEN - 1:0] wb_us_wdata_src1;
input [DLEN - 1:0] wb_us_wdata_src2;
input [2:0] wb_us_src;
input [DLEN - 1:0] wb_us_bit_wen;
input [DBLEN - 1:0] wb_us_mask_wdata;
input wb_us_cmtted;
input wb_us_last;
input vfmis_cmt_valid;
input vfmis_cmt_kill;
output vfmis_vd_wvalid;
output [DLEN - 1:0] vfmis_vd_wdata;
output [DBLEN - 1:0] vfmis_vd_wmask;
input vfmis_vd_wready;





// da963b3c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
reg s1;
reg s2;
reg [DLEN - 1:0] s3;
reg [DLEN - 1:0] s4;
reg [DLEN - 1:0] s5;
reg [2:0] s6;
reg [DLEN - 1:0] s7;
wire [DLEN - 1:0] s8;
reg [DBLEN - 1:0] s9;
reg [DBLEN - 1:0] s10;
reg s11;
wire s12;
wire s13;
wire s14;
wire s15;
reg s16;
wire s17;
wire s18;
wire s19;
wire s20;
reg [4:0] s21;
wire s22;
wire s23;
wire s24;
wire [4:0] s25;
reg [4:0] s26;
wire s27;
wire s28;
wire s29;
wire [4:0] s30;
reg [4:0] vfmis_flag_set;
wire [4:0] s31;
wire s32;
wire s33;
wire s34 = wb_us_valid & wb_us_ready;
wire [DLEN - 1:0] s35;
reg s36;
wire s37;
wire s38;
wire s39;
wire s40;
reg s41;
wire s42;
wire s43;
wire s44;
wire s45;
wire s46;
wire s47;
wire s48 = vfmis_cmt_valid & ~vfmis_cmt_kill;
wire s49 = vfmis_cmt_valid & vfmis_cmt_kill;
wire s50 = s41 & s36;
wire s51 = s41 & ~s36;
wire s52 = ~s41 & s36;
assign s37 = s34;
assign s38 = s47 | s52;
assign s39 = (s36 & ~s38) | s37;
assign s40 = s37 | s38;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s36 <= 1'b0;
    end
    else if (s40) begin
        s36 <= s39;
    end
end

assign s42 = (s52 & ~vfmis_vd_wready & ~s2 & ~s47) | (s50 & vfmis_vd_wready & ~s2 & ~s47 & s34);
assign s43 = s46 | (s41 & vfmis_vd_wready);
assign s44 = (s41 & ~s43) | s42;
assign s45 = s42 | s43;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s41 <= 1'b0;
    end
    else if (s45) begin
        s41 <= s44;
    end
end

assign s46 = (s41 & ~s16 & s49);
assign s47 = (s50 & s16 & ~s11 & s49) | (s50 & ~s16 & ~s1 & s49) | (s52 & ~s11 & s49);
assign exs_nxt_cmt = (s50 & s0 & s11) | (s50 & ~s0 & ~s11 & s16) | (s50 & ~s0 & ~s11 & ~s1) | (s51 & s1 & s16) | (s51 & ~s1 & ~s16) | (s52 & s0 & s11) | (s52 & ~s0 & ~s11) | (~s36 & ~s41);
assign vfmis_vd_wvalid = (s36 & ~s2) | s41;
assign vfmis_vd_wdata = ({DLEN{s36 & ~s41 & s6[0]}} & s3) | ({DLEN{s36 & ~s41 & s6[1]}} & s4) | ({DLEN{s36 & ~s41 & s6[2]}} & s5) | ({DLEN{s41}} & s7);
assign vfmis_vd_wmask = ({DBLEN{s36 & ~s41}} & s9) | ({DBLEN{s41}} & s10);
assign s35 = wb_us_bit_wen;
generate
    genvar i;
    for (i = 0; i < DLEN; i = i + 1) begin:gen_vfmis_vd_wdata
        always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s3[i] <= 1'b0;
                s4[i] <= 1'b0;
                s5[i] <= 1'b0;
            end
            else if (s35[i]) begin
                s3[i] <= wb_us_wdata_src0[i];
                s4[i] <= wb_us_wdata_src1[i];
                s5[i] <= wb_us_wdata_src2[i];
            end
        end

    end
endgenerate
assign s8 = ({DLEN{s6[0]}} & s3) | ({DLEN{s6[1]}} & s4) | ({DLEN{s6[2]}} & s5);
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s7 <= {DLEN{1'b0}};
    end
    else if (s42) begin
        s7 <= s8;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= 3'b0;
    end
    else if (s34) begin
        s6 <= wb_us_src;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s9 <= {DBLEN{1'b0}};
    end
    else if (s34) begin
        s9 <= wb_us_mask_wdata;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s10 <= {DBLEN{1'b0}};
    end
    else if (s42) begin
        s10 <= s9;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= 1'b0;
    end
    else if (s34) begin
        s0 <= wb_us_last;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s2 <= 1'b0;
    end
    else if (s34) begin
        s2 <= wb_us_skip;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= 1'b0;
    end
    else if (s42) begin
        s1 <= s0;
    end
end

assign s17 = (s41 & ~s16 & ~vfmis_vd_wready & vfmis_cmt_valid & ~vfmis_cmt_kill) | (s42 & ~s11 & vfmis_cmt_valid & ~vfmis_cmt_kill) | (s42 & s11);
assign s18 = s43;
assign s19 = (s16 & ~s18) | s17;
assign s20 = s17 | s18;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s16 <= 1'b0;
    end
    else if (s20) begin
        s16 <= s19;
    end
end

assign s12 = (s50 & s16 & ~s11 & s48) | (s50 & ~s16 & ~s1 & s48) | (wb_us_valid & ~s36 & ~s41 & ~wb_us_cmtted & s48) | (s37 & s36 & s11 & ~wb_us_cmtted & s48) | (s37 & s36 & ~s11 & ~s0 & ~wb_us_cmtted & s48) | (s37 & s41 & ~s36 & s16 & ~wb_us_cmtted & s48) | (s37 & s41 & ~s36 & ~s16 & ~s1 & ~wb_us_cmtted & s48) | (s37 & wb_us_cmtted);
assign s13 = s38;
assign s14 = (s11 & ~s13) | s12;
assign s15 = s12 | s13;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s11 <= 1'b0;
    end
    else if (s15) begin
        s11 <= s14;
    end
end

assign s22 = wb_us_flag_update;
assign s23 = s47 | s52 | (~s36 & wb_us_flag_clr);
assign s25 = ({5{s22}} & wb_us_flag) | ({5{~s23}} & s21);
assign s24 = s22 | s23;
assign s27 = s42;
assign s28 = (s41 & vfmis_vd_wready) | s46;
assign s30 = s27 ? s21 : 5'b0;
assign s29 = s27 | s28;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s21 <= 5'b0;
    end
    else if (s24) begin
        s21 <= s25;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s26 <= 5'b0;
    end
    else if (s29) begin
        s26 <= s30;
    end
end

assign s32 = |vfmis_flag_set;
assign s33 = s32 | (vfmis_vd_wvalid & vfmis_vd_wready);
assign s31 = (vfmis_vd_wvalid & vfmis_vd_wready) ? s41 ? s26 : s21 : 5'b0;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vfmis_flag_set <= 5'b0;
    end
    else if (s33) begin
        vfmis_flag_set <= s31;
    end
end

assign wb_us_ready = ~s41 | ~s36;
assign wb_standby = ~s36 & ~s41 & ~(|vfmis_flag_set);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

