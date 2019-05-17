function [vector] = VectorTimeGenerator(minIndex, maxIndex, Nsamples)

a= minIndex;
b =maxIndex;

vector = sort((b-a)*rand(1,Nsamples)+minIndex); %Nsamples = lunghezza riga