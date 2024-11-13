class trans extends uvm_sequence_item;
 `uvm_object_utils(trans)

rand logic rst;
rand logic j;
rand logic k;
logic q;
logic qb;

function new(string name="trans");
 super.new(name);
endfunction


function void do_print(uvm_printer printer);
super.do_print(printer);
 printer.print_field("J",this.j,1,UVM_DEC);
 printer.print_field("K",this.k,1,UVM_DEC);
 printer.print_field("RST",this.rst,1,UVM_BIN);
 printer.print_field("Q",this.q,1,UVM_DEC);
 printer.print_field("Qb",this.qb,1,UVM_BIN);
 //printer.print_field("RST",this.rst,1,UVM_BIN);
endfunction


endclass