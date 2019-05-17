% Clear the board

clc;
clear;
close all;

%% Step 1
% Defining the signals
N = 1000;
n = 0:N-1;

A1 = 1;
N1 = 100;
f1 = 1/N1;
x1 = A1 * cos (2*pi*f1*n);

A2 = 0.5;
N2 = 20;
f2 = 1/N2;
x2 = A2 * cos (2*pi*f2*n);

%Plotting the signals
FontSize = 12;
plot(n,x1,'k',n,x2,'r');
axis([0 N-1 -2 2]);
my_xlabel('$$x1[n]$$',FontSize);
my_legend({'$$x1[n]$$' '$$x2[n]$$'},FontSize);
set(gca,'Fontsize',FontSize);
%% Step 2
% Defining the signal
x = x1 + x2;

% Plotting the signal
figure,plot(n,x,'k');
axis([0 N-1 -2 2]);
my_xlabel('$$n$$',FontSize);
my_ylabel('$$x[n]$$',FontSize);
set(gca,'Fontsize',FontSize);

% %% Step 3
% Computing the spectrum
X = fft(x);
Xsample = X(1 : N/2+1); % I sample the signal
f = 1/N * (0 : N/2); % I obtain a vector with all the frequencies
% 
% % Plotting the spectrum
% figure,plot(f,abs(Xsample));
% axis('tight');
% my_xlabel('$$f$$',FontSize);
% my_ylabel('$$|X(f)|$$',FontSize);
% 
% %% Step 4
% % Saving the plot
% figure(1);
% print('-dpng','x1_x2');
% 
% figure(2);
% print('-dpng','x');
% 
% figure(3);
% print('-dpng','X_magnitude');
% 
% %% Step 5
% % fft shift and plot from f -1/2 to +1/2
% Xs = fftshift(X);
% fs = 1/N * (-N/2 : N/2-1);
% 
% % plotting
% figure,plot(fs,Xs);
% my_xlabel('$$f$$',FontSize);
% my_ylabel('$$|X(f)|$$',FontSize);

% %% Step 6
% % We translate the signal with another sinusoid
% 
% A3 = 1;
% f3 = 0.20-f2;
% x3 = A3 * cos (2*pi*f3*n);
% 
% % We multiplicate x and x3
% x4 = x .* x3;
% 
% % Fourier Transform
% X4 = fft(x4);
% X4sample = X4(1 : N/2+1);
% 
% % Plot
% figure,plot(f,X4sample);
% my_xlabel('$$f$$',FontSize);
% my_ylabel('$$|X(f)|$$',FontSize);

%% Step 7
% sqrt2/10 and sqrt3/10

f1sq = sqrt(2)/10;
x1sq = A1 * cos (2*pi*f1sq*n);

f2sq = sqrt(3)/10
x2sq = A2 * cos (2*pi*f2sq*n);

xsqrt = x1sq + x2sq;

figure,plot(n,xsqrt);

Xsqrt = fft(xsqrt);
XsqrtSample = Xsqrt(1 : N/2+1);

figure,plot(f,abs(XsqrtSample));