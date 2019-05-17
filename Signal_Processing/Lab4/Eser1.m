%% Step 0

my_ccc;

N = 1000;
n = 0:1:N-1;

%% Step 1

F = randn(N,1);

% Step 1.1
muf = mean(F);
% Step 1.2
varf = var(F);
% Step 1.3
r1 = xcorr(F,'biased');
r2 = xcorr(F,'unbiased');

l = -(N-1):1:N-1;

% Step 1.4
subplot(2,1,1);
plot(l,r1,'r');
my_xlabel('$$lag$$',12);
my_legend('$$biased$$',12);

subplot(2,1,2);
plot(l,r2,'b');
my_xlabel('$$lag$$',12);
my_legend('$$unbiased$$',12);

%% Step 2

my_ccc;
N = 100000;
lag_factor = 1000;
Ts = 1;
beta = 0.1;
Ntr = 10 / (beta * Ts); % discarded samples
N0 = Ntr + N;

V0 = my_ornstein_uhlenbeck_process(N0,Ts,beta);
V = V0(Ntr:N); % eliminating the transient

% Step 2.1
muv = mean(V);
% Step 2.2
varv = var(V);
% Step 2.3
rv = xcorr(V,N/lag_factor,'unbiased');

l = -(N/lag_factor):1:(N/lag_factor);
rt = 1/(2*beta)*exp(-beta*(abs(Ts*l)));

figure,plot(l,rv,l,rt,'r');
my_legend({'$$Estimated$$','$$Theoretical$$'},12);