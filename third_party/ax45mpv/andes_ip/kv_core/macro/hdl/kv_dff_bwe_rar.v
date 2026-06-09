// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_dff_bwe_rar (
    clk,
    rst_n,
    bwe,
    d,
    q
);
parameter BYTES = 1;
input clk;
input rst_n;
input [BYTES - 1:0] bwe;
input [(BYTES * 8) - 1:0] d;
output [(BYTES * 8) - 1:0] q;





// 7966abe4 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [(BYTES * 8) - 1:0] q;
generate
    genvar i;
    for (i = 0; i < BYTES; i = i + 1) begin:gen_byte
        always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                q[i * 8 +:8] <= 8'd0;
            end
            else if (bwe[i]) begin
                q[i * 8 +:8] <= d[i * 8 +:8];
            end
        end

    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

