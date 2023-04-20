module fibonacci_lfsr_5bit(
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
    data <= 5'h1f;
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
  
	//localparam SF = 2.0**-8.0;
	 
  	//O seguinte módulo gera um número aleatório de 16 bits.
  	fibonacci_lfsr_5bit UUT (.clk(clk), .rst_n(rst_n), .out(out));
	 
	always #5 clk = ~clk;
    initial begin
      clk = 0;
		rst_n = 0;
		
		#5
		
		rst_n = 1;
		
		
      #5
		$display("[$display] data=%d", out);  
      #60
      $display("[$display] data=%d", out);  
    
    end
    //$stop;   // end of simulation

endmodule