`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2024 11:34:36
// Design Name: 
// Module Name: fsm_mealy_overlapping
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
import pkg_state::*;

module fsm_mealy_overlapping(intrf_seq_dect.dut dut_port);
//clk, rst , seq , out;
states c_state , n_state;
always @ (posedge dut_port.clk or posedge dut_port.rst)
begin
 if (dut_port.rst)
    c_state <= s0;
 else
    c_state <= n_state;
end

always @*
begin
case (c_state)
    s0 :    begin 
            if (dut_port.seq == 1'b1)
            n_state <=s1;
            else
            n_state <=s0;
             end
            
    s1 :    begin
            if (dut_port.seq == 1'b0)
            n_state <= s2;
            else
            n_state <= s1;
            end
            
    s2 :    begin
            if (dut_port.seq == 1'b1)
            n_state <= s1;
            else
            n_state <= s0;
            end
    endcase     
end

always @*
begin
case (c_state)
        s0 : dut_port.out = 1'b0;
        s1 : dut_port.out = 1'b0;
        s2 : begin
             if (dut_port.seq == 1'b1)
             dut_port.out = 1'b1;
             else 
             dut_port.out = 1'b0;
             end
       endcase 
end
endmodule
