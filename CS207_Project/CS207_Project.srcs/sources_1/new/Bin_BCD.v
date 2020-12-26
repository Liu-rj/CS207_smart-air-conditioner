`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/16 09:42:06
// Design Name: 
// Module Name: Bin_BCD
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


module Bin_BCD(
    input [9:0] binary,
    output [11:0] decimal
    );
    reg [3:0] hundreds;
    reg [3:0] tens;
    reg [3:0] ones;

    assign decimal = {hundreds[3:0], tens[3:0], ones[3:0]};

    integer i;
    always @(binary) begin
        hundreds = 4'd0;
        tens = 4'd0;
        ones = 4'd0;

        for (i = 9; i >= 0; i = i - 1) begin
            // 满5加3
            if (hundreds >= 5) begin
                hundreds = hundreds + 3;
            end
            if (tens >= 5) begin
                tens = tens + 3;
            end
            if (ones >= 5) begin
                ones = ones + 3;
            end

            // 向左移位
            hundreds = hundreds << 1;
            hundreds[0] = tens[3];
            tens = tens << 1;
            tens[0] = ones[3];
            ones = ones << 1;
            ones[0] = binary[i];
        end
    end
endmodule
