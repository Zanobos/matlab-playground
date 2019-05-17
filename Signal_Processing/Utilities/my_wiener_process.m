function [ W ] = my_wiener_process(N, Ts)
%MY_WIENER_PROCESS [ W ] = my_wiener_process(N, Ts)
%   N = length of vector
%   Ts = variance
W = zeros(1,N);
% mu = 0;
% sigma = Ts^(1/2);
for i = 1 : N - 1
    deltaWn = Ts^2 * randn(1);
%    deltaWn = normrnd(mu,sigma);
    W(i+1) = W(i) + deltaWn; 
end

end
