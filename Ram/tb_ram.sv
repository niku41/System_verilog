//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04.06.2024 10:55:29
//// Design Name: 
//// Module Name: tb_ram
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////

//class transaction;

//    rand bit oper;  //Randomized bit for operation control
//    bit rd,wr;      //read or write control bit
//    bit [7:0] data_in;       //data_in input
//    bit [7:0] data_out;      //data output
    
//    constraint oper_ctrl {  
//    oper dist {1 :/ 50 , 0 :/ 50};  // Constraint to randomize 'oper' with 50% probability of 1 and 50% probability of 0
//  }
  
//endclass

////////////////////////////////////////////////////////////

//class generator;

//    transaction tr;     //transaction object to generate or create
//    mailbox #(transaction) mbx;  //mailbox for communication 
//    int count = 0;      //no. of transactions to generate
//    int i = 0;          //iteration counter
    
    
//    event next;         //signal to send the next transaction
//    event done;         //signal to convey completion of requested no. of transaction
    
//    function new(mailbox #(transaction) mbx);
//        this.mbx = mbx;
//        tr = new();
//    endfunction
    
//    task run();
//        repeat (count) begin
//            assert (tr.randomize) else $error("randomization failed");
//            i++;
//            mbx.put(tr);
//            $display("[GEN] : Oper : %0d iteration : %0d", tr.oper, i);
//      @(next);
//    end -> done;
//  endtask
  
//endclass

//////////////////////////////////////////////////////////////////

//class driver;

//    virtual ram_if ram;     //virtual interface to ram
//    mailbox #(transaction)mbx;  //mailbox for communication
//    transaction datac;      //transaction object for communication
    
//    function new(mailbox #(transaction) mbx);
//        this.mbx = mbx;
//    endfunction
    
//    //cs to ram
//    task chip_select();
//        @(posedge ram.clk)
//        ram.wr <= 1'b0;
//        ram.rd <= 1'b0;
//        ram.cs <= 1'b0;
//        ram.data_in <= 0;
//        repeat (5) @(posedge ram.clk);
//    ram.cs <= 1'b1;
//    $display("[DRV] : chip select Done");
//    $display("------------------------------------------");
//  endtask
    
//    //write data to ram
//    task write();
//        @(posedge ram.clk)
//        ram.wr <= 1'b1;
//        ram.rd <= 1'b0;
//        ram.cs <= 1'b1;
//        ram.data_in <= $urandom_range(1,10);
//        @(posedge ram.clk);
//        ram.wr <= 1'b0;
//        $display("[DRV] : DATA WRITE  din : %0d", ram.data_in);  
//    @(posedge ram.clk);
//  endtask
  
//  //read data_in from ram
//    task read();
//        @(posedge ram.clk)
//        ram.wr <= 1'b0;
//        ram.rd <= 1'b1;
//        ram.cs <= 1'b1;
//        @(posedge ram.clk);
//        ram.rd <= 1'b0;      
//        $display("[DRV] : DATA READ");  
//        @(posedge ram.clk);
//  endtask
  
//  // Apply random stimulus to the DUT
//  task run();
//    forever begin
//      mbx.get(datac);  
//      if (datac.oper == 1'b1)
//        write();
//      else
//        read();
//    end
//  endtask
  
//endclass

/////////////////////////////////////////////////////////////

//class monitor;

//    virtual ram_if ram;     //virtual interface to ram
//    mailbox #(transaction)mbx;  //mailbox for communication
//    transaction tr;      //transaction object for monitoring
    
//    function new(mailbox #(transaction) mbx);
//      this.mbx = mbx;     
//    endfunction;
 
//    task run();
//      tr = new();
  
//    forever begin
//      repeat (2) @(posedge ram.clk);
//      tr.wr = ram.wr;
//      tr.rd = ram.rd;
//      tr.data_in = ram.data_in;
//      @(posedge ram.clk);
//      tr.data_out = ram.data_out;
    
//      mbx.put(tr);
//      $display("[MON] : Wr:%0d rd:%0d din:%0d dout:%0d ", tr.wr, tr.rd, tr.data_in, tr.data_out);
//    end
    
//  endtask
  
//endclass

///////////////////////////////////////////////////////////

//class scoreboard;
 
//    mailbox #(transaction) mbx;     //mailbox for transaction
//    transaction tr;                 //transaction object for monitor
//    event next;
//    bit [7:0] din[$];               //array to store written data
//    bit [7:0] temp;                 //temporary data storage
//    int err = 0;                    //error count
    
//    function new(mailbox #(transaction) mbx);
//        this.mbx = mbx;     
//    endfunction;

//    task run();
//        forever begin
//            mbx.get(tr);
//            $display("[SCO] : Wr:%0d rd:%0d din:%0d dout:%0d", tr.wr, tr.rd, tr.data_in, tr.data_out);
            
