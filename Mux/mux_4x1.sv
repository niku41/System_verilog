`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 10:20:38
// Design Name: 
// Module Name: mux_4x1
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


`include "interfae.sv"
module mux_4x1(intrf_mux.dut port );
                        
//                        input in_0,in_1,in_2,in_3; // or [3:0] in 
//                        input [1:0] sel; // or sel_0 , sel_1;
//                        output reg mux_out;
                        
                        
                        always @( port.in_0 or port.in_1 or port.in_2 or port.in_3 or port.sel)
                        begin
                        case(port.sel)
                        2'b00: port.mux_out= port.in_0;
                        2'b01: port.mux_out= port.in_1;
                        2'b10: port.mux_out= port.in_2;
                        2'b11: port.mux_out= port.in_3;
                        endcase
                        end

endmodule
