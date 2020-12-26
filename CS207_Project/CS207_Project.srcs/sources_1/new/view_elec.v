`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 15:46:56
// Design Name: 
// Module Name: view_elec
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


module view_elec(
    input on_off,
    input rst,  //复位
    input clk,  //Y18
    input [11:0] elec,  //电量
    output [7:0] DIG,  //8个 扫描一个
    output [7:0] Y    //输出的内容
    );

    reg clkout;
    reg [31:0] cnt;
    reg [2:0] scan_cnt;

    parameter period = 200000; //500Hz
    reg [6:0] Y_r;
    reg [7:0] DIG_r;

    reg [3:0] bcd;
    reg [6:0] seg_out;

    reg dot;

    assign Y = {dot,(~Y_r[6:0])};
    assign DIG = ~DIG_r;


    //分频
    always @ (posedge clk or negedge rst)
    begin
        if (!rst) begin
            cnt <= 0;
            clkout <=0;
        end
        else begin
            if(cnt == (period>>1) - 1)
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
            scan_cnt <= 0;
            else begin
                scan_cnt <= scan_cnt + 1;
                if(scan_cnt == 4'b1000) scan_cnt <= 0;
            end    
    end

    //左侧三位 显示电量数字
    always @ (scan_cnt, elec)
        begin
            case (scan_cnt)
                5 : bcd = elec[3:0];
                6 : bcd = elec[7:4];
                7 : bcd = elec[11:8];       
            default: bcd = 4'b1111;
            endcase
        end

    //BCD转数字 
    //default 理论上到达不了
    always @ (bcd) 
        begin
        case(bcd)
            4'b0000: seg_out = 7'b0111111;//0
            4'b0001: seg_out = 7'b0000110;//1
            4'b0010: seg_out = 7'b1011011;//2
            4'b0011: seg_out = 7'b1001111;//3                                                                                                                                                                                                                                                                                                                                                                                                                                         
            4'b0100: seg_out = 7'b1100110;//4
            4'b0101: seg_out = 7'b1101101;//5
            4'b0110: seg_out = 7'b1111101;//6
            4'b0111: seg_out = 7'b0100111;//7
            4'b1000: seg_out = 7'b1111111;//8
            4'b1001: seg_out = 7'b1101111;//9
            default :seg_out = 7'b0000000;//全灭
        endcase
    end

    //扫描 8个显示选一个
    always @ (scan_cnt)
        begin
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

    //总输出显示
    always @ (scan_cnt, seg_out) begin
        case (scan_cnt)
                0 : Y_r = 7'b1110100;//h
                1 : Y_r = 7'b1000000;//-
                2 : Y_r = 7'b1101010;//w
                3 : Y_r = 7'b0000000;
                4 : Y_r = 7'b0000000;//kong
                5 : Y_r = seg_out;
                6 : Y_r = seg_out;
                7 : Y_r = seg_out;
                default: Y_r = 7'b0000000;
        endcase
    end

    always @(DIG_r) begin
        case (DIG_r)
            8'b1000_0000 : dot = 1'b0;
            default: dot = 1'b1;
        endcase
    end
endmodule
