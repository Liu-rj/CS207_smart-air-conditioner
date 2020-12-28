`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/23 00:55:16
// Design Name: 
// Module Name: music
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


module music(
    input clk,on,
    output signal
    );

    //设定不同的停顿与持续时间
    parameter ms300=15000000;
    parameter ms400=5000000;
    parameter ms900=45000000;
    parameter ms600=15000000;
    parameter ms350=4375000;
    parameter ms1000=12500000;

    reg [31:0] cnt=0;
    reg [31:0] state=0;
    reg hz;

    wire c3,d3,e3,f3,g3,a3,b3,e4,dh4,c4,d4,gh3,ah3;
    
    //生成对应音高的频率信号
    pitch Cdo(clk,on,32'd262,c3);
    pitch Cre(clk,on,32'd294,d3);
    pitch Cmi(clk,on,32'd330,e3);
    pitch Cfa(clk,on,32'd349,f3);
    pitch Cso(clk,on,32'd392,g3);
    pitch Cla(clk,on,32'd440,a3);
    pitch Cti(clk,on,32'd494,b3);
    pitch Hmi(clk,on,32'd660,e4);
    pitch Sre(clk,on,32'd622,dh4);
    pitch Hdo(clk,on,32'd523,c4);
    pitch Hre(clk,on,32'd587,d4);
    pitch Sso(clk,on,32'd415,gh3);
    pitch Ah3(clk,on,32'd466,ah3);

    assign signal=hz;
    
    //根据每个音节的持续时间和停顿时间进行状态机的编码
    always @(posedge clk) begin
        case (state)
            0: begin
                if(cnt<=ms600) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            1: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            2: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            3: begin
                if(cnt<=ms300) begin
                    hz<=dh4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            4: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            5: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            6: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            7: begin
                if(cnt<=ms300) begin
                    hz<=dh4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            8: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            9: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            10: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            11: begin
                if(cnt<=ms300) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            12: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            13: begin
                if(cnt<=ms300) begin
                    hz<=d4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            14: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            15: begin
                if(cnt<=ms300) begin
                    hz<=c4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            16: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            17: begin
                if(cnt<=ms900) begin
                    hz<=a3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            18: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            19: begin
                if(cnt<=ms300) begin
                    hz<=d3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            20: begin
                if(cnt<=ms350) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            21: begin
                if(cnt<=ms300) begin
                    hz<=f3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            22: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            23: begin
                if(cnt<=ms300) begin
                    hz<=a3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            24: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            25: begin
                if(cnt<=ms900) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            26: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            27: begin
                if(cnt<=ms300) begin
                    hz<=f3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            28: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            29: begin
                if(cnt<=ms300) begin
                    hz<=ah3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            30: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            31: begin
                if(cnt<=ms300) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            32: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            33: begin
                if(cnt<=ms900) begin
                    hz<=c4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            34: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            35: begin
                if(cnt<=ms300) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            36: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            37: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            38: begin
                if(cnt<=ms300) begin
                    hz<=dh4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            39: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            40: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            41: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            42: begin
                if(cnt<=ms300) begin
                    hz<=dh4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            43: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            44: begin
                if(cnt<=ms300) begin
                    hz<=e4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            45: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            46: begin
                if(cnt<=ms300) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            47: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            48: begin
                if(cnt<=ms300) begin
                    hz<=d4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            49: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            50: begin
                if(cnt<=ms300) begin
                    hz<=c4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            51: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            52: begin
                if(cnt<=ms900) begin
                    hz<=a3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            53: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            54: begin
                if(cnt<=ms300) begin
                    hz<=d3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            55: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            56: begin
                if(cnt<=ms300) begin
                    hz<=f3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            57: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            58: begin
                if(cnt<=ms300) begin
                    hz<=a3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            59: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            60: begin
                if(cnt<=ms900) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            61: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            62: begin
                if(cnt<=ms300) begin
                    hz<=f3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            63: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            64: begin
                if(cnt<=ms300) begin
                    hz<=c4;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            65: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            66: begin
                if(cnt<=ms300) begin
                    hz<=b3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            67: begin
                if(cnt<=ms400) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            68: begin
                if(cnt<=ms900) begin
                    hz<=a3;
                    cnt<=cnt+1;
                end
                else begin
                    state<=state+1;
                    cnt<=0;
                end
            end
            69: begin
                if(cnt<=ms1000) begin
                    hz<=0;
                    cnt<=cnt+1;
                end
                else begin
                    state<=1;
                    cnt<=0;
                end
            end

        endcase
    end
endmodule
