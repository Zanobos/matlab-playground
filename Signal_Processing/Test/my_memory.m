% parameters are passed:
% by copy if they change
% by references if they don't change

% I can put same output as input
% this means, if correctedly called, no spike for temporary var e no ram
% losts in var
% ex: xx= myfunc(xx) vs yy= myfunc(xx)

% Data type in matlab are like c-ones, but: cell has a cell header, and
% struct has even more header

% Even while creating new variables varNew = var, Matlab doesnt create a
% new var, only if data are changed matlab creates the new variable

% Matlab can import directly table/csv/excel file

% New Data type: table (and easy indexing, column choosing, etc)
% and other new data: categorical array(enum)