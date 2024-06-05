`timescale 1ns / 1ps

module tb_counter_sv(
    output bit rst,
    input bit clk);
    initial begin
        rst <= 0;
        repeat(5) @(posedge clk);
        rst<=1;
        repeat(5) @(posedge clk);
        rst<=0;   
    end
endmodule

