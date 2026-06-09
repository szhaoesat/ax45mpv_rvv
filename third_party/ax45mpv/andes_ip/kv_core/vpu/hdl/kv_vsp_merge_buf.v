// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_merge_buf (
    clk,
    reset_n,
    flush,
    wvalid,
    wready,
    wmask,
    wdata,
    rvalid,
    rready,
    rmask,
    rdata
);
parameter DEPTH = 4;
parameter BYTES = 64;
parameter RAR_SUPPORT = 0;
input clk;
input reset_n;
input flush;
input [(BYTES - 1):0] wvalid;
output [(BYTES - 1):0] wready;
input [(BYTES - 1):0] wmask;
input [((BYTES * 8) - 1):0] wdata;
output [(BYTES - 1):0] rvalid;
input [(BYTES - 1):0] rready;
output [(BYTES - 1):0] rmask;
output [((BYTES * 8) - 1):0] rdata;





// d0b8bdfd rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(BYTES - 1):0] s0[0:DEPTH - 1];
wire [(BYTES - 1):0] s1[0:DEPTH - 1];
wire [(BYTES - 1):0] s2[0:DEPTH - 1];
wire [((BYTES * 8) - 1):0] s3[0:DEPTH - 1];
wire [(BYTES - 1):0] s4[0:DEPTH - 2];
wire [(BYTES - 1):0] s5[0:DEPTH - 2];
wire [(BYTES - 1):0] s6[0:DEPTH - 2];
wire [((BYTES * 8) - 1):0] s7[0:DEPTH - 2];
genvar i;
generate
    for (i = 0; i < (DEPTH - 1); i = i + 1) begin:gen_buf
        if (i == 0) begin:gen_start
            assign s0[i] = wvalid;
            assign s2[i] = wmask;
            assign s3[i] = wdata;
            assign wready = s1[i];
        end
        else begin:gen_body
            assign s0[i] = s4[i - 1];
            assign s2[i] = s6[i - 1];
            assign s3[i] = s7[i - 1];
            assign s5[i - 1] = s1[i];
        end
        kv_vsp_eb_bypass #(
            .BYTES(BYTES),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_bypass_buf (
            .clk(clk),
            .reset_n(reset_n),
            .flush(flush),
            .wvalid(s0[i]),
            .wready(s1[i]),
            .wmask(s2[i]),
            .wdata(s3[i]),
            .rvalid(s4[i]),
            .rready(s5[i]),
            .rmask(s6[i]),
            .rdata(s7[i])
        );
    end
endgenerate
assign s0[DEPTH - 1] = s4[DEPTH - 2];
assign s2[DEPTH - 1] = s6[DEPTH - 2];
assign s3[DEPTH - 1] = s7[DEPTH - 2];
assign s5[DEPTH - 2] = s1[DEPTH - 1];
kv_vsp_eb_pipelined #(
    .BYTES(BYTES),
    .RAR_SUPPORT(RAR_SUPPORT)
) u_pipelined_buf (
    .clk(clk),
    .reset_n(reset_n),
    .flush(flush),
    .wvalid(s0[DEPTH - 1]),
    .wready(s1[DEPTH - 1]),
    .wmask(s2[DEPTH - 1]),
    .wdata(s3[DEPTH - 1]),
    .rvalid(rvalid),
    .rready(rready),
    .rmask(rmask),
    .rdata(rdata)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

