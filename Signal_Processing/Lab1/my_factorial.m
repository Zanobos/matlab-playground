function [ N_fact ] = my_factorial( N )
%MY_FACTORIAL Calculate with a for the factorial of N
N_fact = 1;
for index = 1:N
    N_fact = N_fact * index;
end

end

