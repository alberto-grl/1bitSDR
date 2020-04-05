// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.10.2.115
// Netlist written on Fri Dec 14 20:35:30 2018
//
// Verilog Description of module uart_tx
//

module uart_tx (osc_clk, i_Tx_DV, i_Tx_Byte, o_Tx_Active, o_Tx_Serial, 
            o_Tx_Done) /* synthesis syn_module_defined=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(14[8:15])
    input osc_clk;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(17[16:23])
    input i_Tx_DV;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(18[16:23])
    input [7:0]i_Tx_Byte;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    output o_Tx_Active;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(20[16:27])
    output o_Tx_Serial;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(21[16:27])
    output o_Tx_Done;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(22[16:25])
    
    wire osc_clk_c /* synthesis SET_AS_NETWORK=osc_clk_c, is_clock=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(17[16:23])
    
    wire GND_net, VCC_net, i_Tx_Byte_c_7, i_Tx_Byte_c_6, i_Tx_Byte_c_5, 
        i_Tx_Byte_c_4, i_Tx_Byte_c_3, i_Tx_Byte_c_2, i_Tx_Byte_c_1, 
        i_Tx_Byte_c_0, o_Tx_Active_c, o_Tx_Serial_c, o_Tx_Done_c;
    wire [2:0]r_SM_Main;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(31[16:25])
    wire [15:0]r_Clock_Count;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(32[17:30])
    wire [2:0]r_Bit_Index;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(33[16:27])
    wire [7:0]r_Tx_Data;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(34[16:25])
    
    wire r_SM_Main_2__N_40_c_0, o_Tx_Serial_N_75, n849, n16, n736, 
        n79, n78, n76, o_Tx_Done_N_76, n10, n760, n759, n758, 
        n757, n797, osc_clk_c_enable_23, n34, n75, n74, n80, n81, 
        n82, n83, n84, n85, n73, n72, n71, n70, n77, n767, 
        osc_clk_c_enable_22, n3, n732, n856, n855, n802, n854, 
        n10_adj_1, n610, n6, n848, n756, osc_clk_c_enable_26, n755, 
        osc_clk_c_enable_30, n754, n806, osc_clk_c_enable_20, n753, 
        n537, n538, n851, n805;
    
    VHI i2 (.Z(VCC_net));
    LUT4 r_Bit_Index_1__bdd_4_lut_then_4_lut (.A(r_Tx_Data[7]), .B(r_Tx_Data[6]), 
         .C(r_Bit_Index[2]), .D(r_Bit_Index[0]), .Z(n855)) /* synthesis lut_function=(A (B+((D)+!C))+!A !(B (C (D))+!B (C))) */ ;
    defparam r_Bit_Index_1__bdd_4_lut_then_4_lut.init = 16'hafcf;
    FD1P3IX r_Clock_Count_137__i7 (.D(n78), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[7])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i7.GSR = "ENABLED";
    LUT4 i541_3_lut (.A(r_Tx_Data[2]), .B(r_Tx_Data[3]), .C(r_Bit_Index[0]), 
         .Z(n806)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i541_3_lut.init = 16'hcaca;
    LUT4 i4_4_lut (.A(r_Clock_Count[1]), .B(r_Clock_Count[4]), .C(r_Clock_Count[3]), 
         .D(r_Clock_Count[6]), .Z(n10)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i4_4_lut.init = 16'hfffe;
    FD1P3IX r_Clock_Count_137__i1 (.D(n84), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[1])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i1.GSR = "ENABLED";
    OB o_Tx_Active_pad (.I(o_Tx_Active_c), .O(o_Tx_Active));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(20[16:27])
    FD1P3AX o_Tx_Serial_44 (.D(n6), .SP(osc_clk_c_enable_30), .CK(osc_clk_c), 
            .Q(o_Tx_Serial_c));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam o_Tx_Serial_44.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i0 (.D(i_Tx_Byte_c_0), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[0])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i0.GSR = "ENABLED";
    FD1S3IX r_SM_Main_i0 (.D(n538), .CK(osc_clk_c), .CD(r_SM_Main[2]), 
            .Q(r_SM_Main[0])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_SM_Main_i0.GSR = "ENABLED";
    LUT4 r_Bit_Index_1__bdd_4_lut_else_4_lut (.A(r_Tx_Data[5]), .B(r_Tx_Data[4]), 
         .C(r_Bit_Index[2]), .D(r_Bit_Index[0]), .Z(n854)) /* synthesis lut_function=(A (B (C)+!B (C (D)))+!A !(((D)+!C)+!B)) */ ;
    defparam r_Bit_Index_1__bdd_4_lut_else_4_lut.init = 16'ha0c0;
    LUT4 i1_2_lut_3_lut (.A(r_SM_Main[1]), .B(r_SM_Main[0]), .C(r_SM_Main_2__N_40_c_0), 
         .Z(n34)) /* synthesis lut_function=(!(A+(B+!(C)))) */ ;
    defparam i1_2_lut_3_lut.init = 16'h1010;
    LUT4 i540_3_lut (.A(r_Tx_Data[0]), .B(r_Tx_Data[1]), .C(r_Bit_Index[0]), 
         .Z(n805)) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;
    defparam i540_3_lut.init = 16'hcaca;
    OB o_Tx_Serial_pad (.I(o_Tx_Serial_c), .O(o_Tx_Serial));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(21[16:27])
    FD1P3IX r_Clock_Count_137__i9 (.D(n76), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[9])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i9.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i12 (.D(n73), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[12])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i12.GSR = "ENABLED";
    LUT4 i555_3_lut_rep_9 (.A(r_SM_Main[2]), .B(r_SM_Main[1]), .C(r_SM_Main[0]), 
         .Z(n851)) /* synthesis lut_function=(A+!(B (C))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(41[7] 140[14])
    defparam i555_3_lut_rep_9.init = 16'hbfbf;
    FD1P3IX r_Clock_Count_137__i2 (.D(n83), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[2])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i2.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i8 (.D(n77), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[8])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i8.GSR = "ENABLED";
    LUT4 n828_bdd_4_lut (.A(n856), .B(n806), .C(n805), .D(r_Bit_Index[2]), 
         .Z(o_Tx_Serial_N_75)) /* synthesis lut_function=(A (B+(D))+!A !((D)+!C)) */ ;
    defparam n828_bdd_4_lut.init = 16'haad8;
    LUT4 i1_2_lut_3_lut_3_lut (.A(n851), .B(osc_clk_c_enable_20), .C(n848), 
         .Z(osc_clk_c_enable_22)) /* synthesis lut_function=(A (B)+!A (B+(C))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(41[7] 140[14])
    defparam i1_2_lut_3_lut_3_lut.init = 16'hdcdc;
    CCU2D r_Clock_Count_137_add_4_17 (.A0(r_Clock_Count[15]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), 
          .D1(GND_net), .CIN(n760), .S0(n70));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_17.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_17.INIT1 = 16'h0000;
    defparam r_Clock_Count_137_add_4_17.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_17.INJECT1_1 = "NO";
    CCU2D r_Clock_Count_137_add_4_15 (.A0(r_Clock_Count[13]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[14]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n759), .COUT(n760), .S0(n72), 
          .S1(n71));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_15.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_15.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_15.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_15.INJECT1_1 = "NO";
    CCU2D r_Clock_Count_137_add_4_13 (.A0(r_Clock_Count[11]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[12]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n758), .COUT(n759), .S0(n74), 
          .S1(n73));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_13.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_13.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_13.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_13.INJECT1_1 = "NO";
    LUT4 i473_4_lut (.A(r_Clock_Count[2]), .B(r_Clock_Count[7]), .C(n10), 
         .D(r_Clock_Count[5]), .Z(n732)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i473_4_lut.init = 16'hccc8;
    LUT4 i1_2_lut_3_lut_3_lut_4_lut_4_lut (.A(r_SM_Main[2]), .B(r_SM_Main[1]), 
         .C(r_SM_Main[0]), .D(n848), .Z(osc_clk_c_enable_23)) /* synthesis lut_function=(!(A (B+(C))+!A !(B (C (D))+!B !(C)))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(41[7] 140[14])
    defparam i1_2_lut_3_lut_3_lut_4_lut_4_lut.init = 16'h4303;
    OB o_Tx_Done_pad (.I(o_Tx_Done_c), .O(o_Tx_Done));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(22[16:25])
    IB osc_clk_pad (.I(osc_clk), .O(osc_clk_c));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(17[16:23])
    IB r_SM_Main_2__N_40_pad_0 (.I(i_Tx_DV), .O(r_SM_Main_2__N_40_c_0));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(18[16:23])
    IB i_Tx_Byte_pad_7 (.I(i_Tx_Byte[7]), .O(i_Tx_Byte_c_7));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_6 (.I(i_Tx_Byte[6]), .O(i_Tx_Byte_c_6));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_5 (.I(i_Tx_Byte[5]), .O(i_Tx_Byte_c_5));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_4 (.I(i_Tx_Byte[4]), .O(i_Tx_Byte_c_4));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_3 (.I(i_Tx_Byte[3]), .O(i_Tx_Byte_c_3));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_2 (.I(i_Tx_Byte[2]), .O(i_Tx_Byte_c_2));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_1 (.I(i_Tx_Byte[1]), .O(i_Tx_Byte_c_1));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    IB i_Tx_Byte_pad_0 (.I(i_Tx_Byte[0]), .O(i_Tx_Byte_c_0));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(19[16:25])
    LUT4 i136_1_lut_rep_10 (.A(r_SM_Main[2]), .Z(osc_clk_c_enable_30)) /* synthesis lut_function=(!(A)) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam i136_1_lut_rep_10.init = 16'h5555;
    LUT4 i362_3_lut_4_lut_4_lut (.A(r_SM_Main[2]), .B(n848), .C(r_SM_Main[0]), 
         .D(r_SM_Main[1]), .Z(n610)) /* synthesis lut_function=(!(A+!(B+!(C+(D))))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam i362_3_lut_4_lut_4_lut.init = 16'h4445;
    LUT4 i2_3_lut_4_lut_4_lut (.A(r_SM_Main[2]), .B(r_SM_Main_2__N_40_c_0), 
         .C(r_SM_Main[0]), .D(r_SM_Main[1]), .Z(osc_clk_c_enable_20)) /* synthesis lut_function=(!(A+((C+(D))+!B))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam i2_3_lut_4_lut_4_lut.init = 16'h0004;
    LUT4 i1_3_lut (.A(r_SM_Main[1]), .B(r_Bit_Index[0]), .C(r_Bit_Index[1]), 
         .Z(n797)) /* synthesis lut_function=(!((B (C)+!B !(C))+!A)) */ ;
    defparam i1_3_lut.init = 16'h2828;
    FD1P3IX r_Clock_Count_137__i3 (.D(n82), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[3])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i3.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i4 (.D(n81), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[4])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i4.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i5 (.D(n80), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[5])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i5.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i6 (.D(n79), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[6])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i6.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i11 (.D(n74), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[11])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i11.GSR = "ENABLED";
    CCU2D r_Clock_Count_137_add_4_11 (.A0(r_Clock_Count[9]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[10]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n757), .COUT(n758), .S0(n76), 
          .S1(n75));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_11.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_11.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_11.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_11.INJECT1_1 = "NO";
    FD1P3AX r_Tx_Data_i1 (.D(i_Tx_Byte_c_1), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[1])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i1.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i2 (.D(i_Tx_Byte_c_2), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[2])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i2.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i3 (.D(i_Tx_Byte_c_3), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[3])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i3.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i4 (.D(i_Tx_Byte_c_4), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[4])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i4.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i5 (.D(i_Tx_Byte_c_5), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[5])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i5.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i6 (.D(i_Tx_Byte_c_6), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[6])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i6.GSR = "ENABLED";
    FD1P3AX r_Tx_Data_i7 (.D(i_Tx_Byte_c_7), .SP(osc_clk_c_enable_20), .CK(osc_clk_c), 
            .Q(r_Tx_Data[7])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Data_i7.GSR = "ENABLED";
    FD1S3IX r_SM_Main_i1 (.D(n3), .CK(osc_clk_c), .CD(r_SM_Main[2]), .Q(r_SM_Main[1])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_SM_Main_i1.GSR = "ENABLED";
    LUT4 i14_3_lut (.A(o_Tx_Serial_N_75), .B(r_SM_Main[1]), .C(r_SM_Main[0]), 
         .Z(n6)) /* synthesis lut_function=(A (B+!(C))+!A (B (C)+!B !(C))) */ ;
    defparam i14_3_lut.init = 16'hcbcb;
    LUT4 r_SM_Main_2__bdd_4_lut (.A(r_SM_Main[2]), .B(r_SM_Main[0]), .C(r_SM_Main[1]), 
         .D(n848), .Z(o_Tx_Done_N_76)) /* synthesis lut_function=(!(A (B+(C))+!A !(B (C (D))))) */ ;
    defparam r_SM_Main_2__bdd_4_lut.init = 16'h4202;
    LUT4 i415_3_lut (.A(n537), .B(n848), .C(r_SM_Main[0]), .Z(n538)) /* synthesis lut_function=(!(A (B (C))+!A (B+!(C)))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(31[16:25])
    defparam i415_3_lut.init = 16'h3a3a;
    CCU2D r_Clock_Count_137_add_4_9 (.A0(r_Clock_Count[7]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[8]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n756), .COUT(n757), .S0(n78), 
          .S1(n77));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_9.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_9.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_9.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_9.INJECT1_1 = "NO";
    CCU2D r_Clock_Count_137_add_4_7 (.A0(r_Clock_Count[5]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[6]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n755), .COUT(n756), .S0(n80), 
          .S1(n79));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_7.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_7.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_7.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_7.INJECT1_1 = "NO";
    LUT4 i277_4_lut (.A(r_SM_Main_2__N_40_c_0), .B(n849), .C(r_SM_Main[1]), 
         .D(n848), .Z(n537)) /* synthesis lut_function=(A (B ((D)+!C)+!B !(C))+!A (B (C (D)))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(41[7] 140[14])
    defparam i277_4_lut.init = 16'hca0a;
    LUT4 i4_4_lut_adj_1 (.A(n736), .B(r_Clock_Count[13]), .C(r_Clock_Count[15]), 
         .D(r_Clock_Count[14]), .Z(n10_adj_1)) /* synthesis lut_function=(A+(B+(C+(D)))) */ ;
    defparam i4_4_lut_adj_1.init = 16'hfffe;
    LUT4 i477_4_lut (.A(r_Clock_Count[9]), .B(r_Clock_Count[10]), .C(n732), 
         .D(r_Clock_Count[8]), .Z(n736)) /* synthesis lut_function=(A (B)+!A (B (C+(D)))) */ ;
    defparam i477_4_lut.init = 16'hccc8;
    LUT4 i552_4_lut (.A(r_SM_Main[2]), .B(r_SM_Main[1]), .C(r_SM_Main[0]), 
         .D(n848), .Z(osc_clk_c_enable_26)) /* synthesis lut_function=(!(A+(B (C+!(D))+!B (C)))) */ ;
    defparam i552_4_lut.init = 16'h0501;
    LUT4 i2_2_lut_rep_7_3_lut (.A(r_Bit_Index[1]), .B(r_Bit_Index[0]), .C(r_Bit_Index[2]), 
         .Z(n849)) /* synthesis lut_function=(A (B (C))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(96[36:54])
    defparam i2_2_lut_rep_7_3_lut.init = 16'h8080;
    FD1P3IX r_Clock_Count_137__i10 (.D(n75), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[10])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i10.GSR = "ENABLED";
    CCU2D r_Clock_Count_137_add_4_5 (.A0(r_Clock_Count[3]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[4]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n754), .COUT(n755), .S0(n82), 
          .S1(n81));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_5.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_5.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_5.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_5.INJECT1_1 = "NO";
    FD1P3AX r_Tx_Active_46 (.D(n34), .SP(osc_clk_c_enable_22), .CK(osc_clk_c), 
            .Q(o_Tx_Active_c)) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Active_46.GSR = "ENABLED";
    FD1P3AX r_Tx_Done_43 (.D(o_Tx_Done_N_76), .SP(osc_clk_c_enable_23), 
            .CK(osc_clk_c), .Q(o_Tx_Done_c)) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Tx_Done_43.GSR = "ENABLED";
    LUT4 i2_4_lut (.A(r_Bit_Index[0]), .B(r_SM_Main[1]), .C(r_SM_Main[0]), 
         .D(n848), .Z(n802)) /* synthesis lut_function=(!(A+((C+!(D))+!B))) */ ;
    defparam i2_4_lut.init = 16'h0400;
    LUT4 i14_3_lut_adj_2 (.A(r_SM_Main[0]), .B(r_SM_Main[1]), .C(n848), 
         .Z(n3)) /* synthesis lut_function=(!(A (B (C)+!B !(C))+!A !(B))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(31[16:25])
    defparam i14_3_lut_adj_2.init = 16'h6c6c;
    LUT4 i5_3_lut_rep_6 (.A(r_Clock_Count[11]), .B(n10_adj_1), .C(r_Clock_Count[12]), 
         .Z(n848)) /* synthesis lut_function=(A+(B+(C))) */ ;
    defparam i5_3_lut_rep_6.init = 16'hfefe;
    LUT4 i2_4_lut_3_lut_4_lut (.A(r_Bit_Index[1]), .B(r_Bit_Index[0]), .C(r_SM_Main[1]), 
         .D(r_Bit_Index[2]), .Z(n767)) /* synthesis lut_function=(!(A (B ((D)+!C)+!B !(C (D)))+!A !(C (D)))) */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(96[36:54])
    defparam i2_4_lut_3_lut_4_lut.init = 16'h7080;
    VLO i1 (.Z(GND_net));
    FD1P3AX r_Bit_Index_i0 (.D(n802), .SP(osc_clk_c_enable_26), .CK(osc_clk_c), 
            .Q(r_Bit_Index[0])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Bit_Index_i0.GSR = "ENABLED";
    PFUMX i572 (.BLUT(n854), .ALUT(n855), .C0(r_Bit_Index[1]), .Z(n856));
    CCU2D r_Clock_Count_137_add_4_3 (.A0(r_Clock_Count[1]), .B0(GND_net), 
          .C0(GND_net), .D0(GND_net), .A1(r_Clock_Count[2]), .B1(GND_net), 
          .C1(GND_net), .D1(GND_net), .CIN(n753), .COUT(n754), .S0(n84), 
          .S1(n83));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_3.INIT0 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_3.INIT1 = 16'hfaaa;
    defparam r_Clock_Count_137_add_4_3.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_3.INJECT1_1 = "NO";
    FD1S3IX r_SM_Main_i2 (.D(n848), .CK(osc_clk_c), .CD(n851), .Q(r_SM_Main[2])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_SM_Main_i2.GSR = "ENABLED";
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    FD1P3AX r_Bit_Index_i2 (.D(n767), .SP(osc_clk_c_enable_26), .CK(osc_clk_c), 
            .Q(r_Bit_Index[2])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Bit_Index_i2.GSR = "ENABLED";
    FD1P3AX r_Bit_Index_i1 (.D(n797), .SP(osc_clk_c_enable_26), .CK(osc_clk_c), 
            .Q(r_Bit_Index[1])) /* synthesis lse_init_val=0 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(38[10] 141[8])
    defparam r_Bit_Index_i1.GSR = "ENABLED";
    GSR GSR_INST (.GSR(VCC_net));
    CCU2D r_Clock_Count_137_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), 
          .D0(GND_net), .A1(n16), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .COUT(n753), .S1(n85));   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137_add_4_1.INIT0 = 16'hF000;
    defparam r_Clock_Count_137_add_4_1.INIT1 = 16'h0555;
    defparam r_Clock_Count_137_add_4_1.INJECT1_0 = "NO";
    defparam r_Clock_Count_137_add_4_1.INJECT1_1 = "NO";
    FD1P3IX r_Clock_Count_137__i15 (.D(n70), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[15])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i15.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i14 (.D(n71), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[14])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i14.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i0 (.D(n85), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(n16)) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i0.GSR = "ENABLED";
    FD1P3IX r_Clock_Count_137__i13 (.D(n72), .SP(osc_clk_c_enable_30), .CD(n610), 
            .CK(osc_clk_c), .Q(r_Clock_Count[13])) /* synthesis syn_use_carry_chain=1 */ ;   // c:/users/user/lattice/fpgasdr/impl1/source/uarttx.v(116[34:54])
    defparam r_Clock_Count_137__i13.GSR = "ENABLED";
    TSALL TSALL_INST (.TSALL(GND_net));
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

//
// Verilog Description of module TSALL
// module not written out since it is a black-box. 
//

