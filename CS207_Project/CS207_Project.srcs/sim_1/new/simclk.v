`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/19 20:53:55
// Design Name: 
// Module Name: simclk
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


module simclk;

// clock Parameters
parameter PERIOD  = 1;


// clock Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;

// clock Outputs
wire  clock                                ;


initial
begin
    forever #(PERIOD/500000000)  clk=~clk;
end

initial
begin
    #1 rst  =  1;
end

clock  u_clock (
    .clk                     ( clk     ),
    .rst                     ( rst     ),

    .clock                   ( clock   )
);

initial
begin

    #200000000 $finish;
end

endmodule
