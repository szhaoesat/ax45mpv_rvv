// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_eb_full_o (
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
parameter RAR_SUPPORT = 0;
input clk;
input resetn;
input clk_en;
input i_valid;
output i_ready;
input [DW - 1:0] din;
output o_valid;
input o_ready;
output [DW - 1:0] dout;





// 0fe47f61 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire [DW - 1:0] s2;
wire s3;
wire s4;
wire [DW - 1:0] s5;
reg [DW - 1:0] s6;
wire s7;
wire [DW - 1:0] s8;
reg s9;
wire s10;
wire s11;
wire s12;
wire [DW - 1:0] s13;
wire s14;
wire s15;
wire [DW - 1:0] s16;
reg [DW - 1:0] s17;
wire s18;
wire [DW - 1:0] s19;
reg s20;
wire s21;
assign s3 = s9;
assign s1 = (~s9 | s4);
assign s5 = s6;
assign s10 = (s9 & ~s4) | s0;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s9 <= 1'b0;
    end
    else if (clk_en) begin
        s9 <= s10;
    end
end

assign s7 = s0 & s1 & clk_en;
assign s8 = s2;
generate
    if (RAR_SUPPORT) begin:gen_p_data_reset
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                s6 <= {DW{1'b0}};
            end
            else if (s7) begin
                s6 <= s8;
            end
        end

    end
    else begin:gen_p_data
        always @(posedge clk) begin
            if (s7) begin
                s6 <= s8;
            end
        end

    end
endgenerate
assign s14 = s20 | s11;
assign s12 = ~s20;
assign s16 = s20 ? s17 : s13;
assign s21 = (s20 | s11) & ~s15;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s20 <= 1'b0;
    end
    else begin
        s20 <= s21;
    end
end

assign s18 = s11 & s12 & ~s15;
assign s19 = s16;
generate
    if (RAR_SUPPORT) begin:gen_b_data_reset
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                s17 <= {DW{1'b0}};
            end
            else if (s18) begin
                s17 <= s19;
            end
        end

    end
    else begin:gen_b_data
        always @(posedge clk) begin
            if (s18) begin
                s17 <= s19;
            end
        end

    end
endgenerate
assign s11 = i_valid;
assign i_ready = s12;
assign s13 = din;
assign s0 = s14;
assign s15 = s1 & clk_en;
assign s2 = s16;
assign o_valid = s3;
assign s4 = o_ready;
assign dout = s5;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

