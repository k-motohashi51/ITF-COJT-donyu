`timescale 1ns / 10ps

module kadai3 (
    input CLK,
    input RST,
    input WR,
    input RD,
    input [15:0] DIN,

    output [15:0] DOUT,
    output EMPTY,
    output FULL,
    output VALID
);

wire [15:0] mDOUT;
wire [15:0] mDIN;

wire mEMPTY;
wire mVALID;
wire mRD;
wire mAFull;
wire mFULL;
wire mWR;

/***********************************************/
/* êMçÜÇÃê⁄ë± */

fifo u_fifo1 (
    .CLK(CLK),
    .RST(RST),
    .WR(WR),
    .RD(mRD),
    .DIN(DIN),
    .DOUT(mDOUT),
    .FULL(FULL),
    .EMPTY(mEMPTY),
    .VALID(mVALID)
);

fifo u_fifo2 (
    .CLK(CLK),
    .RST(RST),
    .WR(mWR),
    .RD(RD),
    .DIN(mDIN),
    .DOUT(DOUT),
    .almostFULL(mAFull),
    .FULL(mFULL),
    .EMPTY(EMPTY),
    .VALID(VALID)
);

mult ml(
    .a(mDOUT[15:8]),
    .b(mDOUT[7:0]),
    .x(mDIN)
);


assign mRD = !mEMPTY && !mAFull;
assign mWR = mVALID;

endmodule   // kadai3