%Qui fissiamo la banda dell'interpoltore con kappaTeta fissato
function [interpolatedSignal] = Interpolation(kappaTeta, timeVector,t,B,kappaLambda)

interpolatedSignal = zeros(1, length(t));

for i =1:length(timeVector)
    temp = (1/kappaLambda).*(InputSignal(timeVector(i),B))*sinc(kappaTeta*(t-timeVector(i)));
    interpolatedSignal = interpolatedSignal+temp;
end