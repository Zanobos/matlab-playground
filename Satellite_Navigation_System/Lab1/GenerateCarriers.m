function [carrier, phaseOut, carrierCos, carrierSin] = ...
GenerateCarriers( samplingFrequency, carrierFrequency, phaseIn, nSamples, amplitude )
%GENERATECARRIERS Summary of this function goes here
%   Detailed explanation goes here

f0 = carrierFrequency;
fs = samplingFrequency;
phi = phaseIn;
%fixed

%vector of all possible values, I have one more value to use it as phase
%out
n = (0:nSamples); 
%generating the carrier, as real and imaginary part
frequencyMatrix=2*pi*(f0./fs)*n;
phaseMatrix = repmat(phi,1,length(n));
carrierSin = amplitude * sin(frequencyMatrix + phaseMatrix);
carrierCos = amplitude * cos(frequencyMatrix + phaseMatrix);
%summing them together
carrier = carrierCos + 1i*carrierSin;
%I extract the phase
phaseOut = phase(carrier(:,end));
%deleting last element
carrierCos = carrierCos(:,1:end-1);
carrierSin = carrierSin(:,1:end-1);
carrier = carrier(:,1:end-1);

end

