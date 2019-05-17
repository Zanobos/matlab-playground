%% Step 0

my_ccc;

fid = fopen('AtomicClock.txt');
data = fscanf(fid,'%f');
fclose(fid);

N = length(data);
n = 0:1:N-1;
Nw = 100;
%% Step 1

mu_est = my_sliding_mean(data,Nw);

%% Step 2

plot(n,data,n,mu_est,'k');

%% Step 3

std_est = my_sliding_std(data,Nw);

%% Step 4

figure,plot(n,std_est,'k');

%% Step 5

s1 = mu_est + 2 * std_est;
s2 = mu_est - 2 * std_est;

figure,plot(n,data,n,mu_est,'r',n,s1,'k',n,s2,'k');

%% Step 6 sbarbing signal

shaved = my_sliding_filter(data,mu_est,std_est,3);

figure,plot(n,shaved);

%% Step 7 sbarbing std

Nw2 = 1000;
std_est = my_sliding_std(data,Nw);
K = 1;
mu_of_std = my_sliding_mean(std_est,Nw2);
std_of_std = my_sliding_std(std_est,Nw2);

s1std = mu_of_std + K * std_of_std;
s2std = mu_of_std - K * std_of_std;

figure,plot(n,std_est,n,mu_of_std,'r', n, s1std, 'k', n, s2std, 'k');
figure,plot(n,std_of_std);

shaved_std = my_sliding_filter(std_est,mu_of_std, std_of_std,K);

figure,plot(n,shaved_std);