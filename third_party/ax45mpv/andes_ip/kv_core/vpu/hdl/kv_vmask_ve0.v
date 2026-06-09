// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vmask_ve0 (
    ve0_lane_id,
    ve0_d_id,
    ve0_v_id,
    ve0_ctrl,
    ve0_v0t,
    ve0_vs3_data,
    ve0_vs2_unmasked_data,
    ve0_vs2_viota_unmasked_data,
    ve0_vs2_viota_masked_data,
    ve0_vs2_viota_v0t,
    ve0_vs1_data,
    ve2_vfirst_has_1,
    ve2_vd_wdata,
    ve1_vfirst_wdata,
    ve1_vfirst_has_1,
    ve1_viota_wdata,
    ve1_viota_wmask,
    ve1_viota_carry_in,
    ve1_viota_carry_out,
    ve1_vpopc_carry_out
);
parameter VLEN = 512;
parameter DLEN = 512;
parameter ELEN = 64;
localparam LANE_NUM = DLEN / ELEN;
localparam LANE_ID_BITS = $clog2(LANE_NUM);
localparam E_ID_BITS = $clog2(ELEN);
localparam D_ID_NUM = VLEN / DLEN;
localparam D_ID_BITS = (D_ID_NUM == 1) ? 1 : $clog2(D_ID_NUM);
localparam V_ID_NUM = 8 * (VLEN / DLEN);
localparam V_ID_BITS = $clog2(V_ID_NUM);
localparam CARRY_WIDTH = $clog2(ELEN);
input [(LANE_ID_BITS - 1):0] ve0_lane_id;
input [(D_ID_BITS - 1):0] ve0_d_id;
input [(V_ID_BITS - 1):0] ve0_v_id;
input [(44 - 1):0] ve0_ctrl;
input [(ELEN - 1):0] ve0_v0t;
input [(ELEN - 1):0] ve0_vs3_data;
input [(ELEN - 1):0] ve0_vs2_unmasked_data;
input [(ELEN - 1):0] ve0_vs2_viota_unmasked_data;
input [(ELEN - 1):0] ve0_vs2_viota_masked_data;
input [(ELEN - 1):0] ve0_vs2_viota_v0t;
input [(ELEN - 1):0] ve0_vs1_data;
input ve2_vfirst_has_1;
output [(ELEN - 1):0] ve2_vd_wdata;
output [(CARRY_WIDTH - 1):0] ve1_vfirst_wdata;
output ve1_vfirst_has_1;
output [(ELEN - 1):0] ve1_viota_wdata;
output [((ELEN / 8) - 1):0] ve1_viota_wmask;
input [8:0] ve1_viota_carry_in;
output [8:0] ve1_viota_carry_out;
output [CARRY_WIDTH:0] ve1_vpopc_carry_out;





// c162d3a0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [(ELEN - 1):0] ve2_vd_logical_wdata;
wire [(ELEN - 1):0] ve0_sxf_vs2_masked_data;
wire [(ELEN - 1):0] ve2_vd_sxf_wdata;
wire [(ELEN - 1):0] ve0_viota_vs2_masked_data;
wire [(ELEN - 1):0] ve0_viota_vs2_masked_v0t;
wire [7:0] ve0_viota_vs2_lane_data;
wire [7:0] ve0_viota_vs2_lane_v0t;
generate
    genvar i;
    for (i = 0; i < ELEN; i = i + 1) begin:gen_vmask_logical
        assign ve2_vd_logical_wdata[i] = logical_func(ve0_ctrl[0], ve0_ctrl[6], ve0_ctrl[43], ve0_ctrl[31], ve0_ctrl[29], ve0_vs2_unmasked_data[i], ve0_vs1_data[i]);
    end
