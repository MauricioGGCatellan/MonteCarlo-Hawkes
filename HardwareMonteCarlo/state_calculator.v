module st_calc(
	input [8:0] xin11, xin12, xin13, xin14, xin21, xin22, xin23, xin24, xin31, xin32, xin33, xin34, xin41, xin42, xin43, xin44,
	input [8:0] beta11, beta12, beta13, beta14, beta21, beta22, beta23, beta24,
	input [8:0] beta31, beta32, beta33, beta34, beta41, beta42, beta43, beta44,
	input [8:0] alfa11, alfa12, alfa13, alfa14, alfa21, alfa22, alfa23, alfa24,
	input [8:0] alfa31, alfa32, alfa33, alfa34, alfa41, alfa42, alfa43, alfa44,
	input [7:0] mu1, mu2, mu3, mu4,
	input [7:0] s,
	input [1:0] k,
	input clk, start,
	output reg done,
	output reg [8:0] x11, x12, x13, x14, x21, x22, x23, x24, x31, x32, x33, x34, x41, x42, x43, x44,
	output reg [8:0] lambda
);

wire done11, done12, done13, done14, done21, done22, done23, done24, done31, done32, done33, done34, done41, done42, done43, done44;
wire allDone;
wire [9:0] y11, y12, y13, y14, y21, y22, y23, y24, y31, y32, y33, y34, y41, y42, y43, y44;

