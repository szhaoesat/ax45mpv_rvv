// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmac_vrf_buf (
    vpu_vmac_clk,
    vpu_reset_n,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_last,
    vrf_vs1_kill,
    vrf_vs1_wr,
    vrf_vs1_wdata,
    vrf_vs1_rdata,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_last,
    vrf_vs2_kill,
    vrf_vs2_wr,
    vrf_vs2_wdata,
    vrf_vs2_rdata,
    vrf_vd_valid,
    vrf_vd_kill,
    vrf_vd_rd,
    vrf_vd_last,
    vrf_vd_wr,
    vrf_vd_wdata,
    vrf_vd_rdata,
    vmac_vs1_rvalid,
    vmac_vs1_rready,
    vmac_vs1_rdata,
    vmac_vs1_rlast,
    vmac_vs2_rvalid,
    vmac_vs2_rready,
    vmac_vs2_rdata,
    vmac_vs2_rlast,
    vmac_vs3_rvalid,
    vmac_vs3_rready,
    vmac_vs3_rdata,
    vmac_vs3_rlast
);
input vpu_vmac_clk;
input vpu_reset_n;
input vmac_vs1_rvalid;
output vmac_vs1_rready;
input [63:0] vmac_vs1_rdata;
input vmac_vs1_rlast;
input vmac_vs2_rvalid;
output vmac_vs2_rready;
input [63:0] vmac_vs2_rdata;
input vmac_vs2_rlast;
input vmac_vs3_rvalid;
output vmac_vs3_rready;
input [63:0] vmac_vs3_rdata;
input vmac_vs3_rlast;
output vrf_vs1_valid;
input vrf_vs1_rd;
output vrf_vs1_last;
input vrf_vs1_kill;
input vrf_vs1_wr;
input [63:0] vrf_vs1_wdata;
output [63:0] vrf_vs1_rdata;
output vrf_vs2_valid;
input vrf_vs2_rd;
output vrf_vs2_last;
input vrf_vs2_kill;
input vrf_vs2_wr;
input [63:0] vrf_vs2_wdata;
output [63:0] vrf_vs2_rdata;
output vrf_vd_valid;
input vrf_vd_rd;
output vrf_vd_last;
input vrf_vd_kill;
input vrf_vd_wr;
input [63:0] vrf_vd_wdata;
output [63:0] vrf_vd_rdata;





// 47f86ab2 rnd
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
reg [63:0] vrf_vs1_rdata;
reg [63:0] vrf_vs2_rdata;
reg [63:0] vrf_vd_rdata;
reg vrf_vs1_last;
reg vrf_vs2_last;
reg vrf_vd_last;
wire [63:0] s12;
wire [63:0] s13;
wire [63:0] s14;
wire s15;
wire s16;
wire s17;
assign s15 = vrf_vs1_wr | s0;
assign s16 = vrf_vs2_wr | s4;
assign s17 = vrf_vd_wr | s8;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_last <= 1'b0;
    end
    else if (s0) begin
        vrf_vs1_last <= vmac_vs1_rlast;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_last <= 1'b0;
    end
    else if (s4) begin
        vrf_vs2_last <= vmac_vs2_rlast;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_last <= 1'b0;
    end
    else if (s8) begin
        vrf_vd_last <= vmac_vs3_rlast;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_rdata <= 64'b0;
    end
    else if (s15) begin
        vrf_vs1_rdata <= s12;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_rdata <= 64'b0;
    end
    else if (s16) begin
        vrf_vs2_rdata <= s13;
    end
end

always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_rdata <= 64'b0;
    end
    else if (s17) begin
        vrf_vd_rdata <= s14;
    end
end

assign s12 = ({64{vrf_vs1_wr}} & vrf_vs1_wdata) | ({64{s0}} & vmac_vs1_rdata);
assign s13 = ({64{vrf_vs2_wr}} & vrf_vs2_wdata) | ({64{s4}} & vmac_vs2_rdata);
assign s14 = ({64{vrf_vd_wr}} & vrf_vd_wdata) | ({64{s8}} & vmac_vs3_rdata);
assign s0 = (vmac_vs1_rvalid & vmac_vs1_rready & ~vrf_vs1_kill) | (vmac_vs1_rvalid & vmac_vs1_rready & vrf_vs1_valid & vrf_vs1_last);
assign s1 = vmac_vs1_rready | vrf_vs1_kill;
assign s3 = (vrf_vs1_valid & ~s1) | s0;
assign s2 = s1 | s0;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_valid <= 1'b0;
    end
    else if (s2) begin
        vrf_vs1_valid <= s3;
    end
end

assign s4 = (vmac_vs2_rvalid & vmac_vs2_rready & ~vrf_vs2_kill) | (vmac_vs2_rvalid & vmac_vs2_rready & vrf_vs2_valid & vrf_vs2_last);
assign s5 = vmac_vs2_rready | vrf_vs2_kill;
assign s7 = (vrf_vs2_valid & ~s5) | s4;
assign s6 = s5 | s4;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_valid <= 1'b0;
    end
    else if (s6) begin
        vrf_vs2_valid <= s7;
    end
end

assign s8 = (vmac_vs3_rvalid & vmac_vs3_rready & ~vrf_vd_kill) | (vmac_vs3_rvalid & vmac_vs3_rready & vrf_vd_valid & vrf_vd_last);
assign s9 = vmac_vs3_rready | vrf_vd_kill;
assign s11 = (vrf_vd_valid & ~s9) | s8;
assign s10 = s9 | s8;
always @(posedge vpu_vmac_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vd_valid <= 1'b0;
    end
    else if (s10) begin
        vrf_vd_valid <= s11;
    end
end

assign vmac_vs1_rready = vrf_vs1_rd;
assign vmac_vs2_rready = vrf_vs2_rd;
assign vmac_vs3_rready = vrf_vd_rd;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

