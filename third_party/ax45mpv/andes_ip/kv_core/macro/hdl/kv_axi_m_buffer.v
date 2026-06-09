// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0


module kv_axi_m_buffer (
    	  us_aclk,
    	  us_aresetn,
    	  ds_aclk_en,
    	  ds_aclk,
    	  ds_aresetn,
    	  us_araddr,
    	  us_arburst,
    	  us_arcache,
    	  us_arid,
    	  us_arlen,
    	  us_arlock,
    	  us_arprot,
    	  us_arready,
    	  us_arsize,
    	  us_arvalid,
    	  us_awaddr,
    	  us_awburst,
    	  us_awcache,
    	  us_awid,
    	  us_awlen,
    	  us_awlock,
    	  us_awprot,
    	  us_awready,
    	  us_awsize,
    	  us_awvalid,
    	  us_bid,
    	  us_bready,
    	  us_bresp,
    	  us_bvalid,
    	  us_rdata,
    	  us_rid,
    	  us_rlast,
    	  us_rready,
    	  us_rresp,
    	  us_rvalid,
    	  us_wdata,
    	  us_wlast,
    	  us_wready,
    	  us_wstrb,
    	  us_wvalid,
    	  ds_araddr,
    	  ds_arburst,
    	  ds_arcache,
    	  ds_arid,
    	  ds_arlen,
    	  ds_arlock,
    	  ds_arprot,
    	  ds_arsize,
    	  ds_arvalid,
    	  ds_arready,
    	  ds_awaddr,
    	  ds_awburst,
    	  ds_awcache,
    	  ds_awid,
    	  ds_awlen,
    	  ds_awlock,
    	  ds_awprot,
    	  ds_awsize,
    	  ds_awvalid,
    	  ds_awready,
    	  ds_bid,
    	  ds_bready,
    	  ds_bresp,
    	  ds_bvalid,
    	  ds_rdata,
    	  ds_rid,
    	  ds_rlast,
    	  ds_rready,
    	  ds_rresp,
    	  ds_rvalid,
    	  ds_wdata,
    	  ds_wlast,
    	  ds_wready,
    	  ds_wstrb,
    	  ds_wvalid
);

parameter   AW = 32;
parameter   DW = 64;
parameter   IDW = 5;
parameter   ASYNC = 0;
parameter   REG   = 1;
parameter   SYNC_STAGE  = 3;

localparam  ASYNC_DEPTH = 8;

input                              us_aclk;
input                              us_aresetn;
input                              ds_aclk_en;
input                              ds_aclk;
input                              ds_aresetn;

input                     [AW-1:0] us_araddr;
input                        [1:0] us_arburst;
input                        [3:0] us_arcache;
input                    [IDW-1:0] us_arid;
input                        [7:0] us_arlen;
input                              us_arlock;
input                        [2:0] us_arprot;
output                             us_arready;
input                        [2:0] us_arsize;
input                              us_arvalid;

input                     [AW-1:0] us_awaddr;
input                        [1:0] us_awburst;
input                        [3:0] us_awcache;
input                    [IDW-1:0] us_awid;
input                        [7:0] us_awlen;
input                              us_awlock;
input                        [2:0] us_awprot;
output                             us_awready;
input                        [2:0] us_awsize;
input                              us_awvalid;

output                   [IDW-1:0] us_bid;
input                              us_bready;
output                       [1:0] us_bresp;
output                             us_bvalid;

output                    [DW-1:0] us_rdata;
output                   [IDW-1:0] us_rid;
output                             us_rlast;
input                              us_rready;
output                       [1:0] us_rresp;
output                             us_rvalid;

input                     [DW-1:0] us_wdata;
input                              us_wlast;
output                             us_wready;
input                   [DW/8-1:0] us_wstrb;
input                              us_wvalid;

output                    [AW-1:0] ds_araddr;
output                       [1:0] ds_arburst;
output                       [3:0] ds_arcache;
output                   [IDW-1:0] ds_arid;
output                       [7:0] ds_arlen;
output                             ds_arlock;
output                       [2:0] ds_arprot;
output                       [2:0] ds_arsize;
output                             ds_arvalid;
input                              ds_arready;

