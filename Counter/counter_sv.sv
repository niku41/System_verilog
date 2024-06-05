`timescale 1ns / 1ps

module counter_sv(
    input bit clk,rst,
    output bit [3:0] count
    );
    
always_ff@(posedge clk)
begin
    if(rst)
        count <= 0;
    else
        count <= count + 1;
end

endmodule


