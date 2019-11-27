clear
nNodes = 64;
nFreqs = 30;
freq_samples = 160;
load('pdc_closedeye_64chan');
isomorphism = 1;
% load('pdc_closedeye_64chan');

fileID = fopen('channel_locations.txt','r');
data=textscan(fileID,'%u%s%f%f');
fclose(fileID);

[node_freq, net_freq] = motif3funct_bin(adjacency_matrix_pdc);


for i=1:nNodes
    if net_freq(isomorphism, i) == 0
       adjacency_matrix_pdc(:, i) = 0;
       adjacency_matrix_pdc(i, :) = 0;
    end
end 

G = digraph(adjacency_matrix_pdc, data{2});
plot(G, 'XData', data{3},'YData', data{4}, 'MarkerSize', 6, ...
        'LineWidth', 2, 'ArrowSize', 12, 'NodeFontSize', 12, 'NodeColor', 'r');
axis square