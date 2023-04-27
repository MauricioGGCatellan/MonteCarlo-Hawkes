module ev_gen(
	input [8:0] lambda,
	input [8:0] next_lambda,
	input [7:0] D1,
	input [7:0] D2,
	input clk,
	input start,
	input [1:0] k,
	output reg [8:0] s,
	output s_done,
	output reg done
);

 wire [9:0] ln_D1;
 wire ln_done;
 
 reg [9:0] s_tmp;
 reg [16:0] to_div_ln_D1;
 
 ln ln1 (.x0({1'b0,1'b0,D1}), .clk(clk), .start(start), .y(ln_D1), .done(ln_done));
 
 assign s_done = ln_done;
 
 always@(ln_D1, lambda, ln_done)
 begin
	if(ln_done)
	begin
		to_div_ln_D1 = (~ln_D1 + 1'b1) << 9;
		s_tmp = to_div_ln_D1/lambda;
		s = s_tmp[8:0];
	end
	else
	begin
		to_div_ln_D1 = 0;
		s_tmp = 0;
		s = 0;
	end
 end

 always@(D2, lambda, next_lambda)
 begin
  if(D2*lambda <= next_lambda)
  begin
	done = 1;
  end
  else
  begin
	done = 0;
	end
 end
endmodule

`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module ev_gen_tb;

  	reg [8:0] lambda;
	reg [8:0] next_lambda;
	reg [7:0] D1;
	reg [7:0] D2;
	reg [1:0] k;
   reg clk;
   reg start;
  
  	wire [8:0] s;
   wire s_done;
	wire done;
	
	localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	ev_gen UUT (.lambda(lambda), .next_lambda(next_lambda), .D1(D1), .D2(D2), .k(k), .clk(clk),
								.start(start), .s(s), .s_done(s_done), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      D1 = 8'b10100110;  //0.657
		D2 = 8'b10000000;
		lambda = 9'b100111010;  // 1.226563 (obtido do tb do sim mnger)
		next_lambda = 9'b000000000;
		k = 2'b11;
		
      clk = 0;
      start = 1;
		#6
		start= 0;
      
		#100
      
      $display("[$display] data=%4f", $itor(s*SF));  
    
    end
    //$stop;   // end of simulation

endmodule


