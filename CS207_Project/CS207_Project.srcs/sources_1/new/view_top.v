`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 16:09:08
// Design Name: 
// Module Name: view_top
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


module view_top(
    // 拨码开关(开关机, 1为开机, 0为关机), 板上时钟, 小键盘(1个4bit行), 五个小按钮(上下左右中)
    input on_off, rst, lookup, clk, [3:0] row,
    input up_level, down_level, left_level, right_level, middle_level, ifcharge,
    
    output reg [7:0] DIG,    //8个 扫描一个
    output reg [7:0] Y,      //输出的内容
    output [3:0] col,
    output charge_end,
    output beep
    );

    wire [1:0] mode; // 模式
    wire [11:0] setT; // 设定温度
    wire [11:0] envT; // 环境温度
    wire [11:0] elec; // 电量
    wire [11:0] charge; // 充电量
    wire [11:0] set_time; // 设置倒计时
    wire [11:0] count_down; // 倒计时
    wire [11:0] chargeInfo; // 充值记录

    reg [1:0] select = 2'b01; //01温度, 10电量, 11模式
    wire [7:0] DIG_t;
    wire [7:0] DIG_e;
    wire [7:0] DIG_m;
    wire [7:0] DIG_c;
    wire [7:0] DIG_d;
    wire [7:0] DIG_l;
    wire [7:0] Y_t;
    wire [7:0] Y_e;
    wire [7:0] Y_m;
    wire [7:0] Y_c;
    wire [7:0] Y_d;
    wire [7:0] Y_l;

    wire up, down, left, right, middle;
    wire ifon;
    wire shutdown;

    key_vibration vibration(clk, rst, {up_level, down_level, left_level, right_level, middle_level}, {up, down, left, right, middle});

    view_temp tempV( on_off, ifon, shutdown, rst, clk, envT, setT, DIG_t ,Y_t );
    view_elec elecV( on_off, rst, clk, elec, DIG_e , Y_e );
    view_mode modeV( on_off, rst, clk, mode, DIG_m , Y_m );
    view_charge chargeV(on_off, ifon, rst, clk, elec, charge, DIG_c, Y_c);
    view_time2 timeV(on_off, ifon, shutdown, rst, clk, set_time, count_down, DIG_d, Y_d);
    view_chargehistory history(rst, clk, chargeInfo, DIG_l, Y_l);

    // 与controller链接
    controller_top controller(on_off, rst, lookup, clk, row, up, down, left, right, middle, ifcharge, select, mode, setT, envT, elec, col, ifon, charge, charge_end, set_time, count_down, shutdown, beep, chargeInfo);

    always @(posedge clk) begin
        if (left && on_off) begin
            if (select == 3) begin
                select <= 0;
            end
            else begin
                select <= select + 1;
            end
        end
        else if (right && on_off) begin
            if (select == 0) begin
                select <= 3;
            end
            else begin
                select <= select - 1;
            end
        end
    end

    always @ (posedge clk) begin
        if (lookup) begin
            Y <= Y_l;
            DIG <= DIG_l;
        end
        else if (!(on_off && ifon && shutdown)) begin
            if (ifcharge) begin
                Y <= Y_c;
                DIG <= DIG_c;
            end
            else begin
                Y <= Y_t;
                DIG <= DIG_t;
            end
        end
        else begin
            if (select == 2'b00) begin
                Y <= Y_d;
                DIG <= DIG_d;
            end
            else if (select == 2'b01) begin
                Y <= Y_t;
                DIG <= DIG_t;
            end
            else if (select == 2'b10) begin
                Y <= Y_e;
                DIG <= DIG_e;
            end
            else if (select == 2'b11) begin
                Y <= Y_m;
                DIG <= DIG_m;
            end
        end
    end

endmodule
