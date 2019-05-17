function [ mu ] = my_sliding_std( xx, Nw )
%MY_SLIDING_MEAN Calculate a sliding mean over xx, with intervals Nw
%   [ mu ] = my_sliding_mean( xx, Nw )
N = length(xx);
mu = zeros (1,N);
for n = 0 : N-1
    n1 = n - (Nw/2);
    n2 = n + (Nw/2) -1;
    if n1 < 0
        n1 = 0;
    end
    if n2 > N - 1
        n2 = N - 1;
    end
    xxn = xx(n1+1 : n2+1);
    mu(n+1) = std(xxn);
    
end