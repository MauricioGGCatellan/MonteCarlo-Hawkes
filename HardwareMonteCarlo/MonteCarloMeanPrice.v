module MonteCarloMeanPrice(
	input [8:0] beta11, beta12, beta13, beta14, beta21, beta22, beta23, beta24,
	input [8:0] beta31, beta32, beta33, beta34, beta41, beta42, beta43, beta44,
	input [8:0] alfa11, alfa12, alfa13, alfa14, alfa21, alfa22, alfa23, alfa24,
	input [8:0] alfa31, alfa32, alfa33, alfa34, alfa41, alfa42, alfa43, alfa44,
	input [7:0] mu1, mu2, mu3, mu4,
	input [7:0] qa, qb,
	input [7:0] saL, saM, sbL, sbM,
	input [7:0] N,
	input clk,
	input start,
	output reg [7:0] P,
	output reg done
);

wire s_mng_done;
wire y;

reg [7:0] num_success;
reg [7:0] num_runs;

reg [22:0] seed;

reg s_mng_start;

sim_mng s_mng (.seed(seed), .beta11(beta11), .beta12(beta12), .beta13(beta13), .beta14(beta14), 
								.beta21(beta21), .beta22(beta22), .beta23(beta23), .beta24(beta24),
								.beta31(beta31), .beta32(beta32), .beta33(beta33), .beta34(beta34),
								.beta41(beta41), .beta42(beta42), .beta43(beta43), .beta44(beta44),
								.alfa11(alfa11), .alfa12(alfa12), .alfa13(alfa13), .alfa14(alfa14),
								.alfa21(alfa21), .alfa22(alfa22), .alfa23(alfa23), .alfa24(alfa24),
								.alfa31(alfa31), .alfa32(alfa32), .alfa33(alfa33), .alfa34(alfa34),
								.alfa41(alfa41), .alfa42(alfa42), .alfa43(alfa43), .alfa44(alfa44),
								.mu1(mu1), .mu2(mu2), .mu3(mu3), .mu4(mu4),
								.qa(qa), .qb(qb),
								.saL(saL), .saM(saM), .sbL(sbL), .sbM(sbM),
								.clk(clk), .start(s_mng_start),
								.y(y), .done(s_mng_done));
								
always @(posedge clk)
begin
	if(start)
	begin
		s_mng_start = 1'b1;
		num_success = 0;
		num_runs = 0;
		done = 0;
		P = 0;
		seed = 23'b00000000000000000000001;
	end
	else
	begin
		s_mng_start = 0;
	end
		
	if(s_mng_done)
	begin
		if(y)
		begin
			num_success = num_success + 1'b1;
		end
		
		num_runs = num_runs + 1'b1;
		seed = seed + 1'b1;
		s_mng_start = 1'b1;
	end
	
	if(num_runs == N)
	begin
		done = 1'b1;
		P = (num_success*100)/N;
	end

end

 
endmodule


