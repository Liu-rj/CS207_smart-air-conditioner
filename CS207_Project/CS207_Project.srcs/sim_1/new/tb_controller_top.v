`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/18 14:46:55
// Design Name: 
// Module Name: tb_controller_top
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


module tb_controller_top();
// controller_top Parameters
parameter PERIOD  = 10;


// controller_top Inputs
reg   on_off                               = 1'b1 ;
reg   rst                                  = 0 ;
reg   clock_Y18                            = 0 ;
reg   [3:0] row                            = 0 ;
reg   up                                   = 0 ;
reg   down                                 = 0 ;
reg   mid                                  = 0 ;
reg   select                               = 0 ;
reg   _end                                 = 0 ;
reg   bin_power                            = 0 ;

// controller_top Outputs
wire  [1:0]  mode                          ;
wire  [11:0]  innertemper                  ;
wire  [11:0]  envirtemper                  ;
wire  [11:0]  power                        ;


initial
begin
    forever #(PERIOD/2)  clock_Y18=~clock_Y18;
end

initial
begin
    #(PERIOD*2) rst  =  1;
end

initial fork
    forever #PERIOD select = select + 1;
    forever #(PERIOD/2) up = ~up;
join

controller_top  u_controller_top (
    .on_off                  ( on_off              ),
    .rst                     ( rst                 ),
    .clock_Y18               ( clock_Y18           ),
    .row                     ( row                 ),
    .up                      ( up                  ),
    .down                    ( down                ),
    .mid                     ( mid                 ),
    .select                  ( select              ),

    .mode                    ( mode         [1:0]  ),
    .innertemper             ( innertemper  [11:0] ),
    .envirtemper             ( envirtemper  [11:0] ),
    .power                   ( power        [11:0] )
);

initial
begin

    #100 $finish;
end

endmodule
