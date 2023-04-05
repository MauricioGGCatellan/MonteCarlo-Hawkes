module ln(
  input [8:0] x0, 
  input wire clk, start,
  output reg [8:0] y, 
  output reg done
);
	
  //Lookuptable
  /*
  localparam v0 = 0.6931; //ln(2)
  localparam v1 = 0.4055;   //ln(1.5)
  localparam v2 = 0.2231;   //ln(1.25)
  localparam v3 = 0.1178; //ln(1.125)
  localparam v4 = 0.0606; //ln(1 + 1/16)
  localparam v5 = 0.0308;  //ln(1 + 1/32)
  localparam v6 = 0.0155; //ln(1 + 1/64)
  localparam v7 = 0.0078; //ln(1 + 1/128)
  */
  
  localparam numberOne = 9'b100000000;
  
  reg [17:0] D;
  reg [8:0] x;
  reg [1:0] address;
  reg [1:0] next_address;
  reg [8:0] lookupLn;
  reg advanceAddr;
  
  always @(posedge clk)
    begin
      if(!done)
      begin
		  done = (~start)&address[1]&address[0];
		  
		  next_address[0] = ~address[0];   //next_address = address + 1
		  next_address[1] = address[1]^address[0];
		  
		  if(!(address[1]&address[0]) && advanceAddr)
		  begin
			address = next_address;
		  end
		  
        D = x*(numberOne + (numberOne >> address));
      if(D <= 17'b10000000000000000)
      begin
      	x = D[16:8];
      	y = y + (~lookupLn + 1'b1);
      end
		
		
		   advanceAddr = 1'b1;
      end
    end
	 
	 
	always @(posedge start)
	begin
		  address = 2'b00;
		  x = x0;
		  y = 0;
		  done = 0;
		  advanceAddr = 0;
	end
  
  //assign done = (~start)&address[1]&address[0];
  
  always @(address)
    begin
      case(address)
        2'b00: lookupLn = 9'b010110001;
        2'b01: lookupLn = 9'b001101000;
        2'b10: lookupLn = 9'b000111001;
        2'b11: lookupLn = 9'b000011110;
      endcase
    end

endmodule


`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module ln_tb;

  	reg [8:0] x0;
   reg clk;
   reg start;
  
  	wire signed [8:0] y;
   wire done;
	
	localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	ln UUT (.x0(x0), .clk(clk), .start(start), .y(y), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      x0 = 9'b011001101;    //0.8
		//x0 = 9'b010100110;  //0.65
      clk = 0;
      start = 1;
		#5
		start= 0;
      #60
      
      $display("[$display] data=%4f", $itor(y*SF));  
    
    end
    //$stop;   // end of simulation

endmodule
         