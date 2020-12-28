`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 09:25:27
// Design Name: 
// Module Name: div
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


module div(clk ,rst, clkout);
     
 input rst ;
 input clk ;
 wire clk ;
 
 output clkout ;
 
 reg clkout_r ; 
 
 parameter  period= 200000;    
 //parameter  period= 10;
 reg [31:0] cnt;  
 
 always @( posedge clk or negedge rst)                  //分频50Hz
     begin 
         if ( !rst )
         begin
             cnt <= {31{1'b0}}  ;
             clkout_r <= 0 ;    
             end        
         else begin 
             cnt<= cnt+1;
         if (cnt    == (period >> 1) - 1)                   //设定周期时间的一半
                 clkout_r <= #1 1'b1;
         else if (cnt == period - 1)                    //设定的周期时间
             begin 
                 clkout_r <= #1 1'b0;
                  cnt <= #1 'b0;      
             end
          
         end
      end
 assign clkout = clkout_r ;     
endmodule
