%% Step 0

clc;
% clear; % I need previous variables
close all;

%% Step 1

xe = zeros(4,N);
P = zeros(4,4);
for n = 2 : N
    [xe(:,n),P] = my_kalman(z(:,n),xe(:,n-1),P,H,R,phi,Q,b);
end

%% Step 2

figure,plot(x(1,:),x(3,:),'r',z(1,:),z(2,:),'g.',xe(1,:),xe(3,:),'--b');
my_legend({'$$model$$','$$measurements$$','$$estimate$$'},12);
my_xlabel('x',12);
my_ylabel('y',12);
axis('tight');