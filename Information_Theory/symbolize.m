function [ symbols ] = symbolize( x , pi )
%SYMBOLIZE Summary of this function goes here
%   Detailed explanation goes here

%checking if values in pi are valid probabilities
sum = 0;
for i = 1 : length(pi)
    sum = sum + pi(i);
end

if sum ~= 1
    disp('Probabilities not valid');
    symbols=zeros(1,length(x));
    return
end

% creating edges
edges = zeros(1,length(pi)+1);
for i = 1 : length(pi)
    edges(i+1) = edges(i) + pi(i);
end

%creating values
values = ones(1,length(pi));
for i = 1 : length(pi)
    values(i) = i;
end

%creating symbols
symbols = discretize(x,edges, values);

