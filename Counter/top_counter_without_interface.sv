`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:02:21
// Design Name: 
// Module Name: top_counter_without_interface
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


module top_counter_without_interface();
bit clk ,rst;
logic [3:0]count ;
always #10clk = ~clk ;
    counter_without_interface CWI (clk ,rst,count);
    test_counter_without_interface TCWI(clk ,rst,count);

endmodule
