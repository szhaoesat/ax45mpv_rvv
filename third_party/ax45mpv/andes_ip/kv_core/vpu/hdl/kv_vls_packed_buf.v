// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_packed_buf (
    vpu_vlsu_clk,
    vpu_reset_n,
    segbuf_packed_data_wvalid,
    segbuf_packed_data_wready,
    segbuf_packed_data_wlast,
    segbuf_packed_data_kill,
    segbuf_packed_wdata,
    segbuf_packed_data_bwe,
    segbuf_packed_buf_clr,
    segbuf_packed_buf_shift,
    segbuf_packed_data_rlast,
    segbuf_packed_occupied,
    segbuf_packed_rdata
);
parameter DLEN = 512;
parameter SEG_DATA_WIDTH = 512;
parameter SEG_MASK_WIDTH = 64;
parameter PACKED_DATA_WIDTH = 512;
parameter PACKED_MASK_WIDTH = 64;
input vpu_vlsu_clk;
input vpu_reset_n;
input segbuf_packed_data_wvalid;
output segbuf_packed_data_wready;
input segbuf_packed_data_wlast;
input segbuf_packed_data_kill;
input [PACKED_DATA_WIDTH - 1:0] segbuf_packed_wdata;
input [PACKED_MASK_WIDTH - 1:0] segbuf_packed_data_bwe;
input segbuf_packed_buf_clr;
input segbuf_packed_buf_shift;
input segbuf_packed_data_rlast;
output segbuf_packed_occupied;
output [DLEN - 1:0] segbuf_packed_rdata;





// 6e811e72 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire [PACKED_DATA_WIDTH - 1:0] s1;
wire [PACKED_DATA_WIDTH - 1:0] s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
reg segbuf_packed_occupied;
wire [PACKED_DATA_WIDTH - 1:0] s8;
wire [PACKED_MASK_WIDTH - 1:0] s9;
kv_dff_bwe #(
    .BYTES(PACKED_MASK_WIDTH)
) u_segbuf_packed_data (
    .clk(vpu_vlsu_clk),
    .bwe(s9),
    .d(s2),
    .q(s8)
);
assign segbuf_packed_rdata = s8[DLEN - 1:0];
assign s9 = {PACKED_MASK_WIDTH{s3}} & segbuf_packed_data_bwe | {PACKED_MASK_WIDTH{s0}};
assign s2 = s0 ? s1 : segbuf_packed_wdata;
assign s3 = segbuf_packed_data_wvalid & segbuf_packed_data_wready;
assign segbuf_packed_data_wready = ~segbuf_packed_occupied | s5;
assign s6 = s4 | s5 | segbuf_packed_data_kill;
assign s4 = s3 & segbuf_packed_data_wlast;
assign s5 = segbuf_packed_buf_clr & segbuf_packed_data_rlast;
assign s7 = segbuf_packed_data_kill ? 1'b0 : s4;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        segbuf_packed_occupied <= 1'b0;
    end
    else if (s6) begin
        segbuf_packed_occupied <= s7;
    end
end

generate
    if (SEG_DATA_WIDTH > DLEN) begin:gen_segbuf_packed_rdata
        assign s0 = (SEG_DATA_WIDTH == DLEN) ? 1'b0 : segbuf_packed_buf_shift & ~segbuf_packed_data_rlast;
        assign s1 = {{DLEN{1'b0}},s8[PACKED_DATA_WIDTH - 1:DLEN]};
    end
    else begin:gen_segbuf_packed_rdata_zext
        assign s0 = 1'b0;
        assign s1 = {PACKED_DATA_WIDTH{1'b0}};
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

