%% Step 0

clc;
clear;
close all;
N = 1000;
n = 0 : 1 : N-1;
Ts=1;

%% Step 1

for i = 1 : 5
    W = my_wiener_process(N,Ts);
    plot(n,W);
    hold on;
end

%% Step 2

num = 10000;
N= 700;
T0 = zeros(1,num);
T1 = zeros(1,num);
% I generate a large number of realizations
for i = 1 : num
    W = my_wiener_process(N,Ts);
    % Saving always same time instant
    T0(i)=W(50);
    T1(i)=W(500);
end

bins1=min(T0):1:max(T0);
[N1,x1] = hist(T0,bins1);
figure,plot(x1,N1);
hold on;

bins2=min(T1):1:max(T1);
[N2,x2] = hist(T1,bins2);
plot(x2,N2);

my_legend({'$$T0$$','$$T1$$'},12);
%% Step 3

% Normalizing the samples
toNorm1 = sum(N1);
N1norm = N1 / toNorm1;
figure,plot(x1,N1norm);
hold on;
pdf1 = normpdf(x1,0,sqrt(50));
plot(x1,pdf1);

toNorm2 = sum(N2);
N2norm = N2 / toNorm2;
figure,plot(x2,N2norm);
hold on;
pdf2 = normpdf(x2,0,sqrt(500));
plot(x2,pdf2);