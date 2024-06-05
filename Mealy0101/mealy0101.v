`timescale 1ns / 1ps
module melay_0101 #(parameter s0=2'b00,s1=2'b01,s2=2'b10,s3=2'b11)
(input clk,rst,in,output reg out);
reg [1:0] cs,ns;
//current state logic
always @(posedge clk or posedge rst)
    begin
        if(rst)
            cs<=s0;
        else
            cs<=ns;
    end
//next state logic
always @(*)
    begin
        case(cs)
            s0:if(in==1)
               ns=s0;
               else
               ns=s1;
            s1:if(in==1)
               ns=s2;
               else
               ns=s1;
            s2:if(in==1)
               ns=s0;
               else
               ns=s3;
            s3:if(in==1)
               ns=s0;
               else  
               ns=s1;
           endcase
    end
//output logic
always @(*)
    begin
        case(cs)
            s0:out=0;
            s1:out=0;
            s2:out=0;
            s3:if(in==1)
                out=1;
               else
                out=0;
        endcase
    end
endmodule