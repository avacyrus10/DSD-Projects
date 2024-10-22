module run(load,clk,out_r,out_i);
input load,clk;
output reg[3:0] [7:0] out_r,out_i;  //[31:0][7:0]
 reg [3:0][17:0] din;  //[31:0][7:0]




    genvar i;
    generate
        for (i = 0 ; i < 3; i = i+1)   // i<32
            begin:Loop
            ROM rom1(.addr(i) , .out(din[i]), .clk(clk));
            ALU alu1(.data_in(din[i]), .result_r(out_r[i]), .result_i(out_i[i]), .load(load), .clk(clk));
            end
    endgenerate



endmodule
