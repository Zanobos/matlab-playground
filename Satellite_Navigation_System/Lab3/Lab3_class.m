%% Clear the board

clc;
clear;
close all;

%% Read the signal

fid=fopen('sige_20170120_135332_clean.bin','r');
% fid=fopen('sige_20170120_135427_j.bin','r');
% fid=fopen('sige_20170120_135536_highdinamic.bin','r');
% fid=fopen('sige_20170120_135709_lightindoor.bin','r');

fseek(fid,floor(16.3676e6*10e-3),0); %fseek di 10 ms

signalIn=fread(fid,'int8');
fclose(fid);

%% Test vectors for doppler

% Carrier
signalLength=50e-3; %50ms
integrationTime=1e-3; %1ms - only 1 ms
samplingFrequency = 16.3676e6; %16.3676 MHz
carrierFrequency = 4.1304e6; %4.1304MHz
phaseCarrierIn = 0;
nSamples = floor(integrationTime * samplingFrequency);
amplitude = 1;

deltaDoppler = 2/(integrationTime*3);
minDoppler = -3e3;
maxDoppler = 3e3;
dopplerFrequencies = (minDoppler:deltaDoppler:maxDoppler).';
samplingFrequencies = ones(length(dopplerFrequencies),1)*samplingFrequency;
phaseCarriersIn = ones(length(dopplerFrequencies),1)*phaseCarrierIn;
carriersFrequency = ones(length(dopplerFrequencies),1)*carrierFrequency;

[carriers, phasesOut,carriersCos,carriersSin] = ...
    GenerateCarriers(samplingFrequencies, carriersFrequency+dopplerFrequencies,phaseCarriersIn,nSamples,amplitude);

%% Test the code for delay

prnNumber=1:32;
goldCodeMatrix = GenerateGoldCodeMatrix();
codeFrequency = 1.023e6; %1.023MHz
codeLength = 1e-3; %1ms
chipFractionIn = zeros(length(prnNumber),1);
chipIndexIn = ones(length(prnNumber),1);
codeIn = goldCodeMatrix(:,prnNumber).'; %obtaining the code

[ codeOut, chipIndexOut, chipFractionOut ] = ...
   SampleCode(samplingFrequency, codeIn, codeFrequency, chipIndexIn, chipFractionIn,nSamples);

%% Create the search space for every code

signalToTest = signalIn(1:nSamples).';
signalToTestMatrix = repmat(signalToTest,size(carriers,1),1);

prnNumber=[2 5 7 9 30]; % 2 5 7 9 30

for index = 1 : length(prnNumber)
    codeOutMatrix = repmat(codeOut(prnNumber(index),:),size(carriers,1),1);

    carriersCosModulated = carriersCos.*codeOutMatrix;
    carriersSinModulated = carriersSin.*codeOutMatrix;

    correlationCos = circCorrFTT(carriersCosModulated,signalToTestMatrix);
    correlationSin = circCorrFTT(carriersSinModulated,signalToTestMatrix);

    correlationCosNormalized = abs(correlationCos).^2;
    correlationSinNormalized = abs(correlationSin).^2;

    correlation=correlationSinNormalized + correlationCosNormalized;

    printCAF(1:nSamples,dopplerFrequencies,correlation);
end
