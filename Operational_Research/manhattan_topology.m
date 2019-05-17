nodes = 16;
nodesPerRow = 4;
A = zeros(nodes,nodes);

for i = 1 : nodes
    % sono in un nodo a fine riga
    if mod(i,nodesPerRow) == 0
        A(i, i-1) = 1;
        if i+nodesPerRow < nodes
            A(i,i+nodesPerRow) = 1;
        end
        if i - nodesPerRow > 0
            A(i,i-nodesPerRow) = 1;
        end
    % sono in un nodo a inizio riga
    elseif mod(i,nodesPerRow) == 1
        A(i, i+1) = 1;
        if i+nodesPerRow < nodes
            A(i,i+nodesPerRow) = 1;
        end
        if i - nodesPerRow > 0
            A(i,i-nodesPerRow) = 1;
        end
    else
        A(i, i-1) = 1;
        A(i, i+1) = 1;
        if i+nodesPerRow < nodes
            A(i,i+nodesPerRow) = 1;
        end
        if i - nodesPerRow > 0
            A(i,i-nodesPerRow) = 1;
        end
    end 
end