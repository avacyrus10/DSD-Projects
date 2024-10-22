module ROM(addr, out,clk);

input  [4:0]addr;
input clk;
output [17:0] out;
reg [17:0] out;
reg [31:0] ROM[17:0];


always @(negedge clk)
begin
ROM[0]=18'b100011001000010100; //3+2i * 1+4i
ROM[1]=18'b010011001100010100; // 3+3i - 1+4i
ROM[2]=18'b000011001100010101; //3+3i  +  1+5i
out=ROM[addr];
end

endmodule