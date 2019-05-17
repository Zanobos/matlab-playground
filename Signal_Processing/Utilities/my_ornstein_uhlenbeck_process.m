function [ V ] = my_ornstein_uhlenbeck_process( N, Ts, beta )
%MY_ORNSTEIN_UHLENBECK_PROCESS [ V ] = my_ornstein_uhlenbeck_process( N, Ts, beta )
%   Detailed explanation goes here
V = zeros(1,N);
for i = 1 : N - 1
    deltaWn = ((1/(2 * beta))*(1 - (exp(-2*beta*Ts))))^(1/2) * randn(1);
    V(i+1) = V(i) * exp(-beta*Ts) + deltaWn; 
end

end

