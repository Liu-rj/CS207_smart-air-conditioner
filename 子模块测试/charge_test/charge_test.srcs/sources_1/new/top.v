`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/20 21:35:13
// Design Name: 
// Module Name: top
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


module top(
    input clk, rst,charge,on_off,lookup,left,right,mid,
    input [3:0] row,
    output [3:0] col,
    output [9:0]chargeElectricity,
    output [9:0]chargeInfo,
    output input_end
    );

    wire [15:0]keys;
    wire [15:0]key2;

    kenboard_core testkeyboard(clk,rst,row,col,keys);
    memory memory_inst(lookup,rst,charge,chargeElectricity,clk,input_end,left,right,mid,chargeInfo);

    charge testcharge(clk,rst,charge,keys,on_off,chargeElectricity,input_end);
endmodule
