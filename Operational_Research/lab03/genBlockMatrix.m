%% generate block matrix
% flow on upper left block is high traffic, flow on bottom right is low
% traffic

number_nodes = 20;

a = 0.5 + rand(number_nodes, number_nodes);
b = 0.5 + rand(number_nodes,number_nodes);

out = blkdiag(a,b);
out(out>0.9) = 0;

a = 5 + 10*rand(number_nodes, number_nodes);
b = 0.5*rand(number_nodes,number_nodes);

out = flip(out) + blkdiag(a,b);

trf_m = out;