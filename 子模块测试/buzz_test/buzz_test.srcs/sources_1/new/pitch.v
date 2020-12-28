`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/18 23:59:37
// Design Name: 
// Module Name: buzz_test
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


module pitch(
    input clk,on,[31:0] higher,
    output hz
    );
    reg [19:0]count=0;
    reg bee=0;

    assign hz=bee;

    always@(posedge clk)begin
        if(on) begin
            if (count<=32'd100000000/higher) begin
                count<=count+1;
            end
            else begin
                count<=0;
                bee<=~bee;
            end
        end
    end

endmodule
