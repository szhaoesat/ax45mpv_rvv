// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_seg_num (
    data_in,
    nf,
    data_out
);
parameter WIDTH = 5;
input [WIDTH - 1:0] data_in;
input [2:0] nf;
output [WIDTH - 1:0] data_out;





// fbc7acf2 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire s0;
wire s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
wire [WIDTH - 1:0] s8;
wire [WIDTH - 1:0] s9;
wire [WIDTH - 1:0] s10;
wire [WIDTH - 1:0] s11;
wire [WIDTH - 1:0] s12;
wire [WIDTH - 1:0] s13;
wire [WIDTH - 1:0] s14;
wire [WIDTH - 1:0] s15;
wire nds_unused_data_x3_ov;
wire nds_unused_data_x5_ov;
wire nds_unused_data_x6_ov;
wire nds_unused_data_x7_ov;
assign {nds_unused_data_x3_ov,s10} = s9 + s8;
assign {nds_unused_data_x5_ov,s12} = s11 + s8;
assign {nds_unused_data_x6_ov,s13} = s11 + s9;
assign {nds_unused_data_x7_ov,s14} = s11 + s10;
assign s8 = {data_in[WIDTH - 1:0]};
assign s9 = {data_in[WIDTH - 2:0],1'b0};
assign s11 = {data_in[WIDTH - 3:0],2'b0};
generate
    if (WIDTH > 3) begin:gen_width_gt3
        assign s15 = {data_in[WIDTH - 4:0],3'b0};
    end
    else begin:gen_width_le3
        assign s15 = 3'b0;
    end
endgenerate
assign s0 = (nf == 3'd0);
assign s1 = (nf == 3'd1);
assign s2 = (nf == 3'd2);
assign s3 = (nf == 3'd3);
assign s4 = (nf == 3'd4);
assign s5 = (nf == 3'd5);
assign s6 = (nf == 3'd6);
assign s7 = (nf == 3'd7);
assign data_out = ({WIDTH{s0}} & s8) | ({WIDTH{s1}} & s9) | ({WIDTH{s2}} & s10) | ({WIDTH{s3}} & s11) | ({WIDTH{s4}} & s12) | ({WIDTH{s5}} & s13) | ({WIDTH{s6}} & s14) | ({WIDTH{s7}} & s15);
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

