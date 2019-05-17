%% Step 0

my_ccc;
N = 1000;
n = 0:1:N-1;

%% Step 1

% my_sliding_mean();

%% Step 2

F = randn(1,N);
window_factor = 10;
Nw = length(F)/window_factor;

% Step 2.1
mu_est = my_sliding_mean(F,Nw);
mu_theo = zeros(1,N);

% Step 2.2
plot(n,F,n,mu_est,'r',n,mu_theo,'k');
my_legend({'$$F[n]$$','$$Estimated$$','$$Theoretical$$'},12);

%% Step 3

% Step 3.0

sigma=ones(1,N);

mu1 = 1;
mu2 = 4;

mu_swipe = linspace(mu1,mu2,N);
X_swipe = sigma .* F + mu_swipe;

mu_piecewise = piecewise_costant(mu_swipe,4,10);
X_piecewise = sigma .* F + mu_piecewise;

mu1 = 2;
mu2 = -2;
amp = (mu2 - mu1)/2;

mu_sin = amp * sin(2*pi*n/N*2) + (mu2 + mu1)/2;
X_sin = sigma .* F + mu_sin;

% Step 3.1

mu_swipe_est = my_sliding_mean(X_swipe,Nw);
mu_piecewise_est = my_sliding_mean(X_piecewise,Nw);
mu_sin_est = my_sliding_mean(X_sin, Nw);

% Step 3.2

figure,plot(n,X_swipe,n,mu_swipe_est,'r',n,mu_swipe,'k');
my_legend({'$$F[n]$$','$$Estimated$$','$$Theoretical$$'},12);
figure,plot(n,X_piecewise,n,mu_piecewise_est,'r',n,mu_piecewise,'k');
my_legend({'$$F[n]$$','$$Estimated$$','$$Theoretical$$'},12);
figure,plot(n,X_sin,n,mu_sin_est,'r',n,mu_sin,'k');
my_legend({'$$F[n]$$','$$Estimated$$','$$Theoretical$$'},12);

% Step 3.3
M = 5;
Nws = [5 10 25 100 200];
for i = 1: M
    mu_piecewise_est = my_sliding_mean(X_piecewise,Nws(i));
    subplot(M,1,i);
    plot(n,X_piecewise,n,mu_piecewise_est,'r',n,mu_piecewise,'k');
    my_legend({'$$F[n]$$','$$Estimated$$','$$Theoretical$$'},12);
end
