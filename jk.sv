module jk(clk,rst,j,k,q,qb);
 input j,k,clk,rst;
 output reg q;
 output wire qb;

assign qb =~q;
always@(posedge clk or posedge rst)
begin
 if(rst)
   q<=0;
 else
 begin
 case({j,k})
  2'b00 : q <=q;
  2'b01 : q <=0;
  2'b10 : q <=1;
  2'b11 : q <=~q;
  default : q<=0;
 endcase
end 
end 
endmodule
