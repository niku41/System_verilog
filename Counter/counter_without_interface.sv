`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2024 12:00:27
// Design Name: 
// Module Name: counter_without_interface
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


module counter_without_interface(
input bit clk ,rst ,
output logic [3:0]count 
    );
    always_ff @(posedge clk)
        begin 
        if (rst)
            count <=4'b0000;
        else 
            count <= count + 4'b0001;
        end 

endmodule
