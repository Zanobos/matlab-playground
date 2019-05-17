%% Clear the board

clc;
clear;
close all;
%% Eser 1 - Create the matrix with the gold codes
goldCodeMatrix = GenerateGoldCodeMatrix();

%% Eser 2 - Generate the local carrier

% Params
signalLength = 20e-3; %20ms
phaseIn = 0.1;

carrierFrequency = 4.092e6; %4.092MHz
samplingFrequency = 16.368e6; %16.368MHz
nSamples = signalLength * samplingFrequency;
amplitude = sqrt(2);

% First values
[carrier, phaseOut,carrierCos,carrierSin] = ...
    GenerateCarriers(samplingFrequency, carrierFrequency,phaseIn,nSamples,amplitude);
figure;
plot(carrierCos);

% Other set of values
% carrierFrequency = 4.1304e6; %4.1304MHz
% samplingFrequency = 16.3676e6; %16.3676MHz
% nSamples = signalLength * samplingFrequency;
% 
% [carrier, phaseOut,carrierCos,carrierSin] = ...
%     GenerateCarriers(samplingFrequency, carrierFrequency,phaseIn,nSamples,amplitude);
% figure;
% plot(carrierCos);
%% Eser 3 - Perform the oversampling of the PRN C/A GPS code

% Params
signalLength = 20e-3; %20ms
samplingFrequency = 16.368e6; %16.368MHz
% samplingFrequency = 16.3676e6; %16.3676MHz
codeFrequency = 1.023e6; %1.023MHz
% The number of samples is given by the total length multiplied for the
% sampling frequency - If I floor this number, I should be able to work,
% but I can have a fractional part much larger
nSamples = signalLength * samplingFrequency;
chipIndexIn = 1; %We start from the start of a period
chipFractionIn = 1e-7; %We are very near the analog start of the signal

% Generation of the codeIn
matrixIndex = randi(size(goldCodeMatrix,2),1); %extract the index
singleCode = goldCodeMatrix(:,matrixIndex).'; %obtaining the code indexed
numberOfLoops = signalLength*1e3; %number of loops
codeIn = zeros(1,size(goldCodeMatrix,1)*numberOfLoops); %pre allocating the vector
for index = 1:numberOfLoops
    %generating the codeIn concatenating the goldCode Extracted
    codeIn(1,(size(goldCodeMatrix,1)*(index-1))+1:(size(goldCodeMatrix,1)*index)) = singleCode;
end

[ codeOut, chipIndexOut, chipFractionOut ] = ...
   SampleCode(samplingFrequency, codeIn, codeFrequency, chipIndexIn, chipFractionIn,nSamples);

%% Eser 4 - Draw the signals

%I obtain the modulated carrier
carrierModulated = carrier .* codeOut;

figure;
pwelch(carrierCos);
figure;
pwelch(codeOut);
figure;
pwelch(carrierModulated);

%% Eser 5a - Autocorrelation

% Initializing
clear;
clc;
goldCodeMatrix = GenerateGoldCodeMatrix();

% Params
samplingFrequency = 16.368e6; %16.368MHz
codeFrequency = 1.023e6; %1.023MHz

signalLength1 = 1e-3; %1ms
signalLength2 = 2e-3; %2ms
nSamples1 = signalLength1 * samplingFrequency;
nSamples2 = signalLength2 * samplingFrequency;
chipIndexIn1 = 1; 
chipIndexIn2 = 800;
chipFractionIn = 1e-7; %We are very near the analog start of the signal
prn1 = 1;
prn2 = 1;

codeIn1 = goldCodeMatrix(:,prn1).'; 
singleCode = goldCodeMatrix(:,prn2).'; 

numberOfLoops2 = signalLength2*1e3; %number of loops
codeIn2 = zeros(1,size(goldCodeMatrix,1)*numberOfLoops2); %pre allocating the vector
for index = 1:numberOfLoops2
    %generating the codeIn concatenating the goldCode Extracted
    codeIn2(1,(size(goldCodeMatrix,1)*(index-1))+1:(size(goldCodeMatrix,1)*index)) = singleCode;
end

[ codeOut1, chipIndexOut1, chipFractionOut1 ] = ...
   SampleCode(samplingFrequency, codeIn1, codeFrequency, chipIndexIn1, chipFractionIn,nSamples1);

[ codeOut2, chipIndexOut2, chipFractionOut2 ] = ...
   SampleCode(samplingFrequency, codeIn2, codeFrequency, chipIndexIn2, chipFractionIn,nSamples2);

% Linear correlation
LCF = linCorr(codeOut1,codeOut2);
x = 0 : 1 : length(LCF) - 1 ;
figure;
plot(x,LCF);

% Circular correlation
CCF = circCorr(codeOut1,codeOut2);
x = 0 : 1 : length(CCF) - 1 ;
figure;
plot(x,CCF);

% Circular correlation with FFT
CCF_FTT = circCorrFTT(codeOut1,codeOut2);
x = 0 : 1 : length(CCF_FTT) - 1 ;
figure;
plot(x,CCF_FTT);


%% Eser 5b - Crosscorrelation

% Initializing
clear;
clc;
goldCodeMatrix = GenerateGoldCodeMatrix();

% Params
signalLength1 = 1e-3; %1ms
signalLength2 = 2e-3; %2ms
samplingFrequency = 16.368e6; %16.3676MHz
codeFrequency = 1.023e6; %1.023MHz
nSamples1 = signalLength1 * samplingFrequency;
nSamples2 = signalLength2 * samplingFrequency;
chipIndexIn1 = 1; 
chipIndexIn2 = 800;
chipFractionIn = 1e-7; %We are very near the analog start of the signal
prn1 = 1;
prn2 = 2;

codeIn1 = goldCodeMatrix(:,prn1).'; 
singleCode = goldCodeMatrix(:,prn2).'; 

numberOfLoops2 = signalLength2*1e3; %number of loops
codeIn2 = zeros(1,size(goldCodeMatrix,1)*numberOfLoops2); %pre allocating the vector
for index = 1:numberOfLoops2
    %generating the codeIn concatenating the goldCode Extracted
    codeIn2(1,(size(goldCodeMatrix,1)*(index-1))+1:(size(goldCodeMatrix,1)*index)) = singleCode;
end

[ codeOut1, chipIndexOut1, chipFractionOut1 ] = ...
   SampleCode(samplingFrequency, codeIn1, codeFrequency, chipIndexIn1, chipFractionIn,nSamples1);

[ codeOut2, chipIndexOut2, chipFractionOut2 ] = ...
   SampleCode(samplingFrequency, codeIn2, codeFrequency, chipIndexIn2, chipFractionIn,nSamples2);

% Linear correlation
LCF = linCorr(codeOut1,codeOut2);
x = 0 : 1 : length(LCF) - 1 ;
figure;
plot(x,LCF);

% Circular correlation
CCF = circCorr(codeOut1,codeOut2);
x = 0 : 1 : length(CCF) - 1 ;
figure;
plot(x,CCF);

% Circular correlation with FFT
CCF_FTT = circCorrFTT(codeOut1,codeOut2);
x = 0 : 1 : length(CCF_FTT) - 1 ;
figure;
plot(x,CCF_FTT);