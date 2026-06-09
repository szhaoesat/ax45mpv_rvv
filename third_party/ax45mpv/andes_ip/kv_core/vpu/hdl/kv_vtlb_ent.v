// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vtlb_ent (
    vpu_vlsu_clk,
    vpu_reset_n,
    vtlb_flush,
    vtlb_fill,
    vtlb_enq_tag,
    vtlb_enq_pte,
    vtlb_enq_pte_valid,
    vtlb_enq_pma_mtype,
    vtlb_enq_pma_nosh,
    vtlb_enq_pma_fault,
    vtlb_enq_pmp_permission,
    vtlb_qout_tag,
    vtlb_qout_pte,
    vtlb_qout_valid,
    vtlb_qout_pte_valid,
    vtlb_qout_pma_fault,
    vtlb_qout_pma_mtype,
    vtlb_qout_pma_nosh,
    vtlb_qout_pmp_permission
);
parameter VPN_WIDTH = 26;
parameter PTE_DW = 0;
parameter MMU_SCHEME_INT = 0;
parameter PMA_SUPPORT_INT = 0;
parameter PMP_SUPPORT_INT = 0;
input vpu_vlsu_clk;
input vpu_reset_n;
input vtlb_flush;
input vtlb_fill;
input [VPN_WIDTH - 1:0] vtlb_enq_tag;
input [PTE_DW - 1:0] vtlb_enq_pte;
input vtlb_enq_pte_valid;
input [3:0] vtlb_enq_pma_mtype;
input vtlb_enq_pma_nosh;
input vtlb_enq_pma_fault;
input [3:0] vtlb_enq_pmp_permission;
output [VPN_WIDTH - 1:0] vtlb_qout_tag;
output [PTE_DW - 1:0] vtlb_qout_pte;
output vtlb_qout_valid;
output vtlb_qout_pte_valid;
output vtlb_qout_pma_fault;
output [3:0] vtlb_qout_pma_mtype;
output vtlb_qout_pma_nosh;
output [3:0] vtlb_qout_pmp_permission;





// d1abffe0 rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


reg s0;
reg [VPN_WIDTH - 1:0] s1;
wire s2;
wire s3;
wire s4;
wire s5;
wire s6;
wire s7;
reg s8;
assign s2 = s3 | s4 | s5;
assign s3 = vtlb_fill;
assign s4 = vtlb_flush;
assign s5 = vtlb_fill & ~vtlb_enq_pte_valid;
assign s6 = s4 ? 1'b0 : 1'b1;
assign s7 = (s4 | s5) ? 1'b0 : vtlb_enq_pte_valid;
assign vtlb_qout_tag = s1;
assign vtlb_qout_valid = s0;
assign vtlb_qout_pte_valid = s8;
always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s0 <= 1'b0;
        s8 <= 1'b0;
    end
    else if (s2) begin
        s0 <= s6;
        s8 <= s7;
    end
end

always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
    if (!vpu_reset_n) begin
        s1 <= {VPN_WIDTH{1'b0}};
    end
    else if (vtlb_fill) begin
        s1 <= vtlb_enq_tag;
    end
end

reg s9;
reg [3:0] s10;
reg s11;
always @(posedge vpu_vlsu_clk) begin
    if (vtlb_fill) begin
        s9 <= vtlb_enq_pma_fault;
        s10 <= vtlb_enq_pma_mtype;
        s11 <= vtlb_enq_pma_nosh;
    end
end

assign vtlb_qout_pma_fault = s9;
assign vtlb_qout_pma_mtype = s10;
assign vtlb_qout_pma_nosh = s11;
reg [3:0] s12;
always @(posedge vpu_vlsu_clk) begin
    if (vtlb_fill) begin
        s12 <= vtlb_enq_pmp_permission;
    end
end

assign vtlb_qout_pmp_permission = s12;
generate
    if (MMU_SCHEME_INT != 0) begin:gen_pte_ent
        reg [PTE_DW - 1:0] s13;
        assign vtlb_qout_pte = s13;
        always @(posedge vpu_vlsu_clk) begin
            if (vtlb_fill) begin
                s13 <= vtlb_enq_pte;
            end
        end

    end
    else begin:gen_no_pte_ent
        wire [PTE_DW - 1:0] nds_unused_vtlb_enq_pte = vtlb_enq_pte;
        assign vtlb_qout_pte = {PTE_DW{1'b0}};
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