output                    [AW-1:0] ds_awaddr;
output                       [1:0] ds_awburst;
output                       [3:0] ds_awcache;
output                   [IDW-1:0] ds_awid;
output                       [7:0] ds_awlen;
output                             ds_awlock;
output                       [2:0] ds_awprot;
output                       [2:0] ds_awsize;
output                             ds_awvalid;
input                              ds_awready;

input                    [IDW-1:0] ds_bid;
output                             ds_bready;
input                        [1:0] ds_bresp;
input                              ds_bvalid;
input                     [DW-1:0] ds_rdata;
input                    [IDW-1:0] ds_rid;
input                              ds_rlast;
output                             ds_rready;
input                        [1:0] ds_rresp;
input                              ds_rvalid;

output                    [DW-1:0] ds_wdata;
output                             ds_wlast;
input                              ds_wready;
output                  [DW/8-1:0] ds_wstrb;
output                             ds_wvalid;





// 174051e5 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

generate
if (!ASYNC && !REG) begin : gen_bypass
    assign ds_araddr  = us_araddr ;
    assign ds_arburst = us_arburst;
    assign ds_arcache = us_arcache;
    assign ds_arid    = us_arid   ;
    assign ds_arlen   = us_arlen  ;
    assign ds_arlock  = us_arlock ;
    assign ds_arprot  = us_arprot ;
    assign ds_arsize  = us_arsize ;
    assign ds_arvalid = us_arvalid;
    assign us_arready = ds_arready;

    assign ds_awaddr  = us_awaddr ;
    assign ds_awburst = us_awburst;
    assign ds_awcache = us_awcache;
    assign ds_awid    = us_awid   ;
    assign ds_awlen   = us_awlen  ;
    assign ds_awlock  = us_awlock ;
    assign ds_awprot  = us_awprot ;
    assign ds_awsize  = us_awsize ;
    assign ds_awvalid = us_awvalid;
    assign us_awready = ds_awready;

    assign us_bid     = ds_bid    ;
    assign us_bresp   = ds_bresp  ;
    assign us_bvalid  = ds_bvalid ;
    assign ds_bready  = us_bready ;

    assign us_rdata   = ds_rdata  ;
    assign us_rid     = ds_rid    ;
    assign us_rlast   = ds_rlast  ;
    assign us_rresp   = ds_rresp  ;
    assign us_rvalid  = ds_rvalid ;
    assign ds_rready  = us_rready ;

    assign ds_wdata   = us_wdata  ;
    assign ds_wlast   = us_wlast  ;
    assign ds_wstrb   = us_wstrb  ;
    assign ds_wvalid  = us_wvalid ;
    assign us_wready  = ds_wready ;
