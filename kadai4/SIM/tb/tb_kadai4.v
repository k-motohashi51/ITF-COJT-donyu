`timescale 1ns / 10ps

module tb_kadai4;

    // �p�����[�^��`
    parameter CYCLE = 100;

    // �M����`

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

    // �e�X�g�Ώۉ�H
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

    // �N���b�N��` (�e�X�g�T�C�N��)
    always #(CYCLE / 2) begin
        clk = ~clk;
    end

    initial begin
        
        // ������
        clk <= 1'b0;
        rst <= 1'b0;
        a <= 8'h00;
        b <= 8'h00;
        ack <= 1'b0;
        start <= 1'b0;
        halt <= 1'b0;
        
        // ���͐M������ & ���Ғl��r
        @(negedge clk) rst <= 1'b1;
        @(negedge clk) rst <= 1'b0;

        /**************************************************/
        /* �X�e�[�g��������邩 */
        /* �܂��C7�߂̃f�[�^���͌�� ack ���~�߂� */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        // �f�[�^��7�܂œ���
        for (i = 4'd0; i < 4'd7; i = i + 4'd1) begin
            a <= 8'h01;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;
        
        // ack ��~����
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

        // �o�͂�҂�
        for (j = 5'd0; j < 5'd20; j = j + 5'd1) begin
            @(negedge clk);
        end

        /**************************************************/
        /* S_INPUT �ɂ� HALT �𔭐������� */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        // �f�[�^��3�܂œ���
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
        /* S_EXEC �ɂ� HALT �𔭐������� */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h03;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // fifo_1 �̓r���܂œ��͂����̂�҂�
        for (j = 5'd0; j < 5'd5; j = j + 5'd1) begin
            @(negedge clk);
        end

        @(negedge clk) halt <= 1'b1;
        @(negedge clk) halt <= 1'b0;
        @(negedge clk);

        /**************************************************/
        /* S_OUTPUT �ɂ� HALT �𔭐������� */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h04;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // �o�͂�r���܂ōs��
        for (j = 5'd0; j < 5'd15; j = j + 5'd1) begin
            @(negedge clk);
        end

        @(negedge clk) halt <= 1'b1;
        @(negedge clk) halt <= 1'b0;
        @(negedge clk);
 
        /**************************************************/
        /* �Ō��1�� */

        @(negedge clk) start <= 1'b1;
        @(negedge clk) start <= 1'b0;
        @(negedge clk) ack <= 1'b1;

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            a <= 8'h01;
            b <= i + 8'h01;
            @(negedge clk);
        end

        ack <= 1'b0;

        // �o�͂�҂�
        for (j = 5'd0; j < 5'd20; j = j + 5'd1) begin
            @(negedge clk);
        end

        /**************************************************/

        $display("FINISH.\n");
        $finish;

    end

endmodule   // tb_kadai4