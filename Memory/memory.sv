`timescale 1ns / 1ps

include "mem_intfc.sv";

module memory(mem_intfc.DUT memif);
logic [7:0] mem [8];
always @(posedge memif.start)
begin
    if(memif.write)
        mem[memif.addr] <= memif.data;
end
assign memif.data = ~memif.write ? mem[memif.addr]: 'hz;

endmodule
