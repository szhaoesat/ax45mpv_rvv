// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_fifo (
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
input clk;
input reset_n;
input flush;
input [WIDTH - 1:0] wdata;
input wvalid;
output wready;
output [WIDTH - 1:0] rdata;
output rvalid;
input rready;





// 08c6cf1c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


generate
    if (DEPTH == 1) begin:gen_depth1
        kv_fifo1 #(
            .WIDTH(WIDTH)
        ) u_fifo (
            .clk(clk),
            .reset_n(reset_n),
            .flush(flush),
            .wdata(wdata),
            .wvalid(wvalid),
            .wready(wready),
            .rdata(rdata),
            .rvalid(rvalid),
            .rready(rready)
        );
    end
    else begin:gen_depth_gt1
        kv_fifon #(
            .DEPTH(DEPTH),
            .WIDTH(WIDTH),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_fifo (
            .clk(clk),
            .reset_n(reset_n),
            .flush(flush),
            .wdata(wdata),
            .wvalid(wvalid),
            .wready(wready),
            .rdata(rdata),
            .rvalid(rvalid),
            .rready(rready)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

