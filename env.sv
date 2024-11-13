class env extends uvm_env;
`uvm_component_utils(env)

agt agth;
scoreboard sbh;

function new(string name="env",uvm_component parent=null);
 super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
agth=agt::type_id::create("agth",this);
sbh=scoreboard::type_id::create("sbh",this);
endfunction


function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 agth.monh.M2S.connect(sbh.fifo_h.analysis_export);
endfunction

endclass