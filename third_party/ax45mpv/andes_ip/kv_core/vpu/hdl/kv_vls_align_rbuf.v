// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_align_rbuf (
    vpu_vlsu_clk,
    vpu_reset_n,
    wvalid,
    wready,
    wdata,
    wmask_cnt,
    wbuf_ptr,
    whvm,
    rvalid,
    rready,
    rdata,
    rmask_cnt,
    rbuf_ptr,
    rhvm
);
parameter DW = 1024;
parameter MW = 128;
parameter MASK_CNT = 7;
parameter BUF_DEPTH = 8;
input vpu_vlsu_clk;
input vpu_reset_n;
input wvalid;
output wready;
input [DW - 1:0] wdata;
input [MASK_CNT - 1:0] wmask_cnt;
input [BUF_DEPTH - 1:0] wbuf_ptr;
input whvm;
output rvalid;
input rready;
output [DW - 1:0] rdata;
output [MASK_CNT - 1:0] rmask_cnt;
output [BUF_DEPTH - 1:0] rbuf_ptr;
output rhvm;





// 9fec22ce rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
reg s6;
wire s7;
wire [MW - 1:0] s8;
reg [MASK_CNT - 1:0] rmask_cnt;
reg [BUF_DEPTH - 1:0] rbuf_ptr;
reg rhvm;
kv_dff_bwe #(
    .BYTES(MW)
) u_data_buf (
    .clk(vpu_vlsu_clk),
    .bwe(s8),
    .d(wdata),
    .q(rdata)
);
assign s8 = {MW{s0}};
assign s0 = wvalid & wready;
assign s1 = rvalid & rready;
assign rvalid = s6;
assign wready = ~s6 | (s6 & s1);
assign s2 = s0;
assign s3 = s1 & ~s2;
assign s5 = s2;
assign s7 = s0 ? whvm : 1'b0;
assign s4 = s2 | s3;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s6 <= 1'b0;
        rhvm <= 1'b0;
    end
    else if (s4) begin
        s6 <= s5;
        rhvm <= s7;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        rmask_cnt <= {MASK_CNT{1'b0}};
        rbuf_ptr <= {BUF_DEPTH{1'b0}};
    end
    else if (s0) begin
        rmask_cnt <= wmask_cnt;
        rbuf_ptr <= wbuf_ptr;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

