%% Step 0

clc;
clear;
close all;

N = 1000;
n=0:1:N -1;
isStep = 1;
Nfft = N/2;
Nw = 50;
h = ones(1,Nw);
plotFlag = 0;

%% Step 1 Simple sinusoid

f0 = 0.15;
x = cos(2 * pi * f0 * n);

Px = my_spectrogram(x,isStep,Nfft,h,plotFlag);

%% Step 2 Four sinusoids

f1 = 0.1; f2 = 0.2; f3 = 0.3; f4 = 0.4;

x1 =  cos(2 * pi * f1 * n/4);
x2 =  cos(2 * pi * f2 * n/4);
x3 =  cos(2 * pi * f3 * n/4);
x4 =  cos(2 * pi * f4 * n/4);

x = [x1 x2 x3 x4];

Px = my_spectrogram(x,isStep,Nfft,h,plotFlag);

%% Step 3 Linear Chirp

N = 10000;
n= 0 : 1: N -1;
f1 = 0.1; % start freq
f2= 0.3;  % end freq

f0 = f1;
beta = 2 * pi * (f2 - f1) / N;

x = cos (2* pi * f0 * n + beta * n.^2/2);

Px = my_spectrogram(x,isStep,Nfft,h,plotFlag);

%% Step 4 Loaded signal

x = transp(load('TF_Signal.txt'));
Px = my_spectrogram(x,isStep,Nfft,h,1);