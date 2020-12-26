`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 01:09:50
// Design Name: 
// Module Name: charge
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


module charge(
    input clkin,
    input rst,charge,//16位numbers依次表示0-9，A,B,C,D,*,#;charge为1表示充值状态,rst复位,charge=1表示进入充电模式
    input [15:0]numbers,
    input on_off, ifon_elec,
    output reg [9:0]electricity,
    output input_end//分别表示充电电量和输入是否结束
    );
    reg inend;
    reg [3:0] temp;
    reg ifinput; // 锁定输入

    assign input_end = inend;

    wire clk;
    div div_in(clkin, rst, clk);

    always @(posedge clk, negedge rst) begin//若复位信号，充入电量归零
        if (~rst) begin
            temp <= 4'd12;
            inend <= 0;
            electricity <= 0;
            ifinput <= 1;
        end
        else begin
            if (electricity < 1000 && charge == 1 && !(on_off && ifon_elec)) begin//在充入电量小于1000，同时输入未结束的情况下
                if (numbers == 16'b0000_0000_0000_0001) begin//输入0
                    temp <= 4'd0;
                end
                else if (numbers==16'b0000_0000_0000_0010) begin//输入1
                    temp <= 4'd1;
                end
                else if (numbers==16'b0000_0000_0000_0100) begin//输入2
                    temp <= 4'd2;
                end
                else if (numbers==16'b0000_0000_0000_1000) begin//输入3
                    temp <= 4'd3;
                end
                else if (numbers==16'b0000_0000_0001_0000) begin//输入4
                    temp <= 4'd4;
                end
                else if (numbers==16'b0000_0000_0010_0000) begin//输入5
                    temp <= 4'd5;
                end
                else if (numbers==16'b0000_0000_0100_0000) begin//输入6
                    temp <= 4'd6;
                end
                else if (numbers==16'b0000_0000_1000_0000) begin//输入7
                    temp <= 4'd7;
                end
                else if (numbers==16'b0000_0001_0000_0000) begin//输入8
                    temp <= 4'd8;
                end
                else if (numbers==16'b0000_0010_0000_0000) begin//输入9
                    temp <= 4'd9;
                end
                else if (numbers==16'b0000_0100_0000_0000) begin//输入A,停止输入
                    temp <= 4'd10;
                    inend<=1;
                end
                else if (numbers==16'b0001_0000_0000_0000) begin//输入C,清空充电电量
                    temp <= 4'd11;
                    electricity <= 0;
                    inend<=0;
                end
                else begin
                    temp <= 4'd12;
                    ifinput <= 1;
                end

                if(ifinput == 1 && temp != 4'd12 && temp != 4'd10 && temp != 4'd11 && electricity * 10 + temp < 1000) begin
                    ifinput <= 0;
                    electricity <= electricity * 10 + temp;
                end

            end
        end
    end

endmodule
