class transaction ;
    rand bit seq_in;
         bit seq_out ;
     function transaction copy();
         copy = new();
         copy.seq_in = this.seq_in;
         copy.seq_out = this.seq_out;   
     endfunction  
     
     function void display(input string tag );
        $display("[%0s] : seq_in : %0b seq_out : %0b", seq_in, seq_out); 
     endfunction     
endclass  
 
class  generator;
    transaction tr ;
        mailbox #(transaction)mbx ;
        mailbox #(transaction)mbxref;
        event sconext ;
        event done ;
        int count ;
        function new(mailbox #(transaction)mbx,mailbox #(transaction)mbxref);
            this.mbx = mbx ;
            this.mbxref = mbxref;
            tr = new();
        endfunction     
    task run();
        repeat(count)
            begin 
                assert(tr.randomize)else $error("[GEN]: randomization fail");
                mbx.put(tr.copy);
                mbxref.put(tr.copy);
                tr.display("GEN");
                @(sconext);
            end 
            ->done;
    endtask 
endclass  

class driver ;
    transaction tr ;
    mailbox #(transaction)mbx ;
    virtual melay_0101_if vif;
    function new(mailbox#(transaction )mbx);
        this.mbx = mbx ;
    endfunction 
    
    task reset();
        vif.rst <= 1'b1;
        repeat(5) @(posedge vif.clk); // Wait for 5 clock cycles
        vif.rst <= 1'b0; // Deassert reset signal
        @(posedge vif.clk); // Wait for one more clock cycle
        $display("[DRV] : RESET DONE"); // Display reset completion message
      endtask
   
   task run ();
        forever 
            begin 
                mbx.get(tr);
                vif.seq_in <= tr.seq_in;
                @(posedge vif.clk);
                tr.display("DRV");
                vif.seq_in <= 1'b0;
                @(posedge vif.clk);
            end 
   endtask 
endclass  

class monitor ;
    transaction tr ;
    mailbox #(transaction)mbx;
    virtual melay_0101_if vif;
    function new (mailbox #(transaction)mbx);
        this.mbx = mbx ;
    endfunction 
    task run ();
        tr= new();
        forever 
            begin 
                repeat(2)@(posedge vif.clk);
                tr.seq_out = vif.seq_out;
                mbx.put(tr);
                tr.display("MON");
            end 
    endtask 
endclass

class scoreboard;
      transaction tr; // Define a transaction object
      transaction trref; // Define a reference transaction object for comparison
      mailbox #(transaction) mbx; // Create a mailbox to receive data from the driver
      mailbox #(transaction) mbxref; // Create a mailbox to receive reference data from the generator
      event sconext; // Event to signal completion of scoreboard work
     
      function new(mailbox #(transaction) mbx, mailbox #(transaction) mbxref);
        this.mbx = mbx; // Initialize the mailbox for receiving data from the driver
        this.mbxref = mbxref; // Initialize the mailbox for receiving reference data from the generator
      endfunction
      
      task run();
        forever begin
          mbx.get(tr); // Get a transaction from the driver
          mbxref.get(trref); // Get a reference transaction from the generator
          tr.display("SCO"); // Display the driver's transaction information
          trref.display("REF"); // Display the reference transaction information
          if (tr.seq_out == trref.seq_in)
            $display("[SCO] : DATA MATCHED"); // Compare data and display the result
          else
            $display("[SCO] : DATA MISMATCHED");
          $display("-------------------------------------------------");
          ->sconext; // Signal completion of scoreboard work
        end
      endtask //dout
endclass

class environment ;
    generator gen ;
    driver drv;
    monitor mon ;
    scoreboard sco ;
    event next ;
    mailbox #(transaction) gdmbx; // Mailbox for communication between generator and driver
      mailbox #(transaction) msmbx; // Mailbox for communication between monitor and scoreboard
      mailbox #(transaction) mbxref;
    virtual melay_0101_if vif;
// transection
    function new(virtual melay_0101_if vif);
        gdmbx = new(); // Create a mailbox for generator-driver communication
        mbxref = new(); // Create a mailbox for generator-scoreboard reference data
        gen = new(gdmbx, mbxref); // Initialize the generator
        drv = new(gdmbx); // Initialize the driver
        msmbx = new(); // Create a mailbox for monitor-scoreboard communication
        mon = new(msmbx); // Initialize the monitor
        sco = new(msmbx, mbxref); // Initialize the scoreboard
        this.vif = vif; // Set the virtual interface for DUT
        drv.vif = this.vif; // Connect the virtual interface to the driver
        mon.vif = this.vif; // Connect the virtual interface to the monitor
        gen.sconext = next; // Set the communication event between generator and scoreboard
        sco.sconext = next; // Set the communication event between scoreboard and generator
      endfunction
      
      task pre_test();
        drv.reset();
      endtask  
      
      task test();
        fork
          gen.run(); // Start generator
          drv.run(); // Start driver
          mon.run(); // Start monitor
          sco.run(); // Start scoreboard
        join_any
      endtask 
      
      task post_test();
        wait(gen.done.triggered); // Wait for generator to complete
        $finish(); // Finish simulation
      endtask
      
      task run();
        pre_test(); // Run pre-test setup
        test(); // Run the test
        post_test(); // Run post-test cleanup
      endtask
endclass 

      
module TB_melay_0101();

    melay_0101_if vif();
    SV_melay_0101 dut(vif);
    always #10 vif.clk = ~vif.clk; // Toggle the clock every 10 time units
      environment env; // Create environment instance
     initial begin
        vif.clk = 0; // Initialize clock signal
        env = new(vif); // Initialize the environment with the DUT interface
        env.gen.count = 30; // Set the generator's stimulus count
        env.run(); // Run the environment
      end
      
endmodule