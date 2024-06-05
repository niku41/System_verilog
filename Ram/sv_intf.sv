`timescale 1ns / 1ps
interface ram_if();
bit clk;
logic wr,rd,cs;
logic [9:0] address;
logic [7:0] data_in;
logic [7:0] data_out;
endinterface