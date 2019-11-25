clear
nNodes = 64;
nFreqs = 30;
freq_samples = 160;
load('pdc_openeye_64chan');
% load('pdc_closedeye_64chan');

%%%%%%%%%%%%%%%%%%%%% DA QUI INIZIO IL PUNTO 3.1 %%%%%%%%%%%%%%%%%%%


% Input:      A,      binary directed connection matrix
%
%   Output:     F,      node motif frequency fingerprint
%               f,      network motif frequency fingerprint

[node_freq, net_freq] = motif3funct_bin(adjacency_matrix_pdc);
