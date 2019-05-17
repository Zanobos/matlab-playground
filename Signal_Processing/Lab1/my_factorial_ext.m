function [ A_fact ] = my_factorial_ext( A )
%MY_FACTORIAL_EXT Calcolate the factorial over a matrix (memberwise)
fcn = @my_factorial;
A_fact = arrayfun(fcn,A);
end

