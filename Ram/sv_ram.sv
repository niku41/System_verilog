`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2024 10:45:11
// Design Name: 
// Module Name: sv_ram
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

`include "sv_intf.sv"

module sv_ram(ram_if ram);
ram ram_inst(.address(ram.address),
             .data_in(ram.data_in),
             .data_out(ram.data_out),
             .clk(ram.clk),
             .wr(ram.wr),
             .rd(ram.rd),
             .cs(ram.cs));
endmodule