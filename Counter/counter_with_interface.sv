`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:16:38
// Design Name: 
// Module Name: counter_with_interface
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
module counter_with_interface(counter_if cif);
always @(posedge cif.clk )
    begin 
        if (cif.rst)
            cif.count <= 4'b0000;
        else 
            cif.count <= cif.count+1;
    end 

endmodule
