%% Init part: clear all
clear
close all
clc

%% First part: parameters

% NumberOfBins = 1..8
% NumberOfItems = 1..8
% BinsSize: array(NumberOfBins) of integer !name : type
% ItemsSize: array(NumberOfItems) of integer
% BinsSize:: [20,20,20,20,20,20,20,20]
% ItemsSize:: [4,5,6,6,8,9,10,11]
    
binsNumber = 8;
itemsNumber = 8;
BinsSize = [20,20,20,20,20,20,20,20];
ItemSize = [4,5,6,6,8,9,10,11];

%% Second part: decision variables

% Bins: array(NumberOfBins) of mpvar
% ItemInBin: array(NumberOfItems,NumberOfBins) of mpvar

numXVariables = binsNumber*itemsNumber;
numTotVariables = binsNumber*itemsNumber + binsNumber;

% forall(i in NumberOfBins) Bins(i) is_binary
% forall(i in NumberOfItems, j in NumberOfBins) ItemInBin(i,j) is_binary
% Lower and upper bounds
lb = zeros(numTotVariables);
ub = ones(numTotVariables);

%% Third part: linear equality constraints 
% forall(i in NumberOfItems) sum(j in NumberOfBins) ItemInBin(i,j) = 1
beq = zeros(numTotVariables,1);
for i = numXVariables + 1 : numTotVariables
    beq(i)=1;
end
Aeq = zeros(numTotVariables);
for i = numXVariables + 1 : numTotVariables
    Aeq(i,(mod(i - 1,binsNumber) + 1):itemsNumber:itemsNumber*binsNumber) = ones(itemsNumber,1);
end

%% Fourth part: linear inequality constraints
% forall(i in NumberOfItems, j in NumberOfBins) ItemInBin(i,j) <= Bins(j)
% forall(j in NumberOfBins) sum(i in NumberOfItems) ItemsSize(i)*ItemInBin(i,j)<=BinsSize(j)
% 64 inequality for 1st constraint + 8 inequality for 2nd constraint
b = zeros(numTotVariables,1);
A = zeros(numTotVariables);

% *% What does it matter is the order of columns -> rows are just equations*
for i = 1 : numXVariables
    for j = 1 : numXVariables
        if i==j 
            A(i,j)=1;
        end
    end
end
j = numXVariables +1;
for i = 1 : numXVariables
        A(i,j) = -1;
        if mod(i,binsNumber) == 0
            j = j + 1;
        end    
end
offSet = 1;
j=1;
for i = numXVariables + 1 : numTotVariables
        A(i,j:j+itemsNumber-1)= ItemSize;
        j = j + itemsNumber;
        for k = 1 : binsNumber
            if i == k + numXVariables
                A(i,numXVariables + k)= -BinsSize(k);
            end
        end
end
%% Fifth part: objective function
% Fun:= sum(i in NumberOfBins) Bins(i)
fun = zeros(numTotVariables,1);
for i = numXVariables + 1 : numTotVariables
        fun(i) = 1;
end

%% Sixth part: call the solver
intcon = 1 : numTotVariables;

[x] = intlinprog(fun,intcon,A,b,Aeq,beq,lb,ub);

for i = 1 :numTotVariables
    fprintf('%12.0f\t%d\n', x(i), mod(i-1,8)+1);
end