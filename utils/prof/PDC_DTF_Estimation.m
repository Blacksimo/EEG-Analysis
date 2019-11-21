fs = 160;
%load('3Signals_case1.mat');
nNodes = size(Y,2);
threshold = 1;
used_nodes = 0;
temp = zeros();
density=0;

%%%toolbox functions from http://www.lcs.poli.usp.br/~baccala/pdc/
nFreqs=13;          % nFreqs - number of point in [0,fs/2] frequency scale
metric = 'euc';     % euc  - Euclidean ==> original PDC
freqRange = [8:13]; 
PDC = pdc_alg(Y,nFreqs,metric,1,1,3,0.2);
mPDC = mean(PDC.pdc_th(:,:,freqRange),3)'; 
mPDC = mPDC-triu(tril(mPDC)); %% deletion of the main diagonal
% 
% while density~=0.20
%     used_nodes=0;
%     for i=1:size(mPDC, 1)
%         for j=1:size(mPDC, 2)
%            if mPDC(i,j)>threshold
% %                temp(i,j) = 1;
%                used_nodes = used_nodes +1;
% %            else 
% %                temp(i,j) = 0;
%            end
%         end
%     end 
%     L_tot = size(mPDC, 1) *(size(mPDC, 1) -1);
%     density = used_nodes/L_tot;
%     display(density);
%     threshold = threshold - 0.005;
% end
% 
% for i=1:size(mPDC, 1)
%         for j=1:size(mPDC, 2)
%            if mPDC(i,j)>threshold
%                mPDC(i,j) = 1;
%                %used_nodes = used_nodes +1;
%            else 
%                mPDC(i,j) = 0;
%            end
%         end
% end
% 
% %spy(mPDC);
% gObj = biograph(mPDC,1:size(mPDC,1));
% gObj = view(gObj);
% 
% DTF = dtf_alg(Y,nFreqs,metric); 
% 
% mDTF = mean(DTF.dtf,3)'; 
% mDTF = mDTF-triu(tril(mDTF));  %% deletion of the main diagonal
% MaxValue = max([max(max(mPDC)) max(max(mDTF))]);


figure; 
subplot(1,2,1);
imagesc(mPDC); colorbar;
title('PDC')
set(gca,'XTick',1:nNodes)
set(gca,'YTick',1:nNodes)
caxis([0 MaxValue])
axis square
% 
% subplot(1,2,2);
% imagesc(mDTF); colorbar;
% title('DTF')
% set(gca,'XTick',1:nNodes)
% set(gca,'YTick',1:nNodes)
% caxis([0 MaxValue])
% axis square

