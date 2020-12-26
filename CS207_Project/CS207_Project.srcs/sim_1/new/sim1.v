`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/15 20:30:26
// Design Name: 
// Module Name: sim1
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


module sim1();
    reg clk, set;
    wire [1:0] mode;
    wire [8:0] innertemper;
    wire [8:0] envirtemper; 
    wire [9:0] power;

    start start1(set, clk, mode, innertemper, envirtemper, power);

    initial begin
        clk = 1'b0;
        set = 1'b0;
        forever #2 clk = ~clk;
    end

    initial fork
        #1 set = ~set;
    join

    initial #200 $finish();
endmodule
