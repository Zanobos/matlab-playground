%% Lab 2 Exer 5

%% Step 0

clc;
clear;
close all;
Fontsize = 12;
N = 10000;
n = 0:1:N-1;

%% Step 1
M = 5;
for i = 1:M
    
    F = randn(1,N);
    subplot(M,1,i);
    plot(n,F);
    
end

%% Step 2
sigma=ones(1,N);

%% Step 2.1

mu1 = 10;
mu2 = 40;

mu = linspace(mu1,mu2,N);

X = sigma .* F + mu;
figure,plot(n,X);
my_xlabel('$$n$$',Fontsize);
my_ylabel('$$X[n]$$',Fontsize);
my_legend('$$X[n]$$',Fontsize);

%% Step 2.2

mu = piecewise_costant(mu,4,10);

X = sigma .* F + mu;
figure,plot(n,X);

%% Step 2.3

mu1 = 10;
mu2 = -10;
amp = (mu2 - mu1)/2;

mu = amp * sin(2*pi*n/N*2) + (mu2 + mu1)/2;
X = sigma .* F + mu;

% Parte aggiunta 1
figure,plot(n,X,n,(mu+sigma),'k',n,(mu-sigma),'k',n,mu,'r');
% Parte aggiunta 2
% modificare il rumore in modo che pare che la sigma sia costante
% cambiarlo in base alla derivata del trend
%% Step 3

mu = ones(1,N);

%% Step 3.1

sigma1 = 1;
sigma2 = 100;

sigma = linspace(sigma1,sigma2,N);

X = sigma .* F + mu;
figure,plot(n,X);

%% Step 3.2

sigma = piecewise_costant(sigma,8,10);

X = sigma .* F + mu;
figure,plot(n,X);

%% Step 3.3

sigma1 = 10;
sigma2 = 40;
amp = (sigma1 - sigma2)/2;

sigma = amp * sin(2*pi*n/N) + (sigma2 + sigma1)/2;
X = sigma .* F + mu;
figure,plot(n,X);