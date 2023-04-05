
module MonteCarloMeanPrice(
  input  [7:0] alfa11, alfa12, alfa13, alfa14, 
			alfa21, alfa22, alfa23, alfa24, 
			alfa31, alfa32, alfa33, alfa34, 
			alfa41, alfa42, alfa43, alfa44,
			beta11, beta12, beta13, beta14,
			beta21, beta22, beta23, beta24, 
			beta31, beta32, beta33, beta34, 
			beta41, beta42, beta43, beta44,
			mu1, mu2, mu3, mu4,
			SuB, SdB, SuA, SdA,
			QtB, QtA,
			Num,
	input clk,			
  output [7:0] P
);
  
//Alfa, beta, mu: multiplicados por 10^-1 [4b.4b] 
//S: multiplicado por 10^-4 [5b.3b]
//Q: multiplicado por 10^-3  [5b.3b]

//do stuff
//expon EXPON (.x(x), .y(y));

endmodule