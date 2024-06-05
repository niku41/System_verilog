`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 14:35:57
// Design Name: 
// Module Name: counter_with_ifc
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

interface counter_ifc(input bit clk);
 logic [3:0]count;
 bit mode;
 bit rst;
 
 
modport DUT (input mode, rst,clk,output count);

modport TB (output mode, rst,clk,input count);

modport MONITOR (input mode,rst,clk,count);
endinterface

module counter_with_ifc(counter_ifc.DUT counter_ifc);
 
always_ff @(posedge counter_ifc.clk, posedge counter_ifc.rst) begin
  if (counter_ifc.rst)
    counter_ifc.count <= 4'b0;
  else if (counter_ifc.mode)
    counter_ifc.count <= counter_ifc.count + 1;
  else
    counter_ifc.count <= counter_ifc.count - 1;
end
endmodule