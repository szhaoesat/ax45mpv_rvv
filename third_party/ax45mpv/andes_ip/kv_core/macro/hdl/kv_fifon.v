// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_fifon (
    clk,
    reset_n,
    flush,
    wdata,
    wvalid,
    wready,
    rdata,
    rvalid,
    rready
);
parameter DEPTH = 4;
parameter WIDTH = 8;
parameter RAR_SUPPORT = 0;
localparam MEM_DEPTH = RAR_SUPPORT ? 0 : DEPTH;
localparam MEM_DEPTH_RAR = RAR_SUPPORT ? DEPTH : 0;
input clk;
input reset_n;
input flush;
input [WIDTH - 1:0] wdata;
input wvalid;
output wready;
output [WIDTH - 1:0] rdata;
output rvalid;
input rready;





// 105bc174 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [DEPTH - 1:0] s0;
wire [DEPTH - 1:0] s1;
wire s2;
reg [DEPTH - 1:0] s3;
reg [DEPTH - 1:0] s4;
wire [DEPTH - 1:0] s5;
wire [DEPTH - 1:0] s6;
wire s7;
wire s8;
reg [WIDTH * DEPTH - 1:0] s9;
wire [DEPTH - 1:0] s10;
wire s11;
wire s12;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= {DEPTH{1'b0}};
    end
    else if (s2) begin
        s0 <= s1;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s4 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s7) begin
        s4 <= s6;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s3 <= {{(DEPTH - 1){1'b0}},1'b1};
    end
    else if (s8) begin
        s3 <= s5;
    end
end

assign s11 = rvalid & rready;
assign s12 = wvalid & wready;
assign s2 = flush | (s11 ^ s12);
assign s1 = flush ? {DEPTH{1'b0}} : s11 ? {1'b0,s0[DEPTH - 1:1]} : {s0[DEPTH - 2:0],1'b1};
assign s7 = s11 | flush;
assign s8 = s12 | flush;
assign s6 = flush ? {{(DEPTH - 1){1'b0}},1'b1} : {s4[DEPTH - 2:0],s4[DEPTH - 1]};
assign s5 = flush ? {{(DEPTH - 1){1'b0}},1'b1} : {s3[DEPTH - 2:0],s3[DEPTH - 1]};
assign wready = ~s0[DEPTH - 1];
assign rvalid = s0[0];
assign s10 = s3 & {DEPTH{s12}};
generate
    genvar i;
    for (i = 0; i < MEM_DEPTH; i = i + 1) begin:gen_mem
        always @(posedge clk) begin
            if (s10[i]) begin
                s9[i * WIDTH +:WIDTH] <= wdata;
            end
        end

    end
endgenerate
generate
    genvar j;
    for (j = 0; j < MEM_DEPTH_RAR; j = j + 1) begin:gen_mem_rar
        always @(posedge clk or negedge reset_n) begin
            if (!reset_n) begin
                s9[j * WIDTH +:WIDTH] <= {WIDTH{1'b0}};
            end
            else if (s10[j]) begin
                s9[j * WIDTH +:WIDTH] <= wdata;
            end
        end

    end
endgenerate
kv_mux_onehot #(
    .N(DEPTH),
    .W(WIDTH)
) u_rdata_sel (
    .out(rdata),
    .sel(s4),
    .in(s9)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