end
else if (!ASYNC && REG) begin : gen_sync
    kv_eb_full_o #(
        .DW(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) ar_buffer (
        .clk(us_aclk),
        .resetn(us_aresetn),
        .clk_en(ds_aclk_en),
        .i_valid(us_arvalid),
        .i_ready(us_arready),
        .o_valid(ds_arvalid),
        .o_ready(ds_arready),
        .din( {us_araddr, us_arburst, us_arcache, us_arid, us_arlen, us_arlock, us_arprot, us_arsize}),
        .dout({ds_araddr, ds_arburst, ds_arcache, ds_arid, ds_arlen, ds_arlock, ds_arprot, ds_arsize})
    );

    kv_eb_full_o #(
        .DW(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) aw_buffer (
        .clk(us_aclk),
        .resetn(us_aresetn),
        .clk_en(ds_aclk_en),
        .i_valid(us_awvalid),
        .i_ready(us_awready),
        .o_valid(ds_awvalid),
        .o_ready(ds_awready),
        .din( {us_awaddr, us_awburst, us_awcache, us_awid, us_awlen, us_awlock, us_awprot, us_awsize}),
        .dout({ds_awaddr, ds_awburst, ds_awcache, ds_awid, ds_awlen, ds_awlock, ds_awprot, ds_awsize})
    );

    kv_eb_full_o #(
        .DW(DW + 1 + (DW/8))
    ) w_buffer (
        .clk(us_aclk),
        .resetn(us_aresetn),
        .clk_en(ds_aclk_en),
        .i_valid(us_wvalid),
        .i_ready(us_wready),
        .o_valid(ds_wvalid),
        .o_ready(ds_wready),
        .din( {us_wdata, us_wlast, us_wstrb}),
        .dout({ds_wdata, ds_wlast, ds_wstrb})
    );

    kv_eb_full_i #(
        .DW(DW + IDW + 1 + 2)
    ) r_buffer (
        .clk(us_aclk),
        .resetn(us_aresetn),
        .clk_en(ds_aclk_en),
        .i_valid(ds_rvalid),
        .i_ready(ds_rready),
        .o_valid(us_rvalid),
        .o_ready(us_rready),
        .din( {ds_rdata, ds_rid, ds_rlast, ds_rresp}),
        .dout({us_rdata, us_rid, us_rlast, us_rresp})
    );

    kv_eb_full_i #(
        .DW(IDW + 2)
    ) b_buffer (
        .clk(us_aclk),
        .resetn(us_aresetn),
        .clk_en(ds_aclk_en),
        .i_valid(ds_bvalid),
        .i_ready(ds_bready),
        .o_valid(us_bvalid),
        .o_ready(us_bready),
        .din( {ds_bid, ds_bresp}),
        .dout({us_bid, us_bresp})
    );
    wire nds_unused_wire = ds_aclk | ds_aresetn;
