// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_tl_beat_cnt (
    	  clk,
    	  reset_n,
    	  size,
    	  single,
    	  en,
    	  clr,
    	  first,
    	  last
);

parameter TL_SIZE_WIDTH = 3;
parameter TL_MAX_BURST  = 512;
parameter TL_DATA_WIDTH = 128;

localparam MAX_BYTE_LOG2        = (2**TL_SIZE_WIDTH)-1;
localparam DATA_BYTE_WIDTH_LOG2 = $clog2(TL_DATA_WIDTH/8);
localparam BEAT_CNT_WIDTH       = $clog2(TL_MAX_BURST / TL_DATA_WIDTH);

input                      clk;
input                      reset_n;
input  [TL_SIZE_WIDTH-1:0] size;
input                      single;
input                      en;
input                      clr;

output                     first;
output                     last;





// 1561b1cb rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

generate
if (BEAT_CNT_WIDTH != 0) begin : gen_cnt
    wire                  [31:0] const_one = 32'd1;
    wire   [2*MAX_BYTE_LOG2-1:0] byte_len = {MAX_BYTE_LOG2{1'b1}} << size;
    wire    [BEAT_CNT_WIDTH-1:0] beat_len = ~byte_len[DATA_BYTE_WIDTH_LOG2+:BEAT_CNT_WIDTH];
    reg     [BEAT_CNT_WIDTH-1:0] cnt;
    wire    [BEAT_CNT_WIDTH-1:0] cnt_inc;
    wire    [BEAT_CNT_WIDTH-1:0] cnt_nx;
    wire                         cnt_en;
    wire                         cnt_clr;
    wire                         nds_unused_cout;

    assign last    = (beat_len == cnt) | single;
    assign first   = ~|cnt;

    assign cnt_en  =   en | clr;
    assign cnt_clr = last | clr;
    assign cnt_nx  = {BEAT_CNT_WIDTH{~cnt_clr}} & cnt_inc;

    assign {nds_unused_cout, cnt_inc} = cnt + const_one[BEAT_CNT_WIDTH-1:0];

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            cnt <= {BEAT_CNT_WIDTH{1'b0}};
        end
        else if (cnt_en) begin
            cnt <= cnt_nx;
        end
    end
end
else begin : gen_cnt_stub
    assign first = 1'b1;
    assign last  = 1'b1;
    wire nds_unused_size    = |size;
    wire nds_unused_single  = |single;
    wire nds_unused_en      = |en;
    wire nds_unused_clr     = |clr;
    wire nds_unused_clk     = clk;
    wire nds_unused_reset_n = reset_n;
end
endgenerate

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

