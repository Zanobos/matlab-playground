%% Generate variable traffic matrix
number_nodes = 40;

trf_m = 0.5 + rand(number_nodes, number_nodes);

for i = 1:number_nodes
    for j = 1:number_nodes
        if (rand<0.1)
            trf_m(i,j) = 5+10*rand;
        end
    end
end