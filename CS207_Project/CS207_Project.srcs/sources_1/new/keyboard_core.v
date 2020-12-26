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
    input clkin, rst,
    input [3:0] row,
    output reg [3:0] col,
    output [15:0] keys
    );

    parameter NO_SCAN = 4'd0;
    parameter SCANING = 4'd1;
    parameter UPDATE_DATA = 4'd2;

    reg [3:0] state;

    reg[15:0] data;
    reg[15:0] data_out;

    reg[2:0] waitbit; // make button wait some clock to read data

    keyboard_map keyboard_map_inst(data_out, keys);

    wire clk;
    div div_ins(clkin, rst, clk);

    always @(posedge clk, negedge rst) begin
        if (~rst) begin
            col <= 4'b1111;
            state <= NO_SCAN;
            data <= 16'hFFFF;
            data_out <= 16'hFFFF;
            waitbit <= 0;
        end
        else begin
            case (state)
                NO_SCAN: begin
                    state <= SCANING;
                    col <= 4'b0111;
                end
                SCANING: begin
                    case(col)
                        4'b0111: begin
                            if(waitbit == 7) begin
                                data[15:12] <= row;
                                col <= 4'b1011;
                                waitbit <= 0;
                            end
                            else waitbit <= waitbit + 1;
                        end
                        4'b1011: begin
                            if(waitbit == 7) begin
                                data[11:8] <= row;
                                col <= 4'b1101;
                                waitbit <= 0;
                            end
                            else waitbit <= waitbit + 1;
                        end
                        4'b1101: begin
                            if(waitbit == 7) begin
                                data[7:4] <= row;
                                col <= 4'b1110;
                                waitbit <= 0;
                            end
                            else waitbit <= waitbit + 1;
                        end
                        4'b1110: begin
                            if(waitbit == 7) begin
                                data[3:0] <= row;
                                col <= 4'b1111;
                                waitbit <= 0;
                                state <= UPDATE_DATA;
                            end
                            else waitbit <= waitbit + 1;

                        end
                    endcase

                end
                UPDATE_DATA: begin
                    if(waitbit == 7) begin
                        state <= NO_SCAN;
                        data_out <= data;
                        waitbit <= 0;
                    end
                    else waitbit <= waitbit + 1;
                end

            endcase
        end
    end
endmodule
