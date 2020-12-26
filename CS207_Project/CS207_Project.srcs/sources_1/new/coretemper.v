`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/15 00:59:04
// Design Name: 
// Module Name: coretemper
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


module coretemper(
    // 输入端触发信号, 复位信号(开机时自动复位或者设置成按下reset键复位), 判断按上下键是否加减
    input on_off, ifon_elec, clock_Y18, increase, decrease, rst, [1:0] select,
    output [9:0]temperature // 10bit位表示20.0~30.0的温度,包含小数点
    );
    reg [6:0] temper;

    assign temperature = temper + 8'b11001000;

    always @(posedge clock_Y18, negedge rst) begin // increase信号上升沿, 温度加1
        if (~rst) begin // 复位
            temper <= 7'b0110010;
        end
        else if(on_off && ifon_elec) begin
            if (increase && temper < 7'b1100100 && select == 2'b01) begin // 如果是温度合法, 则加一
                temper <= temper + 4'b1010;
            end else if (decrease && temper > 7'b0000000 && select == 2'b01) begin  // 如果是温度合法, 则减一
                temper <= temper - 4'b1010;
            end
        end
    end
endmodule
