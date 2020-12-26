`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 20:58:54
// Design Name: 
// Module Name: envirtemper_mode
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


module envirtemper_mode(
    input on_off, ifon_elec, clock_Y18, clk, rst, up, down, [9:0] innertemper, [1:0] select, // 1s的时钟信号, 输入端触发信号, 复位信号(开机时自动复位或者设置成按下reset键复位)
    output [9:0]temperature, [1:0]mode // 10bit位表示20.0~30.0的温度,包含小数点, mode:2bit位表示模式, 00默认加一为01, 01显示air, 10显示cold, 11显示hot
    );
    reg [6:0] temper;
    reg [1:0] mod; // 记录mode变化并传给传出参数mode
    reg changemod;

    assign temperature = temper + 8'b11001000; // temper+20.0
    assign mode = mod;

    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            temper <= 7'b0101000; // 复位为24.0
        end
        else if (mode == 2'b10) begin // 制冷模式下环境温度较高, 则环境温度每一秒减一
            if (temperature > innertemper) begin
                temper <= temper - 1;
            end
        end
        else if (mode == 2'b11) begin // 制热模式下环境温度较低, 则环境温度每一秒加一
            if (temperature < innertemper) begin
                temper <= temper + 1;
            end
        end
    end

    // 模式转换
    always @(posedge clock_Y18, negedge rst) begin
        if (~rst) begin
            mod <= 2'b01;
            changemod <= 1'b1;
        end
        else if (select == 2'b11 && on_off && ifon_elec) begin
            if (up) begin
                mod <= (mod + 1) == 3'b100 ? 2'b01 : (mod + 1);
                if (temperature != innertemper) begin
                    changemod <= 1'b1;
                end
            end
            else if (down) begin
                mod <= (mod - 1) == 2'b00 ? 2'b11 : (mod - 1);
                if (temperature != innertemper) begin
                    changemod <= 1'b1;
                end
            end
            else if(temperature == innertemper && changemod) begin
                mod <= 2'b01;
                changemod <= 0;
            end
        end
        else if(!(on_off && ifon_elec)) begin
            mod <= 2'b01;
        end
    end
endmodule
