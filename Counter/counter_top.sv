`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2024 14:34:11
// Design Name: 
// Module Name: counter_top
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


module counter_top;
  bit clk;

always #5 clk = ~clk;

  counter_ifc counter_ifc(clk);
  counter_with_ifc counter_ifc_inst(counter_ifc.DUT);
  test_counter test_ifc_inst(counter_ifc.TB);
  MONITOR_count MONITOR(counter_ifc.MONITOR);

endmodule