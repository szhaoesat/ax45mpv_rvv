// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_eb_full_i (
    clk,
    resetn,
    clk_en,
    i_valid,
    i_ready,
    din,
    o_valid,
    o_ready,
    dout
);
parameter DW = 32;
parameter SW = (DW < 64) ? 1 : (DW / 64);
parameter OVALID_DUP = 1;
parameter RAR_SUPPORT = 0;
localparam SDW = DW / SW;
localparam EXT = -(SDW * SW) + DW;
input clk;
input resetn;
input clk_en;
input i_valid;
output i_ready;
input [DW - 1:0] din;
output [OVALID_DUP - 1:0] o_valid;
input o_ready;
output [DW - 1:0] dout;





// 1a982955 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [DW - 1:0] s0;
wire [DW - 1:0] s1;
wire s2;
reg [OVALID_DUP - 1:0] s3;
wire [OVALID_DUP - 1:0] s4;
wire [OVALID_DUP - 1:0] s5;
wire [OVALID_DUP - 1:0] s6;
reg s7;
wire s8;
reg [DW - 1:0] s9;
wire [DW - 1:0] s10;
wire s11;
reg [OVALID_DUP - 1:0] s12;
wire [OVALID_DUP - 1:0] s13;
wire [OVALID_DUP - 1:0] s14;
wire [OVALID_DUP - 1:0] s15;
reg [SW - 1:0] s16;
assign s5 = {OVALID_DUP{i_valid & i_ready & clk_en}};
assign s6 = ~s12 | {OVALID_DUP{o_ready}};
assign s4 = (s3 & ~s6) | s5;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s3 <= {OVALID_DUP{1'b0}};
    end
    else begin
        s3 <= s4;
    end
end

assign s8 = ~s4[0] | ~s13[0];
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s7 <= 1'b1;
    end
    else if (clk_en) begin
        s7 <= s8;
    end
end

assign s2 = i_valid & i_ready & clk_en;
assign s1 = din;
generate
    if (RAR_SUPPORT) begin:gen_f0_reset
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                s0 <= {DW{1'b0}};
            end
            else if (s2) begin
                s0 <= s1;
            end
        end

    end
    else begin:gen_f0
        always @(posedge clk) begin
            if (s2) begin
                s0 <= s1;
            end
        end

    end
endgenerate
assign s14 = s3;
assign s15 = (s3 ^ s12) & {OVALID_DUP{o_ready}};
assign s13 = (s12 | s14) & ~s15;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s12 <= {OVALID_DUP{1'b0}};
        s16 <= {SW{1'b0}};
    end
    else begin
        s12 <= s13;
        s16 <= {SW{s13[0]}};
    end
end

assign s11 = s3[0] & ~s12[0] & ~o_ready | s3[0] & s12[0] & o_ready;
assign s10 = s0;
generate
    if (RAR_SUPPORT) begin:gen_f1_reset
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                s9 <= {DW{1'b0}};
            end
            else if (s11) begin
                s9 <= s10;
            end
        end

    end
    else begin:gen_f1
        always @(posedge clk) begin
            if (s11) begin
                s9 <= s10;
            end
        end

    end
endgenerate
assign o_valid = s12 | s3;
assign i_ready = s7;
generate
    genvar i;
    for (i = 0; i < SW; i = i + 1) begin:gen_dout
        if (i == (SW - 1)) begin:gen_dout_last
            assign dout[i * SDW +:(SDW + EXT)] = s16[i] ? s9[i * SDW +:(SDW + EXT)] : s0[i * SDW +:(SDW + EXT)];
        end
        else begin:gen_dout_body
            assign dout[i * SDW +:SDW] = s16[i] ? s9[i * SDW +:SDW] : s0[i * SDW +:SDW];
        end
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