`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module MonteCarloMeanPrice_tb;

  	reg [8:0] beta11;
	reg [8:0] beta12;
	reg [8:0] beta13;
	reg [8:0] beta14;
	
	reg [8:0] beta21;
	reg [8:0] beta22;
	reg [8:0] beta23;
	reg [8:0] beta24;
	
	reg [8:0] beta31;
	reg [8:0] beta32;
	reg [8:0] beta33;
	reg [8:0] beta34;
	
	reg [8:0] beta41;
	reg [8:0] beta42;
	reg [8:0] beta43;
	reg [8:0] beta44;
	
	reg [8:0] alfa11;
	reg [8:0] alfa12;
	reg [8:0] alfa13;
	reg [8:0] alfa14;

	reg [8:0] alfa21;
	reg [8:0] alfa22;
	reg [8:0] alfa23;
	reg [8:0] alfa24;
	
	reg [8:0] alfa31;
	reg [8:0] alfa32;
	reg [8:0] alfa33;
	reg [8:0] alfa34;
	
	reg [8:0] alfa41;
	reg [8:0] alfa42;
	reg [8:0] alfa43;
	reg [8:0] alfa44;
	
	reg [7:0] mu1;
	reg [7:0] mu2;
	reg [7:0] mu3;
	reg [7:0] mu4;
	
	reg [7:0] qa;
	reg [7:0] qb;
	
	reg [7:0] saL;
	reg [7:0] saM;
	reg [7:0] sbL;
	reg [7:0] sbM;
	
	reg [7:0] N;
	
	wire [7:0] P;
	
   reg clk;
   reg start;
  
  	wire y;
	wire done;
	
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	MonteCarloMeanPrice UUT (.beta11(beta11), .beta12(beta12), .beta13(beta13), .beta14(beta14), 
								.beta21(beta21), .beta22(beta22), .beta23(beta23), .beta24(beta24),
								.beta31(beta31), .beta32(beta32), .beta33(beta13), .beta34(beta34),
								.beta41(beta41), .beta42(beta42), .beta43(beta43), .beta44(beta44),
								.alfa11(alfa11), .alfa12(alfa12), .alfa13(alfa13), .alfa14(alfa14),
								.alfa21(alfa21), .alfa22(alfa22), .alfa23(alfa23), .alfa24(alfa24),
								.alfa31(alfa31), .alfa32(alfa32), .alfa33(alfa33), .alfa34(alfa34),
								.alfa41(alfa41), .alfa42(alfa42), .alfa43(alfa43), .alfa44(alfa44),
								.mu1(mu1), .mu2(mu2), .mu3(mu3), .mu4(mu4),
								.qa(qa), .qb(qb),
								.saL(saL), .saM(saM), .sbL(sbL), .sbM(sbM),
								.N(N),
								.clk(clk), .start(start),
								.P(P), .done(done));
	 
	always #5 clk = ~clk;
    initial begin
      beta11 = 9'b011010100; //0.827 
		beta12 = 9'b010101001; 	//0.661 
		beta13 = 9'b011011001;	// 0.849 
		beta14 =	9'b010011100;		// 0.609 
		
		beta21 = 9'b010110011; //0.700 
		beta22 =	9'b010011010; // 0.6 
		beta23 =	9'b010011010; //0.6 
		beta24 = 9'b010011010; //0.6 
		
		beta31 = 9'b100110011; //1.200 
		beta32 = 9'b100110011; //1.200 
		beta33 = 9'b100101111;	//1.184 
		beta34 = 9'b100110001;	//1.192 
		
		beta41 =	9'b100110011;	//1.2 
		beta42 = 9'b100110011; 	//1.2 
		beta43 = 9'b100111100; 			//1.235 
		beta44 = 9'b101001001;	//1.287 
		
		alfa11 = 8'b00000000; //alfas todos nulos
		alfa12 = 8'b00000000;
		alfa13 = 8'b00000000;		
		alfa14 =	8'b00000000;		
		
		alfa21 = 8'b00000000; 		
		alfa22 =	8'b00000000;		
		alfa23 =	8'b00000000;		
		alfa24 = 8'b00000000;		
		
		alfa31 = 8'b00000000;		
		alfa32 = 8'b00000000;		
		alfa33 = 8'b00000000;		
		alfa34 = 8'b00000000;		
		
		alfa41 =	8'b00000000;		
		alfa42 = 8'b00000000;		
		alfa43 =	8'b00000000;		
		alfa44 = 8'b00000000;	
	
		mu1 = 8'b0110_1101;	//6.83 e-1
		mu2 = 8'b0011_0000;	//3 e-1
		mu3 = 8'b1000_0101;		//8.33 e-1
		mu4 = 8'b0001_1000;		//1.5 e-1
		
		saL = 8'b10011_100; //19.51 e-4				//saL/.../sbM e qa/qb só interagem entre si, não é necessário renormalizar
		saM = 8'b00011_100; //3.51 e-4
		sbL = 8'b11011_110; //27.75 e-4
		sbM = 8'b01100_111; // 12.92 e-4
		
		qa = 8'b10100_000; //20 e-4
		qb = 8'b10001_110; //17.8 e-4
		
		N = 8'b00011111; //31 runs
		
      clk = 0;
      start = 1'b1;
		#6
		start= 0;
      #600
      
      $display("[$display] data=%1b", $itor(P));  
    
    end
    //$stop;   // end of simulation

endmodule
