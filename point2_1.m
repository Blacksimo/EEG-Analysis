clear
addpath(genpath('emVAR'))
nNodes = 64;
[open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
open_eyes_annotation = open_eyes_record(65,:);
open_eyes_record = open_eyes_record(1:64,:);

Y = open_eyes_record(1:64,:);

[DC,DTF,PDC,GPDC,COH,PCOH,PCOH2,H,S,P,f] = fdMVAR(Y, 30, 160);
freqRange = 8:13;
mPDC = mean(real(PDC(:,:,freqRange)), 3);
mPDC = mPDC-triu(tril(mPDC));

mDTF = mean(real(DTF(:,:,freqRange)), 3);
mDTF = mDTF-triu(tril(mDTF));

MaxValue = max([max(max(mPDC)) ...
    max(max(mDTF))...
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

threshold_dtf = 0.9;
while 1
    used_nodes=0;
    temp = zeros();
    adjacency_matrix_dtf = zeros();
    for i=1:nNodes
        for j=1:nNodes
           if mDTF(i,j)>threshold_dtf
               temp(i,j) = mDTF(i,j);
               adjacency_matrix_dtf(i,j) = 1;
               used_nodes = used_nodes +1;
           else 
               temp(i,j) = 0;
               adjacency_matrix_dtf(i,j) = 0;
           end
        end
    end 
    L_tot = nNodes *(nNodes -1);
    density = used_nodes/L_tot;
    if density>0.19 && density<0.21
       break; 
    end
    %display(density);
    threshold_dtf = threshold_dtf - 0.0005;
end
mDTF = temp;

%%%%%%%%%%%%%%%%%%%%% DA QUI INIZIO IL PUNTO 2.1 %%%%%%%%%%%%%%%%%%%


G = digraph(adjacency_matrix_pdc, open_eyes_header.label(1:64));

in_degree = indegree(G);   %IN DEGREE
out_degree = outdegree(G); %OUT DEGREE
degree = in_degree + out_degree;   %DEGREE

% get adjacency matrix from list of inputs
A = adjacency_matrix_pdc;

% get number of vertices
n = size(A,1);

% shortest path distances between each node
 %Traduco la matrice in una Sparse perche cosi non prende i zeri 
% A = sparse(A);
% D = graphallshortestpaths(A); %problema qui! per il calcolo di L


% characteristic path length
L = sum(A(:))/(n*(n-1)); %formula per la average path lenght MA DOVREI METTTERE I DIVERSO DA J

display(L);

%Clustering coefficient
%formula Ci = 2Li/(ki(ki-1)) 
% totale finale C = Ci/N con n penso sia il numero di nodi

%%%PROVE CODICE%%

[L,EGlob,CClosed,ELocClosed,COpen,ELocOpen] = graphProperties(A);

%CClosed (scalar) - clustering coefficient (closed neighborhood)
%COpen (scalar) - clustering coefficient (open neighborhood)


%%prove codice con brain connectivity toolbox




%%%%%%PER FINIRE PUNTO 2.1 FARE LISTA DEI 10 CANALI CON VALORI PIù ALTI

%%%% PUNTO 2.3 COMPARAZIONE TRA PDC E DTF CON STESSI METODI
