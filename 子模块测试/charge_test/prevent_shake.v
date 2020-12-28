`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/21 22:46:28
// Design Name: 
// Module Name: prevent_shake
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


//top模块
module prevent_shake(
input clk,
input sw,
input rst,
output reg sw_out
);

reg [31:0]cnt;
reg clkout;
reg [1:0]state; // 00 01 低电平 0 1   10 11 高电平 0 1

//先分频
parameter period = 500000; //50ms
always @ (posedge clk or negedge rst)
begin
    if (!rst) begin
        cnt <= 0;
        clkout <=0;
    end
    else begin
        if(cnt == (period>>1)-1)
        begin
            clkout <= ~clkout;
            cnt <= 0;
        end
        else
            cnt <= cnt+1;
    end
end

//状态转移
always @(posedge clkout or negedge rst)
begin
if (~rst) begin
    state <= 2'b00;
end
else
    case ({state,sw})
        3'b001:state <= 2'b01;
        3'b011:state <= 2'b10;
        3'b100:state <= 2'b11;
        3'b110:state <= 2'b00;
        default: state <=state;
    endcase
end


//根据状态确定输出 组合
always @ (state)
begin
    case (state)
        2'b00: sw_out = 1'b0;
        2'b01: sw_out = 1'b0;
        2'b10: sw_out = 1'b1;
        2'b11: sw_out = 1'b1;
    endcase
end




endmodule

