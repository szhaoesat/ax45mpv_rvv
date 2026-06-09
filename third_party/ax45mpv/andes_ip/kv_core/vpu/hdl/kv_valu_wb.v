// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_wb (
    vpu_valu_clk,
    vpu_reset_n,
    wb_standby,
    wb_us_valid,
    wb_us_ready,
    wb_us_flag_update,
    wb_us_flag_clr,
    wb_us_flag,
    wb_us_wdata_src0,
    wb_us_wdata_src1,
    wb_us_wdata_src2,
    wb_us_wdata_src3,
    wb_us_src,
    wb_us_bit_wen,
    wb_us_mask_wdata,
    wb_us_cmtted,
    wb_us_last,
    wb_us_skip,
    exs_nxt_cmt,
    valu_vxsat_set,
    valu_cmt_valid,
    valu_cmt_kill,
    valu_vd_wvalid,
    valu_vd_wdata,
    valu_vd_wmask,
    valu_vd_wready
);
parameter DLEN = 512;
localparam DBLEN = DLEN / 8;
input vpu_valu_clk;
input vpu_reset_n;
output exs_nxt_cmt;
output wb_standby;
input wb_us_valid;
output wb_us_ready;
input wb_us_flag_update;
input wb_us_flag_clr;
input wb_us_flag;
input [DLEN - 1:0] wb_us_wdata_src0;
input [DLEN - 1:0] wb_us_wdata_src1;
input [DLEN - 1:0] wb_us_wdata_src2;
input [DLEN - 1:0] wb_us_wdata_src3;
input [3:0] wb_us_src;
input [DLEN - 1:0] wb_us_bit_wen;
input [DBLEN - 1:0] wb_us_mask_wdata;
input wb_us_cmtted;
input wb_us_last;
input wb_us_skip;
input valu_cmt_valid;
input valu_cmt_kill;
output valu_vd_wvalid;
output [DLEN - 1:0] valu_vd_wdata;
output [DBLEN - 1:0] valu_vd_wmask;
input valu_vd_wready;
output valu_vxsat_set;





// e40363d0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg valu_vxsat_set;
wire s0;
wire s1;
reg s2;
reg s3;
reg s4;
reg [DLEN - 1:0] s5;
reg [DLEN - 1:0] s6;
reg [DLEN - 1:0] s7;
reg [DLEN - 1:0] s8;
reg [3:0] s9;
reg [DLEN - 1:0] s10;
wire [DLEN - 1:0] s11;
reg [DBLEN - 1:0] s12;
reg [DBLEN - 1:0] s13;
reg s14;
wire s15;
wire s16;
wire s17;
wire s18;
reg s19;
wire s20;
wire s21;
wire s22;
wire s23;
reg s24;
wire s25;
wire s26;
wire s27;
wire s28;
reg s29;
wire s30;
wire s31;
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
wire s48 = valu_cmt_valid & ~valu_cmt_kill;
wire s49 = valu_cmt_valid & valu_cmt_kill;
wire s50 = s41 & s36;
wire s51 = s41 & ~s36;
wire s52 = ~s41 & s36;
assign s25 = wb_us_flag_update;
assign s26 = s47 | s52 | (~s36 & wb_us_flag_clr);
assign s27 = (s24 & ~s26) | (s25 & wb_us_flag);
assign s28 = s25 | s26;
assign s30 = s42;
assign s31 = s46 | (s41 & valu_vd_wready);
assign s32 = (s30 & s24) | (s29 & ~s31);
assign s33 = s30 | s31;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s24 <= 1'b0;
    end
    else if (s28) begin
        s24 <= s27;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s29 <= 1'b0;
    end
    else if (s33) begin
        s29 <= s32;
    end
end

assign s37 = s34;
assign s38 = s47 | s52;
assign s39 = (s36 & ~s38) | s37;
assign s40 = s37 | s38;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s36 <= 1'b0;
    end
    else if (s40) begin
        s36 <= s39;
    end
end

assign s42 = (s52 & ~valu_vd_wready & ~s4 & ~s47);
assign s43 = s46 | (s41 & valu_vd_wready);
assign s44 = (s41 & ~s43) | s42;
assign s45 = s42 | s43;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s41 <= 1'b0;
    end
    else if (s45) begin
        s41 <= s44;
    end
end

