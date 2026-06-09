// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_eb_pipelined (
    clk,
    resetn,
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
input i_valid;
output i_ready;
input [DW - 1:0] din;
output o_valid;
input o_ready;
output [DW - 1:0] dout;





// 63c565f1 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [DW - 1:0] s0;
wire s1;
wire [DW - 1:0] s2;
reg s3;
wire s4;
assign o_valid = s3;
assign i_ready = (~s3 | o_ready);
assign dout = s0;
assign s4 = (s3 & ~o_ready) | i_valid;
always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        s3 <= 1'b0;
    end
    else begin
        s3 <= s4;
    end
end

assign s1 = i_valid & i_ready;
assign s2 = din;
generate
    if (RAR_SUPPORT) begin:gen_data_reset
        always @(posedge clk or negedge resetn) begin
            if (!resetn) begin
                s0 <= {DW{1'b0}};
            end
            else if (s1) begin
                s0 <= s2;
            end
        end

    end
    else begin:gen_data
        always @(posedge clk) begin
            if (s1) begin
                s0 <= s2;
            end
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

