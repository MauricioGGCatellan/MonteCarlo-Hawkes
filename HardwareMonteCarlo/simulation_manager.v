

//Gerencia a execução de uma única simulação
module sim_mng(
	input [8:0] beta11, beta12, beta13, beta14, beta21, beta22, beta23, beta24,
	input [8:0] beta31, beta32, beta33, beta34, beta41, beta42, beta43, beta44,
	input [8:0] alfa11, alfa12, alfa13, alfa14, alfa21, alfa22, alfa23, alfa24,
	input [8:0] alfa31, alfa32, alfa33, alfa34, alfa41, alfa42, alfa43, alfa44,
	input [7:0] mu1, mu2, mu3, mu4,
	input [7:0] qa, qb,
	input [7:0] saL, saM, sbL, sbM,
	input clk,
	input start,
	output reg y,
	output reg done
);

wire [7:0] D1;
wire [7:0] D2;

reg rst_rand;

reg start_st_calc;
wire done_st_calc;

reg start_ev_gen;
wire done_ev_gen;
wire s_done_ev_gen;

wire [7:0] lambda;
reg [7:0] prev_lambda;
reg [7:0] next_lambda;

reg [1:0] k;
reg [8:0] s;
wire [8:0] w;
reg [8:0] t;

reg [9:0] Qa;
reg [9:0] Qb;

reg [2:0] state;

reg [8:0] xin11, xin12, xin13, xin14, xin21, xin22, xin23, xin24, xin31, xin32, xin33, xin34, xin41, xin42, xin43, xin44;
wire [8:0] x11, x12, x13, x14, x21, x22, x23, x24, x31, x32, x33, x34, x41, x42, x43, x44;

fibonacci_lfsr_5bit rand1 (.clk(clk), .rst_n(rst_rand), .out(D1));

fibonacci_lfsr_5bit rand2 (.clk(clk), .rst_n(rst_rand), .out(D2));

state_calculator st_calc (.xin11(xin11), .xin12(xin12), .xin13(xin13), .xin14(xin14), .xin21(xin21), .xin22(xin22), .xin23(xin23), .xin24(xin24), 
									.xin31(xin31), .xin32(xin32), .xin33(xin33), .xin34(xin34), .xin41(xin41), .xin42(xin42), .xin43(xin43), .xin44(xin44),
									.x11(x11), .x12(x12), .x13(x13), .x14(x14), .x21(x21), .x22(x22), .x23(x23), .x24(x24), 
									.x31(x31), .x32(x32), .x33(x33), .x34(x34), .x41(x41), .x42(x42), .x43(x43), .x44(x44),
									.alfa11(alfa11), .alfa12(alfa12), .alfa13(alfa13), .alfa14(alfa14),
									.alfa21(alfa21), .alfa22(alfa22), .alfa23(alfa23), .alfa24(alfa24),
									.alfa31(alfa31), .alfa32(alfa32), .alfa33(alfa33), .alfa34(alfa34),
									.alfa41(alfa41), .alfa42(alfa42), .alfa43(alfa43), .alfa44(alfa44),
									.beta11(beta11), .beta12(beta12), .beta13(beta13), .beta14(beta14), 
									.beta21(beta21), .beta22(beta22), .beta23(beta23), .beta24(beta24),
									.beta31(beta31), .beta32(beta32), .beta33(beta33), .beta34(beta34),
									.beta41(beta41), .beta42(beta42), .beta43(beta43), .beta44(beta44),
									.mu1(mu1), .mu2(mu2), .mu3(mu3), .mu4(mu4), .clk(clk),
									.s(s), .k(k), .start(start_st_calc), 
									.lambda(lambda), .done(done_st_calc)
									);

event_generator ev_gen (.lambda(prev_lambda), .next_lambda(next_lambda), .start(start_ev_gen),
								.D1(D1), .D2(D2), .clk(clk), .k(k), .s(w), .s_done(s_done_ev_gen), .done(done_ev_gen));									

/*
task reload_x;
	input [8:0] xin11, xin12, xin13, xin14, xin21, xin22, xin23, xin24, xin31, xin32, xin33, xin34, xin41, xin42, xin43, xin44;
	output [8:0] x11, x12, x13, x14, x21, x22, x23, x24, x31, x32, x33, x34, x41, x42, x43, x44;
	begin
		x11 = xin11;
		x12 = xin12;
		x13 = xin13;
		x14 = xin14;
		x21 = xin21;
		x22 = xin22;
		x23 = xin23;
		x24 = xin24;
		x31 = xin31;
		x32 = xin32;
		x33 = xin33;
		x34 = xin34;
		x41 = xin41;
		x42 = xin42;
		x43 = xin43;
		x44 = xin44;
	end
endtask*/

