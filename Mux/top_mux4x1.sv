`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 10:21:31
// Design Name: 
// Module Name: top_mux4x1
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
module top_mux4x1();

intrf_mux intrf();
mux_4x1 inst(intrf.dut);
tb_mux_4x1  TB (intrf.tb);
monitor_mux_4x1 MON(intrf.monitor);
endmodule
