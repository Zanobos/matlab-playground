 %% generate_flow_matrix
% [flow_matrix max_flow] = generate_flow_matrix (trf_m, number_nodes, n_delta, p,
% n_check, trf_m)

function [ bij ,arcs ] = generate_flow_matrix (number_nodes, n_delta, p, n_check, trf_m)

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
sortArcs

%% assign lightpaths by traffic
lt = 0; % number of chosen low traffic arcs 
l = length(arcsSorted);
c = 1;
for i = 1:l
    if mod(i, n_check) == 0 % every n_check iterations we choose with prob p an arc from the bottom of the list
        if (rand < p) % 
            % choose an arc from the bottom of the list
            chosen_arc = l-lt;
            lt = lt+1;
        else chosen_arc = i; % choose the next highest load arc
        end
    else
        chosen_arc = i;
    end
    atx = arcsSorted(chosen_arc).tx;
    arx = arcsSorted(chosen_arc).rx;
    
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

