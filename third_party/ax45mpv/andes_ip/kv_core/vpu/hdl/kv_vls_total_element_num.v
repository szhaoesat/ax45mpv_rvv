// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vls_total_element_num (
    eew_onehot,
    total_element_num
);
parameter POWER2 = 0;
parameter ELEN = 32;
parameter ELE_NUM_WIDTH = 6;
parameter WIDTH = 512;
input [4:0] eew_onehot;
output [ELE_NUM_WIDTH - 1:0] total_element_num;





// ceb16cc1 rnd
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
wire s8;
wire s9;
wire s10;
wire s11;
wire s12;
wire s13;
assign s0 = eew_onehot[4];
assign s1 = eew_onehot[0];
assign s2 = eew_onehot[1];
assign s3 = eew_onehot[2];
assign s4 = eew_onehot[3] & (ELEN == 64);
assign s5 = (s4 & (WIDTH == 64));
assign s6 = (s3 & (WIDTH == 64)) | (s4 & (WIDTH == 128));
assign s7 = (s2 & (WIDTH == 64)) | (s3 & (WIDTH == 128)) | (s4 & (WIDTH == 256));
assign s8 = (s1 & (WIDTH == 64)) | (s2 & (WIDTH == 128)) | (s3 & (WIDTH == 256)) | (s4 & (WIDTH == 512));
assign s9 = (s0 & (WIDTH == 64)) | (s1 & (WIDTH == 128)) | (s2 & (WIDTH == 256)) | (s3 & (WIDTH == 512)) | (s4 & (WIDTH == 1024));
assign s10 = (s0 & (WIDTH == 128)) | (s1 & (WIDTH == 256)) | (s2 & (WIDTH == 512)) | (s3 & (WIDTH == 1024));
assign s11 = (s0 & (WIDTH == 256)) | (s1 & (WIDTH == 512)) | (s2 & (WIDTH == 1024));
assign s12 = (s0 & (WIDTH == 512)) | (s1 & (WIDTH == 1024));
assign s13 = (s0 & (WIDTH == 1024));
generate
    if (POWER2 == 0) begin:gen_element_num
        wire [7:0] s14;
        assign s14 = ({8{s5}} & 8'd0) | ({8{s6}} & 8'd1) | ({8{s7}} & 8'd3) | ({8{s8}} & 8'd7) | ({8{s9}} & 8'd15) | ({8{s10}} & 8'd31) | ({8{s11}} & 8'd63) | ({8{s12}} & 8'd127) | ({8{s13}} & 8'd255);
        assign total_element_num = s14[ELE_NUM_WIDTH - 1:0];
    end
    else begin:gen_element_num_power2
        wire [8:0] s14;
        assign s14 = ({9{s5}} & 9'd1) | ({9{s6}} & 9'd2) | ({9{s7}} & 9'd4) | ({9{s8}} & 9'd8) | ({9{s9}} & 9'd16) | ({9{s10}} & 9'd32) | ({9{s11}} & 9'd64) | ({9{s12}} & 9'd128) | ({9{s13}} & 9'd256);
        assign total_element_num = s14[ELE_NUM_WIDTH - 1:0];
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

