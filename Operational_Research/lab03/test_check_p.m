%% Multiple tests


%% DATA
close all, clear all, clc

number_nodes = 20;
n_delta = 4;
n_check = 3;

mat = load('trf_m40x40.mat');
% trf_m = mat.trf_m;
trf_m = 0.5 + rand(number_nodes, number_nodes);
trf_m = trf_m - diag(diag(trf_m));
bij_array = zeros(number_nodes, number_nodes,zeros);

A = random_digraph(number_nodes, n_delta);

%% run algorithm with fixed n_check, changing p
p = linspace(0,1, 10);

for count=1:100

for i = 1:length(p)
%     i
    [bij, arcs] = generate_flow_matrix(number_nodes, n_delta, p(i), n_check, trf_m);
    bij_array(:,:,i) = bij;
    [flow_matrix, max_flow] = route_by_shortest_path (bij, arcs, number_nodes, trf_m);
    max_flow_array (i) = max_flow;
end
%%
minmaxflow_I = min(find(min(max_flow_array) == max_flow_array))
minmaxflow = min(max_flow_array);
best_topology = bij_array(:,:,minmaxflow_I);

[flow_matrix_A, max_flow_A] = route_by_shortest_path (A, arcs, number_nodes, trf_m);
max_flow_A;
max_flow_best = minmaxflow;

s = sprintf('%f', p(minmaxflow_I));
S = ['Best result obtained with p = ' s];
disp(S);
s = sprintf('%f', max_flow_best);
S = ['Minimum max flow = ' s];
disp(S);

bins = conncomp(digraph(best_topology));
if sum(bins) == number_nodes
    disp('The topology is connected');
else
    disp('The topology is not connected');
end

clear max_flow_array
%% run algorithm with fixed p, changing n_check
n_check = 1:2:number_nodes/4;
% n_check = 10000;
p = p(minmaxflow_I);

for i = 1:length(n_check)
%     i
    [bij, arcs] = generate_flow_matrix(number_nodes, n_delta, p, n_check(i), trf_m);
    
    bins = conncomp(digraph(bij));

    bij_array(:,:,i) = bij;
    [flow_matrix, max_flow] = route_by_shortest_path (bij, arcs, number_nodes, trf_m);
    max_flow_array (i) = max_flow;
end
%%
minmaxflow_I = min(find(min(max_flow_array) == max_flow_array))
minmaxflow = min(max_flow_array);
best_topology = bij_array(:,:,minmaxflow_I);

[flow_matrix_A, max_flow_A] = route_by_shortest_path (A, arcs, number_nodes, trf_m);
max_flow_A;
max_flow_best = minmaxflow;


s = sprintf('%f', n_check(minmaxflow_I));
S = ['Best result obtained with n_check = ' s];
disp(S);
s = sprintf('%f', max_flow_best);
S = ['Minimum max flow = ' s];
disp(S);

best_topology_graph = digraph(best_topology);

bins = conncomp(best_topology_graph);
if sum(bins) == number_nodes
    disp('topology connected');
else
    disp('topology not connected');
end

%% Plot graphs
figure, plot(best_topology_graph);