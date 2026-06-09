// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_pma2axcache (
    c2nc,
    pma_mtype,
    arcache,
    awcache
);
input c2nc;
input [3:0] pma_mtype;
output [3:0] arcache;
output [3:0] awcache;





// 77c1173b rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire [3:0] arcache;
wire [3:0] awcache;
wire s0 = (pma_mtype == 4'b0001);
wire s1 = (pma_mtype == 4'b0010);
wire s2 = (pma_mtype == 4'b0011) | ((pma_mtype[3:2] == 2'b01) & c2nc) | ((pma_mtype[3:2] == 2'b10) & c2nc);
wire s3 = ((pma_mtype == 4'b0100) & ~c2nc);
wire s4 = ((pma_mtype == 4'b0101) & ~c2nc);
wire s5 = ((pma_mtype == 4'b1000) & ~c2nc) | ((pma_mtype == 4'b1010) & ~c2nc);
wire s6 = ((pma_mtype == 4'b1001) & ~c2nc) | ((pma_mtype == 4'b1011) & ~c2nc);
assign arcache = ({4{s0}} & 4'b0001) | ({4{s1}} & 4'b0010) | ({4{s2}} & 4'b0011) | ({4{s3}} & 4'b1010) | ({4{s4}} & 4'b1110) | ({4{s5}} & 4'b1011) | ({4{s6}} & 4'b1111);
wire s7 = (pma_mtype == 4'b0001);
wire s8 = (pma_mtype == 4'b0010);
wire s9 = (pma_mtype == 4'b0011) | ((pma_mtype[3:2] == 2'b01) & c2nc) | ((pma_mtype[3:2] == 2'b10) & c2nc);
wire s10 = ((pma_mtype == 4'b0100) & ~c2nc) | ((pma_mtype == 4'b0101) & ~c2nc);
wire s11 = ((pma_mtype == 4'b1000) & ~c2nc) | ((pma_mtype == 4'b1001) & ~c2nc);
wire s12 = ((pma_mtype == 4'b1010) & ~c2nc) | ((pma_mtype == 4'b1011) & ~c2nc);
assign awcache = ({4{s7}} & 4'b0001) | ({4{s8}} & 4'b0010) | ({4{s9}} & 4'b0011) | ({4{s10}} & 4'b0110) | ({4{s11}} & 4'b0111) | ({4{s12}} & 4'b1111);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

