function [delay,frequency] = printCAF( codeDelays,dopplerFrequencies,correlation )
%PRINTCORRELATION Summary of this function goes here
%   Detailed explanation goes here
    
    dopplerFrequenciesMatrix = repmat(dopplerFrequencies.',size(correlation,2),1).';
    codeDelaysMatrix = repmat(codeDelays,size(correlation,1),1);
    figure;
    mesh(codeDelaysMatrix,dopplerFrequenciesMatrix,correlation);
    title('2D CAF');
    xlabel('Code delay (samples)');
    ylabel('Doppler frequencies (Hz)');
    
    [M,I]=max(correlation(:));
    [x,y]=ind2sub(size(correlation),I);
    
    delay = codeDelays(y)
    frequency = dopplerFrequencies(x)
    
    figure;
    subplot(2,1,1);
    plot(codeDelays,correlation(x,:));
    title('1D CAF');
    xlabel('Code delay (samples)');
    
    subplot(2,1,2);    
    plot(dopplerFrequencies,correlation(:,y));
    title('1D CAF');
    xlabel('Doppler frequencies (Hz)');

end

