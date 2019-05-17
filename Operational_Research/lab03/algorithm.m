%% Operational research
% Implement a greedy algorithm for the solution of the LTD problem

%% Algorithm
% 1. Given the traffic matrix we sort the nodes by traffic (desc.)
% 2. we assign nodes according to SCOM
% 3. every n_check iterations (n_check < delta) we choose with probability
% p an arc which connects nodes at the bottom of the list 
% 4. after placing n*delta lightpaths we evaluate the topology
% 5. we repeat multiple times the procedure by changing p
% 6. we choose the better topology accoriding to the obj function (min
% f_max)

% We still need to decide how to route the traffic (shortest path, random)

%% Data
clear all, close all, clc;

number_nodes = 6;
n_delta = 3 ;
p = 0.1;
n_check = 2;

% define the traffic matrix
% trf_m = 0.5 + rand(number_nodes, number_nodes);
% trf_m = trf_m - diag(diag(trf_m))

trf_m = [0 0.997948815018947 0.903501388804361 1.05855903456055 0.615625879181259 1.04055042517024;
    0.539184486647583 0 1.43497908617805 1.25663070089437 0.551448293230205 0.931980610856683;
    1.44632498980548 1.49424301064405 0 1.49548105855526 0.804348945636573 1.04266698743634;
    1.26367332366376 1.35485168309068 0.731791611663117 0 1.08019183314271 1.21241480578952;
    1.05882055050956 1.46240393971197 0.896290248509776 1.03506710525616 0 0.516674712940233;
    0.683842944465775 1.17894100897703 1.20507747511279 1.46387012997171 1.40120809265314 0];

% define the lightpath matrix
bij = zeros(number_nodes, number_nodes);


%% define the random adj matrix
adj_m = [0.0 0.0 0.0 1.0 0.0 1.0
0.0 0.0 1.0 0.0 1.0 1.0
0.0 1.0 0.0 1.0 0.0 0.0
1.0 0.0 1.0 0.0 1.0 0.0
0.0 1.0 0.0 1.0 0.0 0.0
1.0 1.0 0.0 0.0 0.0 0.0];
G_random = graph(adj_m);
% plot (G_random)

%% define the delta matrix
delta =  zeros(number_nodes, 2);

%% assign values to struct
c=0;
for i = 1:number_nodes
    for k = 1:number_nodes
        if (trf_m(i,k) > 0)
            c=c+1;
            arcs(c).tx = i;
            arcs(c).rx = k;
            arcs(c).val = trf_m(i,k);
            arcs(c).flow = 0;
        end
    end
end

%% sort arcs by load
sortArcs

%% assign lightpaths by traffic

% todo: constraint over number of transmitters and receivers

lt = 0; % number of chosen low traffic arcs 
l = length(arcsSorted);
c = 1;

for i = 1:l
    if mod(i, n_check) == 0 % every n_check iterations we choose with prob p an arc from the bottom of the list
        if (rand < p) % 
            % choose an arc from the bottom of the list
            chosen_arc = l-lt;
            lt = lt+1;
        else chosen_arc = i;
        end
    else
        chosen_arc = i;
    end
    atx = arcsSorted(chosen_arc).tx;
    arx = arcsSorted(chosen_arc).rx;
    if delta(atx, 1) < n_delta && delta(arx, 2)  < n_delta
        cA = arcsSorted(chosen_arc);
        delta(atx, 1) = delta(atx, 1) + 1;
        delta(arx, 2) = delta(arx, 2) + 1;
%         bij(cA.tx, cA.rx) = cA.val;
        bij(cA.tx, cA.rx) = 1; 
        chosen_lightpaths (c) = chosen_arc;
        c = c+1;
    else continue;
    end
end


G_bij = digraph(bij);
p = plot(G_bij,'Layout','force','EdgeLabel',G_bij.Edges.Weight);
return
%% route by shortest path

flow = zeros(number_nodes, number_nodes);

for i = 1:length(arcs)
    atx = arcs(i).tx;
    arx = arcs(i).rx;
    path = shortestpath(G_bij, atx, arx);
    for k = 1:length(path)-1
        flow(path(k), path(k+1)) = flow(path(k), path(k+1)) + trf_m(path(k), path(k+1));
    end
end
    
flow
max(max(flow))