end
else begin : gen_async
    wire            nds_unused_wire = ds_aclk_en;
    wire   [AW-1:0] s0;
    wire      [1:0] s1;
    wire      [3:0] s2;
    wire  [IDW-1:0] s3;
    wire      [7:0] s4;
    wire            s5;
    wire      [2:0] s6;
    wire      [2:0] s7;
    wire            s8;
    wire            s9;
    wire   [AW-1:0] s10;
    wire      [1:0] s11;
    wire      [3:0] s12;
    wire  [IDW-1:0] s13;
    wire      [7:0] s14;
    wire            s15;
    wire      [2:0] s16;
    wire      [2:0] s17;
    wire            s18;
    wire            s19;
    wire  [IDW-1:0] s20;
    wire            s21;
    wire      [1:0] s22;
    wire            s23;
    wire   [DW-1:0] s24;
    wire  [IDW-1:0] s25;
    wire            s26;
    wire            s27;
    wire      [1:0] s28;
    wire            s29;
    wire   [DW-1:0] s30;
    wire            s31;
    wire            s32;
    wire [DW/8-1:0] s33;
    wire            s34;
    kv_async_fifo #(
        .DEPTH(ASYNC_DEPTH),
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) ar_async_fifo (
        .wclk(us_aclk),
        .wreset_n(us_aresetn),
        .wvalid(us_arvalid),
        .wready(us_arready),
        .rclk(ds_aclk),
        .rreset_n(ds_aresetn),
        .rvalid(s8),
        .rready(s9),
        .wdata({us_araddr, us_arburst, us_arcache, us_arid, us_arlen, us_arlock, us_arprot, us_arsize}),
        .rdata({s0, s1, s2, s3, s4, s5, s6, s7})
    );
    kv_eb_full_o #(
        .DW(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) ar_buffer (
        .clk(ds_aclk),
        .resetn(ds_aresetn),
        .clk_en(1'b1),
        .i_valid(s8),
        .i_ready(s9),
        .o_valid(ds_arvalid),
        .o_ready(ds_arready),
        .din( {s0, s1, s2, s3, s4, s5, s6, s7}),
        .dout({ds_araddr, ds_arburst, ds_arcache, ds_arid, ds_arlen, ds_arlock, ds_arprot, ds_arsize})
    );

    kv_async_fifo #(
        .DEPTH(ASYNC_DEPTH),
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) aw_async_fifo (
        .wclk(us_aclk),
        .wreset_n(us_aresetn),
        .wvalid(us_awvalid),
        .wready(us_awready),
        .rclk(ds_aclk),
        .rreset_n(ds_aresetn),
        .rvalid(s18),
        .rready(s19),
        .wdata({us_awaddr, us_awburst, us_awcache, us_awid, us_awlen, us_awlock, us_awprot, us_awsize}),
        .rdata({s10, s11, s12, s13, s14, s15, s16, s17})
    );
    kv_eb_full_o #(
        .DW(AW + 2 + 4 + IDW + 8 + 1 + 3 + 3)
    ) aw_buffer (
        .clk(ds_aclk),
        .resetn(ds_aresetn),
        .clk_en(1'b1),
        .i_valid(s18),
        .i_ready(s19),
        .o_valid(ds_awvalid),
        .o_ready(ds_awready),
        .din( {s10, s11, s12, s13, s14, s15, s16, s17}),
        .dout({ds_awaddr, ds_awburst, ds_awcache, ds_awid, ds_awlen, ds_awlock, ds_awprot, ds_awsize})
    );

    kv_async_fifo #(
        .DEPTH(ASYNC_DEPTH),
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(DW + 1 + (DW/8))
    ) w_async_fifo (
        .wclk(us_aclk),
        .wreset_n(us_aresetn),
        .wvalid(us_wvalid),
        .wready(us_wready),
        .rclk(ds_aclk),
        .rreset_n(ds_aresetn),
        .rvalid(s34),
        .rready(s32),
        .wdata({us_wdata, us_wlast, us_wstrb}),
        .rdata({s30, s31, s33})
    );
    kv_eb_full_o #(
        .DW(DW + 1 + (DW/8))
    ) w_buffer (
        .clk(ds_aclk),
        .resetn(ds_aresetn),
        .clk_en(1'b1),
        .i_valid(s34),
        .i_ready(s32),
        .o_valid(ds_wvalid),
        .o_ready(ds_wready),
        .din( {s30, s31, s33}),
        .dout({ds_wdata, ds_wlast, ds_wstrb})
    );

    kv_async_fifo #(
        .DEPTH(ASYNC_DEPTH),
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(DW + IDW + 1 + 2)
    ) r_async_fifo (
        .wclk(ds_aclk),
        .wreset_n(ds_aresetn),
        .wvalid(s29),
        .wready(s27),
        .rclk(us_aclk),
        .rreset_n(us_aresetn),
        .rvalid(us_rvalid),
        .rready(us_rready),
        .wdata({s24, s25, s26, s28}),
        .rdata({us_rdata, us_rid, us_rlast, us_rresp})
    );
    kv_eb_full_i #(
        .DW(DW + IDW + 1 + 2)
    ) r_buffer (
        .clk(ds_aclk),
        .resetn(ds_aresetn),
        .clk_en(1'b1),
        .i_valid(ds_rvalid),
        .i_ready(ds_rready),
        .o_valid(s29),
        .o_ready(s27),
        .din( {ds_rdata, ds_rid, ds_rlast, ds_rresp}),
        .dout({s24, s25, s26, s28})
    );

    kv_async_fifo #(
        .DEPTH(ASYNC_DEPTH),
        .SYNC_STAGE(SYNC_STAGE),
        .WIDTH(IDW + 2)
    ) b_async_fifo (
        .wclk(ds_aclk),
        .wreset_n(ds_aresetn),
        .wvalid(s23),
        .wready(s21),
        .rclk(us_aclk),
        .rreset_n(us_aresetn),
        .rvalid(us_bvalid),
        .rready(us_bready),
        .wdata({s20, s22}),
        .rdata({us_bid, us_bresp})
    );
    kv_eb_full_i #(
        .DW(IDW + 2)
    ) b_buffer (
        .clk(ds_aclk),
        .resetn(ds_aresetn),
        .clk_en(1'b1),
        .i_valid(ds_bvalid),
        .i_ready(ds_bready),
        .o_valid(s23),
        .o_ready(s21),
        .din( {ds_bid, ds_bresp}),
        .dout({s20, s22})
    );
end
endgenerate








`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

