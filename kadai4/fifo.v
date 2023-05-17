`timescale 1ns / 1ps

module fifo
(
    input CLK,
    input RST,
    input WR,
    input RD,
    input [15:0] DIN,

    output reg [15:0] DOUT,
    output reg almostFULL,
    output reg FULL,
    output reg OVER,
    output reg EMPTY,
    output reg UNDER,
    output reg VALID
);

reg [2:0] WPTR;         // Write Pointer
reg [2:0] RPTR;         // Read Pointer
reg [15:0] MEM [0:7];   // Memory

/*************************************/
/* Memory */

always @(posedge CLK) begin
    if (WR == 1'b1 && FULL != 1'b1) begin
        MEM[WPTR] <= DIN;
    end
end

/*************************************/
/* Pointer */

// Write Pointer
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        WPTR <= 3'b000;
    end else if (WR == 1'b1 && FULL != 1'b1) begin
        WPTR <= WPTR + 3'b001;
    end
end

// Read Pointer
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        RPTR <= 3'b000;
    end else if (RD == 1'b1 && EMPTY != 1'b1) begin
        RPTR <= RPTR + 3'b001;
    end
end

/*************************************/
/* Write Flag */

// almostFULL
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        almostFULL <= 1'b0;
    end else if (WPTR + 3'b010 == RPTR && WR == 1'b1 && RD == 1'b0) begin
        almostFULL <= 1'b1;
    end else if (WPTR + 3'b001 == RPTR && WR == 1'b0 && RD == 1'b1) begin
        almostFULL <= 1'b0;
    end
end

// FULL
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        FULL <= 1'b0;
    end else if (WPTR + 3'b001 == RPTR && WR == 1'b1 && RD == 1'b0) begin
        FULL <= 1'b1;
    end else if (RPTR == WPTR && RD == 1'b1) begin
        FULL <= 1'b0;
    end
end

// OVER
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        OVER <= 1'b0;
    end else if (FULL == 1'b1 && WR == 1'b1) begin
        OVER <= 1'b1;
    end else begin
        OVER <= 1'b0;
    end
end

/*************************************/
/* Read Flag */

// EMPTY
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        EMPTY <= 1'b1;
    end else if (RPTR + 3'b001 == WPTR && RD == 1'b1 && WR == 1'b0) begin
        EMPTY <= 1'b1;
    end else if (EMPTY == 1'b1 && WR == 1'b1) begin
        EMPTY <= 1'b0;
    end
end

// UNDER
always @(posedge CLK) begin
    if (RST == 1'b1) begin
        UNDER <= 1'b0;
    end else if (EMPTY == 1'b1 && RD == 1'b1) begin
        UNDER <= 1'b1;
    end else begin
        UNDER <= 1'b0;
    end
end

/*************************************/
/* Output Buffer */

always @(posedge CLK) begin
    if (RST == 1'b1) begin
        DOUT <= 16'd0;
    end else if (RD == 1'b1 && EMPTY == 1'b0) begin
        DOUT <= MEM[RPTR];
    end
end

always @(posedge CLK) begin
    if (RST == 1'b1) begin
        VALID <= 1'b0;
    end else if (RD == 1'b1 && EMPTY == 1'b0) begin
        VALID <= 1'b1;
    end else begin
        VALID <= 1'b0;
    end
end

/*************************************/

endmodule   // fifo