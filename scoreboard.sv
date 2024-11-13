class scoreboard extends uvm_scoreboard;
 `uvm_component_utils(scoreboard)

uvm_tlm_analysis_fifo#(trans) fifo_h;

trans sd,rd,cd;

covergroup fcov1;
 option.per_instance=1;

J: coverpoint cd.j{ 
                    bins j1={1'b0};
                    bins j2={1'b1};}

K: coverpoint cd.k{ 
                    bins k1={1'b0};
                    bins k2={1'b1};}

X: cross J,K;

RST: coverpoint cd.rst{ 
                    bins r1={1'b0};
                    bins r2={1'b1};}

endgroup


function new(string name="scoreboard",uvm_component parent=null);
	super.new(name,parent);
    fifo_h = new("fifo_h", this);
	 `uvm_info(get_type_name, "I am in build phase", UVM_LOW)
	fcov1=new;
endfunction

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);
 forever begin
  fifo_h.get(sd);
  cd=sd;
      `uvm_info("SB",$sformatf("printing from SB \n %s", sd.sprint()),UVM_LOW)
  //sd.print;

  assert($cast(rd,sd.clone()));
  out_ref(rd);
  check_data(sd,rd);
  fcov1.sample();
end
endtask


task out_ref(ref trans rd);

 repeat(rd.rst)
  begin
     if(rd.rst==1)
        rd.q=0;
      else
        if(rd.j==0 && rd.k==0) begin
         rd.q=rd.q;
         rd.qb=rd.qb;
        end
      else if(rd.j==0 && rd.k==1) begin
         rd.q=0;
         rd.qb=~rd.q;
        end
      else if(rd.j==1 && rd.k==0) begin
         rd.q=1;
         rd.qb=~rd.q;
        end
else
        begin
         rd.q=~rd.q;
         rd.qb=~rd.qb;
        end
end
endtask


task check_data(trans sd,trans rd);
  		$display("I am here in check data");   
	if(sd.compare(rd))
	`uvm_info(get_full_name(), "Successfully compared", UVM_LOW);   
endtask
 
 endclass


