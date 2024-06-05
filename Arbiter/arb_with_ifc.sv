`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:07:12
// Design Name: 
// Module Name: arb_with_ifc
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

module arb_with_ifc (arb_if arbif);

always @(posedge arbif.clk )

begin

    if (arbif.rst)
    
        arbif.grant <= '0;
    
    else if (arbif.request [0]) // High priority
    
        arbif.grant <= 2'b01;
    
    else if (arbif.request [1]) // Low priority
    
        arbif.grant <= 2'b10;
    
    else
    
        arbif.grant <= '0 ;
    
end

endmodule
