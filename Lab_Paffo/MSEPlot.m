%in qesto caso va fatto variare kappaLambda cioè il numero di campioni che
%consideriamo

function [arrayMSE] = MSEPlot(maxIndex,minIndex,t,stept,B,kappaTeta)

kappaLambda= 1:1:100;
arrayMSE = zeros(1,length(kappaLambda));

for i = 1:length(kappaLambda)
    Nsamples = kappaLambda(i)*(maxIndex-minIndex);
    timeVector=VectorTimeGenerator(minIndex,maxIndex,Nsamples);
    interpolatedSignal = Interpolation(kappaTeta,timeVector,t,B,kappaLambda(i));
    arrayMSE(i) = MSE(interpolatedSignal,t,stept,B);
end

figure;
plot(kappaLambda,arrayMSE);
title('MSE VS KappaLambda lin'); %plottiamo in relazione al numero dei campioni

figure;
semilogy(kappaLambda,arrayMSE);
title('MSE Vs KappaLambda log');