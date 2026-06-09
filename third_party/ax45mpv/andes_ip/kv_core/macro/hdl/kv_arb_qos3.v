// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_arb_qos3 (
    clk,
    resetn,
    en,
    valid,
    qos,
    ready,
    grant
);
parameter Q = 4;
parameter T = 0;
localparam LEVEL = 2 ** Q;
localparam TO = T - 1;
localparam TW = $clog2(T);
input clk;
input resetn;
input en;
input [2:0] valid;
input [(Q * 3) - 1:0] qos;
output [2:0] ready;
output [2:0] grant;





// 941789c8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [Q - 1:0] qos0 = qos[0 * Q +:Q];
wire [Q - 1:0] qos1 = qos[1 * Q +:Q];
wire [Q - 1:0] qos2 = qos[2 * Q +:Q];
wire [2:0] starving;
reg [2:0] granted;
assign grant = valid & ready;
assign ready[0] = (~|starving) & (qos0 == qos1) & (qos0 == qos2) & valid[1] & valid[2] & granted[2] | (~|starving) & (qos0 > qos1) & (qos0 == qos2) & valid[1] & valid[2] & granted[2] | (~|starving) & (qos0 == qos2) & ~valid[1] & valid[2] & granted[2] | (~|starving) & (qos0 == qos1) & (qos0 > qos2) & valid[1] & valid[2] & ~granted[0] | (~|starving) & (qos0 == qos1) & valid[1] & ~valid[2] & ~granted[0] | (~|starving) & (qos0 > qos1) & (qos0 > qos2) & valid[1] & valid[2] | (~|starving) & (qos0 > qos1) & valid[1] & ~valid[2] | (~|starving) & (qos0 > qos2) & ~valid[1] & valid[2] | (~|starving) & ~valid[1] & ~valid[2] | (|starving) & valid[1] & valid[2] & granted[2] | (|starving) & ~valid[1] & valid[2] & granted[2] | (|starving) & valid[1] & ~valid[2] & ~granted[0] | (|starving) & ~valid[1] & ~valid[2];
assign ready[1] = (~|starving) & (qos1 == qos2) & (qos1 == qos0) & valid[2] & valid[0] & granted[0] | (~|starving) & (qos1 > qos2) & (qos1 == qos0) & valid[2] & valid[0] & granted[0] | (~|starving) & (qos1 == qos0) & ~valid[2] & valid[0] & granted[0] | (~|starving) & (qos1 == qos2) & (qos1 > qos0) & valid[2] & valid[0] & ~granted[1] | (~|starving) & (qos1 == qos2) & valid[2] & ~valid[0] & ~granted[1] | (~|starving) & (qos1 > qos2) & (qos1 > qos0) & valid[2] & valid[0] | (~|starving) & (qos1 > qos2) & valid[2] & ~valid[0] | (~|starving) & (qos1 > qos0) & ~valid[2] & valid[0] | (~|starving) & ~valid[2] & ~valid[0] | (|starving) & valid[2] & valid[0] & granted[0] | (|starving) & ~valid[2] & valid[0] & granted[0] | (|starving) & valid[2] & ~valid[0] & ~granted[1] | (|starving) & ~valid[2] & ~valid[0];
assign ready[2] = (~|starving) & (qos2 == qos0) & (qos2 == qos1) & valid[0] & valid[1] & granted[1] | (~|starving) & (qos2 > qos0) & (qos2 == qos1) & valid[0] & valid[1] & granted[1] | (~|starving) & (qos2 == qos1) & ~valid[0] & valid[1] & granted[1] | (~|starving) & (qos2 == qos0) & (qos2 > qos1) & valid[0] & valid[1] & ~granted[2] | (~|starving) & (qos2 == qos0) & valid[0] & ~valid[1] & ~granted[2] | (~|starving) & (qos2 > qos0) & (qos2 > qos1) & valid[0] & valid[1] | (~|starving) & (qos2 > qos0) & valid[0] & ~valid[1] | (~|starving) & (qos2 > qos1) & ~valid[0] & valid[1] | (~|starving) & ~valid[0] & ~valid[1] | (|starving) & valid[0] & valid[1] & granted[1] | (|starving) & ~valid[0] & valid[1] & granted[1] | (|starving) & valid[0] & ~valid[1] & ~granted[2] | (|starving) & ~valid[0] & ~valid[1];
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        granted <= 3'b1;
    end
    else if (en) begin
        granted <= grant;
    end
end

generate
    genvar m;
    if (T == 0) begin:gen_no_timeout
        assign starving = {3{1'b0}};
    end
    else begin:gen_timeout
        wire [31:0] constant_one = 32'b1;
        for (m = 0; m < 3; m = m + 1) begin:gen_timeout_counters
            reg [TW - 1:0] cnt;
            wire cnt_en;
            wire [TW - 1:0] cnt_nx;
            wire [TW - 1:0] cnt_add1;
            wire cnt_inc;
            wire cnt_clr;
            wire nds_unused_c;
            assign {nds_unused_c,cnt_add1} = cnt + constant_one[TW - 1:0];
            assign cnt_nx = cnt_clr ? {TW{1'b0}} : cnt_add1;
            assign cnt_inc = ~starving[m] & valid[m] & ~ready[m];
            assign cnt_clr = (|cnt) & valid[m] & ready[m];
            assign cnt_en = en & (cnt_inc | cnt_clr);
            assign starving[m] = cnt == TO[TW - 1:0];
            always @(posedge clk or negedge resetn) begin
                if (!resetn) begin
                    cnt <= {TW{1'b0}};
                end
                else if (cnt_en) begin
                    cnt <= cnt_nx;
                end
            end

        end
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

