`timescale 1ns / 1ps

module kadai4 (
    input CLK,
    input RST,
    input [7:0] A,
    input [7:0] B,
    input ACK,
    input START,
    input HALT,

    output [15:0] X,
    output X_VALID,
    output REQ_AB
);

/*************************************/

reg [1:0] CUR;
reg [1:0] NXT;

wire UNI_RST;
wire WR_0, WR_1;
wire RD_0, RD_1;
wire FULL_0, FULL_1;
wire EMPTY_0, EMPTY_1;
wire [15:0] DOUT_0;
wire [15:0] DIN_1;
wire VALID_0;

/*************************************/

fifo u_fifo0 (
    .CLK(CLK),
    .RST(UNI_RST),
    .WR(WR_0),
    .RD(RD_0),
    .DIN({A, B}),
    .DOUT(DOUT_0),
    .FULL(FULL_0),
    .EMPTY(EMPTY_0),
    .VALID(VALID_0)
);

mult ml (
    .a(DOUT_0[15:8]),
    .b(DOUT_0[7:0]),
    .x(DIN_1)
);

fifo u_fifo1 (
    .CLK(CLK),
    .RST(UNI_RST),
    .WR(WR_1),
    .RD(RD_1),
    .DIN(DIN_1),
    .DOUT(X),
    .FULL(FULL_1),
    .EMPTY(EMPTY_1),
    .VALID(X_VALID)
);

/*************************************/
/* Allocate value to State */
localparam  S_IDLE = 2'b00,
            S_INPUT = 2'b01,
            S_EXEC = 2'b10,
            S_OUTPUT = 2'b11;

/*************************************/

assign UNI_RST = RST || HALT;

/*************************************/
/* State Register */

always @(posedge CLK) begin
    if (RST == 1'b1) begin
        CUR <= S_IDLE;
    end else begin
        CUR <= NXT;
    end
end

/*************************************/
/* State Generation Circuit */

always @* begin
    case (CUR)
        S_IDLE:     
            if (START == 1'b1) begin
                NXT <= S_INPUT;
            end else begin
                NXT <= S_IDLE;
            end
        S_INPUT:
            if (HALT == 1'b1) begin
                NXT <= S_IDLE;
            end else if (FULL_0 == 1'b1) begin
                NXT <= S_EXEC;
            end else begin
                NXT <= S_INPUT;
            end
        S_EXEC:
            if (HALT == 1'b1) begin
                NXT <= S_IDLE;
            end else if (FULL_1 == 1'b1) begin
                NXT <= S_OUTPUT;
            end else begin
                NXT <= S_EXEC;
            end
        S_OUTPUT:
            if (HALT == 1'b1) begin
                NXT <= S_IDLE;
            end else if (EMPTY_1 == 1'b1) begin
                NXT <= S_IDLE;
            end else begin
                NXT <= S_OUTPUT;
            end
        default:
            NXT <= S_IDLE;
    endcase
end

/*************************************/
/* S_INPUT */

assign REQ_AB = (CUR == S_INPUT) && !FULL_0;
assign WR_0 = (CUR == S_INPUT) && REQ_AB && ACK;

/*************************************/
/* S_EXEC */

assign RD_0 = (CUR == S_EXEC) && !EMPTY_0 && !FULL_1;
assign WR_1 = (CUR == S_EXEC) && VALID_0;

/*************************************/
/* S_OUTPUT */

assign RD_1 = (CUR == S_OUTPUT) && !EMPTY_1;

/*************************************/

endmodule   // kadai4