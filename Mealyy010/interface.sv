interface intrf_seq_dect(input bit clk);
bit rst , seq , out;

clocking cb_tb @(posedge clk);
output seq ;
input out;
endclocking


 
modport dut (input clk , rst ,seq , output out);
modport test(clocking cb_tb ,output rst  );
modport monitor(input seq , out , rst);
endinterface