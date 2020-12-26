`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/23 17:30:19
// Design Name: 
// Module Name: memory
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


module memory(
    input lookup,rst,ifcharge,[9:0]electricity,
    input clkin,//lookup为1表示进入查询模式
    input inend,left,right,mid,//按动左右按键翻页
    output [9:0] chargeInfo
    );

    reg [3:0] cnt=0;//cnt记录当前有多少条充电信息
    reg [3:0] cur=0;//cur记录目前查询到第几条充电记录
    reg [9:0] chargeE;
    reg [9:0] chargeElec[0:9];//存储器记录充电信息

    assign chargeInfo=chargeE;
  //  assign cnts=cnt;

    //div div_inst(clkin, rst, clk);
    //key key_inst(clkin,rst,{leftin,midin,rightin},{left,mid,right});

    always @(posedge clkin, negedge rst) begin
        if(~rst) begin//复位信号，各项清零
            cnt<=4'd8;
            cur<=4'd5;
            chargeE<=0;
            chargeElec[0]<=10'd1;
            chargeElec[1]<=10'd2;
            chargeElec[2]<=10'd3;
            chargeElec[3]<=10'd4;
            chargeElec[4]<=10'd5;
            chargeElec[5]<=10'd6;
            chargeElec[6]<=10'd7;
            chargeElec[7]<=10'd8;
            chargeElec[8]<=10'd9;
            chargeElec[9]<=10'd2;
        end
        else if (ifcharge&&inend&&mid) begin//充电模式且输入结束且按下记录键的情况下，记录电量
            //chargeElec[cnt]<=electricity;
            if (cnt==9) begin
                cnt<=0;
            end
            else begin
                cnt<=cnt+1; 
            end
            case (cnt)
                0: begin
                    chargeElec[0]<=electricity;
                end 
                1: begin
                    chargeElec[1]<=electricity;
                end 
                2: begin
                    chargeElec[2]<=electricity;
                end 
                3: begin
                    chargeElec[3]<=electricity;
                end 
                4: begin
                    chargeElec[4]<=electricity;
                end 
                5: begin
                    chargeElec[5]<=electricity;
                end 
                6: begin
                    chargeElec[6]<=electricity;
                end 
                7: begin
                    chargeElec[7]<=electricity;
                end 
                8: begin
                    chargeElec[8]<=electricity;
                end 
                9: begin
                    chargeElec[9]<=electricity;
                end
                //default:  chargeElec[0]<=electricity;
            endcase
        end
        else if (lookup) begin//查询模式
            //chargeE<=chargeElec[cur];
            if (left) begin
                if (cur>0) begin
                    cur<=cur-1;
                end
                else begin
                    cur<=cnt;
                end
                case (cur) 
                0: begin
                    chargeE<=chargeElec[0];
                end 
                1: begin
                    chargeE<=chargeElec[1];
                end 
                2: begin
                    chargeE<=chargeElec[2];
                end 
                3: begin
                    chargeE<=chargeElec[3];
                end 
                4: begin
                    chargeE<=chargeElec[4];
                end 
                5: begin
                    chargeE<=chargeElec[5];
                end 
                6: begin
                    chargeE<=chargeElec[6];
                end 
                7: begin
                    chargeE<=chargeElec[7];
                end 
                8: begin
                    chargeE<=chargeElec[8];
                end 
                9: begin
                    chargeE<=chargeElec[9];
                end 
                //default: chargeE<=chc[r]geElec[0];
            endcase
            end
            else if (right) begin
                if (cur<cnt) begin
                    cur<=cur+1;
                end
                else begin
                    cur<=0;
                end
                case (cur) 
                0: begin
                    chargeE<=chargeElec[0];
                end 
                1: begin
                    chargeE<=chargeElec[1];
                end 
                2: begin
                    chargeE<=chargeElec[2];
                end 
                3: begin
                    chargeE<=chargeElec[3];
                end 
                4: begin
                    chargeE<=chargeElec[4];
                end 
                5: begin
                    chargeE<=chargeElec[5];
                end 
                6: begin
                    chargeE<=chargeElec[6];
                end 
                7: begin
                    chargeE<=chargeElec[7];
                end 
                8: begin
                    chargeE<=chargeElec[8];
                end 
                9: begin
                    chargeE<=chargeElec[9];
                end 
                //default: chargeE<=chargeElec[0];
            endcase
            end
        end
    end
endmodule
