class drv extends uvm_driver#(trans);
`uvm_component_utils(drv)

virtual jk_if.DRV_MP dif;

function new(string name="drv",uvm_component parent=null);
 super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db#(virtual jk_if)::get(this,"","jk_if",dif))
  `uvm_fatal("DRV CONFIG","Have u set it??")
  `uvm_info("DRV", "This is build_phase", UVM_LOW)

endfunction



task run_phase(uvm_phase phase);
trans req;
forever begin
seq_item_port.get_next_item(req);
drive_to_dut(req);
seq_item_port.item_done();
end
endtask



task drive_to_dut(trans req);
 //dif.rst<=1'b1;
@(dif.drv_cb)
 dif.drv_cb.rst<=req.rst;
 dif.drv_cb.j<=req.j;
 dif.drv_cb.k<=req.k;
endtask


endclass

