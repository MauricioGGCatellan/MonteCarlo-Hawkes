module event_generator(
	input [7:0] lambda,
	input [7:0] next_lambda,
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
 
 ln ln1 (.x0({1'b0,1'b0,D1}), .clk(clk), .start(start), .y(ln_D1), .done(ln_done));
 
 assign s_done = ln_done;
 
 always@(ln_D1, lambda, ln_done)
 begin
	if(ln_done)
		s = (~ln_D1[8:0] + 1'b1)/lambda;
	else
		s = 0;
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

module event_generator_tb;

  	reg [7:0] lambda;
	reg [7:0] next_lambda;
	reg [7:0] D1;
	reg [7:0] D2;
   reg clk;
   reg start;
  
  	wire [7:0] s;
   wire s_done;
	wire done;
	
	localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	event_generator UUT (.lambda(lambda), .next_lambda(next_lambda), .D1(D1), .D2(D2), .clk(clk),
								.start(start), .s(s), .s_done(s_done), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      //D1 = 10'b0010100110;  //0.657
		//D2 = 
		//lambda = 
		//next_lambda = 
		//k =
		
      clk = 0;
      start = 1;
		#6
		start= 0;
      #60
      
      $display("[$display] data=%4f", $itor(s*SF));  
    
    end
    //$stop;   // end of simulation

endmodule


