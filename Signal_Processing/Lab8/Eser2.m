%% Step 0

clc;
clear;
close all;

%% Step 1

Pfa = 0.01:0.01:0.97;    
A = [0.1, 0.5, 1, 2, 4];
N = 1;
sigma = 1;
M = 1e4;

gamma = sqrt(sigma^2/N) * chi2inv(Pfa);
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
 
