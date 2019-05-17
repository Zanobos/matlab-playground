%% Generate random digraph

function A = random_digraph (number_nodes, n_delta)
    A = zeros(number_nodes, number_nodes);

        for i = 1:number_nodes
        placed = 0;
        while placed < n_delta
            for j = 1:number_nodes
                if i ~= j && A(i,j) ~= 1
                    if placed < n_delta
                        if rand < 0.1
                            A(i,j) = 1;
                            placed = placed + 1;
                        end
                    else
                        break;
                    end
                end
            end
        end
        end
