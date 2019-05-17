function [ xx ] = piecewise_costant( xx , numberOfIntervals, scalingFactor )
%PIECEWISE_COSTANT Assign a random number for fixed interval to vector x
%   xx = piecewise_costant( xx , numberOfIntervals, scalingFactor )
%   xx is the vector that will be segmented and given random values on each
%   interval
%   numberOfIntervals is the number of intervals the vector will be
%   splitted
%   scalingFactor is the value the random number will be multiplied for

samplesPerInterval = floor(length(xx)/numberOfIntervals);
samplesInLastInterval = mod(length(xx),numberOfIntervals);
K = randn(1,numberOfIntervals) * scalingFactor;
index = 1;
for i = 1:length(K)
    for j = 1:samplesPerInterval
        xx(index) = K(i);
        index = index +1;
    end
end
Klast = randn(1) * scalingFactor;
for k = 1 : samplesInLastInterval
    xx(index) = Klast;
    index = index + 1;
end

end

