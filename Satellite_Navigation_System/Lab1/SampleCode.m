function [ codeOut, chipIndexOut, chipFractionOut ] = ...
    SampleCode(samplingRate, codeIn, codeRate, chipIndexIn, chipFractionIn,nSamples)
%GENERATESAMPLEDCODE Summary of this function goes here
%   Detailed explanation goes here

numberOfCodes = size(codeIn,1);
%Initial condition
phase=chipFractionIn;
actualChip = chipIndexIn;
numberSamples = floor(nSamples);

samplingTime = 1/samplingRate * ones(numberOfCodes,1);
chipTime = 1/codeRate * ones(numberOfCodes,1);
codeInLength = length(codeIn)*ones(numberOfCodes,1);

codeOut = zeros(numberOfCodes,numberSamples);

for index = 1 : numberSamples
    %sample current chip - I work in this way in order to have the 
    %possibility to use different chipIndexIn
    linearIndexes = sub2ind(size(codeIn), 1:numberOfCodes, actualChip.');
    codeOut(:,index) = codeIn(linearIndexes);
    %At each loop we elaborate a single sample. First thing we do, is to
    %add how much time we need for one sample
    phase = phase + samplingTime;
    %We check if adding this time to the previous time, we go over one
    %single chip time
    phaseOverChipTime = (phase >= chipTime);
    %if we go over one chip time, we "reset" the phase for the amount
    %of a single chip time
    phase = phase - chipTime.*phaseOverChipTime;
    %we go to the next chip, if we finish the codeIn, we start from
    %the first chip
    nextChip = actualChip + ones(numberOfCodes,1).*phaseOverChipTime;
    nextChipStillInCode = nextChip <= codeInLength;  
    actualChip = nextChip.*nextChipStillInCode + ones(numberOfCodes,1).*not(nextChipStillInCode);
end

chipIndexOut = actualChip;
chipFractionOut = phase;
end

