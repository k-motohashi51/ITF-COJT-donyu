`timescale 1ns/10ps

module tb_mult;

    // パラメータ定義
    parameter CYCLE = 100;

    // 信号定義
    reg clk;
    reg [7:0] A, B;
    reg [8:0] i, j;
    wire [15:0] X;

    // �?スト対象回路 x = a * b (乗算器)
    mult m (.a(A), .b(B), .x(X));

    // クロ�?ク定義 (�?ストサイクル)
    always #(CYCLE / 2)
        clk = ~clk;
    
    // 入力信号生�?? & 期�?値比�?
    initial begin
        clk = 1;

        for (i = 0; i < 256; i = i + 1) begin
            A = i;
            for (j = 0; j < 256; j = j + 1) begin
                B = j;
                #CYCLE; // クロ�?ク1周期�?の�?延

                if (X !== A * B) begin
                    $display("error! expval = %h result = %h\n", A * B, X); // 標準�?�力表示
                    $stop;
                end
            end
        end

        $display("finish\n");
        $stop;
    end

endmodule