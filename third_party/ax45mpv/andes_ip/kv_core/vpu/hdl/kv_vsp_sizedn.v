// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_sizedn (
    src_eew,
    dst_eew,
    din,
    dout
);
parameter IW = 512;
parameter OW = 512;
parameter EW = 8;
localparam IW_1EW = IW / (1 * EW);
localparam IW_2EW = IW / (2 * EW);
localparam IW_4EW = IW / (4 * EW);
localparam IW_8EW = IW / (8 * EW);
input [1:0] src_eew;
input [1:0] dst_eew;
input [IW - 1:0] din;
output [OW - 1:0] dout;





// 7338f100 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0 = (src_eew == 2'b00);
wire s1 = (src_eew == 2'b01);
wire s2 = (src_eew == 2'b10);
wire s3 = (src_eew == 2'b11);
wire s4 = (dst_eew == 2'b00);
wire s5 = (dst_eew == 2'b01);
wire s6 = (dst_eew == 2'b10);
wire s7 = (dst_eew == 2'b11);
wire s8 = s3 & s7;
wire s9 = s3 & s6;
wire s10 = s3 & s5;
wire s11 = s3 & s4;
wire s12 = s2 & s6;
wire s13 = s2 & s5;
wire s14 = s2 & s4;
wire s15 = s1 & s5;
wire s16 = s1 & s4;
wire s17 = s0 & s4;
wire [(IW / 2) - 1:0] s18;
wire [(IW / 4) - 1:0] s19;
wire [(IW / 8) - 1:0] s20;
wire [(IW / 2) - 1:0] s21;
wire [(IW / 4) - 1:0] s22;
wire [(IW / 2) - 1:0] s23;
wire [OW:0] s24;
genvar i;
generate
    for (i = 0; i < IW_8EW; i = i + 1) begin:gen_din_8ew
        assign s18[(i * 4 * EW) +:(4 * EW)] = din[(i * 8 * EW) +:(4 * EW)];
        assign s19[(i * 2 * EW) +:(2 * EW)] = din[(i * 8 * EW) +:(2 * EW)];
        assign s20[(i * 1 * EW) +:(1 * EW)] = din[(i * 8 * EW) +:(1 * EW)];
    end
    for (i = 0; i < IW_4EW; i = i + 1) begin:gen_din_4ew
        assign s21[(i * 2 * EW) +:(2 * EW)] = din[(i * 4 * EW) +:(2 * EW)];
        assign s22[(i * 1 * EW) +:(1 * EW)] = din[(i * 4 * EW) +:(1 * EW)];
    end
    for (i = 0; i < IW_2EW; i = i + 1) begin:gen_din_2ew
        assign s23[(i * 1 * EW) +:(1 * EW)] = din[(i * 2 * EW) +:(1 * EW)];
    end
    assign s24 = ({(OW + 1){s8 | s12 | s15 | s17}} & {{(OW + 1 - (IW / 1)){1'b0}},din}) | ({(OW + 1){s9}} & {{(OW + 1 - (IW / 2)){1'b0}},s18}) | ({(OW + 1){s10}} & {{(OW + 1 - (IW / 4)){1'b0}},s19}) | ({(OW + 1){s11}} & {{(OW + 1 - (IW / 8)){1'b0}},s20}) | ({(OW + 1){s13}} & {{(OW + 1 - (IW / 2)){1'b0}},s21}) | ({(OW + 1){s14}} & {{(OW + 1 - (IW / 4)){1'b0}},s22}) | ({(OW + 1){s16}} & {{(OW + 1 - (IW / 2)){1'b0}},s23});
endgenerate
assign dout = s24[OW - 1:0];
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

