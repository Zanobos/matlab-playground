function [ P ] = my_spectrogram( x, isStep, Nfft, h, plotFlag)
%MY_SPECTROGRAM [ P ] = my_spectrogram( x, isStep, Nfft, h, plotFlag) )
%   Detailed explanation goes here

% Getting values from inputs
Nw = length(h);
N = length(x);
I = 1:isStep:N;
P = zeros(Nfft/2+1,length(I));
j = 1;

for n = 0: isStep : N-1 % iterating over the signal
    n1 = n - (Nw/2);
    n2 = n + (Nw/2) -1;
    if n1 < 0 % left padding
        xn = [zeros(1, abs(n1)) x(1:n2+1)];
    elseif n2>N-1 % right padding
        xn = [x(n1+1:N) zeros(1,n2-(N-1))];
    else % no padding
        xn = x(n1+1:n2+1);
    end
    % Here xn will be a truncated part of x
    Xn = fft(xn,Nfft); % Fft of xn, considering only Nfft elements
    powerXn = ((abs(Xn)).^2); % Powerspectrum of Xn
    P(:,j) = powerXn(1:Nfft/2+1); % Truncating the powerspectrum and assigning it in column
    j = j +1;
end

if plotFlag
    f = linspace(0,1/2,Nfft/2 +1);
    figure,imagesc(I,f,P),axis xy;
end

end