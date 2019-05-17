%% Test multiple times with different n_delta and different node_number

% clear all, close all, clc;

% number_nodes = 40;
% n_delta = 1;
function sol_algo = test_multiple_times_multiple_params(trf_m, experiment)
% clear all;
close all;

if nargin < 2
    experiment = '';
end

check = 3;
probability = 0.1;
n_tries = 10;
n_delta = 4;
%%
% trf_m = 0.5 + rand(number_nodes, number_nodes);
% trf_m = trf_m - diag(diag(trf_m));

% mat = load('trf_m40x40.mat');   
% mat = load('trf_m20x20blkdiag.mat');
% mat = load('trf_m30x30blkdiag.mat');
% mat = load('trf_m40x40blkdiag.mat');

% mat = load('trf_m20x20.mat');
% mat = load('trf_m30x30.mat');
% trf_m = mat.trf_m;
% trf_m = flip(trf_m);
%%

number_nodes = size(trf_m, 1);


disp('##########################################################');
disp(experiment);
s = [ 'DATA:'];
disp(s);
s = sprintf('number_nodes = %.0f', number_nodes);
disp(s);
s = sprintf('check = %.0f', check);
disp(s);
s = sprintf('n_delta = %.0f', n_delta);
disp(s);
s = sprintf('probability = %.1f', probability);
disp(s);

disp('');
disp('');


%%
disp('start evaluation algorithm');
[sol_algo, topology_algo, min_connected] = testTopologyMultipleTimes(trf_m, number_nodes, n_tries,  n_delta); % test with reshuffle
%%
disp('start evaluation scom');
% [sol_scom, topology_scom] = testTopologyMultipleTimes(trf_m, number_nodes, n_tries,  n_delta, 100000, 0); % test scom (no reshuffle)
[sol_scom, topology_scom] = testSCOM(trf_m, number_nodes, n_delta);
sol_scom = sol_scom*ones(1,n_tries);
%%
disp('start evaluation random topologies');
[sol_A, min_random] = testRandomTopologies(trf_m, number_nodes, n_tries,  n_delta); % test n_tries random topologies 

%%
avg_A = mean(sol_A);
avg_algo = mean(sol_algo);
avg_scom = mean(sol_scom);

min_A = min(sol_A);
min_algo = min(sol_algo);
min_scom = min(sol_scom);

max_A = max(sol_A);
max_algo = max(sol_algo);
max_scom = max(sol_scom);

scom_better = sum(sol_scom-sol_algo<0);
results = [max_A min_A avg_A max_algo min_algo avg_algo max_scom min_scom avg_scom];

%%
s = sprintf('max Random = %f   max algorithm = %f    max scom = %f    ', max_A, max_algo, max_scom);
disp(s);
s = sprintf('min Random = %f   min algorithm = %f    min scom = %f    ', min_A, min_algo, min_scom);
disp(s);
s = sprintf('avg Random = %f   avg algorithm = %f    avg scom = %f    ', avg_A, avg_algo, avg_scom);
disp(s);

s = sprintf('ALGORITHM: minflow of best connected topology = %f', sol_algo(min_connected));
disp(s);

if (min_random > 0)
s = sprintf('RANDOM: minflow of best connected topology = %f', sol_A(min_random));
disp(s);
end

bins1 = conncomp(digraph(topology_algo));
bins2 = conncomp(digraph(topology_scom));

figure
plot(digraph(topology_scom));
title('scom');

figure
plot(digraph(topology_algo));
title('algorithm');
% 
if (sum(bins1) == number_nodes)
    disp('algorithm topology connected');
else 
    disp('algorithm topology not connected');
end

if (sum(bins2) == number_nodes)
    disp('scom topology connected');
    s = sprintf('cases where scom is better than the algorithm = %.0f out of %.0f', scom_better, n_tries);
    disp(s);
else 
    disp('scom topology not connected');
end


% return 
%% plot
n = 1:n_tries;
figure
plot(n, sol_A, n, sol_algo, n, sol_scom);

title(experiment);
legend ('sol_{A1}', 'sol_{algo}', 'sol_{scom}');

% beep
