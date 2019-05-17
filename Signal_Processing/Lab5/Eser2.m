%% Step 0

my_ccc;

fid = fopen('SpectralEstimation.txt');
data = fscanf(fid,'%f');
fclose(fid);

N = length(data);
n = 0:1:N-1;
Nw = 100;
%% Step 1

figure,plot(n,data);

%% Step 2

X = fft(data);
X = X(1:N/2+1);
basicP = abs(X).^2;
f = 1/N *(0:N/2);
figure, plot(f,basicP);