`timescale 1ns/10ps

module tb_fifo;

    // パラメータ定義
    parameter CYCLE = 100;

    // 信号定義
    reg clk;
    reg rst;
    reg wr;
    reg rd;
    reg [15:0] din;

    wire [15:0] dout;
    wire afull;
    wire full;
    wire over;
    wire empty;
    wire under;
    wire valid;

    reg [3:0] i;

    // テスト対象回路
    fifo f (
        .CLK(clk),
        .RST(rst),
        .WR(wr),
        .RD(rd),
        .DIN(din),
        .DOUT(dout),
        .almostFULL(afull),
        .FULL(full),
        .OVER(over),
        .EMPTY(empty),
        .UNDER(under),
        .VALID(valid)
    );

    // クロック定義 (テストサイクル)
    always #(CYCLE / 2) begin
        clk = ~clk;
    end

    // 入力信号生成 & 期待値比較
    initial begin

        // 初期化
        clk <= 1'b0;
        rst <= 1'b0;
        wr <= 1'b0;
        rd <= 1'b0;
        din <= 16'h0000; 
        i <= 4'b0000;

        /*****************************/

        @(negedge clk) begin
            rst <= 1'b1;
        end

        /*****************************/

        @(negedge clk) begin
            rst <= 1'b0;
            wr <= 1'b1;
            din <= 16'h0001;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b0) begin
            $display("ERROR.\n");
            $stop;
        end

        /*****************************/

        @(negedge clk) begin
            din <= 16'h0002;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
            $display("ERROR.\n");
            $stop;
        end

        /*****************************/

        @(negedge clk) begin
            din <= 16'h0003;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
            $display("ERROR.\n");
            $stop;
        end

        /*****************************/

        @(negedge clk) begin 
            din <= 16'h0004;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
            $display("ERROR.\n");
            $stop;
        end

        /*****************************/

        @(negedge clk) begin 
          din <= 16'h0005;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          din <= 16'h0006;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          din <= 16'h0007;
        end

        if (dout != 16'h0000 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin 
          din <= 16'h0008;
        end

        if (dout != 16'h0000 || afull != 1'b1 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          din <= 16'h0009;
        end

        if (afull !== 1'b1 || full != 1'b1 || over !== 1'b0 || dout !== 16'h0000 || valid !== 1'b0 || empty !== 1'b0 || under !== 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          din <= 16'h000a;
        end

        if (dout != 16'h0000 || afull != 1'b1 || full != 1'b1 || over != 1'b1 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          wr <= 0;
        end

        if (dout != 16'h0000 || afull != 1'b1 || full != 1'b1 || over != 1'b1 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          rd <= 1;
        end

        if (dout != 16'h0000 || afull != 1'b1 || full != 1'b1 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h0001 || afull != 1'b1 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h0002 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h0003 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          wr <= 1;
          din <= 16'h000b;
        end

        if (dout != 16'h0004 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          din <= 16'h000c;
        end

        if (dout != 16'h0005 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          wr <= 0;
        end

        if (dout != 16'h0006 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h0007 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h0008 || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h000b || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h000c || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk) begin
          rd <= 0;
        end

        if (dout != 16'h000c || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b1 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        @(negedge clk);

        if (dout != 16'h000c || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b1 || under != 1'b0 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        /*****************************/

        // Emptyのときの同時読み書き
        @(negedge clk) begin
          wr <= 1;
          rd <= 1;
          din <= 16'h1111;
        end
  
        @(negedge clk) begin
          wr <= 0;
          rd <= 0;
        end

        if (dout != 16'h000c || afull != 1'b0 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b1 || valid != 1'b0) begin
          $display("ERROR.\n");
          $stop;
        end

        // **************************
        // almostFULLまでポインタ移動

        for (i = 4'd0; i < 4'd6; i = i + 4'd1) begin
          @(negedge clk) begin
            wr <= 1'b1;
            din <= 16'h3333;
          end
        end 

        // ****************************
        // almostFULLの時の同時読み書き
        
        @(negedge clk) begin
            wr <= 1;
            rd <= 1;
            din <= 16'h4444;
        end

        @(negedge clk) begin
            wr <= 0;
            rd <= 0;
        end

        if (dout != 16'h1111 || afull != 1'b1 || full != 1'b0 || over != 1'b0 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
            $display("ERROR.\n");
            $stop;
        end

        // *****************************
        
        @(negedge clk) begin
            wr <= 1;
            din <= 16'h9999;
        end

        // *****************************
        // FULLの時のRW
        @(negedge clk) begin
          wr <= 1;
          rd <= 1;
          din <= 16'h5555;
        end

        @(negedge clk) begin
          wr <= 0;
          rd <= 0;
        end

        if (dout != 16'h3333 || afull != 1'b1 || full != 1'b0 || over != 1'b1 || empty != 1'b0 || under != 1'b0 || valid != 1'b1) begin
          $display("ERROR.\n");
          $stop;
        end

        @(negedge clk);

        $finish;

    end

endmodule
