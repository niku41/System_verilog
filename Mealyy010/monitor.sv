`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 11:30:54
// Design Name: 
// Module Name: monitor
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


`include"interface.sv"
module monitor(intrf_seq_dect.monitor mon_port);
integer fd ;

initial
begin
fd = $fopen("melay_output.txt","w");
#50;
$fclose(fd);
end

initial
begin
$fmonitor(fd,"time = %t | rst = %b | seq = %b | out = %b ", $time ,mon_port.rst,mon_port.seq,mon_port.out);
end

//always @(mon_port.seq or mon_port.out or mon_port.rst)
//begin
initial
begin
$monitor("time = %t | rst = %b | seq = %b | out = %b ", $time ,mon_port.rst,mon_port.seq,mon_port.out);
end
 
endmodule
