// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_seg_dict (
    element,
    eew,
    nf2,
    nf3,
    nf4,
    nf5,
    nf6,
    nf7,
    nf8,
    fault_element,
    fault_nf
);
parameter VLEN = 128;
parameter ELE_CNT_WIDTH = 8;
input [ELE_CNT_WIDTH - 1:0] element;
input [1:0] eew;
input nf2;
input nf3;
input nf4;
input nf5;
input nf6;
input nf7;
input nf8;
output [ELE_CNT_WIDTH - 1:0] fault_element;
output [2:0] fault_nf;





// a12b87b3 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [VLEN - 1:0] sel;
wire [VLEN - 1:0] s0;
wire [VLEN - 1:0] s1;
wire [VLEN - 1:0] s2;
wire [VLEN - 1:0] s3;
wire [VLEN - 1:0] s4;
wire [VLEN - 1:0] s5;
wire [VLEN - 1:0] s6;
wire [ELE_CNT_WIDTH - 1:0] s7;
wire [ELE_CNT_WIDTH - 1:0] s8;
wire [ELE_CNT_WIDTH - 1:0] s9;
wire [ELE_CNT_WIDTH - 1:0] s10;
wire [ELE_CNT_WIDTH - 1:0] s11;
wire [ELE_CNT_WIDTH - 1:0] s12;
wire [ELE_CNT_WIDTH - 1:0] s13;
wire [1:0] s14;
wire [2:0] s15;
wire [3:0] s16;
wire [4:0] s17;
wire [5:0] s18;
wire [6:0] s19;
wire [7:0] s20;
wire [2:0] s21;
wire [2:0] s22;
wire [2:0] s23;
wire [2:0] s24;
wire [2:0] s25;
wire [2:0] s26;
wire [2:0] s27;
kv_onehot2bin #(
    .N(VLEN)
) u_nf2_fault_element (
    .out(s7),
    .in(s0)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf3_fault_element (
    .out(s8),
    .in(s1)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf4_fault_element (
    .out(s9),
    .in(s2)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf5_fault_element (
    .out(s10),
    .in(s3)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf6_fault_element (
    .out(s11),
    .in(s4)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf7_fault_element (
    .out(s12),
    .in(s5)
);
kv_onehot2bin #(
    .N(VLEN)
) u_nf8_fault_element (
    .out(s13),
    .in(s6)
);
kv_mux_onehot #(
    .N(VLEN / 2),
    .W(2)
) u_nf2_fault_nf_oh (
    .out(s14),
    .sel({VLEN / 2{1'b1}}),
    .in(sel[2 * (VLEN / 2) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 3),
    .W(3)
) u_nf3_fault_nf_oh (
    .out(s15),
    .sel({VLEN / 3{1'b1}}),
    .in(sel[3 * (VLEN / 3) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 4),
    .W(4)
) u_nf4_fault_nf_oh (
    .out(s16),
    .sel({VLEN / 4{1'b1}}),
    .in(sel[4 * (VLEN / 4) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 5),
    .W(5)
) u_nf5_fault_nf_oh (
    .out(s17),
    .sel({VLEN / 5{1'b1}}),
    .in(sel[5 * (VLEN / 5) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 6),
    .W(6)
) u_nf6_fault_nf_oh (
    .out(s18),
    .sel({VLEN / 6{1'b1}}),
    .in(sel[6 * (VLEN / 6) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 7),
    .W(7)
) u_nf7_fault_nf_oh (
    .out(s19),
    .sel({VLEN / 7{1'b1}}),
    .in(sel[7 * (VLEN / 7) - 1:0])
);
kv_mux_onehot #(
    .N(VLEN / 8),
    .W(8)
) u_nf8_fault_nf_oh (
    .out(s20),
    .sel({VLEN / 8{1'b1}}),
    .in(sel[8 * (VLEN / 8) - 1:0])
);
kv_onehot2bin #(
    .N(8)
) u_nf2_fault_nf (
    .out(s21),
    .in({6'b0,s14})
);
kv_onehot2bin #(
    .N(8)
) u_nf3_fault_nf (
    .out(s22),
    .in({5'b0,s15})
);
kv_onehot2bin #(
    .N(8)
) u_nf4_fault_nf (
    .out(s23),
    .in({4'b0,s16})
);
kv_onehot2bin #(
    .N(8)
) u_nf5_fault_nf (
    .out(s24),
    .in({3'b0,s17})
);
kv_onehot2bin #(
    .N(8)
) u_nf6_fault_nf (
    .out(s25),
    .in({2'b0,s18})
);
kv_onehot2bin #(
    .N(8)
) u_nf7_fault_nf (
    .out(s26),
    .in({1'b0,s19})
);
kv_onehot2bin #(
    .N(8)
) u_nf8_fault_nf (
    .out(s27),
    .in({s20})
);
assign sel = {{VLEN - 1{1'b0}},1'b1} << element;
assign fault_element = ({ELE_CNT_WIDTH{nf2}} & s7) | ({ELE_CNT_WIDTH{nf3}} & s8) | ({ELE_CNT_WIDTH{nf4}} & s9) | ({ELE_CNT_WIDTH{nf5}} & s10) | ({ELE_CNT_WIDTH{nf6}} & s11) | ({ELE_CNT_WIDTH{nf7}} & s12) | ({ELE_CNT_WIDTH{nf8}} & s13);
assign fault_nf = ({3{nf2}} & s21) | ({3{nf3}} & s22) | ({3{nf4}} & s23) | ({3{nf5}} & s24) | ({3{nf6}} & s25) | ({3{nf7}} & s26) | ({3{nf8}} & s27);
generate
    genvar i;
    for (i = 0; i < VLEN; i = i + 1) begin:gen_dict_sel
        if (i < (VLEN / 2)) begin:gen_dict2_sel
            assign s0[i] = |sel[i * 2 +:2];
        end
        else begin:gen_dict2_sel_zero
            assign s0[i] = 1'b0;
        end
        if (i < (VLEN / 3)) begin:gen_dict3_sel
            assign s1[i] = |sel[i * 3 +:3];
        end
        else begin:gen_dict3_sel_zero
            assign s1[i] = 1'b0;
        end
        if (i < (VLEN / 4)) begin:gen_dict4_sel
            assign s2[i] = |sel[i * 4 +:4];
        end
        else begin:gen_dict4_sel_zero
            assign s2[i] = 1'b0;
        end
        if (i < (VLEN / 5)) begin:gen_dict5_sel
            assign s3[i] = |sel[i * 5 +:5];
        end
        else begin:gen_dict5_sel_zero
            assign s3[i] = 1'b0;
        end
        if (i < (VLEN / 6)) begin:gen_dict6_sel
            assign s4[i] = |sel[i * 6 +:6];
        end
        else begin:gen_dict6_sel_zero
            assign s4[i] = 1'b0;
        end
        if (i < (VLEN / 7)) begin:gen_dict7_sel
            assign s5[i] = |sel[i * 7 +:7];
        end
        else begin:gen_dict7_sel_zero
            assign s5[i] = 1'b0;
        end
        if (i < (VLEN / 8)) begin:gen_dict8_sel
            assign s6[i] = |sel[i * 8 +:8];
        end
        else begin:gen_dict8_sel_zero
            assign s6[i] = 1'b0;
        end
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

