// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_csa3_2 (
    in0,
    in1,
    cin,
    sum,
    cout
);
parameter CSA_WIDTH = 32;
input [CSA_WIDTH - 1:0] in0;
input [CSA_WIDTH - 1:0] in1;
input [CSA_WIDTH - 1:0] cin;
output [CSA_WIDTH - 1:0] sum;
output [CSA_WIDTH - 1:0] cout;





// 182b4a32 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


integer s0;
reg [CSA_WIDTH - 1:0] sum;
reg [CSA_WIDTH - 1:0] cout;
always @(in0 or in1 or cin) begin
    for (s0 = 0; s0 < CSA_WIDTH; s0 = s0 + 1) begin
        cout[s0] = (in0[s0] & in1[s0]) | (in0[s0] & cin[s0]) | (in1[s0] & cin[s0]);
        sum[s0] = (in0[s0] ^ in1[s0] ^ cin[s0]);
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

