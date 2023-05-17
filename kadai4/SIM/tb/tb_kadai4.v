`timescale 1ns / 10ps

module tb_kadai4;

    // パラメータ定義
    parameter CYCLE = 100;

    // 信号定義

    // input
    reg clk;
    reg rst;
    reg [7:0] a;
    reg [7:0] b;
    reg ack;
    reg start;
    reg halt;

    // output
    wire [15:0] x;
    wire x_valid;
    wire req_ab;

    // for roop
    reg [3:0] i;
    reg [4:0] j;

    // テスト対象回路
    kadai4 test (
        .CLK(clk),
        .RST(rst),
        .A(a),
        .B(b),
        .ACK(ack),
        .START(start),
        .HALT(halt),
        .X(x),
        .X_VALID(x_valid),
        .REQ_AB(req_ab)
    );

    // クロック定義 (テストサイクル)
    always #(CYCLE / 2) begin
        clk = ~clk;
    end

    initial begin
        
        // 初期化
        clk <= 1'b0;
        rst <= 1'b0;
        a <= 8'h00;
        b <= 8'h00;
        ack <= 1'b0;
        start <= 1'b0;
        halt <= 1'b0;
        
        // 入力信号生成 & 期待値比較
        @(negedge clk) rst <= 1'b1;
        @(negedge clk) rst <= 1'b0;

        /**************************************************/
        /* ステートが一周するか */
        /* また，7つめのデータ入力後に ack を止める */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        // データを7つまで入力
        for (i = 4'd0; i < 4'd7; i = i + 4'd1) begin
            a <= 8'h01;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;
        
        // ack 停止期間
        for (j = 5'd0; j < 5'd4; j = j + 5'd1) begin
            @(negedge clk);
        end

        ack <= 1'b1;

        for (i = 4'd7; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h01;
            b <= i + 8'h01;
            @(negedge clk);
        end
        
        ack <= 1'b0;

        // 出力を待つ
        for (j = 5'd0; j < 5'd20; j = j + 5'd1) begin
            @(negedge clk);
        end

        /**************************************************/
        /* S_INPUT にて HALT を発生させる */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        // データを3つまで入力
        for (i = 4'd0; i < 4'd3; i = i + 4'd1) begin
            a <= 8'h02;
            b <= i + 8'h01;
            @(negedge clk);
        end  

        ack <= 1'b0;
        halt <= 1'b1;

        @(negedge clk) halt <= 1'b0;
        @(negedge clk);

        /**************************************************/
        /* S_EXEC にて HALT を発生させる */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h03;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // fifo_1 の途中まで入力されるのを待つ
        for (j = 5'd0; j < 5'd5; j = j + 5'd1) begin
            @(negedge clk);
        end

        @(negedge clk) halt <= 1'b1;
        @(negedge clk) halt <= 1'b0;
        @(negedge clk);

        /**************************************************/
        /* S_OUTPUT にて HALT を発生させる */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h04;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // 出力を途中まで行う
        for (j = 5'd0; j < 5'd15; j = j + 5'd1) begin
            @(negedge clk);
        end

        @(negedge clk) halt <= 1'b1;
        @(negedge clk) halt <= 1'b0;
        @(negedge clk);
 
        /**************************************************/
        /* 最後に1周 */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h01;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // 出力を待つ
        for (j = 5'd0; j < 5'd20; j = j + 5'd1) begin
            @(negedge clk);
        end

        /**************************************************/

        $display("FINISH.\n");
        $finish;

    end

endmodule   // tb_kadai4