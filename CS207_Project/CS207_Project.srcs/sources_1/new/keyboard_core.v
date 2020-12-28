`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/17 22:08:12
// Design Name: 
// Module Name: kenboard_core
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


module keyboard_core(
    input clk, rst,
    input [3:0] row,
    output reg [3:0] col,
    output [15:0] keys
    );

    parameter NO_SCAN = 4'd0;//表示未扫描的状态
    parameter SCANING = 4'd1;//表示扫描的状态

    reg [3:0] state;

    reg[15:0] data;
    wire [15:0] data_out;

    reg[2:0] count; // 当按键在数个时钟周期中都处于按下的状态，则认为这是一次有效的输入

    keyboard_map key_mapping_inst(data_out, keys);//将生成的行列坐标信号映射成输出所需要的信号

    assign data_out=data;

    always @(posedge clk) begin
        if (rst) begin//复位
            col <= 4'b1111;
            state <= NO_SCAN;
            data <= 16'hFFFF;
            count <= 0;
        end
        else begin
            case (state)
                NO_SCAN: begin//若处于未扫描的状态，则进入扫描状态，开始扫描col0
                    state <= SCANING;
                    col <= 4'b1110;
                end
                SCANING: begin
                    case(col)

                        4'b1110: begin//扫描col0
                            if(count == 7) begin
                                data[3:0] <= row;
                                col <= 4'b0111;
                                count <= 0;
                            end
                            else count <= count + 1;

                        end

                        4'b0111: begin//扫描col3
                            if(count == 7) begin
                                data[15:12] <= row;
                                col <= 4'b1011;
                                count <= 0;
                            end
                            else count <= count + 1;
                        end

                        4'b1011: begin//扫描col2
                            if(count == 7) begin
                                data[11:8] <= row;
                                col <= 4'b1101;
                                count <= 0;
                            end
                            else count <= count + 1;
                        end
                        
                        4'b1101: begin//扫描col1
                            if(count == 7) begin
                                data[7:4] <= row;
                                col <= 4'b1110;
                                count <= 0;
                            end
                            else count <= count + 1;
                        end

                    endcase

                end

            endcase
        end
    end
endmodule