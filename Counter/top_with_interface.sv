`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:17:30
// Design Name: 
// Module Name: top_with_interface
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


`include "counter_if.sv"
module top_with_interrface;

bit clk;
always #10 clk =~clk;
    counter_if cif (clk );
    counter_with_interface CWI_i (cif);
    test_counter_with_interface TCWI_i (cif);
endmodule
