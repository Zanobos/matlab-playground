%% generateArcs
% arcs = generateArcs(trf_m, number_nodes)

function arcs = generateArcs(trf_m, number_nodes)
c = 0;
for i = 1:number_nodes
    for k = 1:number_nodes
        if (trf_m(i,k) > 0)
            c=c+1;
            arcs(c).tx = i; % tx node
            arcs(c).rx = k; % rx node
            arcs(c).val = trf_m(i,k); % traffic moving from tx to rx
            arcs(c).flow = 0; % flow moving on lightpath tx->rx
        end
    end
end
    