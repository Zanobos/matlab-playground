%% Test algorithm

% clear all, close all, clc

%% DATA
number_nodes = 6;
n_delta = 2;
n_check = 8;
trf_m = 0.5 + rand(number_nodes, number_nodes);
trf_m = trf_m - diag(diag(trf_m));
% p = 0.1
% I generate a probability array to check which is the best one
p = linspace(0,1, 10);

max_flow_array = zeros(1, length(p));
bij_array = zeros(number_nodes, number_nodes,zeros);

%% Run the algorithm multiple times changing the value of P
for i = 1:length(p)
    i
    [bij, arcs] = generate_flow_matrix(number_nodes, n_delta, p(i), n_check, trf_m);
    bij_array(:,:,i) = bij;
    [flow_matrix, max_flow] = route_by_shortest_path (bij, arcs, number_nodes, trf_m);
    max_flow_array (i) = max_flow;
end
%% Find the minimum maxflow
minmaxflow_I = min(find(min(max_flow_array) == max_flow_array))
minmaxflow = min(max_flow_array)
best_topology = bij_array(:,:,minmaxflow_I);

%% plot the graph of the best topology
best_topology_graph = digraph(best_topology);
p = plot(best_topology_graph);

%% check whether the topology is connected
bins = conncomp(best_topology_graph);
if sum(bins) == number_nodes
    disp('topology connected');
else
    disp('topology not connected');
end

return
%% find the average shortest distance between nodes
c = 1;
for i = 1:number_nodes
    for j = 1:number_nodes
        if j ~= i
            path = shortestpath(best_topology_graph, i,j);
            path_lengths(c) = length(path);
            c = c+1;
        end
    end
end

path_lengths = path_lengths-1;
mean_path_length = mean(path_lengths)
