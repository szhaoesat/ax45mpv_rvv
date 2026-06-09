// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vpu_lane_xl (
    valu_lane_o_mask_result,
    valu_lane_i_mask_result,
    valu_lane_share_result_data,
    valu_lane_cross_result_data,
    valu_lane_vs1_wide_bdata,
    valu_lane_vs2_wide_bdata,
    valu_lane_vs1_data,
    valu_lane_vs2_data,
    vfmis_f1_lane_o_cmp_bit,
    vfmis_f1_lane_i_cmp_bit,
    vfmis_lane_vs2_sel,
    vfmis_lane_vs2_x2_bdata,
    vfmis_lane_vs2_x4_bdata,
    vfmis_lane_vs2_x8_bdata,
    vfmis_lane_vs2_data,
    vfmis_lane_share_data,
    vfmis_lane_cross_data,
    vmac2_vs1_lane_share_data,
    vmac2_vs2_lane_share_cross_data,
    vmac2_vs2_lane_share_shift_data,
    vmac2_lane_cross_type,
    vmac2_lane_shift_type,
    vmac2_vs1_lane_shift_data,
    vmac2_vs2_lane_shift_data,
    vmac2_vs1_lane_cross_data,
    vmac2_vs2_lane_cross_data,
    vmac_vs1_lane_share_data,
    vmac_vs2_lane_share_cross_data,
    vmac_vs2_lane_share_shift_data,
    vmac_lane_cross_type,
    vmac_lane_shift_type,
    vmac_vs1_lane_shift_data,
    vmac_vs2_lane_shift_data,
    vmac_vs1_lane_cross_data,
    vmac_vs2_lane_cross_data
);
parameter DLEN = 512;
input [DLEN / 8 - 1:0] valu_lane_o_mask_result;
output [DLEN / 8 - 1:0] valu_lane_i_mask_result;
input [DLEN - 1:0] valu_lane_share_result_data;
output [DLEN * 2 - 1:0] valu_lane_cross_result_data;
output [DLEN / 2 - 1:0] valu_lane_vs1_wide_bdata;
output [DLEN / 2 - 1:0] valu_lane_vs2_wide_bdata;
input [DLEN - 1:0] valu_lane_vs1_data;
input [DLEN - 1:0] valu_lane_vs2_data;
input [DLEN / 16 - 1:0] vfmis_f1_lane_o_cmp_bit;
output [DLEN / 16 - 1:0] vfmis_f1_lane_i_cmp_bit;
input [DLEN - 1:0] vfmis_lane_share_data;
output [DLEN * 2 - 1:0] vfmis_lane_cross_data;
output [DLEN / 2 - 1:0] vfmis_lane_vs2_x2_bdata;
output [DLEN / 4 - 1:0] vfmis_lane_vs2_x4_bdata;
output [DLEN / 8 - 1:0] vfmis_lane_vs2_x8_bdata;
input [2:0] vfmis_lane_vs2_sel;
input [DLEN - 1:0] vfmis_lane_vs2_data;
input [DLEN - 1:0] vmac2_vs1_lane_share_data;
input [DLEN - 1:0] vmac2_vs2_lane_share_cross_data;
input [DLEN - 1:0] vmac2_vs2_lane_share_shift_data;
input [3:0] vmac2_lane_cross_type;
input [3:0] vmac2_lane_shift_type;
output [DLEN - 1:0] vmac2_vs1_lane_shift_data;
output [DLEN - 1:0] vmac2_vs2_lane_shift_data;
output [DLEN / 2 - 1:0] vmac2_vs1_lane_cross_data;
output [DLEN / 2 - 1:0] vmac2_vs2_lane_cross_data;
input [DLEN - 1:0] vmac_vs1_lane_share_data;
input [DLEN - 1:0] vmac_vs2_lane_share_cross_data;
input [DLEN - 1:0] vmac_vs2_lane_share_shift_data;
input [3:0] vmac_lane_cross_type;
input [3:0] vmac_lane_shift_type;
output [DLEN - 1:0] vmac_vs1_lane_shift_data;
output [DLEN - 1:0] vmac_vs2_lane_shift_data;
output [DLEN / 2 - 1:0] vmac_vs1_lane_cross_data;
output [DLEN / 2 - 1:0] vmac_vs2_lane_cross_data;





