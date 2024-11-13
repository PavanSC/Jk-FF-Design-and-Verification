module top;

 import uvm_pkg::*;
 import jk_pkg::*;

bit clk;

initial begin
clk=1'b0;
forever #5 clk=~clk;
end

jk_if intf(clk);

jk DUT(.clk(intf.clk),.rst(intf.rst),.j(intf.j),.k(intf.k),.q(intf.q),.qb(intf.qb));


initial begin
uvm_config_db#(virtual jk_if)::set(null,"*","jk_if",intf);
end

initial begin
 run_test();
end

property no_change;
    @(posedge clk) (intf.j == 0 && intf.k == 0 && intf.rst==0) |=> (intf.q == $past(intf.q));
endproperty

property reset_q;
    @(posedge clk) (intf.j == 0 && intf.k == 1 && intf.rst==0) |=> (intf.q == 0);
endproperty

property set_q;
    @(posedge clk) (intf.j == 1 && intf.k == 0 && intf.rst==0) |=> (intf.q == 1);
endproperty

property toggle_q;
    @(posedge clk) (intf.j == 1 && intf.k == 1 && intf.rst==0) |=> (intf.q == ~($past(intf.q)));
endproperty


//always @(posedge clk) begin
    // Assertion for no-change case: J=0, K=0
    assert property(no_change) begin
      $display("no_change assertion pass");
end
 else begin
   $display("no_change assertion fail");
end

    // Assertion for reset case: J=0, K=1
    assert property(reset_q) begin
      $display("RESST assertion pass");
end
 else begin
   $display("RESET assertion fail");
end


    // Assertion for set case: J=1, K=0
    assert property(set_q) begin
      $display("SET assertion pass");
end
 else begin
   $display("SET assertion fail");
end


//end

endmodule