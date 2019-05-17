%% Step 0

clc;
clear;
close all;

N = 10000;
n = 0:1:N -1;
isStep = 1;
Nfft = N/2;
Nw = 100;
h = ones(1,Nw);
plotFlag = 1;

sig = zeros(1,N);

%% Step 1 C


%% Step 2 I

startTime = 3500;
endTime = 3600;
base = 0.1;
top = 0.3;

len = (endTime-startTime)/2;
n = 0:1:len-1;

% fake delta
beta = 2 * pi * (top - base) / len;
x1 = 3 * cos (2* pi * base * n + beta * n.^2/2);
sig(startTime:startTime+len -1)= x1;

%% Step 3 A

startTime = 4000;
endTime = 5000;
base = 0.1;
top = 0.3;

len = (endTime-startTime)/2;
n = 0:1:len-1;

%first chirp
beta = 2 * pi * (top - base) / len;
x1 = cos (2* pi * base * n + beta * n.^2/2);
sig(startTime:startTime+len -1)= x1;

%second chirp
beta = 2 * pi * (base - top) / len;
x2 = cos (2* pi * top * n + beta * n.^2/2);
sig(startTime + len:endTime-1)= x2;

%sin sig
x3= cos (2*pi*(top-base)*n);
sig(startTime + len/2 : endTime-1 - len/2) = sig(startTime + len/2 : endTime-1 - len/2)+ x3;

Px = my_spectrogram(sig,isStep,Nfft,h,plotFlag);

%% Step 4 O

