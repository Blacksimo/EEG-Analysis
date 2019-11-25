clear
addpath(genpath('emVAR'))
density_values = [0.01 0.05 0.1 0.2 0.3 0.5];
all_densities = {};

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

MaxValue = max([max(max(mPDC)) ...
%     max(max(mDTF))...
    ]);

figure; 
for d=1:size(density_values,2)
    fprintf('Processing Density: %f\n', density_values(1,d));
    upper_density_bound = density_values(1,d)+0.01;
    lower_density_bound = density_values(1,d)-0.01;
%     upper_density_bound = 0.011;
%     lower_density_bound = 0.09;
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
        if density>lower_density_bound && density<upper_density_bound
            %temp = temp-triu(tril(ones(nNodes)));
            adjacency_matrix_pdc = adjacency_matrix_pdc-triu(tril(adjacency_matrix_pdc));
            all_densities{1,d} = temp;
            all_densities{2,d} = adjacency_matrix_pdc;
           break; 
        end

        %display(density);
        threshold_pdc = threshold_pdc - 0.0005;
    end
 
    subplot(2,6,1+(1*d-1));
    spy(adjacency_matrix_pdc);

    subplot(2,6,7+(1*d-1));
    imagesc(temp); colorbar;
    caxis([0 MaxValue])
    xlabel(['Threshold = ' num2str(threshold_pdc) ' Density = ' num2str(density_values(d)*100) '%']);
    axis square
end