assign s46 = (s41 & ~s19 & s49);
assign s47 = (s50 & s19 & ~s14 & s49) | (s50 & ~s19 & ~s3 & s49) | (s52 & ~s14 & s49);
assign exs_nxt_cmt = (s50 & s2 & s14) | (s50 & ~s2 & ~s14 & s19) | (s50 & ~s2 & ~s14 & ~s3) | (s51 & s3 & s19) | (s51 & ~s3 & ~s19) | (s52 & s2 & s14) | (s52 & ~s2 & ~s14) | (~s36 & ~s41);
assign valu_vd_wvalid = (s36 & ~s4) | s41;
assign valu_vd_wdata = ({DLEN{s36 & ~s41 & s9[0]}} & s5) | ({DLEN{s36 & ~s41 & s9[1]}} & s6) | ({DLEN{s36 & ~s41 & s9[2]}} & s7) | ({DLEN{s36 & ~s41 & s9[3]}} & s8) | ({DLEN{s41}} & s10);
assign valu_vd_wmask = ({DBLEN{s36 & ~s41}} & s12) | ({DBLEN{s41}} & s13);
assign s35 = wb_us_bit_wen;
generate
    genvar i;
    for (i = 0; i < DLEN; i = i + 1) begin:gen_valu_vd_wdata
        always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s5[i] <= 1'b0;
                s6[i] <= 1'b0;
                s7[i] <= 1'b0;
                s8[i] <= 1'b0;
            end
            else if (s35[i]) begin
                s5[i] <= wb_us_wdata_src0[i];
                s6[i] <= wb_us_wdata_src1[i];
                s7[i] <= wb_us_wdata_src2[i];
                s8[i] <= wb_us_wdata_src3[i];
            end
        end

    end
endgenerate
assign s11 = ({DLEN{s9[0]}} & s5) | ({DLEN{s9[1]}} & s6) | ({DLEN{s9[2]}} & s7) | ({DLEN{s9[3]}} & s8);
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s10 <= {DLEN{1'b0}};
    end
    else if (s42) begin
        s10 <= s11;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s9 <= 4'b0;
    end
    else if (s34) begin
        s9 <= wb_us_src;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s12 <= {DBLEN{1'b0}};
    end
    else if (s34) begin
        s12 <= wb_us_mask_wdata;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s13 <= {DBLEN{1'b0}};
    end
    else if (s42) begin
        s13 <= s12;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s2 <= 1'b0;
        s4 <= 1'b0;
    end
    else if (s34) begin
        s2 <= wb_us_last;
        s4 <= wb_us_skip;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s3 <= 1'b0;
    end
    else if (s42) begin
        s3 <= s2;
    end
end

assign s20 = (s41 & ~s19 & s48) | (s42 & ~s14 & s48) | (s42 & s14);
assign s21 = s43;
assign s22 = (s19 & ~s21) | s20;
assign s23 = s20 | s21;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s19 <= 1'b0;
    end
    else if (s23) begin
        s19 <= s22;
    end
end

assign s15 = (s50 & s19 & ~s14 & s48) | (s50 & ~s19 & ~s3 & s48) | (wb_us_valid & ~s36 & ~s41 & ~wb_us_cmtted & s48) | (s37 & s36 & s14 & ~wb_us_cmtted & s48) | (s37 & s36 & ~s14 & ~s2 & ~wb_us_cmtted & s48) | (s37 & s41 & ~s36 & s19 & ~wb_us_cmtted & s48) | (s37 & s41 & ~s36 & ~s19 & ~s3 & ~wb_us_cmtted & s48) | (s37 & wb_us_cmtted);
assign s16 = s38;
assign s17 = (s14 & ~s16) | s15;
assign s18 = s15 | s16;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s14 <= 1'b0;
    end
    else if (s18) begin
        s14 <= s17;
    end
end

assign wb_us_ready = ~s41 | ~s36;
assign s0 = (s41 & valu_vd_wready) | (~s41 & s36 & valu_vd_wready & ~s4) | (|valu_vxsat_set);
assign s1 = (valu_vd_wvalid & valu_vd_wready) ? s41 ? s29 : s24 : 1'b0;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        valu_vxsat_set <= 1'b0;
    end
    else if (s0) begin
        valu_vxsat_set <= s1;
    end
end

assign wb_standby = ~valu_vxsat_set & ~s36 & ~s41;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

