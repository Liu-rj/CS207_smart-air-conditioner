`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 21:59:49
// Design Name: 
// Module Name: addr_gen
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


module addr_gen(clk, rst_n, addr, time_finsh);
                         
     input clk, rst_n;   //输入1Mhz时钟信号，复位信号
     input time_finsh;   //输入时间计数标记位（每0.25s变高电平一次）
     output reg [6:0]addr; //输出给ROM的地址信号
     
     always@(posedge clk or negedge rst_n)
     begin
         if(!rst_n)
             addr    <=  7'd0;   //输出给ROM的地址信号复位
         else    if(time_finsh) //输出给ROM的地址信号自加1（每0.25s自加1）
             addr    <=  addr    +   1'd1;   
         else
             addr    <=  addr;       //未够0.25s,ROM的地址信号不变
     end
     
 endmodule