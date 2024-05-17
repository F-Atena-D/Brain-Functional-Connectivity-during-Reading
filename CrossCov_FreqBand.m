
% Script Name: CrossCov_FreqBand
% Author: Fatemeh Delavari
% Version: 1.0
% Description: This script calculates Cross-covariance between the normalized density
% in each of the alpha, beta, and gamma frequency bands with that of the theta band

clear; clc;  % Clear workspace and command window
tic

%% Load the normalized density matrices (Calculated using Density_FreqBand and Graph_Density scripts)
load("NDEd_FB.mat", "NDEG", "NDEB", "NDEA");
load('NDEd_T.mat', 'NDEdT');

%% Alpha
for i =1:28
r(i, :) = xcov(NDEdT(i, :), NDEA(i, :));
end
mr = mean(r, 1);
sr = std(r, [], 1);
figure; 
hold on;
errorbar(-124*4:4:124*4, mr, sr/sqrt(28), 'LineWidth', 1.5, 'Color', [0.4940 0.1840 0.5560]);

%% Beta
for i =1:28
r(i, :) = xcov(NDEdT(i, :), NDEB(i, :));
end
mr = mean(r, 1);
sr = std(r, [], 1);
hold on;
errorbar(-124*4:4:124*4, mr, sr/sqrt(28), 'LineWidth', 1.5);

%% Gamma
for i =1:28
r(i, :) = xcov(NDEdT(i, :), NDEG(i, :));
end
mr = mean(r, 1);
sr = std(r, [], 1);
hold on;
errorbar(-124*4:4:124*4, mr, sr/sqrt(28), 'LineWidth', 1.5);

%%
ylim([-5 7]);
set(gca,'FontSize',10,'fontweight','bold')
ylabel('Cross-covariance (Mean+-SEM)', 'FontSize', 18, 'fontweight', 'bold')
xlabel('Lag (ms)', 'FontSize', 18, 'fontweight', 'bold');

%%
xlabel('Lag (ms)', 'FontSize', 18);
ylabel('Cross-covariance (Mean+-SEM)', 'FontSize', 18)
