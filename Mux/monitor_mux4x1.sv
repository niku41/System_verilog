`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 10:19:16
// Design Name: 
// Module Name: monitor_mux4x1
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
module monitor_mux_4x1(intrf_mux.monitor mon_port);
always @(mon_port.sel)begin
$display ("time : %0t , select : %b ", $time,mon_port.sel);
end

always @ (mon_port.mux_out or mon_port.sel)begin
$display ("time : %0t , mux_out : %b ", $time , mon_port.mux_out);
end

endmodule
