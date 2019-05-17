function [ output ] = linCorr( input1, input2 )
%LINCORR Summary of this function goes here
%   Detailed explanation goes here

if(length(input1) > length(input2))
    longSeq = input1;
    shortSeq = input2;
else
    longSeq = input2;
    shortSeq = input1;
end

lengthMin = length(shortSeq);
buffer = [longSeq zeros(1,lengthMin-1)];
lengthMax = length(buffer);
lengthOutput = lengthMax-lengthMin+1;

output = zeros(1,lengthOutput);

for index = 1 : lengthOutput
    output(index) = sum(buffer(1,index:index+lengthMin-1).*shortSeq);
end

output = output/(lengthMin);
end