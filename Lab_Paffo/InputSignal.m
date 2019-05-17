function [signal] = InputSignal(t,B)
%la banda è 1
signal= sinc(2*B*t);
