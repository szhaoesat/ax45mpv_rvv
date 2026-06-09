// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_unpacked_buf (
    vpu_vlsu_clk,
    vpu_reset_n,
    segbuf_unpacked_data_wvalid,
    segbuf_unpacked_data_wready,
    segbuf_unpacked_wdata,
    segbuf_unpacked_data_rvalid,
    segbuf_unpacked_data_rready,
    segbuf_unpacked_rdata
);
parameter SEG_DATA_WIDTH = 256;
parameter SEG_MASK_WIDTH = 32;
input vpu_vlsu_clk;
input vpu_reset_n;
input segbuf_unpacked_data_wvalid;
output segbuf_unpacked_data_wready;
input [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_wdata;
input segbuf_unpacked_data_rvalid;
output segbuf_unpacked_data_rready;
output [SEG_DATA_WIDTH - 1:0] segbuf_unpacked_rdata;





// d41dcd5c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


kv_dff_gen #(
    .W(SEG_DATA_WIDTH)
) u_segbuf_unpacked_data (
    .clk(vpu_vlsu_clk),
    .en(segbuf_unpacked_data_wvalid),
    .d(segbuf_unpacked_wdata),
    .q(segbuf_unpacked_rdata)
);
assign segbuf_unpacked_data_wready = 1'b1;
assign segbuf_unpacked_data_rready = 1'b1;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