endgenerate
assign ve0_sxf_vs2_masked_data = ve0_v0t & ve0_vs2_unmasked_data;
assign {ve1_vfirst_has_1,ve1_vpopc_carry_out,ve1_vfirst_wdata,ve2_vd_sxf_wdata} = sxf_func(ve0_ctrl[24], ve0_ctrl[25], ve0_ctrl[26], ve0_sxf_vs2_masked_data, ve2_vfirst_has_1);
assign ve2_vd_wdata = (ve0_v0t & ve2_vd_logical_wdata) | (ve0_v0t & ve2_vd_sxf_wdata) | (~ve0_v0t & ve0_vs3_data);
assign ve0_viota_vs2_masked_data = ({ELEN{ve0_ctrl[23] | ve0_ctrl[10]}} & ve0_vs2_viota_unmasked_data) | ({ELEN{~ve0_ctrl[23] & ~ve0_ctrl[10]}} & ve0_vs2_viota_masked_data);
assign ve0_viota_vs2_masked_v0t = ve0_vs2_viota_v0t;
assign ve0_viota_vs2_lane_data = ({8{(ve0_ctrl[7 +:2] == 2'b11)}} & {7'b0,ve0_viota_vs2_masked_data[ve0_v_id[0 +:V_ID_BITS] * 1 +:1]}) | ({8{(ve0_ctrl[7 +:2] == 2'b10)}} & {6'b0,ve0_viota_vs2_masked_data[ve0_v_id[0 +:V_ID_BITS] * 2 +:2]}) | ({8{(ve0_ctrl[7 +:2] == 2'b01)}} & {4'b0,ve0_viota_vs2_masked_data[ve0_v_id[0 +:V_ID_BITS] * 4 +:4]}) | ({8{(ve0_ctrl[7 +:2] == 2'b00)}} & ve0_viota_vs2_masked_data[ve0_v_id[0 +:3] * 8 +:8]);
assign ve0_viota_vs2_lane_v0t = ({8{(ve0_ctrl[7 +:2] == 2'b11)}} & {7'b0,ve0_viota_vs2_masked_v0t[ve0_v_id[0 +:V_ID_BITS] * 1 +:1]}) | ({8{(ve0_ctrl[7 +:2] == 2'b10)}} & {6'b0,ve0_viota_vs2_masked_v0t[ve0_v_id[0 +:V_ID_BITS] * 2 +:2]}) | ({8{(ve0_ctrl[7 +:2] == 2'b01)}} & {4'b0,ve0_viota_vs2_masked_v0t[ve0_v_id[0 +:V_ID_BITS] * 4 +:4]}) | ({8{(ve0_ctrl[7 +:2] == 2'b00)}} & ve0_viota_vs2_masked_v0t[ve0_v_id[0 +:3] * 8 +:8]);
assign {ve1_viota_carry_out,ve1_viota_wmask,ve1_viota_wdata} = viota_func(ve0_viota_vs2_lane_data, ve0_viota_vs2_lane_v0t, ve0_ctrl[7 +:2], ve1_viota_carry_in);
function  logical_func;
input ctrl_and;
input ctrl_or;
input ctrl_xor;
input ctrl_vs2_inv;
input ctrl_vs1_inv;
input vs2;
input vs1;
reg op2;
reg op1;
reg result_and;
reg result_or;
reg result_xor;
begin
    op2 = ctrl_vs2_inv ^ vs2;
    op1 = ctrl_vs1_inv ^ vs1;
    result_and = op2 & op1;
    result_or = op2 | op1;
    result_xor = ~result_and & result_or;
    logical_func = (ctrl_and & result_and) | (ctrl_or & result_or) | (ctrl_xor & result_xor);
end
endfunction
function  [1 + (CARRY_WIDTH + 1) + CARRY_WIDTH + ELEN - 1:0] sxf_func;
input ctrl_vmsbf;
input ctrl_vmsif;
input ctrl_vmsof;
input [(ELEN - 1):0] vs2;
input has_1_in;
reg [(ELEN - 1):0] vs2_op_minus_1;
reg [(ELEN - 1):0] sbf;
reg [(ELEN - 1):0] sif;
reg [(ELEN - 1):0] sof;
reg has_1;
reg [(ELEN - 1):0] sxf;
reg [(CARRY_WIDTH - 1):0] vfirst;
reg [CARRY_WIDTH:0] vpopc;
integer i;
begin
    vs2_op_minus_1 = vs2 - {{(ELEN - 1){1'b0}},1'b1};
    sbf = ~vs2 & vs2_op_minus_1;
    sif = {sbf[(ELEN - 2):0],1'b1};
    sof = sif ^ sbf;
    has_1 = |vs2;
    vfirst = {CARRY_WIDTH{1'b0}};
    for (i = 1; i < ELEN; i = i + 2) begin:gen_vfirst0
        vfirst[0] = vfirst[0] | (|sof[i +:1]);
    end
    for (i = 2; i < ELEN; i = i + 4) begin:gen_vfirst1
        vfirst[1] = vfirst[1] | (|sof[i +:2]);
    end
    for (i = 4; i < ELEN; i = i + 8) begin:gen_vfirst2
        vfirst[2] = vfirst[2] | (|sof[i +:4]);
    end
    for (i = 8; i < ELEN; i = i + 16) begin:gen_vfirst3
        vfirst[3] = vfirst[3] | (|sof[i +:8]);
    end
    for (i = 16; i < ELEN; i = i + 32) begin:gen_vfirst4
        vfirst[4] = vfirst[4] | (|sof[i +:16]);
    end
    for (i = 32; i < ELEN; i = i + 32) begin:gen_vfirst5
        vfirst[5] = vfirst[5] | (|sof[i +:32]);
    end
    vpopc = {(CARRY_WIDTH + 1){1'b0}};
    for (i = 0; i < ELEN; i = i + 1) begin:gen_vpopc
        vpopc = vpopc[(CARRY_WIDTH - 1):0] + {{(CARRY_WIDTH - 1){1'b0}},vs2[i]};
    end
    sxf = ({ELEN{ctrl_vmsbf & ~has_1_in}} & sbf) | ({ELEN{ctrl_vmsif & ~has_1_in}} & sif) | ({ELEN{ctrl_vmsof & ~has_1_in}} & sof);
    sxf_func = {has_1,vpopc,vfirst,sxf};
end
endfunction
function  [9 + (ELEN / 8) + ELEN - 1:0] viota_func;
input [7:0] vs2;
input [7:0] v0t;
input [1:0] sew;
input [8:0] viota_carry_in;
reg [7:0] viota_sew8[0:(ELEN / 8)];
reg [15:0] viota_sew16[0:(ELEN / 16)];
reg [31:0] viota_sew32[0:(ELEN / 32)];
reg [63:0] viota_sew64[0:(ELEN / 64)];
reg [8:0] viota_carry_out;
reg [(ELEN - 1):0] viota;
reg [((ELEN / 8) - 1):0] wmask_sew8;
reg [((ELEN / 8) - 1):0] wmask_sew16;
reg [((ELEN / 8) - 1):0] wmask_sew32;
reg [((ELEN / 8) - 1):0] wmask_sew64;
reg [((ELEN / 8) - 1):0] wmask;
reg [(ELEN / 8):0] nds_unused_viota_sew8;
reg [(ELEN / 16):0] nds_unused_viota_sew16;
reg [(ELEN / 32):0] nds_unused_viota_sew32;
reg [(ELEN / 64):0] nds_unused_viota_sew64;
integer i;
integer j;
begin
    for (i = 0; i <= (ELEN / 8); i = i + 1) begin:gen_viota_sew8_outer
        viota_sew8[i] = viota_carry_in[7:0] & {8{(sew == 2'b00)}};
        if (i > 0) begin:gen_viota_sew8_inner_loop
            for (j = 0; j < i; j = j + 1) begin:gen_viota_sew8_inner
                {nds_unused_viota_sew8[i],viota_sew8[i]} = viota_sew8[i] + {7'b0,(vs2[j] & (sew == 2'b00))};
            end
        end
    end
    for (i = 0; i < (ELEN / 8); i = i + 1) begin:gen_viota_sew8_v0t
        wmask_sew8[i] = v0t[i] & (sew == 2'b00);
    end
    for (i = 0; i <= (ELEN / 16); i = i + 1) begin:gen_viota_sew16_outer
        viota_sew16[i] = {{(16 - 9){1'b0}},viota_carry_in[8:0] & {9{(sew == 2'b01)}}};
        if (i > 0) begin:gen_viota_sew16_inner_loop
            for (j = 0; j < i; j = j + 1) begin:gen_viota_sew16_inner
                {nds_unused_viota_sew16[i],viota_sew16[i]} = viota_sew16[i] + {15'b0,(vs2[j] & (sew == 2'b01))};
            end
        end
    end
    for (i = 0; i < (ELEN / 16); i = i + 1) begin:gen_viota_sew16_v0t
        wmask_sew16[i * 2 +:2] = {2{v0t[i] & (sew == 2'b01)}};
    end
    for (i = 0; i <= (ELEN / 32); i = i + 1) begin:gen_viota_sew32_outer
        viota_sew32[i] = {{(32 - 8){1'b0}},viota_carry_in[7:0] & {8{(sew == 2'b10)}}};
        if (i > 0) begin:gen_viota_sew32_inner_loop
            for (j = 0; j < i; j = j + 1) begin:gen_viota_sew32_inner
                {nds_unused_viota_sew32[i],viota_sew32[i]} = viota_sew32[i] + {31'b0,(vs2[j] & (sew == 2'b10))};
            end
        end
    end
    for (i = 0; i < (ELEN / 32); i = i + 1) begin:gen_viota_sew32_v0t
        wmask_sew32[i * 4 +:4] = {4{v0t[i] & (sew == 2'b10)}};
    end
    for (i = 0; i <= (ELEN / 64); i = i + 1) begin:gen_viota_sew64_outer
        viota_sew64[i] = {{(64 - 7){1'b0}},viota_carry_in[6:0] & {7{(sew == 2'b11)}}};
        if (i > 0) begin:gen_viota_sew64_inner_loop
            for (j = 0; j < i; j = j + 1) begin:gen_viota_sew64_inner
                {nds_unused_viota_sew64[i],viota_sew64[i]} = viota_sew64[i] + {63'b0,(vs2[j] & (sew == 2'b11))};
            end
        end
    end
    for (i = 0; i < (ELEN / 64); i = i + 1) begin:gen_viota_sew64_v0t
        wmask_sew64[i * 8 +:8] = {8{v0t[i] & (sew == 2'b11)}};
    end
    viota = {viota_sew8[7],viota_sew8[6],viota_sew8[5],viota_sew8[4],viota_sew8[3],viota_sew8[2],viota_sew8[1],viota_sew8[0]} | {viota_sew16[3],viota_sew16[2],viota_sew16[1],viota_sew16[0]} | {viota_sew32[1],viota_sew32[0]} | viota_sew64[0];
    wmask = wmask_sew8 | wmask_sew16 | wmask_sew32 | wmask_sew64;
    viota_carry_out = {1'b0,viota_sew8[(ELEN / 8)][7:0]} | viota_sew16[(ELEN / 16)][8:0] | {1'b0,viota_sew32[(ELEN / 32)][7:0]} | {2'b0,viota_sew64[(ELEN / 64)][6:0]};
    viota_func = {viota_carry_out,wmask,viota};
end
endfunction
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

