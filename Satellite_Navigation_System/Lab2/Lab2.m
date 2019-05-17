%% Clear the board

clc;
clear;
close all;
tic;
%% Read the signal

fid=fopen('signalrx_1.bin','r');
signalIn=fread(fid,'double');
fclose(fid);

%% Test vectors for doppler

% Carrier
signalLength=50e-3; %50ms
integrationTime=1e-3; %1ms - only 1 ms
samplingFrequency = 12e6; %12MHz
carrierFrequency = 4.152e6; %4.152MHz
phaseCarrierIn = 0;
nSamples = integrationTime * samplingFrequency;

amplitude = sqrt(2);
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

prnNumber=21;
goldCodeMatrix = GenerateGoldCodeMatrix();
codeFrequency = 1.023e6; %1.023MHz
codeLength = 1e-3; %1ms
chipFractionIn = 0;
chipIndexIn = 1;
codeIn = goldCodeMatrix(:,prnNumber).'; %obtaining the code

[ codeOut, chipIndexOut, chipFractionOut ] = ...
   SampleCode(samplingFrequency, codeIn, codeFrequency, chipIndexIn, chipFractionIn,nSamples);

%% Create the search space

signalToTest = signalIn(1:nSamples).';
signalToTestMatrix = repmat(signalToTest,size(carriers,1),1);

codeOutMatrix = repmat(codeOut,size(carriers,1),1);

carriersCosModulated = carriersCos.*codeOutMatrix;
carriersSinModulated = carriersSin.*codeOutMatrix;

correlationCos = circCorr(carriersCosModulated,signalToTestMatrix);
correlationSin = circCorr(carriersSinModulated,signalToTestMatrix);

correlationCosNormalized = abs(correlationCos).^2;
correlationSinNormalized = abs(correlationSin).^2;

correlation=correlationSinNormalized + correlationCosNormalized;

%% Plotting

printCAF(1:nSamples,dopplerFrequencies,correlation);
toc;