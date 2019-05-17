% Clear the board

clc;
clear;
close all;

% Computation
A = [1 2 3
     4 5 6];
fact = factorial(A);
my_fact = my_factorial_ext(A);

% Display
disp('Matlab factorial of A:');
disp(A);
disp(fact);
disp('My factorial of A');
disp(A);
disp(my_fact);