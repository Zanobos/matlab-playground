clc;
clear;
close all;

Nsymb = 1000;
pi = [0.01 0.02 0.03 0.04 0.05 0.05 0.3 0.5];
x=rand(1,Nsymb);

%creating the vector of symbols
symbols = symbolize(x,pi);

%% Encoding - Huffman

%huffman encoding (by Matlab)
dict = huffmandict([1:8],pi);
y2 = huffmanenco(symbols,dict);

% Questions
%number of bits
bits2 = length(y2);
%number of occurences of one
occur2 = histc(y2,[1]);
%estimated entropy
% H(x) = 0*pi0*log2(1/pi0) + 1*pi1*log2(1/pi1)
H2 = occur2/bits2 * log2(1/(occur2/bits2));
%mean quantity of information(entropy) of original signal
syms k
f = k*log2(1/k);
V = subs(f,k,pi(1:8));
H2sym = double(sum(V));

%% Decoding

%huffman encoding (by Matlab)
decodedSignal = huffmandeco(y2,dict);

% Checking
assert(isequal(symbols,decodedSignal));