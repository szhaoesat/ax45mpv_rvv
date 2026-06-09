// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_valu_vrf_buf (
    vpu_valu_clk,
    vpu_reset_n,
    valu_vs1_rvalid,
    valu_vs1_rready,
    valu_vs1_rdata,
    valu_vs1_rlast,
    valu_vs1_wide_rdata,
    valu_vs2_rvalid,
    valu_vs2_rready,
    valu_vs2_rdata,
    valu_vs2_rlast,
    valu_vs2_wide_rdata,
    valu_vs3_rvalid,
    valu_vs3_rready,
    valu_vs3_rdata,
    valu_vs3_rlast,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_rdata,
    vrf_vs1_last,
    vrf_vs1_wdata,
    vrf_vs1_wr,
    vrf_vs1_wide_wdata,
    vrf_vs1_wide_rdata,
    vrf_vs1_wide_wr,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_rdata,
    vrf_vs2_last,
    vrf_vs2_wdata,
    vrf_vs2_wr,
    vrf_vs2_wide_wdata,
    vrf_vs2_wide_rdata,
    vrf_vs2_wide_wr,
    vrf_vd_valid,
    vrf_vd_rd,
    vrf_vd_kill,
    vrf_vd_wr,
    vrf_vd_wdata,
    vrf_vd_rdata,
    vrf_vd_last,
    vrf_vd_srl
);
input vpu_valu_clk;
input vpu_reset_n;
input valu_vs1_rvalid;
output valu_vs1_rready;
input [63:0] valu_vs1_rdata;
input [31:0] valu_vs1_wide_rdata;
input valu_vs1_rlast;
input valu_vs2_rvalid;
output valu_vs2_rready;
input [63:0] valu_vs2_rdata;
input [31:0] valu_vs2_wide_rdata;
input valu_vs2_rlast;
input valu_vs3_rvalid;
output valu_vs3_rready;
input [63:0] valu_vs3_rdata;
input valu_vs3_rlast;
output vrf_vs1_valid;
input vrf_vs1_rd;
input vrf_vs1_kill;
output [63:0] vrf_vs1_rdata;
output vrf_vs1_last;
input [63:0] vrf_vs1_wdata;
input vrf_vs1_wr;
input [31:0] vrf_vs1_wide_wdata;
output [31:0] vrf_vs1_wide_rdata;
input vrf_vs1_wide_wr;
output vrf_vs2_valid;
input vrf_vs2_rd;
input vrf_vs2_kill;
output [63:0] vrf_vs2_rdata;
output vrf_vs2_last;
input [63:0] vrf_vs2_wdata;
input vrf_vs2_wr;
input [31:0] vrf_vs2_wide_wdata;
output [31:0] vrf_vs2_wide_rdata;
input vrf_vs2_wide_wr;
output vrf_vd_valid;
input vrf_vd_rd;
input vrf_vd_kill;
input vrf_vd_wr;
input [63:0] vrf_vd_wdata;
output [63:0] vrf_vd_rdata;
output vrf_vd_last;
input vrf_vd_srl;





// 4dd71c06 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg vrf_vs1_valid;
wire s0;
wire s1;
wire s2;
wire s3;
reg vrf_vs2_valid;
wire s4;
wire s5;
wire s6;
wire s7;
reg vrf_vd_valid;
wire s8;
wire s9;
wire s10;
wire s11;
reg vrf_vd_last;
reg [63:0] vrf_vd_rdata;
wire [63:0] s12;
wire s13;
reg [63:0] vrf_vs1_rdata;
wire [63:0] s14;
wire s15;
reg vrf_vs1_last;
reg [31:0] vrf_vs1_wide_rdata;
wire [31:0] s16;
wire s17;
reg [63:0] vrf_vs2_rdata;
wire [63:0] s18;
wire s19;
reg vrf_vs2_last;
reg [31:0] vrf_vs2_wide_rdata;
wire [31:0] s20;
wire s21;
assign s0 = (valu_vs1_rvalid & valu_vs1_rready & ~vrf_vs1_kill) | (valu_vs1_rvalid & valu_vs1_rready & vrf_vs1_valid & vrf_vs1_last);
assign s1 = valu_vs1_rready | vrf_vs1_kill;
assign s3 = (vrf_vs1_valid & ~s1) | s0;
assign s2 = s1 | s0;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_valid <= 1'b0;
    end
    else if (s2) begin
        vrf_vs1_valid <= s3;
    end
