%% generate_flow_matrix
% [flow_matrix max_flow] = generate_flow_matrix_bis (trf_m, number_nodes, n_delta, p,
% n_check, trf_m)

function [ bij ,arcs ] = generate_flow_matrix_bis (number_nodes, n_delta, p, n_check, trf_m)

% define the lightpath matrix
bij = zeros(number_nodes, number_nodes);
% define the delta matrix
delta =  zeros(number_nodes, 2);

%% assign values to struct
% I create an array of structs which contain info about every edge
c=0;
arcs = generateArcs(trf_m, number_nodes);

%% sort arcs by load
% I sort all the arcs array by traffic transmitted
arcsSorted = sortArcsValue(arcs);
arcsSortedTX = sortArcsTX (arcs);

%% assign lightpaths by traffic
lt = 0; % number of chosen low traffic arcs 
l = length(arcsSorted);
c = 1;
for i = 1:l
    if mod(i, n_check) == 0 % every n_check iterations we choose with prob p an arc from the bottom of the list
        if (rand < p) % 
            % choose a random arc from the bottom half of the list
            rArc = rand * length(arcsSorted)/2 + length(arcsSorted)/2;
            chosen_arc = floor(rArc);
            lt = lt+1;
            atx = arcsSortedTX(chosen_arc).tx;
            arx = arcsSortedTX(chosen_arc).rx;
        else
            chosen_arc = i; % choose the next highest load arc
            atx = arcsSorted(chosen_arc).tx;
            arx = arcsSorted(chosen_arc).rx;
        end
    else
        chosen_arc = i;
        atx = arcsSorted(chosen_arc).tx;
        arx = arcsSorted(chosen_arc).rx;
    end
    % check on number of transmitters: I choose an arc only if there are
    % enough receivers and transmitters on the involved nodes
    if delta(atx, 1) < n_delta && delta(arx, 2)  < n_delta
        cA = arcsSorted(chosen_arc);
        delta(atx, 1) = delta(atx, 1) + 1;
        delta(arx, 2) = delta(arx, 2) + 1;
        bij(cA.tx, cA.rx) = 1; 
        chosen_lightpaths (c) = chosen_arc;
        c = c+1;
    else continue; % not enough transmitters/receivers, ignore lightpath
    end
end

