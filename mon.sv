class mon extends uvm_monitor;
`uvm_component_utils(mon)

trans ds;
uvm_analysis_port#(trans) M2S;
virtual jk_if.MON_MP mif;

function new(string name="mon",uvm_component parent=null);
 super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 if(!uvm_config_db#(virtual jk_if)::get(this,"","jk_if",mif))
  `uvm_fatal("MON CONFIG","Have u set it??")
  `uvm_info("MON", "This is build_phase", UVM_LOW)

   M2S=new("M2S",this);
   ds= trans::type_id::create("ds",this);

endfunction


task run_phase(uvm_phase phase);
     forever
       collect_data();     
endtask


task collect_data();
   // seq_item data_sent;
	
	
	@(mif.mon_cb);
        ds.rst = mif.mon_cb.rst;
        ds.j=mif.mon_cb.j;
        ds.k=mif.mon_cb.k;
        ds.q=mif.mon_cb.q;
        ds.qb=mif.mon_cb.qb;   
    `uvm_info("MONITOR",$sformatf("printing from monitor \n %s", ds.sprint()),UVM_LOW) 
	M2S.write(ds);
endtask

endclass
