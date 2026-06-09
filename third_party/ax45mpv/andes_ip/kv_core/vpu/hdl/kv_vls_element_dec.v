// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_element_dec (
    en,
    eew,
    vstart_element,
    vl_element,
    vstart_dlen,
    vl_dlen,
    vrf_beat
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
parameter ELE_CNT_WIDTH = 6;
parameter ELE_DLEN_WIDTH = $clog2(DLEN / 8);
parameter VRF_LW = 3;
parameter SEW8_DLEN_WIDTH = $clog2(DLEN / 8);
parameter SEW16_DLEN_WIDTH = $clog2(DLEN / 16);
parameter SEW32_DLEN_WIDTH = $clog2(DLEN / 32);
parameter SEW64_DLEN_WIDTH = $clog2(DLEN / 64);
input en;
input [2:0] eew;
input [ELE_CNT_WIDTH - 1:0] vstart_element;
input [ELE_CNT_WIDTH - 1:0] vl_element;
output [VRF_LW - 1:0] vstart_dlen;
output [VRF_LW - 1:0] vl_dlen;
output [VRF_LW - 1:0] vrf_beat;





// 21fd4ee0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire eew8;
wire eew16;
wire eew32;
wire eew64;
wire [VRF_LW - 1:0] vstart_eew8_dlen_num;
wire [VRF_LW - 1:0] vstart_eew16_dlen_num;
wire [VRF_LW - 1:0] vstart_eew32_dlen_num;
wire [VRF_LW - 1:0] vstart_eew64_dlen_num;
wire [VRF_LW - 1:0] vl_eew8_dlen_num;
wire [VRF_LW - 1:0] vl_eew16_dlen_num;
wire [VRF_LW - 1:0] vl_eew32_dlen_num;
wire [VRF_LW - 1:0] vl_eew64_dlen_num;
assign eew8 = (eew[1:0] == 2'b00);
assign eew16 = (eew[1:0] == 2'b01);
assign eew32 = (eew[1:0] == 2'b10);
assign eew64 = (eew[1:0] == 2'b11) && (ELEN == 64);
assign vstart_eew8_dlen_num = vstart_element[SEW8_DLEN_WIDTH +:VRF_LW];
assign vstart_eew16_dlen_num = vstart_element[SEW16_DLEN_WIDTH +:VRF_LW];
assign vstart_eew32_dlen_num = vstart_element[SEW32_DLEN_WIDTH +:VRF_LW];
assign vstart_eew64_dlen_num = vstart_element[SEW64_DLEN_WIDTH +:VRF_LW];
assign vl_eew8_dlen_num = vl_element[SEW8_DLEN_WIDTH +:VRF_LW];
assign vl_eew16_dlen_num = vl_element[SEW16_DLEN_WIDTH +:VRF_LW];
assign vl_eew32_dlen_num = vl_element[SEW32_DLEN_WIDTH +:VRF_LW];
assign vl_eew64_dlen_num = vl_element[SEW64_DLEN_WIDTH +:VRF_LW];
assign vstart_dlen = ({VRF_LW{eew8}} & vstart_eew8_dlen_num) | ({VRF_LW{eew16}} & vstart_eew16_dlen_num) | ({VRF_LW{eew32}} & vstart_eew32_dlen_num) | ({VRF_LW{eew64}} & vstart_eew64_dlen_num);
assign vl_dlen = ({VRF_LW{eew8}} & vl_eew8_dlen_num) | ({VRF_LW{eew16}} & vl_eew16_dlen_num) | ({VRF_LW{eew32}} & vl_eew32_dlen_num) | ({VRF_LW{eew64}} & vl_eew64_dlen_num);
assign vrf_beat = vl_dlen;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

