%% generate random topologies and test them
% [sol_A] = testRandomTopologies(trf_m, number_nodes,n_delta)

function [sol_A, min_connected] = testRandomTopologies(trf_m, number_nodes, n_tries, n_delta)
    
    connected = zeros(1,n_tries);


for count=1:n_tries
    A = random_digraph(number_nodes, n_delta);
    arcs = generateArcs(trf_m, number_nodes); 
    [bij, max_flow_A] = route_by_shortest_path (A, arcs, number_nodes, trf_m);
    array_A(count) = max_flow_A;
    
    
    bins = conncomp (digraph(bij));
    if sum(bins) == number_nodes
        connected(count) = 1;
%         figure, plot(digraph(bij));
    end

end

sol_A = array_A;


if (sum(connected) == 0)
    disp('No randomly generated connected topologies.');
    min_connected = -1;
else
    s = sprintf('n of randomly generated connected topologies = %.0f', sum(connected));
    disp(s);
    min_connected = find(min(array_A(find(connected>0))), 1 );

end
