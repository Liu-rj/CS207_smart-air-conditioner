`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 22:01:27
// Design Name: 
// Module Name: music_gen
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


module music_gen    (clk, rst_n, music_data, beep);
                             
     input clk, rst_n;           //输入1Mhz时钟信号，复位信号
     input [10:0]music_data; //输入音乐频率控制字
     output reg beep;            //输出方波
     
     reg [10:0]data, count;  //寄存音乐控制字的data，计数器count
     
     always@(posedge clk or negedge rst_n)
     begin
         if(!rst_n)
             data    <=  11'd0;          //寄存器data复位
         else
             data    <=  music_data;     //data寄存音乐控制字
     end
         
     always@(posedge clk or negedge rst_n)
     begin
         if(!rst_n)
             begin
                 count   <=  11'd1;      //计数器复位
                 beep    <=  1'd0;       //输出方波复位
             end
         else    if(data== 11'd0)   //当data==11‘d0，（停止节拍）
             begin
                 count   <=  11'd1;   //计数器归一
                 beep    <=  1'd0;     //输出方波归零
             end
         else    if(count    <=  data)   //当计数器小于等于data的值
             count   <=  count   +   1'd1;//计数器继续累加
         else
             begin
                 count   <=  11'd1;  //当计数器大于data的值，计数器归一
                 beep    <=  ~beep;  //输出方波取反
             end
     end
 endmodule