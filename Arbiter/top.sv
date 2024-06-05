`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:06:00
// Design Name: 
// Module Name: top
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


`include "arb_if.sv"
    module top;
    
    bit clk;
    
    always #5 clk = ~clk;
    
       arb_if arbif (clk);
    
       arb_with_ifc al (arbif);
       test_with_ifc tl (arbif);
    
  endmodule: top