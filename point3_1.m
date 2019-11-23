clear
addpath(genpath('emVAR'))
nNodes = 64;
[open_eyes_header, open_eyes_record] = edfread('data/S070R01.edf');
open_eyes_annotation = open_eyes_record(65,:);
open_eyes_record = open_eyes_record(1:64,:);

Y = open_eyes_record(1:64,:);

[DC,DTF,PDC,GPDC,COH,PCOH,PCOH2,H,S,P,f] = fdMVAR(Y, 30, 160);
freqRange = 14:30;
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

%%%%%%%%%%%%%%%%%%%%% DA QUI INIZIO IL PUNTO 3.1 %%%%%%%%%%%%%%%%%%%


% Input:      A,      binary directed connection matrix
%
%   Output:     F,      node motif frequency fingerprint
%               f,      network motif frequency fingerprint

A =  adjacency_matrix_pdc;
[f,F] = motif3funct_bin(A);


