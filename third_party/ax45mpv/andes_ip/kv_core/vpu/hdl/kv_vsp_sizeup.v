// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vsp_sizeup (
    src_eew,
    dst_eew,
    sext,
    din,
    dout
);
parameter IW = 512;
parameter OW = 512;
parameter EW = 8;
localparam IW_1EW = IW / EW;
localparam IW_F2EW = IW_1EW * 2;
localparam IW_2EW = IW_1EW / 2;
localparam IW_4EW = IW_1EW / 4;
input [2:0] src_eew;
input [1:0] dst_eew;
input sext;
input [IW - 1:0] din;
output [OW - 1:0] dout;





// 39767d91 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0 = (src_eew == 3'b100);
wire s1 = (src_eew == 3'b000);
wire s2 = (src_eew == 3'b001);
wire s3 = (src_eew == 3'b010);
wire s4 = (src_eew == 3'b011);
wire s5 = (dst_eew == 2'b00);
wire s6 = (dst_eew == 2'b01);
wire s7 = (dst_eew == 2'b10);
wire s8 = (dst_eew == 2'b11);
wire s9 = s0 & s5;
wire s10 = s0 & s6;
wire s11 = s0 & s7;
wire s12 = s0 & s8;
wire s13 = s1 & s5;
wire s14 = s1 & s6;
wire s15 = s1 & s7;
wire s16 = s1 & s8;
wire s17 = s2 & s6;
wire s18 = s2 & s7;
wire s19 = s2 & s8;
wire s20 = s3 & s7;
wire s21 = s3 & s8;
wire s22 = s4 & s8;
genvar i;
generate
    wire [(2 * IW) - 1:0] s23;
    wire [(4 * IW) - 1:0] s24;
    wire [(8 * IW) - 1:0] s25;
    wire [(16 * IW) - 1:0] s26;
    wire [(2 * IW) - 1:0] s27;
    wire [(4 * IW) - 1:0] s28;
    wire [(8 * IW) - 1:0] s29;
    wire [(2 * IW) - 1:0] s30;
    wire [(4 * IW) - 1:0] s31;
    wire [(2 * IW) - 1:0] s32;
    if (EW > 1) begin:gen_w_f2
        for (i = 0; i < IW_F2EW; i = i + 1) begin:gen_din_f2ew
            wire [(EW / 2) - 1:0] s33 = din[(i * (EW / 2)) +:(EW / 2)];
            wire s34 = sext & s33[(EW / 2) - 1];
            assign s23[(i * 1 * EW) +:(1 * EW)] = {{((2 - 1) * (EW / 2)){s34}},s33};
            assign s24[(i * 2 * EW) +:(2 * EW)] = {{((4 - 1) * (EW / 2)){s34}},s33};
            assign s25[(i * 4 * EW) +:(4 * EW)] = {{((8 - 1) * (EW / 2)){s34}},s33};
            assign s26[(i * 8 * EW) +:(8 * EW)] = {{((16 - 1) * (EW / 2)){s34}},s33};
        end
    end
    else begin:gen_wo_f2
        assign s23 = {(2 * IW){1'b0}};
        assign s24 = {(4 * IW){1'b0}};
        assign s25 = {(8 * IW){1'b0}};
        assign s26 = {(16 * IW){1'b0}};
    end
    for (i = 0; i < IW_1EW; i = i + 1) begin:gen_din_1ew
        wire [(1 * EW) - 1:0] s33 = din[(i * 1 * EW) +:(1 * EW)];
        wire s34 = sext & s33[(1 * EW) - 1];
        assign s27[(i * 2 * EW) +:(2 * EW)] = {{((2 - 1) * EW){s34}},s33};
        assign s28[(i * 4 * EW) +:(4 * EW)] = {{((4 - 1) * EW){s34}},s33};
        assign s29[(i * 8 * EW) +:(8 * EW)] = {{((8 - 1) * EW){s34}},s33};
    end
    for (i = 0; i < IW_2EW; i = i + 1) begin:gen_din_2ew
        wire [(2 * EW) - 1:0] s33 = din[(i * 2 * EW) +:(2 * EW)];
        wire s34 = sext & s33[(2 * EW) - 1];
        assign s30[(i * 4 * EW) +:(4 * EW)] = {{((4 - 2) * EW){s34}},s33};
        assign s31[(i * 8 * EW) +:(8 * EW)] = {{((8 - 2) * EW){s34}},s33};
    end
    for (i = 0; i < IW_4EW; i = i + 1) begin:gen_din_4ew
        wire [(4 * EW) - 1:0] s33 = din[(i * 4 * EW) +:(4 * EW)];
        wire s34 = sext & s33[(4 * EW) - 1];
        assign s32[(i * 8 * EW) +:(8 * EW)] = {{((8 - 4) * EW){s34}},s33};
    end
    for (i = 0; i < OW; i = i + 1) begin:gen_dout
        if (i >= (16 * IW)) begin:gen_ow_gt_16iw
            assign dout[i] = 1'b0;
        end
        else if (i >= (8 * IW)) begin:gen_ow_gt_8iw
            assign dout[i] = (s12 & s26[i]);
        end
        else if (i >= (4 * IW)) begin:gen_ow_gt_4iw
            assign dout[i] = (s11 & s25[i]) | (s12 & s26[i]) | (s16 & s29[i]);
        end
        else if (i >= (2 * IW)) begin:gen_ow_gt_2iw
            assign dout[i] = (s10 & s24[i]) | (s11 & s25[i]) | (s12 & s26[i]) | (s15 & s28[i]) | (s16 & s29[i]) | (s19 & s31[i]);
        end
        else if (i >= (1 * IW)) begin:gen_ow_gt_1iw
            assign dout[i] = (s9 & s23[i]) | (s10 & s24[i]) | (s11 & s25[i]) | (s12 & s26[i]) | (s14 & s27[i]) | (s15 & s28[i]) | (s16 & s29[i]) | (s18 & s30[i]) | (s19 & s31[i]) | (s21 & s32[i]);
        end
        else begin:gen_ow_le_1iw
            assign dout[i] = ((s13 | s17 | s20 | s22) & din[i]) | (s9 & s23[i]) | (s10 & s24[i]) | (s11 & s25[i]) | (s12 & s26[i]) | (s14 & s27[i]) | (s15 & s28[i]) | (s16 & s29[i]) | (s18 & s30[i]) | (s19 & s31[i]) | (s21 & s32[i]);
        end
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

