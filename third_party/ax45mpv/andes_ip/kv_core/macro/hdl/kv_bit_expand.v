// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_bit_expand (
    out,
    in
);
parameter N = 8;
parameter M = 8;
output [(N * M) - 1:0] out;
input [N - 1:0] in;





// ca46665c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


integer s0;
reg [(N * M) - 1:0] out;
always @(in) begin
    for (s0 = 0; s0 < N; s0 = s0 + 1) begin
        out[s0 * M +:M] = {M{in[s0]}};
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

