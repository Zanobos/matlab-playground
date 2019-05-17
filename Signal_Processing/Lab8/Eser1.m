%% Step 0

clc;
clear;
close all;

%% Step 1

Pfa = 0.01:0.01:0.97;    
A = [0.1, 0.5, 1, 2, 4];
N = 1;
sigma = 1;

gamma = sqrt(sigma^2/N) * qfuncinv(Pfa);
for i=1:length(A)
    Pd  = qfunc((gamma - A(i))/(sqrt(sigma^2/N)));
    plot(Pfa,Pd);
    hold on;
end

%% Step 2

A = 1;
N = [1, 2, 4, 16];

figure;
for i=1:length(N)
    gamma = sqrt(sigma^2/ N(i)) * qfuncinv(Pfa);
    Pd  = qfunc((gamma - A)/(sqrt(sigma^2/N(i))));
    plot(Pfa,Pd);
    hold on;
end

%% Step 3

N = 2;
M = 1e4;

gamma = sqrt(sigma^2/N) * qfuncinv(Pfa);
Pd  = qfunc((gamma - A)/(sqrt(sigma^2/N)));

x0n = sigma * randn(2,M); % H0
x1n = A + sigma * randn(2,M); %H1

mu0 = mean(x0n);
mu1 = mean(x1n);

Pfaest = ones(1,length(gamma));
Pdest = ones(1,length(gamma));

for i = 1 : length(gamma)
    
    false_alarms = mu0 > gamma(i);
    Nfa = sum(false_alarms);
    Pfaest(i) = Nfa/M;
    
    detections = mu1 > gamma(i);
    Nd = sum(detections);
    Pdest(i) = Nd/M;
end

figure,plot(Pfa,Pd,'-',Pfaest, Pdest, 'o');
 
