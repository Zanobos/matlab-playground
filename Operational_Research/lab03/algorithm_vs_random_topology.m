%% Test algorithm vs random topology

close all

number_nodes = 40;
n_delta = 2;
% A = [0 1 1 0 0 0; 1 0 0 0 0 1; 0 0 0 1 1 0; 0 1 0 0 0 1; 0 0 1 1 0 0; 0 1 1 0 0 0 ];
A = random_digraph(number_nodes, n_delta);

% return

[flow_matrix_A, max_flow_A] = route_by_shortest_path (A, arcs, number_nodes, trf_m);

[flow_matrix_best, max_flow_best] = route_by_shortest_path (best_topology, arcs, number_nodes, trf_m);

G_A = digraph(flow_matrix_A);
G_best = digraph(flow_matrix_best);

% plot(G_A,'Layout','force','EdgeLabel',G_A.Edges.Weight);
% plot(G_A);
% title('random topology');
% figure, plot(G_best,'Layout','force','EdgeLabel',G_best.Edges.Weight);
% figure, plot(G_best);
% title('best topology');

max_flow_A
max_flow_best