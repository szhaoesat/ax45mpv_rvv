// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

`include "config.inc"

module ace (
	core_clk,
        core_reset_n,
	ace_cmd_valid,
	ace_cmd_inst,
	ace_cmd_pc,
	ace_cmd_rs1,
	ace_cmd_rs2,
	ace_cmd_rs3,
	ace_cmd_rs4,
`ifdef NDS_IO_ACE_STREAM_PORT
        ace_cmd_beat,
        ace_cmd_mhartid,
        ace_cmd_umisc_ctl,
        ace_cmd_priv,
        ace_cmd_vl,
        ace_cmd_vtype,
	`ifdef NDS_IO_ACE_ASP
	ace_vpu_sp_store_sent,
	`endif
`endif
	ace_cmd_ready,
	ace_error,
	ace_standby_ready,
	ace_xrf_rd1_ready,
	ace_xrf_rd1_valid,
	ace_xrf_rd1_index,
	ace_xrf_rd1_data,
	ace_xrf_rd1_status,
	ace_xrf_rd2_ready,
	ace_xrf_rd2_valid,
	ace_xrf_rd2_index,
	ace_xrf_rd2_data,
	ace_xrf_rd2_status,
	ace_sync_req,
	ace_sync_type,
	ace_sync_ack,
	ace_sync_ack_status,
	ace_interrupt
);

parameter XLEN	= 32;
parameter VALEN	= 32;

input				core_clk;
input				core_reset_n;
input				ace_cmd_valid;
input	[31:7]			ace_cmd_inst;
input	[VALEN-1:0]		ace_cmd_pc;
input	[XLEN-1:0]		ace_cmd_rs1;
input	[XLEN-1:0]		ace_cmd_rs2;
input	[XLEN-1:0]		ace_cmd_rs3;
input	[XLEN-1:0]		ace_cmd_rs4;

`ifdef NDS_IO_ACE_STREAM_PORT
input	[31:0]			ace_cmd_beat;
input	[XLEN-1:0]		ace_cmd_mhartid;
input	[XLEN-1:0]		ace_cmd_umisc_ctl;
input	[1:0]			ace_cmd_priv;
input	[XLEN-1:0]		ace_cmd_vl;
input	[XLEN-1:0]		ace_cmd_vtype;
	`ifdef NDS_IO_ACE_ASP
output				ace_vpu_sp_store_sent;
	`endif
`endif

output				ace_cmd_ready;

output				ace_error;
output				ace_standby_ready;

input				ace_xrf_rd1_ready;
output				ace_xrf_rd1_valid;
output	[4:0]			ace_xrf_rd1_index;
output	[XLEN-1:0]		ace_xrf_rd1_data;
output				ace_xrf_rd1_status;

input				ace_xrf_rd2_ready;
output				ace_xrf_rd2_valid;
output	[4:0]			ace_xrf_rd2_index;
output	[XLEN-1:0]		ace_xrf_rd2_data;
output				ace_xrf_rd2_status;

input                           ace_interrupt;
output                          ace_sync_ack;
output                          ace_sync_ack_status;
input                           ace_sync_req;
input                    [31:0] ace_sync_type;





// 6b104580 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign ace_sync_ack             = 1'b0;
assign ace_sync_ack_status      = 1'b0;

assign ace_cmd_ready		= 1'b0;

assign ace_error		= 1'b0;

assign ace_standby_ready	= 1'b1;

assign ace_xrf_rd1_valid	= 1'b0;
assign ace_xrf_rd1_index	= 5'b0;
assign ace_xrf_rd1_data		= {XLEN{1'b0}};
assign ace_xrf_rd1_status	= 1'b0;

assign ace_xrf_rd2_valid	= 1'b0;
assign ace_xrf_rd2_index	= 5'b0;
assign ace_xrf_rd2_data		= {XLEN{1'b0}};
assign ace_xrf_rd2_status	= 1'b0;

`ifdef NDS_IO_ACE_STREAM_PORT
	`ifdef NDS_IO_ACE_ASP
assign ace_vpu_sp_store_sent       = 1'b0;
	`endif
`endif


wire nds_unused_core_clk = core_clk;
wire nds_unused_core_reset_n = core_reset_n;
wire nds_unused_ace_cmd_valid = ace_cmd_valid;
wire [31:7] nds_unused_ace_cmd_inst = ace_cmd_inst;
wire [VALEN-1:0] nds_unused_ace_cmd_pc = ace_cmd_pc;
wire [XLEN-1:0] nds_unused_ace_cmd_rs1 = ace_cmd_rs1;
wire [XLEN-1:0] nds_unused_ace_cmd_rs2 = ace_cmd_rs2;
wire [XLEN-1:0] nds_unused_ace_cmd_rs3 = ace_cmd_rs3;
wire [XLEN-1:0] nds_unused_ace_cmd_rs4 = ace_cmd_rs4;
wire nds_unused_ace_xrf_rd1_ready = ace_xrf_rd1_ready;
wire nds_unused_ace_xrf_rd2_ready = ace_xrf_rd2_ready;
wire nds_unused_ace_interrupt = ace_interrupt;
wire nds_unused_ace_sync_req = ace_sync_req;
wire [31:0] nds_unused_ace_sync_type = ace_sync_type;
`ifdef NDS_IO_ACE_STREAM_PORT

wire [31:0] nds_unused_ace_cmd_beat = ace_cmd_beat;
wire [XLEN-1:0] nds_unused_ace_cmd_mhartid = ace_cmd_mhartid;
wire [1:0] nds_unused_ace_cmd_priv = ace_cmd_priv;
wire [XLEN-1:0] nds_unused_ace_cmd_vl = ace_cmd_vl;
wire [XLEN-1:0] nds_unused_ace_cmd_vtype = ace_cmd_vtype;
`endif
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule
