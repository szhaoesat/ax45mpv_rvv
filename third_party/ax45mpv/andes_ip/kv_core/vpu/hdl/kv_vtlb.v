// Copyright (C) 2024, Andes Technology Corp. Confidential Proprietary
// AX45MPV_PREMIUM v30.1.0

module kv_vtlb (
    vpu_vlsu_clk,
    vpu_reset_n,
    vpu_vtlb_flush,
    vlsq2vtlb_req_valid,
    vlsq2vtlb_req_ready,
    vlsq2vtlb_req_va2pa_en,
    vlsq2vtlb_req_va,
    vlsq2vtlb_cmt_valid,
    vlsq2vtlb_cmt_kill,
    vlsq2vtlb_resp_ppn,
    vlsq2vtlb_resp_data,
    vpu_pma_req_pa,
    vpu_pma_resp_fault,
    vpu_pma_resp_hvm,
    vpu_pma_resp_mtype,
    vpu_pma_resp_nosh,
    vpu_pmp_req_pa,
    vpu_pmp_resp_permission,
    vpu_vtlb_miss_req,
    vpu_vtlb_miss_vpn,
    vpu_vtlb_miss_resp,
    vpu_vtlb_miss_data
);
parameter VALEN = 38;
parameter PALEN = 38;
parameter VPN_WIDTH = VALEN - 12;
parameter PPN_WIDTH = PALEN - 12;
parameter VTLB_ENTRIES = 8;
parameter MMU_SCHEME_INT = 0;
parameter PMA_SUPPORT_INT = 0;
parameter PMP_SUPPORT_INT = 0;
localparam VTLB_V_BIT = 0;
localparam VTLB_X_BIT = VTLB_V_BIT + 1;
localparam VTLB_W_BIT = VTLB_X_BIT + 1;
localparam VTLB_R_BIT = VTLB_W_BIT + 1;
localparam VTLB_U_BIT = VTLB_R_BIT + 1;
localparam VTLB_G_BIT = VTLB_U_BIT + 1;
localparam VTLB_A_BIT = VTLB_G_BIT + 1;
localparam VTLB_D_BIT = VTLB_A_BIT + 1;
localparam VTLB_PAGE_FAULT_BIT = VTLB_D_BIT + 1;
localparam VTLB_PTW_ACCESS_FAULT_BIT = VTLB_PAGE_FAULT_BIT + 1;
localparam VTLB_MDCAUSE_LSB = VTLB_PTW_ACCESS_FAULT_BIT + 1;
localparam VTLB_MDCAUSE_MSB = VTLB_MDCAUSE_LSB + 3 - 1;
localparam VTLB_ECC_CODE_LSB = VTLB_MDCAUSE_MSB + 1;
localparam VTLB_ECC_CODE_MSB = VTLB_ECC_CODE_LSB + 8 - 1;
localparam VTLB_ECC_CORR_BIT = VTLB_ECC_CODE_MSB + 1;
localparam VTLB_ECC_RAMID_LSB = VTLB_ECC_CORR_BIT + 1;
localparam VTLB_ECC_RAMID_MSB = VTLB_ECC_RAMID_LSB + 4 - 1;
localparam VTLB_PPN_LSB = VTLB_ECC_RAMID_MSB + 1;
localparam VTLB_PPN_MSB = VTLB_PPN_LSB + PALEN - 12 - 1;
localparam VTLB_MSB = VTLB_PPN_MSB;
localparam PTE_DW = VTLB_MSB + 1;
input vpu_vlsu_clk;
input vpu_reset_n;
input vpu_vtlb_flush;
input vlsq2vtlb_req_valid;
output vlsq2vtlb_req_ready;
input vlsq2vtlb_req_va2pa_en;
input [VALEN - 1:0] vlsq2vtlb_req_va;
input vlsq2vtlb_cmt_valid;
input vlsq2vtlb_cmt_kill;
output [PPN_WIDTH - 1:0] vlsq2vtlb_resp_ppn;
output [35 - 1:0] vlsq2vtlb_resp_data;
output [PALEN - 1:0] vpu_pma_req_pa;
input vpu_pma_resp_fault;
input vpu_pma_resp_hvm;
input [3:0] vpu_pma_resp_mtype;
input vpu_pma_resp_nosh;
output [PALEN - 1:0] vpu_pmp_req_pa;
input [3:0] vpu_pmp_resp_permission;
output vpu_vtlb_miss_req;
output [(VALEN - 1):12] vpu_vtlb_miss_vpn;
input vpu_vtlb_miss_resp;
input [(13 + PALEN):0] vpu_vtlb_miss_data;





// 8f5e35ee rnd
`ifndef NDS_FPGA
// synthesis translate_off
`endif


wire nds_unused_vpu_pma_resp_hvm = vpu_pma_resp_hvm;
generate
    if (VTLB_ENTRIES != 0) begin:gen_vtlb
        wire [VPN_WIDTH - 1:0] vtlb_enq_tag;
        wire [PTE_DW - 1:0] vtlb_enq_pte;
        wire vtlb_enq_pte_valid;
        wire vtlb_enq_pma_fault;
        wire [3:0] vtlb_enq_pma_mtype;
        wire vtlb_enq_pma_nosh;
        wire [3:0] vtlb_enq_pmp_permission;
        wire [VTLB_ENTRIES - 1:0] s0;
        wire [VTLB_ENTRIES - 1:0] s1;
        wire [(VTLB_ENTRIES * VPN_WIDTH) - 1:0] s2;
        wire [(VTLB_ENTRIES * PTE_DW) - 1:0] s3;
        wire [VTLB_ENTRIES - 1:0] s4;
        wire [(VTLB_ENTRIES * 4) - 1:0] s5;
        wire [VTLB_ENTRIES - 1:0] s6;
        wire [(VTLB_ENTRIES * 4) - 1:0] s7;
        wire [VTLB_ENTRIES - 1:0] s8;
        wire [VTLB_ENTRIES - 1:0] s9;
        wire s10;
        wire [VTLB_ENTRIES - 1:0] s11;
        wire [VTLB_ENTRIES - 1:0] s12;
        wire [VTLB_ENTRIES - 1:0] s13;
        wire [VTLB_ENTRIES - 1:0] s14;
        wire s15;
        wire s16;
        wire [VTLB_ENTRIES - 1:0] s17;
        wire [3:0] s18;
        wire s19;
        wire s20;
        wire [3:0] s21;
        wire [PTE_DW - 1:0] s22;
        wire [VPN_WIDTH - 1:0] s23;
        reg [VALEN - 1:0] s24;
        reg [VTLB_ENTRIES - 1:0] s25;
        wire s26;
        wire s27;
        wire s28;
        wire s29;
        reg s30;
        wire s31;
        wire [VPN_WIDTH - 1:0] s32;
        wire [PTE_DW - 1:0] s33;
        wire s34;
        wire [3:0] s35;
        wire s36;
        wire [3:0] s37;
        wire s38;
        wire [VTLB_ENTRIES - 1:0] s39;
        wire [VTLB_ENTRIES - 1:0] s40;
        reg s41;
        wire s42;
        wire s43;
        wire s44;
        wire s45;
        kv_mux_onehot #(
            .N(VTLB_ENTRIES),
            .W(4)
        ) u_vtlb_pma_mtype (
            .out(s18),
            .sel(s11),
            .in(s5)
        );
        kv_mux_onehot #(
            .N(VTLB_ENTRIES),
            .W(1)
        ) u_vtlb_pma_nosh (
            .out(s19),
            .sel(s11),
            .in(s6)
        );
        kv_mux_onehot #(
            .N(VTLB_ENTRIES),
            .W(1)
        ) u_vtlb_pma_fault (
            .out(s20),
            .sel(s11),
            .in(s4)
        );
        kv_mux_onehot #(
            .N(VTLB_ENTRIES),
            .W(4)
        ) u_vtlb_pmp_permission (
            .out(s21),
            .sel(s11),
            .in(s7)
        );
        kv_mux_onehot #(
            .N(VTLB_ENTRIES),
            .W(PTE_DW)
        ) u_vtlb_pte (
            .out(s22),
            .sel(s11),
            .in(s3)
        );
        genvar i;
        for (i = 0; i < VTLB_ENTRIES; i = i + 1) begin:gen_vtlb_ent
            kv_vtlb_ent #(
                .VPN_WIDTH(VPN_WIDTH),
                .PTE_DW(PTE_DW),
                .MMU_SCHEME_INT(MMU_SCHEME_INT),
                .PMA_SUPPORT_INT(PMA_SUPPORT_INT),
                .PMP_SUPPORT_INT(PMP_SUPPORT_INT)
            ) u_vtlb_ent (
                .vpu_vlsu_clk(vpu_vlsu_clk),
                .vpu_reset_n(vpu_reset_n),
                .vtlb_flush(s8[i]),
                .vtlb_fill(s9[i]),
                .vtlb_enq_tag(vtlb_enq_tag),
                .vtlb_enq_pte(vtlb_enq_pte),
                .vtlb_enq_pte_valid(vtlb_enq_pte_valid),
                .vtlb_enq_pma_fault(vtlb_enq_pma_fault),
                .vtlb_enq_pma_mtype(vtlb_enq_pma_mtype),
                .vtlb_enq_pma_nosh(vtlb_enq_pma_nosh),
                .vtlb_enq_pmp_permission(vtlb_enq_pmp_permission),
                .vtlb_qout_valid(s0[i]),
                .vtlb_qout_pte_valid(s1[i]),
                .vtlb_qout_tag(s2[i * VPN_WIDTH +:VPN_WIDTH]),
                .vtlb_qout_pte(s3[i * PTE_DW +:PTE_DW]),
                .vtlb_qout_pma_fault(s4[i]),
                .vtlb_qout_pma_mtype(s5[i * 4 +:4]),
                .vtlb_qout_pma_nosh(s6[i]),
                .vtlb_qout_pmp_permission(s7[i * 4 +:4])
            );
            assign s12[i] = ~vlsq2vtlb_req_va2pa_en & s0[i] & (s23 == s2[i * VPN_WIDTH +:VPN_WIDTH]) & ~s1[i];
            assign s13[i] = vlsq2vtlb_req_va2pa_en & s1[i] & (s23 == s2[i * VPN_WIDTH +:VPN_WIDTH]);
            assign s11[i] = s12[i] | s13[i];
            assign s14[i] = s16 & s17[i];
        end
        assign s23 = vlsq2vtlb_req_va[VALEN - 1:12];
        assign vtlb_enq_tag = s32;
        assign vtlb_enq_pte = s33;
        assign vtlb_enq_pma_fault = s34;
        assign vtlb_enq_pma_mtype = s35;
        assign vtlb_enq_pma_nosh = s36;
        assign vtlb_enq_pmp_permission = s37;
        assign vtlb_enq_pte_valid = (s30 & vpu_vtlb_miss_resp);
        assign s15 = |s11;
        assign s16 = ~s15;
        assign s10 = (vlsq2vtlb_req_va2pa_en & vlsq2vtlb_cmt_valid & ~vlsq2vtlb_cmt_kill) | (~vlsq2vtlb_req_va2pa_en);
        assign vlsq2vtlb_req_ready = s15 & ~s30;
        assign s43 = s44 | s45;
        assign s42 = s45 ? 1'b0 : 1'b1;
        assign s44 = vlsq2vtlb_req_valid & s16 & ~s41 & s10;
        assign s45 = s41 & ((s30 & vpu_vtlb_miss_resp) | (~s30));
        assign s8 = {VTLB_ENTRIES{vpu_vtlb_flush}};
        assign s9 = {VTLB_ENTRIES{s31}} & s40;
        assign vpu_pma_req_pa = s30 ? {vpu_vtlb_miss_data[VTLB_PPN_MSB:VTLB_PPN_LSB],s24[11:0]} : s24[PALEN - 1:0];
        assign vpu_pmp_req_pa = s30 ? {vpu_vtlb_miss_data[VTLB_PPN_MSB:VTLB_PPN_LSB],s24[11:0]} : s24[PALEN - 1:0];
        assign s31 = s41 & ((s30 & vpu_vtlb_miss_resp) | (~s30));
        assign s32 = s24[VALEN - 1:12];
        assign s34 = vpu_pma_resp_fault;
        assign s35 = vpu_pma_resp_mtype;
        assign s36 = vpu_pma_resp_nosh;
        assign s37 = vpu_pmp_resp_permission;
        assign s33 = vpu_vtlb_miss_data;
        assign s38 = (vlsq2vtlb_req_valid & s15) | s31;
        assign s39 = s31 ? s25 : s11;
        assign s40 = s31 ? s25 : {VTLB_ENTRIES{1'b0}};
        always @(posedge vpu_vlsu_clk) begin
            if (s44) begin
                s24 <= vlsq2vtlb_req_va;
                s25 <= s14;
            end
        end

        always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s41 <= 1'b0;
            end
            else if (s43) begin
                s41 <= s42;
            end
        end

        assign s26 = vlsq2vtlb_req_valid & s16 & vlsq2vtlb_req_va2pa_en & s10 & ~s30;
        assign s27 = s30 & vpu_vtlb_miss_resp;
        assign s28 = s26 | s27;
        assign s29 = s27 ? 1'b0 : 1'b1;
        always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
            if (!vpu_reset_n) begin
                s30 <= 1'b0;
            end
            else if (s28) begin
                s30 <= s29;
            end
        end

        assign vpu_vtlb_miss_req = s30;
        assign vpu_vtlb_miss_vpn = s24[VALEN - 1:12];
        assign vlsq2vtlb_resp_data[25] = s20;
        assign vlsq2vtlb_resp_data[26 +:4] = s18;
        assign vlsq2vtlb_resp_data[30] = s19;
        assign vlsq2vtlb_resp_data[31 +:4] = s21;
        assign vlsq2vtlb_resp_data[22] = s22[VTLB_V_BIT];
        assign vlsq2vtlb_resp_data[20] = s22[VTLB_R_BIT];
        assign vlsq2vtlb_resp_data[23] = s22[VTLB_W_BIT];
        assign vlsq2vtlb_resp_data[24] = s22[VTLB_X_BIT];
        assign vlsq2vtlb_resp_data[21] = s22[VTLB_U_BIT];
        assign vlsq2vtlb_resp_data[0] = s22[VTLB_A_BIT];
        assign vlsq2vtlb_resp_data[2] = s22[VTLB_D_BIT];
        assign vlsq2vtlb_resp_data[19] = s22[VTLB_PAGE_FAULT_BIT];
        assign vlsq2vtlb_resp_data[1] = s22[VTLB_PTW_ACCESS_FAULT_BIT];
        assign vlsq2vtlb_resp_data[3 +:3] = s22[VTLB_MDCAUSE_MSB:VTLB_MDCAUSE_LSB];
        assign vlsq2vtlb_resp_data[6 +:8] = s22[VTLB_ECC_CODE_MSB:VTLB_ECC_CODE_LSB];
        assign vlsq2vtlb_resp_data[14] = s22[VTLB_ECC_CORR_BIT];
        assign vlsq2vtlb_resp_data[15 +:4] = s22[VTLB_ECC_RAMID_MSB:VTLB_ECC_RAMID_LSB];
        assign vlsq2vtlb_resp_ppn = s22[VTLB_PPN_MSB:VTLB_PPN_LSB];
        if (VTLB_ENTRIES == 8) begin:gen_vtlb8_lru
            reg [2:0] s46;
            reg [2:0] s47;
            wire [6:0] s48;
            reg [(VTLB_ENTRIES - 2):0] s49;
            wire [(VTLB_ENTRIES - 2):0] s50;
            always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    s49 <= {(VTLB_ENTRIES - 1){1'b0}};
                end
                else if (s38) begin
                    s49 <= s50[(VTLB_ENTRIES - 2):0];
                end
            end

            always @(posedge vpu_vlsu_clk or negedge vpu_reset_n) begin
                if (!vpu_reset_n) begin
                    s46 <= 3'b0;
                    s47 <= 3'b0;
                end
                else if (|s40) begin
                    s46[0] <= s49[0];
                    if (|s40[3:0]) begin
                        s46[1] <= s49[1];
                    end
                    if (|s40[7:4]) begin
                        s46[2] <= s49[2];
                    end
                    s47 <= (s46 ^~ s49[2:0]);
                end
            end

            assign s17[0] = ~s48[0] & ~s48[1] & ~s48[3];
            assign s17[1] = ~s48[0] & ~s48[1] & s48[3];
            assign s17[2] = ~s48[0] & s48[1] & ~s48[4];
            assign s17[3] = ~s48[0] & s48[1] & s48[4];
            assign s17[4] = s48[0] & ~s48[2] & ~s48[5];
            assign s17[5] = s48[0] & ~s48[2] & s48[5];
            assign s17[6] = s48[0] & s48[2] & ~s48[6];
            assign s17[7] = s48[0] & s48[2] & s48[6];
            assign s48[0] = (s49[0] & ~(&s0[7:4])) | (s49[0] & (&s0[3:0])) | ((&s0[3:0]) & ~(&s0[7:4]));
            assign s48[1] = (s49[1] & ~(&s0[3:2])) | (s49[1] & (&s0[1:0])) | ((&s0[1:0]) & ~(&s0[3:2]));
            assign s48[2] = (s49[2] & ~(&s0[7:6])) | (s49[2] & (&s0[5:4])) | ((&s0[5:4]) & ~(&s0[7:6]));
            assign s48[3] = (s49[3] & ~s0[1]) | (s49[3] & s0[0]) | (s0[0] & ~s0[1]);
            assign s48[4] = (s49[4] & ~s0[3]) | (s49[4] & s0[2]) | (s0[2] & ~s0[3]);
            assign s48[5] = (s49[5] & ~s0[5]) | (s49[5] & s0[4]) | (s0[4] & ~s0[5]);
            assign s48[6] = (s49[6] & ~s0[7]) | (s49[6] & s0[6]) | (s0[6] & ~s0[7]);
            assign s50[0] = s47[0] ? ~s49[0] : |s39[3:0];
            assign s50[1] = s47[1] ? ~s49[1] : |s39[3:0] ? |s39[1:0] : s49[1];
            assign s50[2] = s47[2] ? ~s49[2] : |s39[7:4] ? |s39[5:4] : s49[2];
            assign s50[3] = |s39[1:0] ? s39[0] : s49[3];
            assign s50[4] = |s39[3:2] ? s39[2] : s49[4];
            assign s50[5] = |s39[5:4] ? s39[4] : s49[5];
            assign s50[6] = |s39[7:6] ? s39[6] : s49[6];
        end
    end
    else begin:gen_vtlb_stub
        assign vlsq2vtlb_req_ready = 1'b1;
        assign vpu_pma_req_pa = vlsq2vtlb_req_va[PALEN - 1:0];
        assign vpu_pmp_req_pa = vlsq2vtlb_req_va[PALEN - 1:0];
        assign vlsq2vtlb_resp_data[25] = vpu_pma_resp_fault;
        assign vlsq2vtlb_resp_data[26 +:4] = vpu_pma_resp_mtype;
        assign vlsq2vtlb_resp_data[30] = vpu_pma_resp_nosh;
        assign vlsq2vtlb_resp_data[31 +:4] = vpu_pmp_resp_permission;
        assign vlsq2vtlb_resp_data[22] = 1'b0;
        assign vlsq2vtlb_resp_data[20] = 1'b0;
        assign vlsq2vtlb_resp_data[23] = 1'b0;
        assign vlsq2vtlb_resp_data[24] = 1'b0;
        assign vlsq2vtlb_resp_data[21] = 1'b0;
        assign vlsq2vtlb_resp_data[0] = 1'b0;
        assign vlsq2vtlb_resp_data[2] = 1'b0;
        assign vlsq2vtlb_resp_data[19] = 1'b0;
        assign vlsq2vtlb_resp_data[1] = 1'b0;
        assign vlsq2vtlb_resp_data[3 +:3] = 3'b0;
        assign vlsq2vtlb_resp_data[6 +:8] = 8'b0;
        assign vlsq2vtlb_resp_data[14] = 1'b0;
        assign vlsq2vtlb_resp_data[15 +:4] = 4'b0;
        assign vlsq2vtlb_resp_ppn = vlsq2vtlb_req_va[PALEN - 1:12];
        assign vpu_vtlb_miss_req = 1'b0;
        assign vpu_vtlb_miss_vpn = {(VALEN - 12){1'b0}};
        wire nds_unused_vpu_vtlb_miss_resp = vpu_vtlb_miss_resp;
        wire [(13 + PALEN):0] nds_unused_vpu_vtlb_miss_data = vpu_vtlb_miss_data;
    end
endgenerate
`ifndef NDS_FPGA
// synthesis translate_on
`endif




endmodule

