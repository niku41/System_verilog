`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 10:23:09
// Design Name: 
// Module Name: tb_mux4x1
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
program automatic tb_mux_4x1(intrf_mux.tb tb_port);
integer fd;
initial 
begin
fd = $fopen("output.txt", "w");
tb_port.in_0 = 1'b0;
tb_port.in_1 = 1'b1;
tb_port.in_2 = 1'b0;
tb_port.in_3 = 1'b1;
for (int i = 0 ; i < 4 ; i++)
begin
    #10
    tb_port.sel = $urandom_range(0,3);
end
$fclose(fd);
end

initial begin
$fmonitor (fd,"time : %t , in_0 : %b , in_1 : %b , in_2 : %b , in_3 : %b , sel = %b , mux_out : %b" , $time , tb_port.in_0 ,tb_port.in_1 ,tb_port.in_2,tb_port.in_3 , tb_port.sel , tb_port.mux_out);
end
endprogram
