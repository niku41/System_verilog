`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:08:01
// Design Name: 
// Module Name: test_with_ifc
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
module test_with_ifc (arb_if arbif);

initial 
begin

    @(posedge arbif.clk);

        arbif.request <= 2'b10;
    
        $display("@%0t: Drove re*alpha =01" , $time);
    
    repeat (2) @(posedge arbif.clk);
    
        if (arbif.grant != 2'b01)
    
        $display("@%0t: Error: grant t= 2'b01^ prime prime" , $time);
    
    $finish;

end

endmodule
