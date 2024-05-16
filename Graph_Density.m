
% Script Name: Graph_Density
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates density of connectivity graphs

clear; clc;  % Clear workspace and command window
tic

%% load the calculated PLV
for d = 3:30 % Subject you want to work on...
load(sprintf('plvdn%d.mat', d))

% Calculate the density in different frequency bands
NE = zeros(125, 1);
DE = zeros(125, 1);
% for tr = 0.25:0.05:0.95
tr = 0.7;
for s = 1:125
    plvs = squeeze(plvThetaBand(s, :, :));
    tplv = plvs;
    tplv(plvs>tr) = 1;
    tplv(plvs<tr) = 0;
    tplv(plvs==tr) = 1;
    G = graph(tplv, 'upper');
    NE(s, 1) = numedges(G);
%     DE(s, round(20*tr-4)) = NE(s, 1)/(192*191/2);
    DE(s, 1) = NE(s, 1)/(192*191/2);
end
% end
DEd(:, d) = DE;
end

%%
DEd(DEd==0) = [];
rDEd = reshape(DEd, 125, []);

%%
DEdt = rDEd';

  %%
  n = 28;
    for i = 1:n
NDEd(i,:) = (DEdt(i,:) - min(DEdt(i,:)))/(max(DEdt(i,:)) - min(DEdt(i,:)));
    end

%%
mDEd = mean(NDEd, 1);
sDEd = std(NDEd, [], 1);

%%
% for i =1:28
% figure; plot(1:4:500, NDEd(i,:)');
% xlabel('Time (ms)','FontSize',14);
% ylabel('Normalized Density','FontSize',14)
% end

%%
figure; 
errorbar(1:4:500, mDEd, sDEd/sqrt(n), 'LineWidth', 1.5);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized Density (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')

%%
save('DensityT.mat', 'DEd');

