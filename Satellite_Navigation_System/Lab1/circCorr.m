function [ output ] = circCorr( input1, input2 )
%CIRCCORR Summary of this function goes here
%   Detailed explanation goes here

if(length(input1) > length(input2))
    longSeq = input1;
    shortSeq = input2;
else
    longSeq = input2;
    shortSeq = input1;
end

lengthMin = length(shortSeq);
buffer = [longSeq longSeq(:,1:lengthMin-1)];
lengthMax = length(buffer);
lengthOutput = lengthMax-lengthMin+1;

output = zeros(size(input1,1),lengthOutput);

% DEBUG
for index = 1 : lengthOutput 
    productMatrix = buffer(:,index:index+lengthMin-1).*shortSeq;
    output(:,index) = sum(productMatrix,2);
end

output = output/lengthMin;

end

