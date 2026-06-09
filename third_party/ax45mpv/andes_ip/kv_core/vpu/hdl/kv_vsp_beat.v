// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0


module kv_vsp_beat (
		  core_clk,
		  core_reset_n,
		  lx_stall,
		  func,
		  rf_type,
		  sew,
		  vl,
		  offset,
		  beat
);

parameter XLEN = 64;
parameter VLEN = 512;
parameter DW   = 256;

localparam DW_NB_BITS = $clog2(DW/4);
localparam TSIZE_NB_BITS = 15;
localparam BEAT_NB_BITS = TSIZE_NB_BITS - DW_NB_BITS;

input			core_clk;
input			core_reset_n;
input			lx_stall;

input	[5:0]		func;
input	[1:0]		rf_type;
input	[2:0]		sew;
input	[10:0]		vl;
input	[XLEN-1:0]	offset;
output	[31:0]		beat;





// 07f87f85 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

wire vrf;
wire frf;
wire xrf;

wire eew4;
wire eew8;
wire eew16;
wire eew32;
wire eew64;

wire [TSIZE_NB_BITS-1:0] ex_tsize_nb;
wire [TSIZE_NB_BITS-1:0] ex_offset_nb;

wire [TSIZE_NB_BITS-1:0] ex_beat;
wire                     nds_unused_ex_beat_c;
reg  [TSIZE_NB_BITS-1:0] mm_beat;
wire [BEAT_NB_BITS-1:0]  lx_beat_nx;
wire                     nds_unused_lx_beat_nx_c;
reg  [BEAT_NB_BITS-1:0]  lx_beat;

assign vrf = (rf_type == 2'b10);
assign frf = (rf_type == 2'b01);
assign xrf = (rf_type == 2'b00);

assign eew4  = (vrf & (func[3:0] == 4'b1000))
             | (vrf & (func[3:0] == 4'b1001))
             | (xrf & (func[3:0] == 4'b1000))
	     ;
assign eew8  = (vrf & (func[3:0] == 4'b0000))
             | (vrf & (func[3:0] == 4'b1010))
             | (xrf & (func[3:0] == 4'b0000))
	     | (vrf & (func[3:0] == 4'b0111) & (sew == 3'b000))
	     ;
assign eew16 = (vrf & (func[3:0] == 4'b0101))
             | (vrf & (func[3:0] == 4'b1011))
	     | (xrf & (func[3:0] == 4'b0101))
             | (frf & (func[3:0] == 4'b0001))
	     | (vrf & (func[3:0] == 4'b0111) & (sew == 3'b001))
             ;
assign eew32 = (vrf & (func[3:0] == 4'b0110))
	     | (xrf & (func[3:0] == 4'b0110))
             | (frf & (func[3:0] == 4'b0010))
	     | (vrf & (func[3:0] == 4'b0111) & (sew == 3'b010))
	     ;
assign eew64 = (xrf & (func[3:0] == 4'b0111))
             | (frf & (func[3:0] == 4'b0011))
	     | (vrf & (func[3:0] == 4'b0111) & (sew == 3'b011))
	     ;

assign ex_tsize_nb = ({(TSIZE_NB_BITS){eew4  &  vrf}} & {4'b0, vl[10:0]      })
                   | ({(TSIZE_NB_BITS){eew8  &  vrf}} & {3'b0, vl[10:0], 1'b0})
                   | ({(TSIZE_NB_BITS){eew16 &  vrf}} & {2'b0, vl[10:0], 2'b0})
                   | ({(TSIZE_NB_BITS){eew32 &  vrf}} & {1'b0, vl[10:0], 3'b0})
                   | ({(TSIZE_NB_BITS){eew64 &  vrf}} & {      vl[10:0], 4'b0})
		   | ({(TSIZE_NB_BITS){eew4  & ~vrf}} & 15'b1                 )
                   | ({(TSIZE_NB_BITS){eew8  & ~vrf}} & 15'b10                )
                   | ({(TSIZE_NB_BITS){eew16 & ~vrf}} & 15'b100               )
                   | ({(TSIZE_NB_BITS){eew32 & ~vrf}} & 15'b1000              )
                   | ({(TSIZE_NB_BITS){eew64 & ~vrf}} & 15'b10000             )
		   ;
assign ex_offset_nb = (vrf & (vl == 11'b0)) ? {(TSIZE_NB_BITS){1'b0}} :{{(TSIZE_NB_BITS-DW_NB_BITS){1'b0}}, offset[DW_NB_BITS-2:0], 1'b0};
assign {nds_unused_ex_beat_c, ex_beat} = ex_tsize_nb + ex_offset_nb;

always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n) begin
		mm_beat <= {(TSIZE_NB_BITS){1'b0}};
	end
	else if (~lx_stall) begin
		mm_beat <= ex_beat;
	end
end

assign {nds_unused_lx_beat_nx_c, lx_beat_nx} = mm_beat[TSIZE_NB_BITS-1:DW_NB_BITS] + {{(BEAT_NB_BITS-1){1'b0}}, (|mm_beat[DW_NB_BITS-1:0])};

always @(posedge core_clk or negedge core_reset_n) begin
	if (!core_reset_n) begin
		lx_beat <= {(BEAT_NB_BITS){1'b0}};
	end
	else if (~lx_stall) begin
		lx_beat <= lx_beat_nx;
	end
end

assign beat = {{(32-BEAT_NB_BITS){1'b0}}, lx_beat};


`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule
