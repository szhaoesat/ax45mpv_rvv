// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vfdiv_vrf_buf (
    vpu_vfdiv_clk,
    vpu_reset_n,
    vrf_vs1_valid,
    vrf_vs1_rd,
    vrf_vs1_kill,
    vrf_vs1_rdata,
    vrf_vs1_srl,
    vrf_vs2_valid,
    vrf_vs2_rd,
    vrf_vs2_kill,
    vrf_vs2_rdata,
    vrf_vs2_srl,
    vfdiv_vs1_rvalid,
    vfdiv_vs1_rready,
    vfdiv_vs1_rdata,
    vfdiv_vs2_rvalid,
    vfdiv_vs2_rready,
    vfdiv_vs2_rdata
);
parameter DLEN = 512;
parameter CLEN = 512;
input vpu_vfdiv_clk;
input vpu_reset_n;
output vrf_vs1_valid;
output [CLEN - 1:0] vrf_vs1_rdata;
input vrf_vs1_srl;
output vrf_vs2_valid;
output [CLEN - 1:0] vrf_vs2_rdata;
input vrf_vs2_srl;
input vfdiv_vs1_rvalid;
output vfdiv_vs1_rready;
input [DLEN - 1:0] vfdiv_vs1_rdata;
input vfdiv_vs2_rvalid;
output vfdiv_vs2_rready;
input [DLEN - 1:0] vfdiv_vs2_rdata;
input vrf_vs1_rd;
input vrf_vs1_kill;
input vrf_vs2_rd;
input vrf_vs2_kill;





// 286f70ff rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg vrf_vs1_valid;
wire s0;
wire s1;
wire s2;
wire s3;
reg [DLEN - 1:0] s4;
wire [DLEN - 1:0] s5;
wire s6;
reg vrf_vs2_valid;
wire s7;
wire s8;
wire s9;
wire s10;
reg [DLEN - 1:0] s11;
wire [DLEN - 1:0] s12;
wire s13;
assign s0 = vfdiv_vs1_rvalid & vfdiv_vs1_rready & ~vrf_vs1_kill;
assign s1 = vfdiv_vs1_rready | vrf_vs1_kill;
assign s3 = (vrf_vs1_valid & ~s1) | s0;
assign s2 = s1 | s0;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs1_valid <= 1'b0;
    end
    else if (s2) begin
        vrf_vs1_valid <= s3;
    end
end

assign s6 = s0 | vrf_vs1_srl;
generate
    if (DLEN == CLEN) begin:gen_vs1_rdata_nx_clen_eq_dlen
        assign s5 = vfdiv_vs1_rdata;
    end
    else begin:gen_vs1_rdata_nx_clen_nq_dlen
        assign s5 = s0 ? vfdiv_vs1_rdata : {{CLEN{1'b0}},s4[DLEN - 1:CLEN]};
    end
endgenerate
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s4 <= {DLEN{1'b0}};
    end
    else if (s6) begin
        s4 <= s5;
    end
end

assign vrf_vs1_rdata = s4[CLEN - 1:0];
assign s7 = vfdiv_vs2_rvalid & vfdiv_vs2_rready & ~vrf_vs2_kill;
assign s8 = vfdiv_vs2_rready | vrf_vs2_kill;
assign s10 = (vrf_vs2_valid & ~s8) | s7;
assign s9 = s8 | s7;
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        vrf_vs2_valid <= 1'b0;
    end
    else if (s9) begin
        vrf_vs2_valid <= s10;
    end
end

assign s13 = s7 | vrf_vs2_srl;
generate
    if (DLEN == CLEN) begin:gen_vs2_rdata_nx_clen_eq_dlen
        assign s12 = vfdiv_vs2_rdata;
    end
    else begin:gen_vs2_rdata_nx_clen_nq_dlen
        assign s12 = s7 ? vfdiv_vs2_rdata : {{CLEN{1'b0}},s11[DLEN - 1:CLEN]};
    end
endgenerate
always @(posedge vpu_vfdiv_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s11 <= {DLEN{1'b0}};
    end
    else if (s13) begin
        s11 <= s12;
    end
end

assign vrf_vs2_rdata = s11[CLEN - 1:0];
assign vfdiv_vs1_rready = vrf_vs1_rd;
assign vfdiv_vs2_rready = vrf_vs2_rd;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

