`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 14:35:02
// Design Name: 
// Module Name: test_counter
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


module test_counter(counter_ifc.TB counter_ifc);

initial begin
  counter_ifc.mode = 1'b0;
  counter_ifc.rst = 1'b1;
  #5 counter_ifc.rst = 1'b0;
  counter_ifc.mode = 1'b0;
  #60;
  counter_ifc.mode = 1'b1;
end

initial
    $monitor("counter_ifc.count = %b",counter_ifc.count);
    
 initial begin 
 repeat(11) begin
 @(posedge counter_ifc.clk)
    if(counter_ifc.count == 'hf)
     $display("maximum count reached");
    else
     $display("current count %b",counter_ifc.count);
     
end
end
endmodule