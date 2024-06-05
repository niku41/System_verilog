interface intrf_mux ();
bit in_0,in_1,in_2,in_3;
bit [1:0] sel;
bit mux_out;

modport dut (input in_0 , in_1 , in_2 , in_3 , sel , output mux_out);
modport tb  (output in_0 , in_1 , in_2 , in_3 , sel , input mux_out);
modport monitor (input sel , mux_out);
endinterface