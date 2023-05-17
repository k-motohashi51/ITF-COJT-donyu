`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 16:28:28
// Design Name: 
// Module Name: mult
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mult(
    input [7:0] a,
    input [7:0] b,
    output [15:0] x
    );

    wire S11, S12, S13, S14, S15, S16, S17, S18, S19, S1A, S1B, S1C, S1D;
    wire C11, C12, C13, C14, C15, C16, C17, C18, C19, C1A, C1B, C1C, C1D;
    wire S24, S25, S26, S27, S28, S29, S2A;
    wire C24, C25, C26, C27, C28, C29, C2A;
    wire S37;
    wire C37;

    wire S42, S43, S44, S45, S46, S47, S48, S49, S4A, S4B;
    wire C42, C43, C44, C45, C46, C47, C48, C49, C4A, C4B;
    wire S56, S57, S58;
    wire C56, C57, C58;

    wire S63, S64, S65, S66, S67, S68, S69, S6A, S6B, S6C;
    wire C63, C64, C65, C66, C67, C68, C69, C6A, C6B, C6C;

    wire S74, S75, S76, S77, S78, S79, S7A, S7B, S7C, S7D, S7E;
    wire C74, C75, C76, C77, C78, C79, C7A, C7B, C7C, C7D, C7E;

    // row 1
    half_adder ha11(a[1] & b[0], a[0] & b[1],              S11, C11);
    full_adder fa11(a[2] & b[0], a[1] & b[1], a[0] & b[2], S12, C12);
    full_adder fa12(a[3] & b[0], a[2] & b[1], a[1] & b[2], S13, C13);
    full_adder fa13(a[4] & b[0], a[3] & b[1], a[2] & b[2], S14, C14);
    full_adder fa14(a[5] & b[0], a[4] & b[1], a[3] & b[2], S15, C15);
    full_adder fa15(a[6] & b[0], a[5] & b[1], a[4] & b[2], S16, C16);
    full_adder fa16(a[7] & b[0], a[6] & b[1], a[5] & b[2], S17, C17);
    full_adder fa17(a[7] & b[1], a[6] & b[2], a[5] & b[3], S18, C18);
    full_adder fa18(a[7] & b[2], a[6] & b[3], a[5] & b[4], S19, C19);
    full_adder fa19(a[7] & b[3], a[6] & b[4], a[5] & b[5], S1A, C1A);
    full_adder fa1A(a[7] & b[4], a[6] & b[5], a[5] & b[6], S1B, C1B);
    full_adder fa1B(a[7] & b[5], a[6] & b[6], a[5] & b[7], S1C, C1C);
    half_adder ha12(a[7] & b[6], a[6] & b[7],              S1D, C1D);

    half_adder ha13(a[1] & b[3], a[0] & b[4],              S24, C24);
    full_adder fa1C(a[2] & b[3], a[1] & b[4], a[0] & b[5], S25, C25);
    full_adder fa1D(a[3] & b[3], a[2] & b[4], a[1] & b[5], S26, C26);
    full_adder fa1E(a[4] & b[3], a[3] & b[4], a[2] & b[5], S27, C27);
    full_adder fa1F(a[4] & b[4], a[3] & b[5], a[2] & b[6], S28, C28);
    full_adder fa1G(a[4] & b[5], a[3] & b[6], a[2] & b[7], S29, C29);
    half_adder ha14(a[4] & b[6], a[3] & b[7],              S2A, C2A);

    half_adder ha15(a[1] & b[6], a[0] & b[7],              S37, C37);

    // row 2
    half_adder ha21(S12, C11,              S42, C42);
    full_adder fa21(S13, C12, a[0] & b[3], S43, C43);
    full_adder fa22(S14, C13, S24,         S44, C44);
    full_adder fa23(S15, C14, S25,         S45, C45);
    full_adder fa24(S16, C15, S26,         S46, C46);
    full_adder fa25(S17, C16, S27,         S47, C47);
    full_adder fa26(S18, C17, S28,         S48, C48);
    full_adder fa27(S19, C18, S29,         S49, C49);
    full_adder fa28(S1A, C19, S2A,         S4A, C4A);
    full_adder fa29(S1B, C1A, a[4] & b[7], S4B, C4B);

    half_adder ha22(C25, a[0] & b[6],      S56, C56);
    half_adder ha23(C26, S37,              S57, C57);
    full_adder fa2A(C27, a[1] & b[7], C37, S58, C58);

    // row 3
    half_adder ha31(S43, C42,      S63, C63);
    half_adder ha32(S44, C43,      S64, C64);
    full_adder fa31(S45, C44, C24, S65, C65);
    full_adder fa32(S46, C45, S56, S66, C66);
    full_adder fa33(S47, C46, S57, S67, C67);       
    full_adder fa34(S48, C47, S58, S68, C68);
    full_adder fa35(S49, C48, C28, S69, C69);
    full_adder fa36(S4A, C49, C29, S6A, C6A);
    full_adder fa37(S4B, C4A, C2A, S6B, C6B);
    full_adder fa38(S1C, C1B, C4B, S6C, C6C);


    // row 4
    half_adder ha41(S64,         C63,      S74, C74);
    half_adder ha42(S65,         C64,      S75, C75);
    half_adder ha43(S66,         C65,      S76, C76);
    full_adder fa41(S67,         C66, C56, S77, C77);
    full_adder fa42(S68,         C67, C57, S78, C78);
    full_adder fa43(S69,         C68, C58, S79, C79);
    half_adder ha44(S6A,         C69,      S7A, C7A);
    half_adder ha45(S6B,         C6A,      S7B, C7B);
    half_adder ha46(S6C,         C6B,      S7C, C7C);
    full_adder fa44(S1D,         C1C, C6C, S7D, C7D);
    half_adder ha47(a[7] & b[7], C1D,      S7E, C7E);

    assign x = {1'b0, S7E, S7D, S7C, S7B, S7A, S79, S78, S77, S76, S75,  S74,  S63,  S42,  S11, a[0] & b[0]}
             + {C7E,  C7D, C7C, C7B, C7A, C79, C78, C77, C76, C75, C74, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
    
endmodule
