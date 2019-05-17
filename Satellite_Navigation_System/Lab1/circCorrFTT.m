function [ output ] = circCorrFTT( input1, input2 )
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
lengthMax = length(longSeq);

transformedShort = conj(fft(shortSeq.',lengthMax));
transformedLong = fft(longSeq.',lengthMax);

output = (ifft(transformedShort.*transformedLong,lengthMax)/lengthMin).';

end

