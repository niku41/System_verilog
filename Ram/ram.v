`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2024 10:37:21
// Design Name: 
// Module Name: ram
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


module ram (address,data_in,clk,wr,rd,cs,data_out);
input [9:0] address;
input clk,wr,rd,cs;
input [7:0]data_in;
reg [7:0] mem [1023:0];
output reg [7:0] data_out;

always @(posedge clk)begin
if(cs && wr && !rd)
mem[address]=data_in;
end

always @(posedge clk)begin
if(cs && rd && !wr)                               
data_out=mem[address];
end

endmodule
