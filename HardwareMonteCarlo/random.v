
module fibonacci_lfsr_5bit(
  input [22:0] seed,
  input clk,
  input rst_n,
	
  output reg [7:0] out
);

  wire [7:0] data_next;
  reg [22:0] data;
  reg [22:0] lsdata;
  
 assign data_next[7] = data[22]^data[1];
 assign data_next[6] = data[21]^data[0];
 assign data_next[5] = data[20]^data_next[7];
 assign data_next[4] = data[19]^data_next[6];
 assign data_next[3] = data[18]^data_next[5];
 assign data_next[2] = data[17]^data_next[4];
 assign data_next[1] = data[16]^data_next[3];
 assign data_next[0] = data[15]^data_next[2];

 
always @(posedge clk or negedge rst_n)
  if(!rst_n)
  begin	 
  
	 data <= seed;
  	 out <= 8'hff;
  end
  else
  begin
    out <= data_next;
	 begin
		 lsdata = data << 1;
		 data = {lsdata[22:1], data_next[7]};
	 end
  end
endmodule

module fibonacci_lfsr_5bit_tb;

  	wire [7:0] out;
   reg clk;
   reg rst_n;
	reg [22:0] seed;
  
	//localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo gera um número aleatório de 16 bits.
  	fibonacci_lfsr_5bit UUT (.seed(seed), .clk(clk), .rst_n(rst_n), .out(out));
	 
	always #5 clk = ~clk;
    initial begin
      clk = 0;
		rst_n = 0;
		seed = 23'b00000000000000000000001;
		
		#5
		
		rst_n = 1;
		
		
      #5
		$display("[$display] data=%d", out);  
      #60
      $display("[$display] data=%d", out);  
    
    end
    //$stop;   // end of simulation

endmodule

/*
module fibonacci_lfsr_5bit(
  input [4:0] seed,
  input clk,
  input rst_n,
	
  output reg [7:0] out
);

  wire [7:0] data_next;
  reg [4:0] data;
  reg [4:0] lsdata;
  
 assign data_next[7] = data[4]^data[1];
 assign data_next[6] = data[3]^data[0];
 assign data_next[5] = data[2]^data_next[7];
 assign data_next[4] = data[1]^data_next[6];
 assign data_next[3] = data[0]^data_next[5];
 assign data_next[2] = data_next[7]^data_next[4];
 assign data_next[1] = data_next[6]^data_next[3];
 assign data_next[0] = data_next[5]^data_next[2];

always @(posedge clk or negedge rst_n)
  if(!rst_n)
  begin	 
  
	 data <= seed;
  	 out <= 8'hff;
  end
  else
  begin
    out <= data_next;
	 begin
		 lsdata = data << 1;
		 data = {lsdata[4:1], data_next[7]};
	 end
  end
endmodule

`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module fibonacci_lfsr_5bit_tb;

  	wire [7:0] out;
   reg clk;
   reg rst_n;
	reg [4:0] seed;
  
	//localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo gera um número aleatório de 16 bits.
  	fibonacci_lfsr_5bit UUT (.seed(seed), .clk(clk), .rst_n(rst_n), .out(out));
	 
	always #5 clk = ~clk;
    initial begin
      clk = 0;
		rst_n = 0;
		seed = 5'b00000;
		
		#5
		
		rst_n = 1;
		
		
      #5
		$display("[$display] data=%d", out);  
      #60
      $display("[$display] data=%d", out);  
    
    end
    //$stop;   // end of simulation

endmodule
*/