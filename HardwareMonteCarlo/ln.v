module ln(
  input [9:0] x0, 
  input wire clk, start,
  output reg [9:0] y, 
  output reg done
);
	  
  localparam numberOne = 9'b100000000;
  
  reg [18:0] D;
  reg [9:0] x;
  reg [1:0] address;
  reg [1:0] next_address;
  reg [9:0] lookupLn;
  reg advanceAddr;
  
  always @(posedge clk)
    begin
		if(start)
		begin
		  address = 2'b00;
		  x = x0;
		  y = 0;
		  done = 0;
		  advanceAddr = 0;
		end
		
		done = (~start)&address[1]&address[0];
		
      if(!done)
      begin
		  
		  next_address[0] = ~address[0];   //next_address = address + 1
		  next_address[1] = address[1]^address[0];
		  
		  if(!(address[1]&address[0]) && advanceAddr)
		  begin
			address = next_address;
		  end
		  
		  case(address)
			  2'b00: lookupLn = 10'b0010110001;
			  2'b01: lookupLn = 10'b0001101000;
			  2'b10: lookupLn = 10'b0000111001;
			  2'b11: lookupLn = 10'b0000011110;
		  endcase
		  
        D = x*(numberOne + (numberOne >> address));
      if(D <= 19'b0010000000000000000)
      begin
      	x = D[17:8];
      	y = y + (~lookupLn + 1'b1);
      end
		
		   advanceAddr = 1'b1;
      end
    end
	
endmodule


`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module ln_tb;

  	reg [9:0] x0;
   reg clk;
   reg start;
  
  	wire signed [9:0] y;
   wire done;
	
	localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	ln UUT (.x0(x0), .clk(clk), .start(start), .y(y), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      //x0 = 10'b0011001101;    //0.8
		x0 = 10'b0010100110;  //0.65
      clk = 0;
      start = 1;
		#6
		start= 0;
      #60
      
      $display("[$display] data=%4f", $itor(y*SF));  
    
    end
    //$stop;   // end of simulation

endmodule
         