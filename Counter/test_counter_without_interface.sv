`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:01:16
// Design Name: 
// Module Name: test_counter_without_interface
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


module test_counter_without_interface(
input bit clk ,
output bit rst ,
input  logic [3:0]count 
    );
    initial 
        
        begin
            rst =1;
            #12 
            rst =0;
            repeat(15)@(posedge clk );
        end  

endmodule