//            if(tr.wr == 1'b1)begin
//                din.push_front(tr.data_in);
//                $display("[SCO] : DATA STORED IN QUEUE :%0d", tr.data_in);
//        end
//        $display("--------------------------------------"); 
//      end
      
//      if (tr.rd == 1'b1) begin 
//          temp = din.pop_back();
          
//          if (tr.data_out == temp)
//            $display("[SCO] : DATA MATCH");
//          else begin
//            $error("[SCO] : DATA MISMATCH");
//            err++;
//          end        
          
//        $display("--------------------------------------"); 
         
//       -> next;
//    end
//  endtask
  
//endclass

////////////////////////////////////////////////////////////

//class environment;
 
//  generator gen;
//  driver drv;
//  monitor mon;
//  scoreboard sco;
//  mailbox #(transaction) gdmbx;  // Generator + Driver mailbox
//  mailbox #(transaction) msmbx;  // Monitor + Scoreboard mailbox
//  event nextgs;
//  virtual ram_if ram;
  
//  function new(virtual ram_if ram);
//    gdmbx = new();
//    gen = new(gdmbx);
//    drv = new(gdmbx);
//    msmbx = new();
//    mon = new(msmbx);
//    sco = new(msmbx);
//    this.ram = ram;
//    drv.ram = this.ram;
//    mon.ram = this.ram;
//    gen.next = nextgs;
//    sco.next = nextgs;
//  endfunction
  
//  task pre_test();
//    drv.chip_select();
//  endtask
  
//  task test();
//    fork
//      gen.run();
//      drv.run();
//      mon.run();
//      sco.run();
//    join_any
//  endtask
  
//  task post_test();
//    wait(gen.done.triggered);  
//    $display("---------------------------------------------");
//    $display("Error Count :%0d", sco.err);
//    $display("---------------------------------------------");
//    $finish();
//  endtask
  
//  task run();
//    pre_test();
//    test();
//    post_test();
//  endtask
  
//endclass
 
////////////////////////////////////////////////////////////

//module tb_ram;
    
// ram_if vif(); // Create DUT interface
     
//      sv_ram dut(vif); // Instantiate DUT
      
//      initial begin
//        vif.clk <= 0; // Initialize clock signal
//      end
      
//      always #10 vif.clk <= ~vif.clk; // Toggle the clock every 10 time units
      
//      environment env; // Create environment instance
    
//  initial begin
//    env = new(vif);
//    env.gen.count = 10;
//    env.run();
//  end
    
//  initial begin
//    $dumpfile("dump.vcd");
//    $dumpvars;
//  end
   
//endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2024 10:55:29
// Design Name: 
// Module Name: tb_ram
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

class transaction;
    rand bit oper;  // Randomized bit for operation control
    bit [7:0] address;  // Address for RAM
    bit [7:0] data_in;  // Data input
    bit [7:0] data_out;  // Data output
    bit wr,rd,cs;
    constraint oper_ctrl {
        oper dist {1 :/ 50 , 0 :/ 50};  // Constraint to randomize 'oper' with 50% probability of 1 and 50% probability of 0
    }
endclass

//////////////////////////////////////////////////////////

class generator;
    transaction tr;  // Transaction object to generate or create
    mailbox #(transaction) mbx;  // Mailbox for communication
    int count = 0;  // Number of transactions to generate
    int i = 0;  // Iteration counter

    event next;  // Signal to send the next transaction
    event done;  // Signal to convey completion of requested number of transactions

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
        tr = new();
    endfunction
    
    task run();
        repeat (count) begin
            assert (tr.randomize()) else $error("randomization failed");
            i++;
            mbx.put(tr);
            $display("[GEN] : Oper : %0d Address: %0d Data: %0d iteration : %0d", tr.oper, tr.address, tr.data_in, i);
            @(next);
        end
        -> done;
    endtask
endclass

////////////////////////////////////////////////////////////////

