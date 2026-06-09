// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vdiv_adder71 (
    sub,
    sign,
    ssew_1hot,
    src1,
    src2,
    ci,
    rup,
    ovf,
    neg,
    zero,
    sum,
    uco,
    co
);
input [7:0] sub;
input sign;
input [3:0] ssew_1hot;
input [63:0] src1;
input [63:0] src2;
input [7:0] ci;
input [7:0] rup;
output reg [7:0] ovf;
output reg [7:0] neg;
output reg [7:0] zero;
output [63:0] sum;
output [7:0] uco;
output [7:0] co;





// 68124f35 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [6:0] s0;
reg [63:0] s1;
reg [63:0] s2;
reg [7:0] s3;
reg [7:0] s4;
reg [7:0] s5;
wire [7:0] s6;
wire [7:0] s7;
wire [64 - 1:0] s8[0:1];
always @* begin
    casez (ssew_1hot)
        4'b1???: begin
            s0[6:0] = 7'b111_1111;
            s2[63:0] = {62'b0,rup[0],ci[0] ^ sub[7]};
            s1 = {{64{sub[7]}} ^ src2};
        end
        4'b01??: begin
            s0[6:0] = 7'b111_0111;
            s2[31:0] = {30'b0,rup[0],ci[0] ^ sub[3]};
            s2[63:32] = {30'b0,rup[4],ci[4] ^ sub[7]};
            s1 = {{32{sub[7]}} ^ src2[63:32],{32{sub[3]}} ^ src2[31:0]};
        end
        4'b001?: begin
            s0[6:0] = 7'b101_0101;
            s2[15:0] = {14'b0,rup[0],ci[0] ^ sub[1]};
            s2[31:16] = {14'b0,rup[2],ci[2] ^ sub[3]};
            s2[47:32] = {14'b0,rup[4],ci[4] ^ sub[5]};
            s2[63:48] = {14'b0,rup[6],ci[6] ^ sub[7]};
            s1 = {{16{sub[7]}} ^ src2[63:48],{16{sub[5]}} ^ src2[47:32],{16{sub[3]}} ^ src2[31:16],{16{sub[1]}} ^ src2[15:0]};
        end
        default: begin
            s0[6:0] = 7'b000_0000;
            s2[7:0] = {6'b0,rup[0],ci[0] ^ sub[0]};
            s2[15:8] = {6'b0,rup[1],ci[1] ^ sub[1]};
            s2[23:16] = {6'b0,rup[2],ci[2] ^ sub[2]};
            s2[31:24] = {6'b0,rup[3],ci[3] ^ sub[3]};
            s2[39:32] = {6'b0,rup[4],ci[4] ^ sub[4]};
            s2[47:40] = {6'b0,rup[5],ci[5] ^ sub[5]};
            s2[55:48] = {6'b0,rup[6],ci[6] ^ sub[6]};
            s2[63:56] = {6'b0,rup[7],ci[7] ^ sub[7]};
            s1 = {{8{sub[7]}} ^ src2[63:56],{8{sub[6]}} ^ src2[55:48],{8{sub[5]}} ^ src2[47:40],{8{sub[4]}} ^ src2[39:32],{8{sub[3]}} ^ src2[31:24],{8{sub[2]}} ^ src2[23:16],{8{sub[1]}} ^ src2[15:8],{8{sub[0]}} ^ src2[7:0]};
        end
    endcase
end

wire [7:0] s9;
reg [7:0] s10;
assign {s6,s8[0],s8[1]} = parallel_cmp32_64b_func(s0, src1, s1, s2);
assign {s7,sum} = parallel_add_64b_func(s0, s8[0], s8[1]);
assign s9 = s6 ^ s7;
assign uco = s6 ^ s7 ^ sub;
assign co = sign ? s10 : uco;
integer s11;
always @* begin
    for (s11 = 0; s11 < 8; s11 = s11 + 1) begin
        s5[s11] = (src1[(8 * s11) +:8] == src2[(8 * s11) +:8]);
        s3[s11] = sign ? (s9[s11] ^ sum[8 * (s11 + 1) - 1]) & ~(src1[8 * (s11 + 1) - 1] ^ s1[8 * (s11 + 1) - 1]) : (s9[s11] ^ sub[s11]);
        s4[s11] = sign ? (src1[8 * (s11 + 1) - 1] & ~src2[8 * (s11 + 1) - 1]) | ((src1[8 * (s11 + 1) - 1] == src2[8 * (s11 + 1) - 1]) & sum[8 * (s11 + 1) - 1]) : ~s9[s11];
        s10[s11] = (s9[s11] ^ src1[8 * (s11 + 1) - 1] ^ s1[8 * (s11 + 1) - 1]);
    end
end

always @* begin
    for (s11 = 0; s11 < 8; s11 = s11 + 1) begin
        ovf[s11] = s3[s11];
    end
    casez (ssew_1hot)
        4'b1???: begin
            zero[7] = &s5;
            for (s11 = 0; s11 < 8; s11 = s11 + 1) begin
                neg[s11] = s4[7];
            end
            for (s11 = 0; s11 < 7; s11 = s11 + 1) begin
                zero[s11] = s5[s11];
            end
        end
        4'b01??: begin
            zero[0] = s5[0];
            zero[1] = s5[1];
            zero[2] = s5[2];
            zero[3] = &s5[3:0];
            zero[4] = s5[4];
            zero[5] = s5[5];
            zero[6] = s5[6];
            zero[7] = &s5[7:4];
            for (s11 = 0; s11 < 4; s11 = s11 + 1) begin
                neg[s11] = s4[3];
            end
            for (s11 = 4; s11 < 8; s11 = s11 + 1) begin
                neg[s11] = s4[7];
            end
        end
        4'b001?: begin
            for (s11 = 0; s11 < 8; s11 = s11 + 2) begin
                zero[s11 + 1] = s5[s11] & s5[s11 + 1];
                neg[s11 + 1] = s4[s11 + 1];
                neg[s11] = neg[s11 + 1];
            end
            for (s11 = 0; s11 < 8; s11 = s11 + 2) begin
                zero[s11] = s5[s11];
            end
        end
        default: begin
            for (s11 = 0; s11 < 8; s11 = s11 + 1) begin
                neg[s11] = s4[s11];
                zero[s11] = s5[s11];
            end
        end
    endcase
end

function  [64 * 2 - 1 + 8:0] parallel_cmp32_64b_func;
input [6:0] chain_byte;
input [64 - 1:0] op0;
input [64 - 1:0] op1;
input [64 - 1:0] op2;
reg [64 - 1:0] s12;
reg [64 - 1:0] s13;
reg [64:0] s14;
reg [64 - 1:0] s15;
reg [7:0] co;
begin
    s13 = op0 ^ op1 ^ op2;
    s12 = (op0 & op1) | (op0 & op2) | (op1 & op2);
    s14 = {s12[64 - 1:0],1'b0};
    s15 = {s14[(8 * 7 + 1) +:7],s14[8 * 7] & chain_byte[6],s14[(8 * 6 + 1) +:7],s14[8 * 6] & chain_byte[5],s14[(8 * 5 + 1) +:7],s14[8 * 5] & chain_byte[4],s14[(8 * 4 + 1) +:7],s14[8 * 4] & chain_byte[3],s14[(8 * 3 + 1) +:7],s14[8 * 3] & chain_byte[2],s14[(8 * 2 + 1) +:7],s14[8 * 2] & chain_byte[1],s14[(8 * 1 + 1) +:7],s14[8 * 1] & chain_byte[0],s14[(8 * 0) +:8]};
    co = {s14[8 * 8],s14[8 * 7],s14[8 * 6],s14[8 * 5],s14[8 * 4],s14[8 * 3],s14[8 * 2],s14[8 * 1]};
    parallel_cmp32_64b_func = {co,s15,s13};
end
endfunction
function  [64 - 1 + 8:0] parallel_add_64b_func;
input [6:0] chain_byte;
input [64 - 1:0] src1;
input [64 - 1:0] src2;
reg [64 + 7:0] op1;
reg [64 + 7:0] op2;
reg nds_unused_op_result;
begin
    op1 = {1'b0,src1[63:56],chain_byte[6],src1[55:48],chain_byte[5],src1[47:40],chain_byte[4],src1[39:32],chain_byte[3],src1[31:24],chain_byte[2],src1[23:16],chain_byte[1],src1[15:8],chain_byte[0],src1[7:0]};
    op2 = {1'b0,src2[63:56],1'b0,src2[55:48],1'b0,src2[47:40],1'b0,src2[39:32],1'b0,src2[31:24],1'b0,src2[23:16],1'b0,src2[15:8],1'b0,src2[7:0]};
    {nds_unused_op_result,parallel_add_64b_func[64 + 7],parallel_add_64b_func[63:56],parallel_add_64b_func[64 + 6],parallel_add_64b_func[55:48],parallel_add_64b_func[64 + 5],parallel_add_64b_func[47:40],parallel_add_64b_func[64 + 4],parallel_add_64b_func[39:32],parallel_add_64b_func[64 + 3],parallel_add_64b_func[31:24],parallel_add_64b_func[64 + 2],parallel_add_64b_func[23:16],parallel_add_64b_func[64 + 1],parallel_add_64b_func[15:8],parallel_add_64b_func[64 + 0],parallel_add_64b_func[7:0]} = op1 + op2;
end
endfunction
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

