`timescale 1ns / 1ps

module tb_fifo;
parameter CYCLE = 100;

reg  clk;
reg[63:0] step;

reg rst, we, re;
reg[15:0] din;

wire[15:0] dout;
wire almost_full, full, over, empty, under, valid;

reg [15:0] i;

fifo fifo_inst(clk, rst, we, re, din, dout, almost_full, full, over, empty, under, valid);

always #(CYCLE / 2) clk = ~clk;

always @(posedge clk) step = step + 1;

initial begin
  step <= 0;
  clk <= 0;
  we <= 0;
  re <= 0;
  rst <= 0;
  din <= 16'h0000;

  #(3 * CYCLE)
  @(negedge clk) rst <= 1;
  @(negedge clk);

  rst <= 0;
  we <= 1;
  din <= 16'h0001;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0002;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 0'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0003;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0004;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0005;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0006;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0007;

  if (dout != 16'h0000 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0008;
  if (dout != 16'h0000 || almost_full != 1'b1 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) din <= 16'h0009;

  @(negedge clk) din <= 16'h000a;
  if (dout != 16'h0000 || almost_full != 1'b1 || full != 1'b1 || over != 1'b1 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) we <= 0;
  if (dout != 16'h0000 || almost_full != 1'b1 || full != 1'b1 || over != 1'b1 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) re <= 1;
  if (dout != 16'h0000 || almost_full != 1'b1 || full != 1'b1 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h0001 || almost_full != 1'b1 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h0002 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h0003 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

//Din 11
  @(negedge clk);
  we <= 1;
  din <= 16'h000b;
  if (dout != 16'h0004 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

//Din 12
  @(negedge clk) din <= 16'h000c;
  if (dout != 16'h0005 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk) we <= 0;
  if (dout != 16'h0006 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h0007 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h0008 || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h000b || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h000c || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b1) begin
    $display("FAILURE at %d", step);
    $stop;
  end

//RD = 0
  @(negedge clk) re <= 0;
  if (dout != 16'h000c || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b1 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end

  @(negedge clk);
  if (dout != 16'h000c || almost_full != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b0) begin
    $display("FAILURE at %d", step);
    $stop;
  end
 
  $finish;
end

endmodule
