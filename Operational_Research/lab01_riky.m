%% Bin packing problem

n_bins = 8;
n_items = 8;
%% Inputs
BinSize = [20,20,20,20,20,20,20,20]; % size of each bin
ItemSize = [4,5,6,6,8,9,10,11]; % size of each item

%% Variables
n_variables = n_items*n_bins+n_bins;
                 % 64 variables are taken by x_ij (the flag that tells me
                 % whether a variable is inside the bin or  not), then 8 
                 % variables are the y_j (i.e. the flag that tells me 
                 % whether the bin was used or not)
                 
%% Lower bounds
lb = zeros(n_variables,1);

%% Upper bounds
ub = ones(n_variables,1);
ub(n_items*n_bins+1:n_variables) = BinSize;

%% Linear inequalities
A = zeros(n_variables,n_variables);
b = zeros(n_variables,1);

% constraint 1
eq_constraint_1 = n_bins*n_items; 
equation_number = 0;
for j=1:n_bins
    for i=1:n_items
        equation_number = equation_number+1;
        A(equation_number, [j*n_items+i, n_items*n_bins+j]) = [1 -1];   
    end
end

% constraint 3
for j=0:n_bins-1
    s = 0;
    equation_number = equation_number+1;
    p=n_items*j;
    A(equation_number,p+1:p+n_items) = ItemSize;
    b(equation_number) = BinSize(j+1);
end

%% Linear equalities
Aeq = zeros(n_variables,n_variables);
beq = zeros(n_variables,1);

for i=1:n_items
    
    Aeq (i,i:n_items:n_items*n_bins) = ones(n_items,1);
end
beq (1:n_items) = ones(n_items,1);

%% intcon
intcon=1:n_variables;

%% Objective function
f = zeros(n_items*n_bins+n_bins, 1);
f(n_items*n_bins+1:length(f)) = ones(n_bins,1);

[sol, fval] = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub);

%% print
for i=0:72-1
    fprintf('%12.0f\t%d\n', sol(i+1), mod(i,8)+1);
end