`timescale 1ns / 10ps

module tb_kadai3;

    // パラメータ定義
    parameter CYCLE = 100;

    // 信号定義
    reg clk;
    reg rst;
    reg wr;
    reg rd;
    reg [15:0] din;

    reg [7:0] i;
    reg [15:0] test_mem [0:15]; // 検算用
    reg [3:0] w_ptr;
    reg [3:0] r_ptr;
    reg tmp;
    
    wire [15:0] dout;
    wire empty;
    wire full;
    wire valid;

    // テスト対象回路
    kadai3 test (
        .CLK(clk),
        .RST(rst),
        .WR(wr),
        .RD(rd),
        .DIN(din),
        .DOUT(dout),
        .EMPTY(empty),
        .FULL(full),
        .VALID(valid)
    );

    // クロック定義 (テストサイクル)
    always #(CYCLE / 2) begin
        clk = ~clk;
    end

    initial begin
        // 初期化
        clk <= 1'b0;
        rst <= 1'b0;
        wr <= 1'b0;
        rd <= 1'b0;
        din <= 1'b0;
        i <= 8'h00;
        w_ptr <= 4'b0000;
        r_ptr <= 4'b0000;
        tmp <= 1'b0;

        // 入力信号生成 & 期待値比較
        @(negedge clk);
            rst <= 1'b1;

        @(negedge clk);
            rst <= 1'b0;

        for (i = 8'h00; i < 8'hFF; i = i + 8'h01) begin
            @(negedge clk);

                if (full === 1'b0 && (i < 8'd60 || 8'd120 <= i)) begin
                    wr <= $random % 2;
                end else begin
                    wr <= 1'b0;
                end

                if (wr === 1'b1) begin
                    din <= $random % 16'hFFFF; 
                    test_mem[w_ptr] <= din[15:8] * din[7:0];
                    w_ptr <= w_ptr + 4'b1;
                end


                if (empty === 1'b0 && i >= 8'd50) begin
                    rd <= $random % 2;
                end else begin
                    rd <= 1'b0;
                end

                if (valid === 1'b1) begin
                    if (dout !== test_mem[r_ptr]) begin
                        $display("ERROR.--> (dout,ans)=(%h,%h)\n", dout, test_mem[r_ptr]);
                        $stop;
                    end
                    test_mem[r_ptr] <= 16'h0000;
                    r_ptr <= r_ptr + 4'b1;
                end
        end

        $display("finish.\n");
        $finish;
    end
endmodule