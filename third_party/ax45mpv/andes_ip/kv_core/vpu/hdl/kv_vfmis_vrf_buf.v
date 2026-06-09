// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfmis_vrf_buf (
    vpu_vfmis_clk,
    vpu_reset_n,
    vrf_vs1_rdata,
    vrf_vs2_rdata,
    vrf_vs2_wide_rdata,
    vfmis_vs1_rvalid,
    vfmis_vs1_rlast,
    vfmis_vs1_rready,
    vfmis_vs1_rdata,
    vfmis_vs2_rvalid,
    vfmis_vs2_rlast,
    vfmis_vs2_rready,
    vfmis_vs2_rdata,
    vfmis_vs2_wide_rdata,
    vfmis_vs3_rvalid,
    vfmis_vs3_rlast,
    vfmis_vs3_rready,
    vfmis_vs3_rdata,
    vrf_vs1_valid,
    vrf_vs1_last,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_wr,
    vrf_vs1_wdata,
    vrf_vs2_valid,
    vrf_vs2_last,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_wr,
    vrf_vs2_wdata,
    vrf_vs2_wide_wr,
    vrf_vs2_wide_wdata,
    vrf_vd_valid,
    vrf_vd_last,
    vrf_vd_rd,
    vrf_vd_kill,
    vrf_vd_rdata
);
input vpu_vfmis_clk;
input vpu_reset_n;
output [63:0] vrf_vs1_rdata;
output [63:0] vrf_vs2_rdata;
output [31:0] vrf_vs2_wide_rdata;
input vfmis_vs1_rvalid;
input vfmis_vs1_rlast;
output vfmis_vs1_rready;
input [63:0] vfmis_vs1_rdata;
input vfmis_vs2_rvalid;
input vfmis_vs2_rlast;
output vfmis_vs2_rready;
input [63:0] vfmis_vs2_rdata;
input [31:0] vfmis_vs2_wide_rdata;
input vfmis_vs3_rvalid;
input vfmis_vs3_rlast;
output vfmis_vs3_rready;
input [63:0] vfmis_vs3_rdata;
output vrf_vs1_valid;
output vrf_vs1_last;
input vrf_vs1_rd;
input vrf_vs1_kill;
input vrf_vs1_wr;
input [63:0] vrf_vs1_wdata;
output vrf_vs2_valid;
output vrf_vs2_last;
input vrf_vs2_rd;
input vrf_vs2_kill;
input vrf_vs2_wr;
input [63:0] vrf_vs2_wdata;
input vrf_vs2_wide_wr;
input [31:0] vrf_vs2_wide_wdata;
output vrf_vd_valid;
output vrf_vd_last;
input vrf_vd_rd;
input vrf_vd_kill;
output [63:0] vrf_vd_rdata;





// 49ea7d48 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg vrf_vs1_valid;
reg vrf_vs1_last;
wire s0;
wire s1;
wire s2;
wire s3;
reg [63:0] vrf_vs1_rdata;
wire [63:0] s4;
wire s5;
reg vrf_vs2_valid;
reg vrf_vs2_last;
wire s6;
wire s7;
wire s8;
wire s9;
reg [63:0] vrf_vs2_rdata;
wire [63:0] s10;
wire s11;
reg [31:0] vrf_vs2_wide_rdata;
wire [31:0] s12;
wire s13;
reg vrf_vd_valid;
reg vrf_vd_last;
wire s14;
wire s15;
wire s16;
wire s17;
reg [63:0] vrf_vd_rdata;
wire [63:0] s18;
wire s19;
assign s0 = (vfmis_vs1_rvalid & vfmis_vs1_rready & ~vrf_vs1_kill) | (vfmis_vs1_rvalid & vfmis_vs1_rready & vrf_vs1_valid & vrf_vs1_last);
assign s1 = vfmis_vs1_rready | vrf_vs1_kill;
assign s3 = (vrf_vs1_valid & ~s1) | s0;
assign s2 = s1 | s0;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_valid <= 1'b0;
    end
    else if (s2) begin
        vrf_vs1_valid <= s3;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_last <= 1'b0;
    end
    else if (s0) begin
        vrf_vs1_last <= vfmis_vs1_rlast;
    end
end

assign s5 = s0 | vrf_vs1_wr;
assign s4 = s0 ? vfmis_vs1_rdata : vrf_vs1_wdata;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_rdata <= 64'b0;
    end
    else if (s5) begin
        vrf_vs1_rdata <= s4;
    end
end

assign s6 = (vfmis_vs2_rvalid & vfmis_vs2_rready & ~vrf_vs2_kill) | (vfmis_vs2_rvalid & vfmis_vs2_rready & vrf_vs2_valid & vrf_vs2_last);
assign s7 = vfmis_vs2_rready | vrf_vs2_kill;
assign s9 = (vrf_vs2_valid & ~s7) | s6;
assign s8 = s7 | s6;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_valid <= 1'b0;
    end
    else if (s8) begin
        vrf_vs2_valid <= s9;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_last <= 1'b0;
    end
    else if (s6) begin
        vrf_vs2_last <= vfmis_vs2_rlast;
    end
end

assign s11 = s6 | vrf_vs2_wr;
assign s10 = s6 ? vfmis_vs2_rdata : vrf_vs2_wdata;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_rdata <= 64'b0;
    end
    else if (s11) begin
        vrf_vs2_rdata <= s10;
    end
end

assign s13 = s6 | vrf_vs2_wide_wr;
assign s12 = s6 ? vfmis_vs2_wide_rdata : vrf_vs2_wide_wdata;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_wide_rdata <= 32'b0;
    end
    else if (s13) begin
        vrf_vs2_wide_rdata <= s12;
    end
end

assign s14 = (vfmis_vs3_rvalid & vfmis_vs3_rready & ~vrf_vd_kill) | (vfmis_vs3_rvalid & vfmis_vs3_rready & vrf_vd_valid & vrf_vd_last);
assign s15 = vfmis_vs3_rready | vrf_vd_kill;
assign s17 = (vrf_vd_valid & ~s15) | s14;
assign s16 = s15 | s14;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_valid <= 1'b0;
    end
    else if (s16) begin
        vrf_vd_valid <= s17;
    end
end

always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_last <= 1'b0;
    end
    else if (s14) begin
        vrf_vd_last <= vfmis_vs3_rlast;
    end
end

assign s19 = s14;
assign s18 = vfmis_vs3_rdata;
always @(posedge vpu_vfmis_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_rdata <= 64'b0;
    end
    else if (s19) begin
        vrf_vd_rdata <= s18;
    end
end

assign vfmis_vs1_rready = vrf_vs1_rd;
assign vfmis_vs2_rready = vrf_vs2_rd;
assign vfmis_vs3_rready = vrf_vd_rd;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

