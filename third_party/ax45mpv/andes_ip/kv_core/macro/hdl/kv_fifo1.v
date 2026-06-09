// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_fifo1 (
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
parameter WIDTH = 8;
input clk;
input reset_n;
input flush;
input [WIDTH - 1:0] wdata;
input wvalid;
output wready;
output [WIDTH - 1:0] rdata;
output rvalid;
input rready;





// 1de75a25 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
wire s1;
wire s2;
wire s3;
wire s4;
reg [WIDTH - 1:0] s5;
assign s1 = wvalid & ~s0;
assign s2 = (rready & s0) | flush;
assign s4 = (s0 | s1) & ~s2;
assign s3 = s1 | s2;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s0 <= 1'b0;
    end
    else if (s3) begin
        s0 <= s4;
    end
end

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        s5 <= {WIDTH{1'b0}};
    end
    else if (s1) begin
        s5 <= wdata;
    end
end

assign wready = ~s0;
assign rvalid = s0;
assign rdata = s5;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