wire [9:0] inp1, inp2, inp3, inp4, inp5, inp6, inp7, inp8, inp9, inp10, inp11, inp12, inp13, inp14, inp15, inp16;

	assign inp1 = ~(beta11*s) + 1'b1;
	assign inp2 = ~(beta12*s) + 1'b1;
	assign inp3 = ~(beta13*s) + 1'b1;
	assign inp4 = ~(beta14*s) + 1'b1;
	assign inp5 = ~(beta21*s) + 1'b1;
	assign inp6 = ~(beta22*s) + 1'b1;
	assign inp7 = ~(beta23*s) + 1'b1;
	assign inp8 = ~(beta24*s) + 1'b1;
	assign inp9 = ~(beta31*s) + 1'b1;
	assign inp10 = ~(beta32*s) + 1'b1;
	assign inp11 = ~(beta33*s) + 1'b1;
	assign inp12 = ~(beta34*s) + 1'b1;
	assign inp13 = ~(beta41*s) + 1'b1;
	assign inp14 = ~(beta42*s) + 1'b1;
	assign inp15 = ~(beta43*s) + 1'b1;
	assign inp16 = ~(beta44*s) + 1'b1;

	
	assign allDone = done11 & done12 & done13 & done14 & done21 & done22  & done23 & done24 & 
						  done31 & done32 & done33 & done34 & done41 & done42 & done43 & done44;
						  
 expon expon1 (.x0(inp1), .clk(clk), .start(start), .y(y11), .done(done11));
 expon expon2 (.x0(inp2), .clk(clk), .start(start), .y(y12), .done(done12));
 expon expon3 (.x0(inp3), .clk(clk), .start(start), .y(y13), .done(done13));
 expon expon4 (.x0(inp4), .clk(clk), .start(start), .y(y14), .done(done14));
 expon expon5 (.x0(inp5), .clk(clk), .start(start), .y(y21), .done(done21));
 expon expon6 (.x0(inp6), .clk(clk), .start(start), .y(y22), .done(done22));
 expon expon7 (.x0(inp7), .clk(clk), .start(start), .y(y23), .done(done23));
 expon expon8 (.x0(inp8), .clk(clk), .start(start), .y(y24), .done(done24));
 expon expon9 (.x0(inp9), .clk(clk), .start(start), .y(y31), .done(done31));
 expon expon10 (.x0(inp10), .clk(clk), .start(start), .y(y32), .done(done32));
 expon expon11 (.x0(inp11), .clk(clk), .start(start), .y(y33), .done(done33));
 expon expon12 (.x0(inp12), .clk(clk), .start(start), .y(y34), .done(done34));
 expon expon13 (.x0(inp13), .clk(clk), .start(start), .y(y41), .done(done41));
 expon expon14 (.x0(inp14), .clk(clk), .start(start), .y(y42), .done(done42));
 expon expon15 (.x0(inp15), .clk(clk), .start(start), .y(y43), .done(done43));
 expon expon16 (.x0(inp16), .clk(clk), .start(start), .y(y44), .done(done44));
 
 /*done1 and done2 and done3 and done4 and done5 and done6 and done7 and done8 and done9 and done10 and done11 and done12
	and done13 and done14 and done15 and done16*/
 always @(allDone, k , mu1, mu2, mu3, mu4, y11, y12, y13, y14, y21, y22, y23, y24, 
 alfa11, alfa12, alfa13, alfa14, alfa21, alfa22, alfa23, alfa24,
 alfa31, alfa32, alfa33, alfa34, alfa41, alfa42, alfa43, alfa44,
 y31, y32, y33, y34, y41, y42, y43, y44,
 x11, x12, x13, x14, x21, x22, x23, x24, x31, x32, x33, x34, x41, x42, x43, x44,
 xin11, xin12, xin13, xin14, xin21, xin22, xin23, xin24, xin31, xin32, xin33, xin34, xin41, xin42, xin43, xin44)
 begin
   if(allDone)
	begin
		x11 = xin11*y11[8:0]; //(x11*(y11[8:0]))[16:9];
		x12 = xin12*y12[8:0];
		x13 = xin13*y13[8:0];
		x14 = xin14*y14[8:0];
		x21 = xin21*y21[8:0];
		x22 = xin22*y22[8:0];
		x23 = xin23*y23[8:0];
		x24 = xin24*y24[8:0];
		x31 = xin31*y31[8:0];
		x32 = xin32*y32[8:0];
		x33 = xin33*y33[8:0];
		x34 = xin34*y34[8:0];
		x41 = xin41*y41[8:0];
		x42 = xin42*y42[8:0];
		x43 = xin43*y43[8:0];
		x44 = xin44*y44[8:0];
		
		case(k)
			2'b00: 
			begin
				lambda = mu1 + x11;
				
			end
			2'b01: 
			begin
				lambda = mu1 + x11 + x12 + mu2 + x21 + x22;
			end
			2'b10: 
			begin
				lambda = mu1 + x11 + x12 + x13 + mu2 + x21 + x22 + x23 + mu3 + x31 + x32 + x33;
			end
			2'b11: 
			begin
				lambda = mu1 + x11 + x12 + x13 + x14 + mu2 + x21 + x22 + x23 + x24 +
								mu3 + x31 + x32 + x33 + x34 + mu4 + x41 + x42 + x43 + x44;
								
				x11 = x11 + alfa11;
				x12 = x12 + alfa12;
				x13 = x13 + alfa13;
				x14 = x14 + alfa14;
				x21 = x21 + alfa21;
				x22 = x22 + alfa22;
				x23 = x23 + alfa23;
				x24 = x24 + alfa24;
				x31 = x31 + alfa31;
				x32 = x32 + alfa32;
				x33 = x33 + alfa33;
				x34 = x34 + alfa34;
				x41 = x41 + alfa41;
				x42 = x42 + alfa42;
				x43 = x43 + alfa43;
				x44 = x44 + alfa44;
				
			end
		endcase
		done = 1;
	end
	else
	begin
		lambda = 0;
		
		x11 = xin11;
		x12 = xin12;
		x13 = xin13;
		x14 = xin14;
		
		x21 = xin11;
		x22 = xin12;
		x23 = xin13;
		x24 = xin14;
		
		x31 = xin11;
		x32 = xin12;
		x33 = xin13;
		x34 = xin14;
		
		x41 = xin11;
		x42 = xin12;
		x43 = xin13;
		x44 = xin14;
		
		done = 0;
	end
 end
  
 endmodule
 
 `timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module st_calc_tb;

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
  
  	wire [8:0] lambda;
	wire [8:0] x11, x12, x13, x14, x21, x22, x23, x24, x31, x32, x33, x34, x41, x42, x43, x44;
	wire done;
	
	localparam zero = 9'b000000000;
	localparam SF = 2.0**-8.0;
	
  	//O seguinte módulo apenas calcula ln para x entre 0.5 e 1.
  	st_calc UUT (.beta11(beta11), .beta12(beta12), .beta13(beta13), .beta14(beta14), 
								.beta21(beta21), .beta22(beta22), .beta23(beta23), .beta24(beta24),
								.beta31(beta31), .beta32(beta32), .beta33(beta13), .beta34(beta34),
								.beta41(beta41), .beta42(beta42), .beta43(beta43), .beta44(beta44),
								.alfa11(alfa11), .alfa12(alfa12), .alfa13(alfa13), .alfa14(alfa14),
								.alfa21(alfa21), .alfa22(alfa22), .alfa23(alfa23), .alfa24(alfa24),
								.alfa31(alfa31), .alfa32(alfa32), .alfa33(alfa33), .alfa34(alfa34),
								.alfa41(alfa41), .alfa42(alfa42), .alfa43(alfa43), .alfa44(alfa44),
								.mu1(mu1), .mu2(mu2), .mu3(mu3), .mu4(mu4),
								.xin11(zero), .xin12(zero), .xin13(zero), .xin14(zero),
								.xin21(zero), .xin22(zero), .xin23(zero), .xin24(zero),
								.xin31(zero), .xin32(zero), .xin33(zero), .xin34(zero),
								.xin41(zero), .xin42(zero), .xin43(zero), .xin44(zero),
								.s(zero), .k(2'b11),
								.clk(clk), .start(start), .done(done),
								.lambda(lambda), 
								.x11(x11), .x12(x12), .x13(x13), .x14(x14), 
								.x21(x21), .x22(x22), .x23(x23), .x24(x24),
								.x31(x31), .x32(x32), .x33(x33), .x34(x34),
								.x41(x41), .x42(x42), .x43(x43), .x44(x44)
								);
	 
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
      #100
      
      $display("[$display] data=%4f", $itor(lambda*SF));  
    
    end
    //$stop;   // end of simulation

endmodule