end

assign s15 = s0 | vrf_vs1_wr;
assign s14 = s0 ? valu_vs1_rdata : vrf_vs1_wdata;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_rdata <= {64{1'b0}};
    end
    else if (s15) begin
        vrf_vs1_rdata <= s14;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_last <= 1'b0;
    end
    else if (s0) begin
        vrf_vs1_last <= valu_vs1_rlast;
    end
end

assign s17 = s0 | vrf_vs1_wide_wr;
assign s16 = s0 ? valu_vs1_wide_rdata : vrf_vs1_wide_wdata;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_wide_rdata <= 32'b0;
    end
    else if (s17) begin
        vrf_vs1_wide_rdata <= s16;
    end
end

assign s4 = (valu_vs2_rvalid & valu_vs2_rready & ~vrf_vs2_kill) | (valu_vs2_rvalid & valu_vs2_rready & vrf_vs2_valid & vrf_vs2_last);
assign s5 = valu_vs2_rready | vrf_vs2_kill;
assign s7 = (vrf_vs2_valid & ~s5) | s4;
assign s6 = s5 | s4;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_valid <= 1'b0;
    end
    else if (s6) begin
        vrf_vs2_valid <= s7;
    end
end

assign s19 = s4 | vrf_vs2_wr;
assign s18 = s4 ? valu_vs2_rdata : vrf_vs2_wdata;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_rdata <= {64{1'b0}};
    end
    else if (s19) begin
        vrf_vs2_rdata <= s18;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_last <= 1'b0;
    end
    else if (s4) begin
        vrf_vs2_last <= valu_vs2_rlast;
    end
end

assign s21 = s4 | vrf_vs2_wide_wr;
assign s20 = s4 ? valu_vs2_wide_rdata : vrf_vs2_wide_wdata;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_wide_rdata <= 32'b0;
    end
    else if (s21) begin
        vrf_vs2_wide_rdata <= s20;
    end
end

assign s13 = vrf_vd_wr | s8 | vrf_vd_srl;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_rdata <= {64{1'b0}};
    end
    else if (s13) begin
        vrf_vd_rdata <= s12;
    end
end

always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_last <= 1'b0;
    end
    else if (s8) begin
        vrf_vd_last <= valu_vs3_rlast;
    end
end

assign s12 = ({64{vrf_vd_wr & ~vrf_vd_srl}} & vrf_vd_wdata) | ({64{s8}} & valu_vs3_rdata) | ({64{vrf_vd_srl & ~vrf_vd_wr}} & {{32{1'b0}},vrf_vd_rdata[63:32]}) | ({64{vrf_vd_srl & vrf_vd_wr}} & {{32{1'b0}},vrf_vd_wdata[63:32]});
assign s8 = (valu_vs3_rvalid & valu_vs3_rready & ~vrf_vd_kill) | (valu_vs3_rvalid & valu_vs3_rready & vrf_vd_valid & vrf_vd_last);
assign s9 = valu_vs3_rready | vrf_vd_kill;
assign s11 = (vrf_vd_valid & ~s9) | s8;
assign s10 = s9 | s8;
always @(posedge vpu_valu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_valid <= 1'b0;
    end
    else if (s10) begin
        vrf_vd_valid <= s11;
    end
end

assign valu_vs1_rready = vrf_vs1_rd;
assign valu_vs2_rready = vrf_vs2_rd;
assign valu_vs3_rready = vrf_vd_rd;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

