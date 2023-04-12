module expon(
  input [9:0] x0, 			//10 bits: 1 para signed, 1 para > ou < que 1, 8 para decimais
  input wire clk, start,
  output reg [9:0] y, 
  output reg done
);
	
  localparam numberOne = 10'b0100000000;
  
  reg [9:0] D;
  reg [9:0] x;
  reg [1:0] address;
  reg [1:0] next_address;
  reg [9:0] lookupLn;
  reg [9:0] curr_lookup;
  reg [9:0] y_sum;
  reg [18:0] multp_y;
  reg advanceAddr;
  
  always @(posedge clk)
    begin
	 if(start)
		begin
			address = 0;
			x = x0;
			y = numberOne;   //numberOne
		  
			advanceAddr = 0;
			y_sum = 0; 
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
			  2'b00: lookupLn = 10'b0111111111; //Maior positivo
			  2'b01: lookupLn = 10'b0010110001;//10'b1101001111;  //Complemento de 2 de 10'b0010110001 (v0 = -0.6931; //ln(0.5))
			  2'b10: lookupLn = 10'b0001001010;//10'b1110110110;  //Complemento de 2 de 0001001010 (v1 = -0.2877;   //ln(0.75))
			  2'b11: lookupLn = 10'b0000100010;//10'b1111011110;	 //Complemento de 2 de 0000100010 (v2 = -0.1335;   //ln(0.875))
		  endcase	
		
		curr_lookup = lookupLn;
		D = x + lookupLn;
		
		y_sum = y_sum | ((numberOne >> address) & ~numberOne); 
      if(D[9] || D==0)
      begin
      	x = D;
			multp_y = y*y_sum;
      	y = multp_y[17:8]; //15 é 0.5 (parece certo)
      end
		   advanceAddr = 1;
		end
    end
	 
endmodule

`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module expon_tb;

  	reg [9:0] x0;
   reg clk;
   reg start;
  
  	wire signed [9:0] y;
   wire done;
	
	localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo apenas calcula expon para x entre -1.24 e 0.
  	expon UUT (.x0(x0), .clk(clk), .start(start), .y(y), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      //x0 = 10'b1100000000;    //-1 complemento de 2 de 0100000000 (numberOne)
										//Saída esperada: aprox. 10'b 00_01011110,
		x0 = 10'b1110000000;		//-0.5 (complemento de 2)
				
		//x0 = 10'b1011100110;    //-1.1 complemento de 2 de 10'b0100011010
			
		//x0 = 10'b0000000000;    //0
										
      clk = 0;
      start = 1;
		#6
		start= 0;
      #60
      
      $display("[$display] data=%4f", $itor(y*SF));  
    
    end

endmodule
         