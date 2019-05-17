
close all;
clear all;
clc;

%definisci vettore di kappaLambda

arrayKappaLambda = [1,10,100];
arrayMedie = zeros(1,length(arrayKappaLambda));

for i= 1: length(arrayKappaLambda)
    arrayMedie(i)= Iteration(arrayKappaLambda(i));
end

display(arrayMedie);