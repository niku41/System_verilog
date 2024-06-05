`timescale 1ns / 1ps
`include "sv_intf.sv"
module SV_melay_0101(melay_0101_if mel);
melay_0101 mel_ver_inst(.rst(mel.rst),
                       .clk(mel.clk),
                       .in(mel.seq_in),
                       .out(mel.seq_out));
endmodule