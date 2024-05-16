
% Script Name: Graph_JaccardSimilarity
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates Jaccard Similarity of connectivity graphs

clear; clc;  % Clear workspace and command window
tic

%% load the calculated PLV
for d = 3:30 % Subject you want to work on...
load(sprintf('plvdn%d.mat', d))

% Calculate the similarity in each frequency band
tr = .7; % Apply the threshold
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;

stplv = squeeze(sum(tplv, 1)/125); % Create the template graph
stplv(stplv<1) = 0;
PLVTemplate = stplv;

rtplvt = reshape(PLVTemplate, [], 1);
Similarm = sum(rtplvt,'all');

SimilarJ = ones(125,1);
for s = 1:125
rtrplv = reshape(tplv(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtplvt==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtplvt==1)));
end

SimilarJB(d,:)=SimilarJ;
end

%%
SimilarJB(SimilarJB==0) = [];
rSimilarJB = reshape(SimilarJB, [], 125);

  %%
  n = 28;
    for i = 1:n
NSE(i,:) = (rSimilarJB(i,:) - min(rSimilarJB(i,:)))/(max(rSimilarJB(i,:)) - min(rSimilarJB(i,:)));
    end

%%
mSE = mean(NSE, 1);
sSE = std(NSE, [], 1);

%%
n = 28;
figure; 
errorbar(1:4:500, mSE, sSE/sqrt(n), 'LineWidth', 1.5);
ylim([0 1]);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized Similarity (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')
