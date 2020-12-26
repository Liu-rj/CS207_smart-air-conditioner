`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 15:16:16
// Design Name: 
// Module Name: view_mode
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


module view_mode(
    input on_off,
    input rst,  //复位
    input clk,  //Y18
    input [1:0] mode, //模式
    output [7:0] DIG,  //8个 扫描一个
    output [7:0] Y    //输出的内容
    );
    reg clkout;
    reg [31:0] cnt;
    reg [2:0] scan_cnt;

    parameter period = 200000; //500Hz
    //parameter period = 2500000 // 40Hz 
    //parameter period = 5000000;
    reg [6:0] Y_r;
    reg [7:0] DIG_r;

    reg [7:0] char3;
    reg [7:0] char2;
    reg [7:0] char1;
    reg [7:0] char0;

    assign Y = {1'b1,(~Y_r[6:0])};
    assign DIG = ~DIG_r;

    //分频
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


    //扫描计数
    always @ (posedge clkout or negedge rst)
    begin
        if(!rst)
            scan_cnt <=0;
            else begin
                if(scan_cnt == 3'd7) scan_cnt <=0;
                scan_cnt <= scan_cnt +1;
            end    
    end

    //右侧4位输出内容
    always @ (mode)
        begin
            case(mode) //01 wind 10 cool 11 hot
                1:
                begin
                    char0 = 7'b0000000;
                    char1 = 7'b1010000;//r
                    char2 = 7'b0000100;//i
                    char3 = 7'b1110111;//a
                end
                2:
                begin
                    char0 = 7'b0000110;//l
                    char1 = 7'b1011100;//o
                    char2 = 7'b1011100;//o
                    char3 = 7'b1011000;//c
                end
                3:
                begin
                    char0 = 7'b0000000;//kong
                    char1 = 7'b1111000;//t
                    char2 = 7'b1011100;//o
                    char3 = 7'b1110100;//h
                end
                default
                    begin
                        char0 = 7'b0000000;//kong
                        char1 = 7'b0000000;//kong
                        char2 = 7'b0000000;//kong
                        char3 = 7'b0000000;//kong
                    end
                endcase
        end

    //扫描到的位置
    always @ (scan_cnt) begin
            case (scan_cnt)
                3'b000 : DIG_r = 8'b0000_0001;
                3'b001 : DIG_r = 8'b0000_0010;
                3'b010 : DIG_r = 8'b0000_0100;
                3'b011 : DIG_r = 8'b0000_1000;
                3'b100 : DIG_r = 8'b0001_0000;
                3'b101 : DIG_r = 8'b0010_0000;
                3'b110 : DIG_r = 8'b0100_0000;
                3'b111 : DIG_r = 8'b1000_0000;
            endcase
    end

    //扫描输出的内容
    always @ (scan_cnt, char0, char1, char2, char3) begin
        case (scan_cnt)
            7 : Y_r = 7'b1010101;//m
            6 : Y_r = 7'b1011100;//o
            5 : Y_r = 7'b1011110;//d
            4 : Y_r = 7'b1111001;//e

            0 : Y_r = char0;
            1 : Y_r = char1;
            2 : Y_r = char2;
            3 : Y_r = char3;
            default: Y_r = 7'b0000000;
        endcase
    end
endmodule