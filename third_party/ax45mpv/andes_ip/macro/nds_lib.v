// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module nds_mux2 (O, A, B, S);
output  O;
input   A, B, S;





// 5d1f1f23 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = S ? B : A;
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_mux3 (O, A, B, C, S0, S1);
output  O;
input   A, B, C, S0, S1;





// 084bd1bc rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     O;

always @(A or B or C or S0 or S1) begin
    case ({S1, S0})
        2'b00: O = A;
        2'b01: O = B;
        2'b10: O = C;
        2'b11: O = C;
	default: O = 1'bx;
    endcase
end
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_mux4 (O, A, B, C, D, S0, S1);
output  O;
input   A, B, C, D;
input   S0, S1;





// 30ddc71d rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     O;

always @(A or B or C or D or S0 or S1) begin
    case ({S1, S0})
        2'b00: O = A;
        2'b01: O = B;
        2'b10: O = C;
        2'b11: O = D;
	default: O = 1'bx;
    endcase
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_qdffsb (Q, D, CK, SB);
output  Q;
input   D;
input   CK, SB;





// eaee232c rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     Q;

always @(posedge CK or negedge SB) begin
    if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_qdffrb_2 (QB, D, CK, RB);
output  QB;
input   D;
input   CK, RB;





// 1d248427 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
wire QB;
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge RB) begin
	    if (!RB)
		            Q <= 1'b0;
		        else
				        Q <= D;
			end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




			endmodule


module nds_qdffrb (Q, D, CK, RB);
output  Q;
input   D;
input   CK, RB;





// b1f4e0ac rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     Q;

always @(posedge CK or negedge RB) begin
    if (!RB)
        Q <= 1'b0;
    else
        Q <= D;
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_qdffrsb (Q, D, RB, SB, CK);
output  Q;
input   D;
input   RB, SB;
input   CK;





// 2f8ca289 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     Q;

always @(posedge CK or negedge RB or negedge SB) begin
    if (!RB)
        Q <= 1'b0;
    else if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_dffsb (Q, QB, D, CK, SB);
output  Q, QB;
input   D;
input   CK, SB;





// 5c18c706 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge SB) begin
    if (!SB)
        Q <= 1'b1;
    else
        Q <= D;
end

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_dffrb (Q, QB, D, CK, RB);
output  Q, QB;
input   D;
input   CK, RB;





// 8ccf33a7 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif
reg     Q;

assign QB = ~Q;
always @(posedge CK or negedge RB) begin
    if (!RB)
        Q <= 1'b0;
    else
        Q <= D;
end
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_an2 (O, I1, I2);
output  O;
input   I1, I2;





// 72f70c8b rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = I1 & I2;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_an2b1 (O, I1, B1);
output  O;
input   I1, B1;





// e91b5039 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = I1 & (!B1);

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_or2 (O, I1, I2);
output  O;
input   I1, I2;





// 2b9b5eed rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = I1 || I2;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_or3 (O, I1, I2, I3);
output  O;
input   I1, I2, I3;





// 24c79f57 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = I1 || I2 || I3;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_buf (O, I);
output  O;
input   I;





// faac4b9b rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = I;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

module nds_inv (O, I);
output  O;
input   I;





// 6aba07f0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif

assign O = ~I;

`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

