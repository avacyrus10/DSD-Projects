module Stack(
 clk,
 rstn,
 pop,
 push,
 empty,
 full,
 din,
 dout
    );

parameter WIDTH = 4;
parameter DEPTH = 8;

input clk,rstn,pop,push;
input [WIDTH-1:0]din;

output [WIDTH-1:0]dout;
output empty,full;


reg [WIDTH-1:0]stack[DEPTH-1:0]; 
reg [WIDTH-1:0]index, next_index; 
reg [WIDTH-1:0]dout, next_dout;

wire empty, full;

always @ (posedge clk) 
begin
  if(!rstn)
  begin
    dout  <= 8'd0;
    index <= 1'b0;
  end
  else
  begin
    dout  <= next_dout;
    index <= next_index;
  end
end

assign empty = (|index);
assign full  = !(|(index ^ DEPTH));
 
always @(*) 
begin
  if(push) 
  begin
  stack[index] <= din;
  next_index   <= index+1'b1;
  end
  else if(pop)  
  begin
  next_dout  <= stack[index-1'b1];
  next_index <= index-1'b1;
  end
  else
  begin
  next_dout  <= dout;
  next_index <= index;
  end
 
end
endmodule