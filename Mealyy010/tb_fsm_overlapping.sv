`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 11:31:57
// Design Name: 
// Module Name: tb_fsm_overlapping
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
program automatic tb_fsm_overlapping (intrf_seq_dect.test tb_port);
integer fd;
initial 
begin
//fd = $fopen("Mealy_output.txt", "w");
tb_port.rst = 1'b1;
#10
tb_port.rst = 1'b0;
for (int i = 0 ; i <=10 ; i++)
begin
#10
tb_port.cb_tb.seq <= $urandom_range(0,1);
end
//tb_port.cb_tb.seq <= 1'b0;
//#10
//tb_port.cb_tb.seq <= 1'b1;
//#10
//tb_port.cb_tb.seq <= 1'b0;
//#10
//tb_port.cb_tb.seq <= 1'b1;
//$fclose(fd);
//$fdisplay(fd,"Simulation over!!");
end

//initial
//begin
//$fmonitor(fd ,"Time- %d | rst - %b | seq = %b",$time,tb_port.rst);
//end

endprogram
