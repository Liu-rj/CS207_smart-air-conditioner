`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/15 19:02:35
// Design Name: 
// Module Name: corepower
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


module corepower(
    // 时钟用于电量每秒的下降,on_off,1开机，0关机 mode用于模式的判定,01送风 10制冷 11制热
    //rst为初始化复位, tik为进入充值状态的触发，10位chargeElectricity表示充值的电量,input_end=1表示输入结束
    input clock_Y18, on_off, rst,
    input [1:0] mode,
    input [9:0]chargeElectricity,
    input input_end,
    
    output reg [9:0] power, // 10位电量值, 0~1000
    output ifon // 电量为0自动关机(1'b0)
    );
    reg [31:0] record1second;
    reg [31:0] record2second;
    reg on;
    reg ifinput; // 锁定输入

    assign ifon = on;

    always @(posedge clock_Y18, negedge rst) begin
        if (!rst) begin // 复位
            power <= 10'd100;
            record1second <= 1'b0;
            record2second <= 0;
            on <= 1'b1;
            ifinput <= 1;
        end
        else if (on_off && on) begin
            if (mode == 2'b10 || mode == 2'b11) begin // 制冷制热, 每1秒电量降1.0
                if (record1second == 100000000) begin
                    if (power < 10) begin
                        power <= 0;
                    end
                    else begin
                        power <= power - 10'd10;
                    end
                    record1second <= 0;
                end
                else begin
                    record1second <= record1second + 1;
                end
            end
            else if (mode == 2'b01) begin // 送风, 每两秒电量降0.5
                if (record2second == 400000000) begin
                    if (power < 5) begin
                        power <= 0;
                    end
                    else begin
                        power <= power - 10'd5;
                    end
                    record2second <= 0;
                end
                else begin
                    record2second <= record2second + 1;
                end
            end
            
            if (power == 0) begin
                on <= 1'b0;
            end
            else begin
                on <= 1'b1;
            end
        end
        else begin
            if (input_end == 1 && ifinput) begin // 位于关机模式且输入已经结束, 充电环节
                if (power + chargeElectricity > 10'd999) begin //若当前电量加充入电量大于999，则将电量设置为999
                    power <= 10'd999;
                end
                else begin //否则 当前电量加上充入电量
                    power <= power + chargeElectricity;
                end
                ifinput <= 0;
            end
            else if (input_end == 0) begin
                ifinput <= 1;
            end

            if (!on_off && power != 0) begin
                record1second <= 1'b0;
                record2second <= 0;
                on <= 1'b1;
            end
        end
    end
endmodule
