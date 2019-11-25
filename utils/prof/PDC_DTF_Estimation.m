fs = 100;
load('3Signals_case1.mat');
nNodes = size(Y,2);

%%%toolbox functions from http://www.lcs.poli.usp.br/~baccala/pdc/
nFreqs=50;          % nFreqs - number of point in [0,fs/2] frequency scale
metric = 'euc';     % euc  - Euclidean ==> original PDC
freqRange = [8:13];
PDC = pdc_alg(Y,nFreqs,metric);
mPDC = mean(PDC.pdc(:,:,freqRange),3)'; 
mPDC = mPDC-triu(tril(mPDC)); %% deletion of the main diagonal

DTF = dtf_alg(Y,nFreqs,metric); 
mDTF = mean(DTF.dtf,3)'; 
mDTF = mDTF-triu(tril(mDTF));  %% deletion of the main diagonal
MaxValue = max([max(max(mPDC)) max(max(mDTF))]);
figure;
subplot(1,2,1);
imagesc(mPDC); colorbar;
title('PDC')
set(gca,'XTick',1:nNodes)
set(gca,'YTick',1:nNodes)
caxis([0 MaxValue])
axis square

subplot(1,2,2);
imagesc(mDTF); colorbar;
title('DTF')
set(gca,'XTick',1:nNodes)
set(gca,'YTick',1:nNodes)
caxis([0 MaxValue])
axis square