// 19d19153 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [DLEN - 1:0] s0;
reg [DLEN - 1:0] s1;
wire [DLEN - 1:0] s2;
reg [DLEN - 1:0] s3;
integer s4;
assign s0 = valu_lane_share_result_data;
assign s2 = vfmis_lane_share_data;
always @* begin
    for (s4 = 0; s4 < DLEN / 64; s4 = s4 + 1) begin
        s1[s4 * 64 +:64] = {32'b0,s0[s4 * 64 +:32]};
        s3[s4 * 64 +:64] = {32'b0,s2[s4 * 64 +:32]};
    end
end

assign valu_lane_i_mask_result = valu_lane_o_mask_result;
assign valu_lane_cross_result_data = {s1,s0};
assign valu_lane_vs1_wide_bdata = valu_lane_vs1_data[DLEN - 1:DLEN / 2];
assign valu_lane_vs2_wide_bdata = valu_lane_vs2_data[DLEN - 1:DLEN / 2];
assign vfmis_f1_lane_i_cmp_bit = {{vfmis_f1_lane_o_cmp_bit}};
assign vfmis_lane_vs2_x2_bdata = (vfmis_lane_vs2_data[DLEN - 1:DLEN / 2] & {DLEN / 2{vfmis_lane_vs2_sel[0]}}) | (vfmis_lane_vs2_data[DLEN / 2 - 1:0] & {DLEN / 2{~vfmis_lane_vs2_sel[0]}});
assign vfmis_lane_vs2_x4_bdata = (vfmis_lane_vs2_data[DLEN / 4 - 1:0] & {DLEN / 4{vfmis_lane_vs2_sel[1:0] == 2'b00}}) | (vfmis_lane_vs2_data[DLEN / 2 - 1:DLEN / 4] & {DLEN / 4{vfmis_lane_vs2_sel[1:0] == 2'b01}}) | (vfmis_lane_vs2_data[DLEN * 3 / 4 - 1:DLEN / 2] & {DLEN / 4{vfmis_lane_vs2_sel[1:0] == 2'b10}}) | (vfmis_lane_vs2_data[DLEN - 1:DLEN * 3 / 4] & {DLEN / 4{vfmis_lane_vs2_sel[1:0] == 2'b11}});
assign vfmis_lane_vs2_x8_bdata = (vfmis_lane_vs2_data[DLEN / 8 - 1:0] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b000}}) | (vfmis_lane_vs2_data[DLEN * 2 / 8 - 1:DLEN * 1 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b001}}) | (vfmis_lane_vs2_data[DLEN * 3 / 8 - 1:DLEN * 2 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b010}}) | (vfmis_lane_vs2_data[DLEN * 4 / 8 - 1:DLEN * 3 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b011}}) | (vfmis_lane_vs2_data[DLEN * 5 / 8 - 1:DLEN * 4 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b100}}) | (vfmis_lane_vs2_data[DLEN * 6 / 8 - 1:DLEN * 5 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b101}}) | (vfmis_lane_vs2_data[DLEN * 7 / 8 - 1:DLEN * 6 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b110}}) | (vfmis_lane_vs2_data[DLEN * 8 / 8 - 1:DLEN * 7 / 8] & {DLEN / 8{vfmis_lane_vs2_sel[2:0] == 3'b111}});
assign vfmis_lane_cross_data = {s3,s2};
wire [DLEN / 2 - 1:0] s5;
wire [DLEN / 2 - 1:0] s6;
wire [DLEN / 2 - 1:0] s7;
wire [DLEN / 2 - 1:0] s8;
generate
    genvar j;
    for (j = 0; j < DLEN / 64; j = j + 1) begin:gen_qwide_lx_data
        assign s5[j * 32 +:32] = {16'b0,vmac_vs1_lane_share_data[j * 16 +:16]};
        assign s6[j * 32 +:32] = {16'b0,vmac_vs2_lane_share_cross_data[j * 16 +:16]};
        assign s7[j * 32 +:32] = {16'b0,vmac2_vs1_lane_share_data[j * 16 +:16]};
        assign s8[j * 32 +:32] = {16'b0,vmac2_vs2_lane_share_cross_data[j * 16 +:16]};
    end
endgenerate
assign vmac_vs1_lane_cross_data = ({DLEN / 2{vmac_lane_cross_type[0]}} & vmac_vs1_lane_share_data[DLEN / 2 - 1:0]) | ({DLEN / 2{vmac_lane_cross_type[1]}} & s5[DLEN / 2 - 1:0]);
assign vmac_vs2_lane_cross_data = ({DLEN / 2{vmac_lane_cross_type[0]}} & vmac_vs2_lane_share_cross_data[DLEN / 2 - 1:0]) | ({DLEN / 2{vmac_lane_cross_type[1]}} & s6[DLEN / 2 - 1:0]);
assign vmac2_vs1_lane_cross_data = ({DLEN / 2{vmac2_lane_cross_type[0]}} & vmac2_vs1_lane_share_data[DLEN / 2 - 1:0]) | ({DLEN / 2{vmac2_lane_cross_type[1]}} & s7[DLEN / 2 - 1:0]);
assign vmac2_vs2_lane_cross_data = ({DLEN / 2{vmac2_lane_cross_type[0]}} & vmac2_vs2_lane_share_cross_data[DLEN / 2 - 1:0]) | ({DLEN / 2{vmac2_lane_cross_type[1]}} & s8[DLEN / 2 - 1:0]);
generate
    if (DLEN > 128) begin:gen_lane_shift_data_dlen_gt_128
        reg [DLEN - 1:0] s9;
        reg [DLEN - 1:0] s10;
        integer s11;
        always @* begin
            for (s11 = 0; s11 < DLEN / 256; s11 = s11 + 1) begin
                s9[s11 * 256 +:256] = {192'b0,vmac_vs2_lane_share_shift_data[(s11 * 4 + 2) * 64 +:64]};
                s10[s11 * 256 +:256] = {192'b0,vmac2_vs2_lane_share_shift_data[(s11 * 4 + 2) * 64 +:64]};
            end
        end

        assign vmac_vs1_lane_shift_data = ({DLEN{vmac_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac_vs1_lane_share_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac_vs1_lane_share_data[DLEN - 1:DLEN / 2]});
        assign vmac_vs2_lane_shift_data = ({DLEN{vmac_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac_vs2_lane_share_shift_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac_vs2_lane_share_shift_data[DLEN - 1:DLEN / 2]}) | ({DLEN{vmac_lane_shift_type[1]}} & {s9[DLEN - 1:0]}) | ({DLEN{vmac_lane_shift_type[0]}} & {64'b0,vmac_vs2_lane_share_shift_data[DLEN - 1:64]});
        assign vmac2_vs1_lane_shift_data = ({DLEN{vmac2_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac2_vs1_lane_share_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac2_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac2_vs1_lane_share_data[DLEN - 1:DLEN / 2]});
        assign vmac2_vs2_lane_shift_data = ({DLEN{vmac2_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac2_vs2_lane_share_shift_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac2_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac2_vs2_lane_share_shift_data[DLEN - 1:DLEN / 2]}) | ({DLEN{vmac2_lane_shift_type[1]}} & {s10[DLEN - 1:0]}) | ({DLEN{vmac2_lane_shift_type[0]}} & {64'b0,vmac2_vs2_lane_share_shift_data[DLEN - 1:64]});
    end
    else begin:gen_lane_shift_data_dlen_eq_128
        assign vmac_vs1_lane_shift_data = ({DLEN{vmac_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac_vs1_lane_share_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac_vs1_lane_share_data[DLEN - 1:DLEN / 2]});
        assign vmac_vs2_lane_shift_data = ({DLEN{vmac_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac_vs2_lane_share_shift_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac_vs2_lane_share_shift_data[DLEN - 1:DLEN / 2]}) | ({DLEN{vmac_lane_shift_type[0]}} & {64'b0,vmac_vs2_lane_share_shift_data[DLEN - 1:64]});
        assign vmac2_vs1_lane_shift_data = ({DLEN{vmac2_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac2_vs1_lane_share_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac2_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac2_vs1_lane_share_data[DLEN - 1:DLEN / 2]});
        assign vmac2_vs2_lane_shift_data = ({DLEN{vmac2_lane_shift_type[3]}} & {{DLEN / 4{1'b0}},vmac2_vs2_lane_share_shift_data[DLEN - 1:DLEN / 4]}) | ({DLEN{vmac2_lane_shift_type[2]}} & {{DLEN / 2{1'b0}},vmac2_vs2_lane_share_shift_data[DLEN - 1:DLEN / 2]}) | ({DLEN{vmac2_lane_shift_type[0]}} & {64'b0,vmac2_vs2_lane_share_shift_data[DLEN - 1:64]});
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

