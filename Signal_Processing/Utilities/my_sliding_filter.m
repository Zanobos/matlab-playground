function [ shaved ] = my_sliding_filter( xx, mu_est, std_est, k )
%MY_SLIDING_FILTER Summary of this function goes here
%   Detailed explanation goes here

highFilter  = mu_est + k * std_est;
lowFilter = mu_est - k * std_est;

shaved = zeros(1,length(xx));
for i = 1:length(xx)
    tmp = xx(i);
    high = highFilter(i);
    low = lowFilter(i);
    if(tmp > high || tmp < low)
        tmp = mu_est(i);
    end
    shaved(i)=tmp;
end

end

