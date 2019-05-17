%% Step 0

clc;
clear;
close all;
N = 100;
n = 0 : 1 : N-1;
Ts=1;
beta = 0.01;

%% Step 1

for i = 1 : 50
    W = my_ornstein_uhlenbeck_process(N,Ts,beta);
    plot(n,W);
    hold on;
end

sigma = sqrt(((1/(2 * beta))*(1 - (exp(-2*beta*n)))));
sigmaMinus = - sigma;
plot(n,sigma,'k', n, sigmaMinus, 'k');

%% Step 2

betas = logspace(-5,1,5);
figure;
for i = 1 : length(betas)
    W = my_ornstein_uhlenbeck_process(N,Ts,betas(i));
    legendInfo{i} = ['$$B = ' num2str(betas(i)) '$$'];
    plot(n,W);
    hold on;
end

W = my_wiener_process(N,Ts);
plot(n,W);
legendInfo{6}= '$$B = 0 Wiener$$';
my_legend(legendInfo,12);
