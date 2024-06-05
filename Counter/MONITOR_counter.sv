`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 14:33:07
// Design Name: 
// Module Name: MONITOR_counter
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


module MONITOR_count(counter_ifc.MONITOR counter_ifc);

always @(posedge counter_ifc.rst) begin
   $display("@%0t: rst asserted", $time);
   @(posedge counter_ifc.count);
   $display("@%0t: count asserted",$time);
end
 
 always @(posedge counter_ifc.mode)begin
   $display("@%0t: mode asserted", $time);
   @(posedge counter_ifc.count);
   $display("@%0t: count asserted",$time);
end   
endmodule