`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/18 10:40:20
// Design Name: 
// Module Name: controller_top
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


module controller_top(
    // 拨码开关(开关机, 1为开机, 0为关机), 板上时钟, 小键盘(2个4bit行和列), 
    //五个小按钮(上下左右中), 当前状态(01温度, 10电量, 11模式)
    input on_off, rst, lookup, clock_Y18,
    input [3:0] row,
    input up, down, left, right, middle, mid,
    input [1:0] select,

    output [1:0] mode,
    output [11:0] innertemper,
    output [11:0] envirtemper,
    output [11:0] power,
    output [3:0] col,
    output ifon,
    output [11:0] chargevalue, 
    output input_end, // 充电结束
    output [11:0] count_time,
    output [11:0] time_remain,
    output ifon_count_time,
    output beep_out,
    output [11:0] chargeInfo
    );

    wire clk;
    wire [1:0] mod;
    wire [9:0] bin_inner; // 设定温度
    wire [9:0] bin_envir; // 环境温度
    wire [9:0] bin_power; // 电量
    wire [9:0] chargeElectricity; // 充电量
    wire [9:0] bin_count_time; //设置倒计时
    wire [9:0] bin_time_remain; // 倒计时
    wire [9:0] bin_chargeInfo;

    wire [15:0] numbers;//小键盘输出
    wire ifon_elec; // 电量监控开关

    assign mode = mod;
    assign ifon = ifon_elec;

    // 分频器生成一秒时钟信号
    div_frequency modeclk(clock_Y18, rst, clk);

    // 设置环境温度和模式
    envirtemper_mode setenvirtemper(on_off, ifon_elec, clock_Y18, clk, rst, up, down, bin_inner, select, bin_envir, mod);
    
    // 设定温度
    coretemper settemper(on_off, ifon_elec, clock_Y18, up, down, rst, select, bin_inner);
    
    // 电量
    corepower setpower(clock_Y18, on_off, rst, mod, chargeElectricity, input_end, bin_power, ifon_elec);

    // 小键盘
    keyboard_core readkeyboard(clock_Y18,rst,row,col,numbers);
    
    // 充电
    charge modecharge(clock_Y18, rst, mid, numbers, on_off, ifon_elec, chargeElectricity, input_end);

    //倒计时的时间
    countdown_input givetime(clock_Y18, rst, mid, numbers, on_off, ifon_elec, select, bin_count_time, input_time_end);

    //倒计时模块
    auto_off_top count_time_to_close(on_off, clock_Y18, rst, input_time_end, bin_count_time, ifon_count_time, beep_out, bin_time_remain);

    //充值记录模块
    memory memory_inst(lookup,rst,mid,chargeElectricity,clk,input_end,left,right,middle,bin_chargeInfo);
    
    // 二进制转BCD
    Bin_BCD trans_inner(bin_inner, innertemper);
    Bin_BCD trans_envir(bin_envir, envirtemper);
    Bin_BCD trans_power(bin_power, power);
    Bin_BCD trans_charge(chargeElectricity, chargevalue);
    Bin_BCD trans_count_time(bin_time_remain,time_remain);
    Bin_BCD trans_set_count_time(bin_count_time, count_time);
    Bin_BCD trans_chargeinfo(bin_chargeInfo, chargeInfo);

endmodule