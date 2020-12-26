`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/19 16:11:42
// Design Name: 
// Module Name: key_vibration
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


module key_vibration(
    input		  	 mclk,
	input		  	 rst_n,
	input	   [4:0] key,
	output reg [4:0] key_en
	);
	
	parameter DURATION = 50_000;                           //延时10ms	
	reg [15:0] cnt; 
	
	wire ken_enable;
	assign ken_enable = key[4] | key[3] | key[2] | key[1] | key[0]; //只要任意按键被按下，相应的按键进行消抖
	
	always @(posedge mclk or negedge rst_n)
	begin
		if(!rst_n)
			cnt <= 11'd0;
		else if(ken_enable == 1) begin
			if(cnt == DURATION)
				cnt <= cnt;
			else 
				cnt <= cnt + 1'b1;
			end
		else
			cnt <= 16'b0;
	end
	
	always @(posedge mclk or negedge rst_n) 
	begin
		if(!rst_n) key_en <= 5'd0;
		else if(key[0]) key_en[0] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(key[1]) key_en[1] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(key[2]) key_en[2] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(key[3]) key_en[3] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else if(key[4]) key_en[4] <= (cnt == DURATION-1'b1) ? 1'b1 : 1'b0;
		else key_en <= key_en;
	end
	
endmodule
