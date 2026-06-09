// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_eb_bypass (
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





// 6156d493 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


genvar i;
generate
    for (i = 0; i < BYTES; i = i + 1) begin:gen_buf_byte
        wire [8:0] din;
        wire [8:0] dout;
        wire i_valid = wvalid[i] & ~flush;
        wire o_ready = rready[i] | flush;
        assign din = {wmask[i],wdata[i * 8 +:8]};
        assign {rmask[i],rdata[i * 8 +:8]} = dout;
        kv_eb_bypass #(
            .DW(9),
            .RAR_SUPPORT(RAR_SUPPORT)
        ) u_mask_buf (
            .clk(clk),
            .resetn(reset_n),
            .i_valid(i_valid),
            .i_ready(wready[i]),
            .din(din),
            .o_valid(rvalid[i]),
            .o_ready(o_ready),
            .dout(dout)
        );
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

