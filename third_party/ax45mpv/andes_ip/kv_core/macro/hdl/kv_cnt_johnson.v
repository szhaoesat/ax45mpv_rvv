// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_cnt_johnson (
    clk,
    rst_n,
    up,
    dn,
    cnt
);
parameter N = 3;
input clk;
input rst_n;
input up;
input dn;
output [N - 1:0] cnt;





// 39dffbcc rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [N - 1:0] cnt;
wire [N - 1:0] s0;
wire s1 = up ^ dn;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= {N{1'b0}};
    end
    else if (s1) begin
        cnt <= s0;
    end
end

assign s0 = dn ? {~cnt[0],cnt[N - 1:1]} : {cnt[N - 2:0],~cnt[N - 1]};
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

