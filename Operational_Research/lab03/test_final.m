 %% run test over different matrices

% unif matrices
%% 20x20
mat = load('trf_m20x20.mat');
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Uniform traffic 20x20');

%% 30x30
mat = load('trf_m30x30.mat');
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Uniform traffic 30x30');

%% 40x40
mat = load('trf_m40x40.mat');   
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Uniform traffic 40x40');

% diag matrices
%% 20x20 main diag
mat = load('trf_m20x20blkdiag.mat');
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Main block diagonal 20x20');

%% 30x30 main diag
mat = load('trf_m30x30blkdiag.mat');
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Main block diagonal 30x30');

%% 40x40 main diag
mat = load('trf_m40x40blkdiag.mat');
trf_m = mat.trf_m;
test_multiple_times_multiple_params(trf_m,'Main block diagonal 40x40');

%% 20x20 sec diag
mat = load('trf_m20x20blkdiag.mat');
trf_m = mat.trf_m;
trf_m = flip(trf_m);
test_multiple_times_multiple_params(trf_m,'Secondary block diagonal 20x20');

%% 30x30 sec diag
mat = load('trf_m30x30blkdiag.mat');
trf_m = mat.trf_m;
trf_m = flip(trf_m);
test_multiple_times_multiple_params(trf_m,'Secondary block diagonal 30x30');

%% 40x40 sec diag
mat = load('trf_m40x40blkdiag.mat');
trf_m = mat.trf_m;
trf_m = flip(trf_m);
test_multiple_times_multiple_params(trf_m,'Secondary block diagonal 40x40');

% variable traffic matrices

%% 20x20
mat = load('trf_m20x20vartrf.mat');
trf_m = mat.trf_m;

test_multiple_times_multiple_params(trf_m,'Variable traffic 20x20');

%% 30x30
mat = load('trf_m30x30vartrf.mat');
trf_m = mat.trf_m;

test_multiple_times_multiple_params(trf_m,'Variable traffic 30x30');

%% 40x40
mat = load('trf_m40x40vartrf.mat');
trf_m = mat.trf_m;

test_multiple_times_multiple_params(trf_m,'Variable traffic 40x40');

beep

