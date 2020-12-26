`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/12/22 22:31:16
// Design Name: 
// Module Name: my_rom
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


module my_rom(
input [6:0] address,
output reg  [7:0] q
    );
    reg [7:0] my_memory [0:127];

initial
begin
my_memory[0] = 8'h25;
my_memory[1] = 8'h41;
my_memory[2] = 8'h41;
my_memory[3] = 8'h42;
my_memory[4] = 8'h41;
my_memory[5] = 8'h27;
my_memory[6] = 8'h26;
my_memory[7] = 8'h26;
my_memory[8] = 8'h26;
my_memory[9] = 8'h42;
my_memory[10] = 8'h42;
my_memory[11] = 8'h43;
my_memory[12] = 8'h42;
my_memory[13] = 8'h41;
my_memory[14] = 8'h27;
my_memory[15] = 8'h25;
my_memory[16] = 8'h25;
my_memory[17] = 8'h43;
my_memory[18] = 8'h43;
my_memory[19] = 8'h44;
my_memory[20] = 8'h43;
my_memory[21] = 8'h42;
my_memory[22] = 8'h41;
my_memory[23] = 8'h26;
my_memory[24] = 8'h25;
my_memory[25] = 8'h25;
my_memory[26] = 8'h26;
my_memory[27] = 8'h42;
my_memory[28] = 8'h27;
my_memory[29] = 8'h41;
my_memory[30] = 8'h41;
my_memory[31] = 8'h25;
my_memory[32] = 8'h41;
my_memory[33] = 8'h41;
my_memory[34] = 8'h41;
my_memory[35] = 8'h27;
my_memory[36] = 8'h27;
my_memory[37] = 8'h27;
my_memory[38] = 8'h41;
my_memory[39] = 8'h27;
my_memory[40] = 8'h26;
my_memory[41] = 8'h25;
my_memory[42] = 8'h25;
my_memory[43] = 8'h42;
my_memory[44] = 8'h43;
my_memory[45] = 8'h42;
my_memory[46] = 8'h41;
my_memory[47] = 8'h45;
my_memory[48] = 8'h25;
my_memory[49] = 8'h25;
my_memory[50] = 8'h25;
my_memory[51] = 8'h26;
my_memory[52] = 8'h42;
my_memory[53] = 8'h27;
my_memory[54] = 8'h41;
my_memory[55] = 8'h41;
my_memory[56] = 8'h41;

my_memory[56] = 8'h25;
my_memory[57] = 8'h41;
my_memory[58] = 8'h41;
my_memory[59] = 8'h42;
my_memory[60] = 8'h41;
my_memory[61] = 8'h27;
my_memory[62] = 8'h26;
my_memory[63] = 8'h26;
my_memory[64] = 8'h26;
my_memory[65] = 8'h42;
my_memory[66] = 8'h42;
my_memory[67] = 8'h43;
my_memory[68] = 8'h42;
my_memory[69] = 8'h41;
my_memory[70] = 8'h27;
my_memory[71] = 8'h25;
my_memory[72] = 8'h25;
my_memory[73] = 8'h43;
my_memory[74] = 8'h43;
my_memory[75] = 8'h44;
my_memory[76] = 8'h43;
my_memory[77] = 8'h42;
my_memory[78] = 8'h41;
my_memory[79] = 8'h26;
my_memory[80] = 8'h25;
my_memory[81] = 8'h25;
my_memory[82] = 8'h26;
my_memory[83] = 8'h42;
my_memory[84] = 8'h27;
my_memory[85] = 8'h41;
my_memory[86] = 8'h41;
my_memory[87] = 8'h25;
my_memory[88] = 8'h41;
my_memory[89] = 8'h41;
my_memory[90] = 8'h41;
my_memory[91] = 8'h27;
my_memory[92] = 8'h27;
my_memory[93] = 8'h27;
my_memory[94] = 8'h41;
my_memory[95] = 8'h27;
my_memory[96] = 8'h26;
my_memory[97] = 8'h25;
my_memory[98] = 8'h25;
my_memory[99] = 8'h42;
my_memory[100] = 8'h43;
my_memory[101] = 8'h42;
my_memory[102] = 8'h41;
my_memory[103] = 8'h45;
my_memory[104] = 8'h25;
my_memory[105] = 8'h25;
my_memory[106] = 8'h25;
my_memory[107] = 8'h26;
my_memory[108] = 8'h42;
my_memory[109] = 8'h27;
my_memory[110] = 8'h41;
my_memory[111] = 8'h41;
my_memory[112] = 8'h41;

my_memory[113] = 8'h25;
my_memory[114] = 8'h41;
my_memory[115] = 8'h41;
my_memory[116] = 8'h42;
my_memory[117] = 8'h41;
my_memory[118] = 8'h27;
my_memory[119] = 8'h26;
my_memory[120] = 8'h26;
my_memory[121] = 8'h26;
my_memory[122] = 8'h42;
my_memory[123] = 8'h42;
my_memory[124] = 8'h43;
my_memory[125] = 8'h42;
my_memory[126] = 8'h41;
my_memory[127] = 8'h27;


end

always @ (address)
    begin
        case (address)
7'd0: q = my_memory[0];
7'd1: q = my_memory[1];
7'd2: q = my_memory[2];
7'd3: q = my_memory[3];
7'd4: q = my_memory[4];
7'd5: q = my_memory[5];
7'd6: q = my_memory[6];
7'd7: q = my_memory[7];
7'd8: q = my_memory[8];
7'd9: q = my_memory[9];
7'd10: q = my_memory[10];
7'd11: q = my_memory[11];
7'd12: q = my_memory[12];
7'd13: q = my_memory[13];
7'd14: q = my_memory[14];
7'd15: q = my_memory[15];
7'd16: q = my_memory[16];
7'd17: q = my_memory[17];
7'd18: q = my_memory[18];
7'd19: q = my_memory[19];
7'd20: q = my_memory[20];
7'd21: q = my_memory[21];
7'd22: q = my_memory[22];
7'd23: q = my_memory[23];
7'd24: q = my_memory[24];
7'd25: q = my_memory[25];
7'd26: q = my_memory[26];
7'd27: q = my_memory[27];
7'd28: q = my_memory[28];
7'd29: q = my_memory[29];
7'd30: q = my_memory[30];
7'd31: q = my_memory[31];
7'd32: q = my_memory[32];
7'd33: q = my_memory[33];
7'd34: q = my_memory[34];
7'd35: q = my_memory[35];
7'd36: q = my_memory[36];
7'd37: q = my_memory[37];
7'd38: q = my_memory[38];
7'd39: q = my_memory[39];
7'd40: q = my_memory[40];
7'd41: q = my_memory[41];
7'd42: q = my_memory[42];
7'd43: q = my_memory[43];
7'd44: q = my_memory[44];
7'd45: q = my_memory[45];
7'd46: q = my_memory[46];
7'd47: q = my_memory[47];
7'd48: q = my_memory[48];
7'd49: q = my_memory[49];
7'd50: q = my_memory[50];
7'd51: q = my_memory[51];
7'd52: q = my_memory[52];
7'd53: q = my_memory[53];
7'd54: q = my_memory[54];
7'd55: q = my_memory[55];
7'd56: q = my_memory[56];
7'd57: q = my_memory[57];
7'd58: q = my_memory[58];
7'd59: q = my_memory[59];
7'd60: q = my_memory[60];
7'd61: q = my_memory[61];
7'd62: q = my_memory[62];
7'd63: q = my_memory[63];
7'd64: q = my_memory[64];
7'd65: q = my_memory[65];
7'd66: q = my_memory[66];
7'd67: q = my_memory[67];
7'd68: q = my_memory[68];
7'd69: q = my_memory[69];
7'd70: q = my_memory[70];
7'd71: q = my_memory[71];
7'd72: q = my_memory[72];
7'd73: q = my_memory[73];
7'd74: q = my_memory[74];
7'd75: q = my_memory[75];
7'd76: q = my_memory[76];
7'd77: q = my_memory[77];
7'd78: q = my_memory[78];
7'd79: q = my_memory[79];
7'd80: q = my_memory[80];
7'd81: q = my_memory[81];
7'd82: q = my_memory[82];
7'd83: q = my_memory[83];
7'd84: q = my_memory[84];
7'd85: q = my_memory[85];
7'd86: q = my_memory[86];
7'd87: q = my_memory[87];
7'd88: q = my_memory[88];
7'd89: q = my_memory[89];
7'd90: q = my_memory[90];
7'd91: q = my_memory[91];
7'd92: q = my_memory[92];
7'd93: q = my_memory[93];
7'd94: q = my_memory[94];
7'd95: q = my_memory[95];
7'd96: q = my_memory[96];
7'd97: q = my_memory[97];
7'd98: q = my_memory[98];
7'd99: q = my_memory[99];
7'd100: q = my_memory[100];
7'd101: q = my_memory[101];
7'd102: q = my_memory[102];
7'd103: q = my_memory[103];
7'd104: q = my_memory[104];
7'd105: q = my_memory[105];
7'd106: q = my_memory[106];
7'd107: q = my_memory[107];
7'd108: q = my_memory[108];
7'd109: q = my_memory[109];
7'd110: q = my_memory[110];
7'd111: q = my_memory[111];
7'd112: q = my_memory[112];
7'd113: q = my_memory[113];
7'd114: q = my_memory[114];
7'd115: q = my_memory[115];
7'd116: q = my_memory[116];
7'd117: q = my_memory[117];
7'd118: q = my_memory[118];
7'd119: q = my_memory[119];
7'd120: q = my_memory[120];
7'd121: q = my_memory[121];
7'd122: q = my_memory[122];
7'd123: q = my_memory[123];
7'd124: q = my_memory[124];
7'd125: q = my_memory[125];
7'd126: q = my_memory[126];
7'd127: q = my_memory[127];

        endcase
    end

endmodule
