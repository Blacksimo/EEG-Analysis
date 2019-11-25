clear
% addpath(genpath('emVAR'))
nNodes = 64;
% Open Eyes Record
% [open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
% open_eyes_annotation = open_eyes_record(65,:);
% open_eyes_record = open_eyes_record(1:64,:);
% 
% Y = open_eyes_record(1:64,:);
% Closed Eyes Record
[closed_eyes_header, closed_eyes_record] = edfread('data/S070R02.edf');
closed_eyes_annotation = closed_eyes_record(65,:);
closed_eyes_record = closed_eyes_record(1:64,:);

Y = closed_eyes_record(1:64,:);

nFreqs = 30;
freq_samples = 160;
AR = idMVAR(Y, nFreqs);
[DC,DTF,PDC,GPDC,COH,PCOH,PCOH2,H,S,P,f] = fdMVAR(AR, nFreqs, freq_samples);

freqRange = 8:13;
mPDC = mean(real(PDC(:,:,freqRange)), 3);
mPDC = mPDC-triu(tril(mPDC));

% mDTF = mean(real(DTF(:,:,freqRange)), 3);
% mDTF = mDTF-triu(tril(mDTF));

% MaxValue = max([max(max(mPDC)) ...
%     max(max(mDTF))...
%     ]);

threshold_pdc = 0.9;
while 1
    used_nodes=0;
    temp = zeros();
    adjacency_matrix_pdc = zeros();
    for i=1:size(mPDC, 1)
        for j=1:nNodes
           if mPDC(i,j)>threshold_pdc
               temp(i,j) = mPDC(i,j);
               adjacency_matrix_pdc(i,j) = 1;
               used_nodes = used_nodes +1;
           else 
               temp(i,j) = 0;
               adjacency_matrix_pdc(i,j) = 0;
           end
        end
    end 
    L_tot = nNodes *(nNodes -1);
    density = used_nodes/L_tot;
    if density>0.029 && density<0.031
       break; 
    end
    
    %display(density);
    threshold_pdc = threshold_pdc - 0.0005;
end
mPDC = temp;

% threshold_dtf = 0.9;
% while 1
%     used_nodes=0;
%     temp = zeros();
%     adjacency_matrix_dtf = zeros();
%     for i=1:nNodes
%         for j=1:nNodes
%            if mDTF(i,j)>threshold_dtf
%                temp(i,j) = mDTF(i,j);
%                adjacency_matrix_dtf(i,j) = 1;
%                used_nodes = used_nodes +1;
%            else 
%                temp(i,j) = 0;
%                adjacency_matrix_dtf(i,j) = 0;
%            end
%         end
%     end 
%     L_tot = nNodes *(nNodes -1);
%     density = used_nodes/L_tot;
%     if density>0.19 && density<0.21
%        break; 
%     end
%     %display(density);
%     threshold_dtf = threshold_dtf - 0.0005;
% end
% mDTF = temp;

%%%%%%%%%%%%%%%%%%%%% DA QUI INIZIO IL PUNTO 2.1 %%%%%%%%%%%%%%%%%%%


G = digraph(adjacency_matrix_pdc, closed_eyes_header.label(1:64));

fileID = fopen('channel_locations.txt','r');
data=textscan(fileID,'%u%s%f%f');
fclose(fileID);

x=[];
y=[];
for i=1:nNodes
    x = [x,data{3}(i)];
    y = [y,data{4}(i)];
end
h = plot(G);
h.NodeColor = 'r';
h.MarkerSize = 8;
h.XData = x;
h.YData = y;
h.MarkerSize = 15;
h.LineWidth = 2;
h.ArrowSize = 12;
h.NodeFontSize = 12;
axis square;

in_degree = indegree(G);   %IN DEGREE
out_degree = outdegree(G); %OUT DEGREE
degree = in_degree + out_degree;   %DEGREE

cluster_coeff = clustering_coef_bd(adjacency_matrix_pdc);
D = G.distances;

sum_length = 0;
counter = 0;
for i=1:nNodes
   for j=1:nNodes
       if D(i,j) ~= Inf && D(i,j) ~= 0 && i~=j
           sum_length = sum_length + D(i,j);
           counter = counter + 1;
       end
   end
end
sum_length = sum_length/(counter * (counter-1));

channel_struct.index = data{1};
channel_struct.name = data{2};
channel_struct.x = data{3};
channel_struct.y = data{4};
channel_struct.indegree = in_degree;
channel_struct.outdegree = out_degree;
channel_struct.totaldegree = degree;

channel_table_indegree = struct2table(channel_struct);
channel_table_indegree = sortrows(channel_table_indegree, 'indegree', 'descend'); 
display(channel_table_indegree(1:10,:));

channel_table_outdegree = struct2table(channel_struct);
channel_table_outdegree = sortrows(channel_table_outdegree, 'outdegree', 'descend'); 
display(channel_table_outdegree(1:10,:));

channel_table_totaldegree = struct2table(channel_struct);
channel_table_totaldegree = sortrows(channel_table_totaldegree, 'totaldegree', 'descend'); 
display(channel_table_totaldegree(1:10,:));