class driver;
    virtual ram_if ram;  // Virtual interface to ram
    mailbox #(transaction) mbx;  // Mailbox for communication
    transaction datac;  // Transaction object for communication

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;
    endfunction
    
    // cs to ram
    task chip_select();
        @(posedge ram.clk)
        ram.wr <= 1'b0;
        ram.rd <= 1'b0;
        ram.cs <= 1'b0;
        ram.data_in <= 0;
        repeat (5) @(posedge ram.clk);
        ram.cs <= 1'b1;
        $display("[DRV] : chip select Done");
        $display("------------------------------------------");
    endtask
    
    // write data to ram
    task write(bit [7:0] addr, bit [7:0] data);
        @(posedge ram.clk)
        ram.address <= addr;
        ram.wr <= 1'b1;
        ram.rd <= 1'b0;
        ram.cs <= 1'b1;
        ram.data_in <= data;
        @(posedge ram.clk);
        ram.wr <= 1'b0;
        $display("[DRV] : DATA WRITE Addr: %0d Data: %0d", addr, data);  
        @(posedge ram.clk);
    endtask
  
    // read data from ram
    task read(bit [7:0] addr);
        @(posedge ram.clk)
        ram.address <= addr;
        ram.wr <= 1'b0;
        ram.rd <= 1'b1;
        ram.cs <= 1'b1;
        @(posedge ram.clk);
        ram.rd <= 1'b1;      
        $display("[DRV] : DATA READ Addr: %0d", addr);  
        @(posedge ram.clk);
    endtask
  
    // Apply random stimulus to the DUT
    task run();
        forever begin
            mbx.get(datac);  
            if (datac.oper == 1'b1)
                write(datac.address, datac.data_in);
            else
                read(datac.address);
        end
    endtask
endclass

///////////////////////////////////////////////////////////

class monitor;
    virtual ram_if ram;  // Virtual interface to ram
    mailbox #(transaction) mbx;  // Mailbox for communication
    transaction tr;  // Transaction object for monitoring

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;     
    endfunction;
 
    task run();
        tr = new();
        forever begin
            repeat (4) @(posedge ram.clk);
            tr.wr = ram.wr;
            tr.rd = ram.rd;
            tr.data_in = ram.data_in;
            tr.rd = ram.rd;
            @(posedge ram.clk);
            tr.data_out = ram.data_out;
            mbx.put(tr);
            $display("[MON] : Wr:%0d Rd:%0d Addr:%0d Din:%0d Dout:%0d ", tr.wr, tr.rd, ram.address, tr.data_in, tr.data_out);
        end
    endtask
endclass

/////////////////////////////////////////////////////////

class scoreboard;
    mailbox #(transaction) mbx;  // Mailbox for transaction
    transaction tr;  // Transaction object for monitor
    event next;
    bit [7:0] din[$];  // Array to store written data
    bit [7:0] dout[$];  // Array to store read data
    bit [7:0] temp;  // Temporary data storage
    int err = 0;  // Error count

    function new(mailbox #(transaction) mbx);
        this.mbx = mbx;     
    endfunction;

    task run();
        forever begin
            mbx.get(tr);
            $display("[SCO] : Wr:%0d Rd:%0d Addr:%0d Din:%0d Dout:%0d", tr.wr, tr.rd, tr.address, tr.data_in, tr.data_out);
            if(tr.wr == 1'b1) begin
                din.push_front(tr.data_in);
                $display("[SCO] : DATA STORED IN QUEUE :%0d", tr.data_in);
            end
            if (tr.rd == 1'b1) begin 
                temp = din.pop_back();
                if (tr.data_out == temp)
                    $display("[SCO] : DATA MATCH");
                else begin
                    $error("[SCO] : DATA MISMATCH");
                    err++;
                end        
                $display("--------------------------------------"); 
                -> next;
            end
        end
    endtask
endclass

//////////////////////////////////////////////////////////

class environment;
    generator gen;
    driver drv;
    monitor mon;
    scoreboard sco;
    mailbox #(transaction) gdmbx;  // Generator + Driver mailbox
    mailbox #(transaction) msmbx;  // Monitor + Scoreboard mailbox
    event nextgs;
    virtual ram_if ram;
  
    function new(virtual ram_if ram);
        gdmbx = new();
        gen = new(gdmbx);
        drv = new(gdmbx);
        msmbx = new();
        mon = new(msmbx);
        sco = new(msmbx);
        this.ram = ram;
        drv.ram = this.ram;
        mon.ram = this.ram;
        gen.next = nextgs;
        sco.next = nextgs;
    endfunction
  
    task pre_test();
        drv.chip_select();
    endtask
  
    task test();
        fork
            gen.run();
            drv.run();
            mon.run();
            sco.run();
        join_any
    endtask
  
    task post_test();
        wait(gen.done.triggered);  
        $display("---------------------------------------------");
        $display("Error Count :%0d", sco.err);
        $display("---------------------------------------------");
        $finish();
    endtask
  
    task run();
        pre_test();
        test();
        post_test();
    endtask
endclass
 
//////////////////////////////////////////////////////////

module tb_ram;
    ram_if vif();  // Create DUT interface
    sv_ram dut(vif);  // Instantiate DUT

    initial begin
        vif.clk <= 0;  // Initialize clock signal
    end
      
    always #10 vif.clk <= ~vif.clk;  // Toggle the clock every 10 time units

    environment env;  // Create environment instance
    
    initial begin
        env = new(vif);
        env.gen.count = 10;
        env.run();
    end
    
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule
