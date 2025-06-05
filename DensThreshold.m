
% Script Name: DensThreshold
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script depicts the effects of using different thresholds on 
% the density of connectivity graphs

clear; clc;  % Clear workspace and command window
tic

%% load the calculated PLV
clear DEd
for d = 3:30 % Subject you want to work on...
load(sprintf('plvdn%d.mat', d))

% Calculate the density in different frequency bands
NE = zeros(125, 1);
DE = zeros(125, 1);
for tr = 0.25:0.05:0.95
for s = 1:125
    plvs = squeeze(plvThetaBand(s, :, :));
    tplv = plvs;
    tplv(plvs>tr) = 1;
    tplv(plvs<tr) = 0;
    tplv(plvs==tr) = 1;
    G = graph(tplv, 'upper');
    NE(s, 1) = numedges(G);
    DE(s, round(20*tr-4)) = NE(s, 1)/(192*191/2);
end
end
DEd(:, :, d) = DE;
end
DEdT = DEd;

%%
for d = 3:30 % Subject you want to work on...
    for tr = 0.25:0.05:0.95
        corrDE(round(20*tr-4), d) = corr(DEd(:, round(20*tr-4), d), DEd(:, round(20*0.7-4), d));
    end
end

%%
corrDE(:, 2) = [];
corrDE(:, 1) = [];
mCorrD = mean(corrDE, 2);
sCorrD = std(corrDE, [], 2);

%%
n = 28;
figure;
errorbar(0.25:0.05:0.95, mCorrD, sCorrD/sqrt(n), 'LineWidth', 2.5);
ylabel('Correlation (Mean+/-SEM)','FontSize',18,'fontweight','bold')
xlabel('Threshold','FontSize',18,'fontweight','bold')
ylim([0 1]);
xlim([0.2 1]);
set(gca,'FontSize',14,'fontweight','bold')
title('Density','FontSize',18,'fontweight','bold')
