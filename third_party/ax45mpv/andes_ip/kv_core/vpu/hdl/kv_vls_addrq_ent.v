// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_addrq_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    enq_valid,
    deq_valid,
    shift_valid,
    shift_value,
    enq_addr,
    qout_addr_valid,
    qout_addr
);
parameter W = 64;
parameter ELEN = 64;
input vpu_vlsu_clk;
input vpu_reset_n;
input enq_valid;
input deq_valid;
input shift_valid;
input [1:0] shift_value;
input [W - 1:0] enq_addr;
output qout_addr_valid;
output [W - 1:0] qout_addr;





// ab6707a1 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg [W - 1:0] qout_addr;
wire s0;
wire s1;
reg s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire [W - 1:0] s8;
wire [W - 1:0] s9;
wire [W - 1:0] s10;
wire [W - 1:0] s11;
wire [W - 1:0] s12;
wire [W - 1:0] s13;
assign qout_addr_valid = s2;
assign s0 = enq_valid | deq_valid;
assign s1 = deq_valid ? 1'b0 : 1'b1;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s2 <= 1'b0;
    end
    else if (s0) begin
        s2 <= s1;
    end
end

assign s7 = enq_valid | shift_valid;
assign s8 = enq_valid ? enq_addr : s13;
assign s3 = (shift_value[1:0] == 2'b00);
assign s4 = (shift_value[1:0] == 2'b01);
assign s5 = (shift_value[1:0] == 2'b10);
assign s6 = (shift_value[1:0] == 2'b11) & (ELEN == 64);
assign s9 = {8'b0,qout_addr[W - 1:8]};
assign s10 = {16'b0,qout_addr[W - 1:16]};
assign s11 = {32'b0,qout_addr[W - 1:32]};
generate
    if (W > 64) begin:gen_data_gt64
        assign s12 = {64'b0,qout_addr[W - 1:64]};
    end
    else begin:gen_data_le64
        assign s12 = {W{1'b0}};
    end
endgenerate
assign s13 = ({W{s3}} & s9) | ({W{s4}} & s10) | ({W{s5}} & s11) | ({W{s6}} & s12);
always @(posedge vpu_vlsu_clk) begin
    if (s7) begin
        qout_addr <= s8;
    end
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

