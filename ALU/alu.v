module ALU(data_in, result_r,result_i,load,clk);

input [17:0] data_in;
input load,clk;
output reg signed [7:0] result_r,result_i;



 reg [1:0] opcode;
 reg [3:0] a,b,c,d;

 reg signed [7:0] a1,b1,c1,d1,r,i;
 reg flag;


parameter start=0,s0=1, s1=2, s2=3, s0_1=4, s0_2=5, s1_1=6, s1_2=7, s2_1=8, s2_2=9, s2_3=10, s2_4=11, finish=12, error=13;
 reg [3:0]ps=0;

always@(load)
begin

  opcode[1:0] = data_in[17:16];
  a <= data_in[15:12];
  b <= data_in[11:8];
  c <= data_in[7:4];
  d <= data_in[3:0];
end

always@(posedge clk )
  begin

    case(ps)
           s0:
                begin
                a1 = a;
                b1 = b;
                c1 = c;
                d1 = d;
                flag = 0;
                ps = s0_1;
                end
            s0_1:
                 begin
                 r = a1+c1;
                 ps = s0_2;
                 end
            s0_2:
                 begin
                 i = b1+d1;
                 ps = finish;
                 end
            s1:
                begin
                a1 = a;
                b1 = b;
                c1 = c;
                d1 = d;
                flag = 0;
                ps = s1_1;
                end
            s1_1:
                 begin
                 r = a1-c1;
                 if(flag==0) ps = s1_2;
                 else if(flag==1) ps = s2_3;
                 end
            s1_2:
                 begin
                 i = b1-d1;
                 ps = finish;
                 end
            s2:
               begin
               flag = 1;
               ps = s2_1;
               end
            s2_1:
                 begin
                 a1 = a*c;
                 ps = s2_2;
                 end
            s2_2:
                 begin
                 c1 = b*d;
                 ps = s1_1;
                 end
            s2_3:
                 begin
                 b1 = a*d;
                 ps = s2_4;
                 end
            s2_4:
                 begin
                 d1 = b*c;
                 ps = s0_2;
                 end
            start:
                    begin
                    if(opcode == 2'b00) ps = s0;
                    else if(opcode == 2'b01) ps = s1;
                    else if(opcode == 2'b10) ps = s2;
                    else ps = error;
                    end
            error:
                  begin
                  ps = start;
                  end
            finish:
                   begin
                   result_r = r;
                   result_i = i;
                   
                   end
            default:
                    ps <= start;                                                                                     
    endcase
  end
  
endmodule
