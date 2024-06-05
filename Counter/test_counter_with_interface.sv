`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:14:44
// Design Name: 
// Module Name: test_counter_with_interface
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

module test_counter_with_interface(counter_if cif);

initial 
    begin 
        cif.rst=1;
        #12
        cif.rst=0;
        repeat(20)@(posedge cif.clk); ;    
    end 
    endmodule