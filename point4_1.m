% Iterative community finetuning.
% W is the input connection matrix.
clear
load('pdc_dtf_openeye_64chan_20density');
nNodes = 64;
W = mPDC;
n  = size(W,1);             % number of nodes
M  = 1:n;                   % initial community affiliations
Q0 = -1; Q1 = 1;            % initialize modularity values
counter = 0;

fileID = fopen('channel_locations.txt','r');
data=textscan(fileID,'%u%s%f%f');
fclose(fileID);
 

while Q1-Q0>1e-24           % while modularity increases
  Q0 = Q1;                  % perform community detection
  [M, Q1] = community_louvain(W, [], M);
  counter = counter + 1;
end

groups = [];
for i=1:size(M,1)
    if ~ismember(M(i), groups)
        groups = [groups M(i)];
        my_field = strcat('group_',num2str(M(i)));
        clusters.(my_field) = W;
    end
end

for i=1:size(M,1)
   for j=1:size(groups,2)
      if M(i)~=groups(j)
          my_field = strcat('group_',num2str(groups(j)));
          clusters.(my_field)(i, :) = 0;
          clusters.(my_field)(:, i) = 0;
      end
   end
end

figure;
for i=1:size(groups,2)
    my_field = strcat('group_',num2str(groups(i)));
    nets.(my_field) = digraph(clusters.(my_field), data{2});
    subplot(2, 2, i);
    plot(nets.(my_field), 'XData', data{3},'YData', data{4}, 'MarkerSize', 6, ...
        'LineWidth', 2, 'ArrowSize', 12, 'NodeFontSize', 6, 'NodeColor', 'r');
    axis square
end

