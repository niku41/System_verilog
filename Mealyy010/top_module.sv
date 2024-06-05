`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 11:30:08
// Design Name: 
// Module Name: top_module
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

`include "interface.sv"
module top_module();
bit clk;
always #5 clk = ~clk;
intrf_seq_dect intrf(clk);
fsm_mealy_overlapping DUT(intrf.dut);
tb_fsm_overlapping TEST(intrf.test);
monitor MONITOR (intrf.monitor);
endmodule
