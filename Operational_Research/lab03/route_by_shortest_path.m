%% Route by shortest path
% [flow_matrix, max_flow] = route_by_shortest_path (bij, arcs, number_nodes, trf_m)

function [flow_matrix, max_flow] = route_by_shortest_path (bij, arcs, number_nodes, trf_m)

G_bij = digraph(bij);

flow_matrix = zeros(number_nodes, number_nodes);

for i = 1:length(arcs)
    % find tx and rx nodes of i-th arc
    atx = arcs(i).tx;
    arx = arcs(i).rx;
    % find the shortest path between atx and arx
    path = shortestpath(G_bij, atx, arx);
    % add to the flow matrix the traffic flowing on each active edge
    for k = 1:length(path)-1
        % this implies no flow splitting
        flow_matrix(path(k), path(k+1)) = flow_matrix(path(k), path(k+1)) + trf_m(atx, arx);
    end
end

% find the max flow in the matrix
max_flow = max(max(flow_matrix));