function X=DFT(x,n)
K = 50; 
k = 0:K; 
 X = x * (exp(-j*pi/K)) .^ (n'*k);
 