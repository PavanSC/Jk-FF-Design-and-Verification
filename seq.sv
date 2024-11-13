class seq extends uvm_sequence#(trans);

`uvm_object_utils(seq)


 trans s1;

function new(string name="seq");
 super.new(name);
endfunction

virtual task body();
 repeat(50) begin
  s1=trans::type_id::create("s1");
  start_item(s1);
  s1.randomize() with {rst==1'b0;};
  finish_item(s1);
end
endtask

endclass

 
