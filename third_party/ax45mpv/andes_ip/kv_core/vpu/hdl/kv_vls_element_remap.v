// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_element_remap (
    element_num,
    eew_onehot,
    element_num_remap
);
parameter ELE_DLEN_WIDTH = 6;
parameter ELE_CNT_WIDTH = 9;
parameter SEW8_DLEN_WIDTH = 6;
parameter SEW16_DLEN_WIDTH = 5;
parameter SEW32_DLEN_WIDTH = 4;
parameter SEW64_DLEN_WIDTH = 3;
input [ELE_CNT_WIDTH - 1:0] element_num;
input [3:0] eew_onehot;
output [ELE_DLEN_WIDTH - 1:0] element_num_remap;





// 4a3e8fe8 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire s3;
wire [ELE_DLEN_WIDTH - 1:0] s4;
wire [ELE_DLEN_WIDTH - 1:0] s5;
wire [ELE_DLEN_WIDTH - 1:0] s6;
wire [ELE_DLEN_WIDTH - 1:0] s7;
assign s0 = eew_onehot[0];
assign s1 = eew_onehot[1];
assign s2 = eew_onehot[2];
assign s3 = eew_onehot[3];
assign s4 = {element_num[SEW8_DLEN_WIDTH - 1:0]};
assign s5 = {{ELE_DLEN_WIDTH - SEW16_DLEN_WIDTH{1'b0}},element_num[SEW16_DLEN_WIDTH - 1:0]};
assign s6 = {{ELE_DLEN_WIDTH - SEW32_DLEN_WIDTH{1'b0}},element_num[SEW32_DLEN_WIDTH - 1:0]};
assign s7 = {{ELE_DLEN_WIDTH - SEW64_DLEN_WIDTH{1'b0}},element_num[SEW64_DLEN_WIDTH - 1:0]};
assign element_num_remap = ({ELE_DLEN_WIDTH{s0}} & s4) | ({ELE_DLEN_WIDTH{s1}} & s5) | ({ELE_DLEN_WIDTH{s2}} & s6) | ({ELE_DLEN_WIDTH{s3}} & s7);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

