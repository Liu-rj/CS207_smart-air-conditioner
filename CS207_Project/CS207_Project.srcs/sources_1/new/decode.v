`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 22:00:36
// Design Name: 
// Module Name: decode
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


module decode(clk, rst_n, rom_data, music_data);
                     
     input clk, rst_n;       //输入1Mhz时钟信号，复位信号
     input [7:0] rom_data;    //输入的ROM的数据
     output reg [10:0]music_data;    //输出ROM的解码数据
     
     always@(posedge clk or negedge rst_n)
     begin
         if(!rst_n)
             music_data  <=  11'd0;      //输出ROM的解码数据复位
         else    
         case (rom_data)
             8'h11   :   music_data  <=  11'd1911;   //(1Mhz/261.63Hz)/2)=1191   低音1
             8'h12   :   music_data  <=  11'd1702;   //(1Mhz/293.67Hz)/2)=1702   低音2
             8'h13   :   music_data  <=  11'd1517;   //(1Mhz/329.63Hz)/2)=1517   低音3
             8'h14   :   music_data  <=  11'd1431;   //(1Mhz/349.23Hz)/2)=1431   低音4
             8'h15   :   music_data  <=  11'd1276;   //(1Mhz/391.99Hz)/2)=1276   低音5
             8'h16   :   music_data  <=  11'd1136;   //(1Mhz/440.00Hz)/2)=1136   低音6
             8'h17   :   music_data  <=  11'd1012;   //(1Mhz/493.88Hz)/2)=1012   低音7
             
             8'h21   :   music_data  <=  11'd939;    //(1Mhz/532.25Hz)/2)=939    中音1
             8'h22   :   music_data  <=  11'd851;    //(1Mhz/587.33Hz)/2)=851    中音2
             8'h23   :   music_data  <=  11'd758;    //(1Mhz/659.25Hz)/2)=758    中音3
             8'h24   :   music_data  <=  11'd716;    //(1Mhz/698.46Hz)/2)=716    中音4
             8'h25   :   music_data  <=  11'd638;    //(1Mhz/783.99Hz)/2)=638    中音5
             8'h26   :   music_data  <=  11'd568;    //(1Mhz/880.00Hz)/2)=568    中音6
             8'h27   :   music_data  <=  11'd506;    //(1Mhz/987.76Hz)/2)=506    中音7
             
             8'h41   :   music_data  <=  11'd478;    //(1Mhz/1046.50Hz)/2)=478   高音1
             8'h42   :   music_data  <=  11'd425;    //(1Mhz/1174.66Hz)/2)=425   高音2
             8'h43   :   music_data  <=  11'd379;    //(1Mhz/1318.51Hz)/2)=379   高音3
             8'h44   :   music_data  <=  11'd358;    //(1Mhz/1396.51Hz)/2)=358   高音4
             8'h45   :   music_data  <=  11'd319;    //(1Mhz/1567.98Hz)/2)=319   高音5
             8'h46   :   music_data  <=  11'd284;    //(1Mhz/1760.00Hz)/2)=284   高音6
             8'h47   :   music_data  <=  11'd253;    //(1Mhz/1975.52Hz)/2)=253   高音7
             
             8'h00   :   music_data  <=  11'd0;      //0HZ，停止节拍
         endcase
     end     
     
 endmodule               