clear
addpath(genpath('emVAR'))
nNodes = 19;
freqRange = 8:13;
[open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
open_eyes_annotation = open_eyes_record(65,:);
open_eyes_record = open_eyes_record(1:64,:);

chosen_channels = {'Fp1'  'Fp2'   'F7'   'F3'   'Fz'   'F4'   'F8'   'T7'   'C3'   'Cz'   'C4'   'T8'   'P7'   'P3'   'Pz'   'P4'  'P8'   'O1'   'O2'};
chosen_index = zeros();
Y = [];

for i=1:size(chosen_channels,2)
    index = find(strcmp(chosen_channels{1,i}, open_eyes_header.label));
    chosen_index(i) = index;
    Y = [Y; open_eyes_record(index,:)];
end

[DC,DTF,PDC,GPDC,COH,PCOH,PCOH2,H,S,P,f] = fdMVAR(Y, 30, 160);
freqRange = 8:13;
mPDC = mean(real(PDC(:,:,freqRange)), 3);
mPDC = mPDC-triu(tril(mPDC));
% tic
% c=asymp_pdc(Y,mPDC,eye(nNodes,nNodes),30,'euc',0.05);
% toc

MaxValue = max([max(max(mPDC)) ...
%     max(max(mDTF))...
    ]);

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
    if density>0.19 && density<0.21
       break; 
    end
    
    %display(density);
    threshold_pdc = threshold_pdc - 0.0005;
end
mPDC = temp;

fileID = fopen('channel_locations.txt','r');
data=textscan(fileID,'%u%s%f%f');
fclose(fileID);



chosen_index = sort(chosen_index);
gObj = biograph(adjacency_matrix_pdc, chosen_channels);

for i=1:nNodes
    index = find(strcmp(gObj.Nodes(i).ID , open_eyes_header.label));
    gObj.nodes(i).Position = [data{3}(index) , data{4}(index) ];
%     gObj.nodes(i)
%     gObj.nodes(i).Position
end
% gObj.nodes(i).Position
dolayout(gObj, 'Pathsonly', false);
view(gObj);

%%prova con digraph

%%FUNZIONAAAA AHAHHAHAHA GOOOOOOODOOOOO

G = digraph(adjacency_matrix_pdc, chosen_channels);
x=[];
y=[];
for i=1:nNodes
    index = find(strcmp(gObj.Nodes(i).ID , open_eyes_header.label));
    x = [x,data{3}(index)];
    y = [y,data{4}(index)];
end
h = plot(G);
h.NodeColor = 'r';
h.MarkerSize = 8;
h.XData = x;
h.YData = y;



% chosen_index = sort(chosen_index);
% G = graph(adjacency_matrix_pdc, chosen_channels);
% 
% view(G);