/*
reload_x(xin11, xin12, xin13, xin14, xin21, xin22, xin23, xin24, 
			xin31, xin32, xin33, xin34, xin41, xin42, xin43, xin44,
			x11, x12, x13, x14, x21, x22, x23, x24,
			x31, x32, x33, x34, x41, x42, x43, x44);
*/
								
always @(posedge clk)
begin

if(start)
begin
	rst_rand = 0;	
	k = 2'b11;
	t = 0;
	s = 0;
	Qa = qa;
	Qb = qb;
	start_ev_gen = 0;
	start_st_calc = 1;
	state = 2'b00;
	done = 0;
	
	
	xin11 = 0;
	xin12 = 0;
	xin13 = 0;
	xin14 = 0;
	xin21 = 0;
	xin22 = 0;
	xin23 = 0;
	xin24 = 0;
	xin31 = 0;
	xin32 = 0;
	xin33 = 0;
	xin34 = 0;
	xin41 = 0;
	xin42 = 0;
	xin43 = 0;
	xin44 = 0;
end

case(state)
3'b000:
begin
	start_st_calc = 0;
	if(done_st_calc)
	begin
		prev_lambda = lambda;
		
		xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
		
		start_st_calc = 1;
		state = 3'b001;
	end
end
3'b001:
begin
	start_st_calc = 0;
	if(done_st_calc)
	begin
		next_lambda = lambda;
		start_ev_gen = 1;
		state = 3'b010;
	end
end
3'b010:
begin
	if(s_done_ev_gen)
	begin
		s = s + w;
		if(done)
		begin
		 k = 2'b00;
		 
		 xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
			
		 start_st_calc = 1;
		 state = 3'b011;
		end
		else
		begin
		 k = 2'b11; 
		 
		 xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
			
	    start_st_calc = 1;
		 state = 3'b000;
		end
	end
end
3'b011:
begin
	start_st_calc = 0;
	if(done_st_calc)
	begin
		next_lambda = lambda;
		start_ev_gen = 1;
		state = 3'b100;
	end
end
3'b100: 
begin
	start_ev_gen = 0;
	if(done_ev_gen)	//Eventos totalmente gerados (s e k)
	begin
		case(k)
			2'b00: Qb = Qb - sbM;
			2'b01: Qb = Qb + sbL;
			2'b10: Qa = Qa - saM;
			2'b11: Qa = Qa + saL;
		endcase
		t = t + s;
		
		xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
			
		start_st_calc = 1;
		state = 3'b101;
	end
	else
	begin
		k = k + 1'b1;
		
		xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
			
		start_st_calc = 1;
		state = 3'b011;
	end
end
3'b101:							
begin
	start_st_calc = 0;
	if(Qa > 0 && Qb > 0)
	begin
		s = 0;
		k = 2'b11;	
		
		xin11 = x11;
		xin12 = x12;
		xin13 = x13;
		xin14 = x14;
		xin21 = x21;
		xin22 = x22;
		xin23 = x23;
		xin24 = x24;
		xin31 = x31;
		xin32 = x32;
		xin33 = x33;
		xin34 = x34;
		xin41 = x41;
		xin42 = x42;
		xin43 = x43;
		xin44 = x44;
			
		start_st_calc = 1;
		state = 3'b000;
	end
	else
	begin
		done = 1;
		if(Qa <= 0)
		begin
			y = 1;
		end
		else
		begin
			y = 0;
		end
	end
end

endcase
 end
 
endmodule


`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module sim_mng_tb;

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
	
   reg clk;
   reg start;
  
  	wire y;
	wire done;
	
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	sim_mng UUT (.beta11(beta11), .beta12(beta12), .beta13(beta13), .beta14(beta14), 
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
								.clk(clk), .start(start),
								.y(y), .done(done));
	 
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
		
      clk = 0;
      start = 1'b1;
		#6
		start= 0;
      #600
      
      $display("[$display] data=%1b", $itor(y));  
    
    end
    //$stop;   // end of simulation

endmodule
