%% Step 0

clc;
clear;
close all;

N = 100;

%% Step 1

phi = [ 1   0.6321  0   0;
        0   0.3679  0   0;
        0   0       1   0.6321;
        0   0       0   0.3679 ];
    
b = [ 0.3679;
      0.6321;
      0.3679;
      0.6321 ];
  
Q = [ 0.0168 0.0200 0       0;
      0.0200 0.0432 0       0;
      0      0      0.0168  0.0200;
      0      0      0.0200  0.0432 ] ;


x = zeros(4,N);
mu = zeros(4,1);

for n = 2 : N
    eta = mvnrnd(mu,Q);
    x(:,n) = phi * x(:,n-1) + eta' + b;
end

%% Step 2

r = 10;

H = [ 1   0   0   0;
      0   0   1   0 ];
 
R = r * [ 1  0;
          0  1 ];
      
mu = zeros(2,1);
z = zeros(2,N);

for n = 1 : N
    v = mvnrnd(mu,R);
    z(:,n) = H * x(:,n) + v'; % I assign to the n-th column x and y
end

%% Step 3

figure,plot(x(1,:),x(3,:),'r',z(1,:),z(2,:),'b.');
my_legend({'$$system model$$','$$measurements$$'},12);
my_xlabel('x',12);
my_ylabel('y',12);
axis('tight');