
function [media] = Iteration(kappaLambdaValue)

minIndex=-100;
maxIndex=+100;
kappaLambda = kappaLambdaValue; %fattore di intensità del processo di poisson
Nsamples = kappaLambda*(maxIndex-minIndex);

stept= 0.0001;
t= minIndex:stept:maxIndex;
B= 1/2;
kappaTeta = 1; %fattore di sovracampionamento che considera la banda dell'interpolatore
somma = 0;

for i = 1:1000
%Generazione Time Vector

timeVector = VectorTimeGenerator(maxIndex, minIndex, Nsamples);

%Interpolazione

interpolatedSignal = Interpolation(kappaTeta,timeVector,t,B,kappaLambda);



%MSE

MSEvalue = MSE(interpolatedSignal, t, stept,B);
somma = somma + MSEvalue;
%display(i);

end

media = somma / 1000;
%display(somma);

%arrayMSE = MSEPlot(maxIndex,minIndex,t,stept,B,kappaTeta);

