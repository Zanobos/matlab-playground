function [signal] = InputSignal(t,B)
%la banda � 1
signal= sinc(2*B*t);
