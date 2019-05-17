%% Generate 100 matrices and test probability

%% DATA
% close all, clear all, clc

number_nodes = 40;
n_delta = [1 2 4 8];
n_check = 3;

% mat = load('trf_m40x40.mat');
% trf_m = mat.trf_m;
trf_m = 0.5 + rand(number_nodes, number_nodes);
trf_m = trf_m - diag(diag(trf_m));

%% run algorithm
p = 0.1;
i = 3; % which n_delta I choose

trf_m = 0.5 + rand(number_nodes, number_nodes);
trf_m = trf_m - diag(diag(trf_m));


for count=1:10
    count
    A = random_digraph(number_nodes, n_delta(i));
    
    [bij, arcs] = generate_flow_matrix(number_nodes, n_delta(i), p, n_check, trf_m);
    [flow_matrix_bij, max_flow_bij] = route_by_shortest_path (bij, arcs, number_nodes, trf_m);
    
    [flow_matrix_A, max_flow_A] = route_by_shortest_path (A, arcs, number_nodes, trf_m);
    
    array_A(count) = max_flow_A;
    array_bij(count) = max_flow_bij;
    
    
end

mean_bij = mean(array_bij)
mean_A = mean(array_A)

min_bij = min(array_bij)
min_A = min(array_A)

max_bij = max(array_bij)
max_A = max(array_A)

diff = -array_bij+array_A;

bad_solutions = sum(diff<0)

n = 1:100;

plot(n, array_bij, n, array_A);
legend('topologies found by algorithm', 'random topologies');

return 

s = sprintf('%f', p(minmaxflow_I));
S = ['Best result obtained with p = ' s];
disp(S);
s = sprintf('%f', max_flow_best);
S = ['Minimum max flow = ' s];
disp(S);
