`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/23 18:00:44
// Design Name: 
// Module Name: auto_off_top
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


module auto_off_top(
    input on_off,
    input clock_Y18, // Y18
    input rst, // 复位
    input confirm,
    input [9:0] ctime, // 倒计时的时间
    output reg shutdown, // 1开机
    output beep, //输出的音乐
    output reg [9:0] count_down
    );

    reg rst_b;
    reg [31:0] num;
    reg temp;

    beep beep_ring(clock_Y18, rst_b, beep);

    always @ (posedge clock_Y18 or negedge rst) begin
        if(~rst) begin
            count_down <= 0;
            num <= 0;
            shutdown <= 1;
            rst_b <= 0;
            temp <= 0;
        end
        else if (confirm == 1) begin
            count_down <= ctime;
            temp <= 1;
        end
        else begin
            if (count_down != 0) begin
                if (num < 100000000) begin
                    num <= num + 1;
                end
                else if(num == 100000000) begin
                    count_down <= count_down - 1;
                    num <= 0;
                end
            end
            
            if (count_down == 10) begin
                rst_b <= 1;
            end

            if (count_down == 0 && temp) begin
                shutdown <= 0;
                temp <= 0;
                rst_b <= 0;
            end

            if (!on_off) begin
                count_down <= 0;
                num <= 0;
                shutdown <= 1;
                rst_b <= 0;
                temp <= 0;
            end
        end
    end

endmodule
