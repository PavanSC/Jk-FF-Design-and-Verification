interface jk_if(input clk);

 logic rst;
 logic j;
 logic k;
 logic q;
 logic qb;

clocking drv_cb@(posedge clk);
		default input#1 output#1;
		output j;
                output k;
		output rst;
	endclocking

	clocking mon_cb@(posedge clk);
		default input#0;
		
		input rst;
		input j;
                input k;
                input q;
                input qb;

	endclocking

modport DRV_MP   (clocking drv_cb);
	modport MON_MP   (clocking mon_cb);
 endinterface