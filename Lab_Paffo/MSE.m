function [MSEvalue] = MSE (interpolatedSignal,t, stept,B)

 erroreTotale = 0;
 originalSignal =InputSignal(t,B);
 
 for i= 1:length(originalSignal)
     temp= ((interpolatedSignal(i)-originalSignal(i)).^2)*stept;
     erroreTotale = temp+erroreTotale;
 end

 MSEvalue= erroreTotale;