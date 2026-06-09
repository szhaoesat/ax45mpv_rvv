// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_plru (
    clk,
    reset_n,
    cmt_valid,
    cmt_ptr,
    victim_ptr
);
parameter N = 8;
localparam DEPTH = $clog2(N);
input clk;
input reset_n;
input cmt_valid;
input [N - 1:0] cmt_ptr;
output [N - 1:0] victim_ptr;





// 824c6bb8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [2 * (N - 1):0] en;
wire [2 * (N - 1):0] sel;
reg [N - 2:0] rvalue;
wire rvalue_en;
wire [N - 2:0] rvalue_nx;
wire [N - 2:0] wvalue;
wire [N - 2:0] wen;
assign sel[0] = 1'b1;
assign en[N - 1 +:N] = {N{cmt_valid}} & cmt_ptr;
assign victim_ptr = sel[N - 1 +:N];
assign rvalue_en = |wen;
assign rvalue_nx = rvalue & ~wen | wvalue & wen;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        rvalue <= {N - 1{1'b0}};
    end
    else if (rvalue_en) begin
        rvalue <= rvalue_nx;
    end
end

generate
    genvar i;
    for (i = 0; i < N - 1; i = i + 1) begin:gen_ent
        kv_plru_ent u_ent(
            .clk(clk),
            .reset_n(reset_n),
            .p_en(en[i]),
            .c0_en(en[i * 2 + 1]),
            .c1_en(en[i * 2 + 2]),
            .p_sel(sel[i]),
            .c0_sel(sel[i * 2 + 1]),
            .c1_sel(sel[i * 2 + 2]),
            .rvalue(rvalue[i]),
            .wvalue(wvalue[i]),
            .wen(wen[i])
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

