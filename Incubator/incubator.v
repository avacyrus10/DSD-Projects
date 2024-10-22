module incubator(sensor,heater,cooler,fan,clk,rst);


input signed [7:0] sensor;
output reg heater,cooler;
output reg [3:0] fan;
input clk,rst;

reg [2:0] ps,ns;
parameter s1=0,s2=1,s3=2,s1_2=3,s2_2=4,s3_2=5,out=6;
initial
begin
ps = s1;
ns = s1;
heater = 0;
cooler = 0;
fan = 0;
end

always@(sensor or ps or rst)
begin
if(rst==1)
begin
ns <= s1;
end
else begin
        case(ps)
                s1: if(sensor<15)
                        begin
                        ns<=s3;
                        end
                    else if(sensor > 35)
						ns<=s2;
                    else ns <= s1;
                s2: if(sensor<25)
                        ns<=s1; 
                     else 
						ns <= out;
                s3: if(sensor>30) ns<=s1;
                    else ns <= s3;
                    
                s1_2: if(sensor>40)
                      begin
						ns<=s2_2;
                      end
                      else if(sensor < 25)
                      begin
							ns <= out;
                      end
                      else ns <= s1_2;
                s2_2: if(sensor > 45)
                        begin
                        ns<=s3_2;
                        
                        end
                        else if(sensor < 35)
                        begin
							ns <= s1_2;
                        end
                        else ns <= s2_2;
                s3_2: if(sensor<40)
                        begin
                        ns<=s2_2;
                        end
                        else ns <= s3_2;
                out: if(sensor>35)
                        begin
                        ns<=s1_2;
                        end
                        else
                            begin
                               ns <= s1;
                            end                                                       
                default: ns<=s1;
                endcase
                end                                     
end


always@(ps)
begin
	case(ps)
					s1:
                    begin
                       heater <=0;
                       cooler <=0;
                       fan <= 0;
                    end
                    s2:
                    begin
                       heater <=0;
                       cooler <=1;
                       fan <= 0;
                    end
                    s3:
                    begin
                       heater <=1;
                       cooler <=0;
                       fan <= 0;
                    end
                    s1_2:
                    begin
						heater <=0;
						cooler <=1;
						fan <= 4;
                    end
                    s2_2:
                    begin
                       heater <=0;
                       cooler <=1;
                       fan <= 6;
                    end
                    s3_2:
                    begin
						heater <=0;
						cooler <=1;
						fan <= 8;
                    end
                    out:
                    begin
                       heater <=0;
                       cooler <=1;
                       fan <= 0;
                    end                                                                                
                    default:
                    begin  
                     heater <=0;
                     cooler <=0;
                     fan <= 0;
                    end
                    endcase
end
always@(posedge clk )
begin
	ps = ns;
end
endmodule               
