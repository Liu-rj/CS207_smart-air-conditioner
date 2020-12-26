`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 22:01:41
// Design Name: 
// Module Name: beep
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
module beep(clk, rst_n, beep);
     input clk, rst_n;           //输入100Mhz时钟信号,复位信号
     output beep;            //输出的方波
     
     wire clk_1M, time_finsh;    //1Mhz时钟信号线，0.25s时间计数标记位
     wire [6:0]addr;             //rom地址线
     wire [7:0]rom_data;         //rom数据线
     wire [10:0]music_data;      //rom数据解码数据线
     
     /*****1M_Hz模块*****/
     div_frequency #(100)my_time_1MHz_inst (             
         .rst(rst_n),
         .clk(clk),
         .clkout(clk_1M)
     );
     
     /*****0.25s时间计数器模块*****/
     div_frequency #(625000)time_counter_inst(
         .rst(rst_n),
         .clk(clk_1M),
         .clkout(time_finsh)
     );  
         
     /*****ROM地址发生器*****/
     addr_gen addr_gen_inst(         
         .clk(clk_1M),
         .rst_n(rst_n),
         .addr(addr),
         .time_finsh(time_finsh)
     );  
     
     /*****ROM模块*****/
     my_rom my_rom_inst(             
         .address(addr),
         .q(rom_data)
     );
     
     /*****解码模块*****/
     decode decode_inst(             
         .clk(clk_1M),
         .rst_n(rst_n),  
         .rom_data(rom_data),
         .music_data(music_data)
     );                  
     
     /*****音乐发生器模块*****/
     music_gen music_gen_inst(       
         .clk(clk_1M),
         .rst_n(rst_n),
         .music_data(music_data),
         .beep(beep)
     );                  
         
 endmodule