// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv_wb (
    vpu_vdiv_clk,
    vpu_reset_n,
    e1_vd_valid,
    e1_vd_ready,
    e1_vd_data,
    e1_vd_mask,
    vdiv_vd_wvalid,
    vdiv_vd_wready,
    vdiv_vd_wdata,
    vdiv_vd_wmask,
    vdiv_vd_wlast
);
parameter DLEN = 512;
parameter DEPTH = 4;
localparam MASK_LEN = DLEN / 8;
localparam VD_FIFO_WIDTH = DLEN + MASK_LEN;
input vpu_vdiv_clk;
input vpu_reset_n;
input e1_vd_valid;
output e1_vd_ready;
input [DLEN - 1:0] e1_vd_data;
input [MASK_LEN - 1:0] e1_vd_mask;
output vdiv_vd_wvalid;
input vdiv_vd_wready;
output [DLEN - 1:0] vdiv_vd_wdata;
output [MASK_LEN - 1:0] vdiv_vd_wmask;
input vdiv_vd_wlast;





// 7ade7d82 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VD_FIFO_WIDTH - 1:0] s0;
wire [VD_FIFO_WIDTH - 1:0] s1;
assign s0 = {e1_vd_data,e1_vd_mask};
assign {vdiv_vd_wdata,vdiv_vd_wmask} = s1;
kv_fifo #(
    .DEPTH(DEPTH),
    .WIDTH(VD_FIFO_WIDTH)
) u_wb_fifo (
    .clk(vpu_vdiv_clk),
    .reset_n(vpu_reset_n),
    .flush(1'b0),
    .wvalid(e1_vd_valid),
    .wdata(s0),
    .wready(e1_vd_ready),
    .rvalid(vdiv_vd_wvalid),
    .rdata(s1),
    .rready(vdiv_vd_wready)
);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

