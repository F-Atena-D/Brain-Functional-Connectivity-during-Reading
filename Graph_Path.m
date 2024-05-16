
% Script Name: Graph_Path
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates Shortest Path Length of connectivity graphs

clear; clc;  % Clear workspace and command window
tic

%% load the calculated PLV
for d = 3:30 % Subject you want to work on...
load(sprintf('plvdn%d.mat', d))

% Calculate the path length in each frequency band
tr = .7; % Apply the threshold

    for s = 1:125
    plvs = squeeze(plvThetaBand(s, :, :));
    tplv = plvs;
    tplv(plvs>tr) = 1;
    tplv(plvs<tr) = 0;
    tplv(plvs==tr) = 1;

    L(d, s) =averagePathLength(tplv);
    end
end

%%
L(L==0) = [];
rL = reshape(L, [], 125);

%%
 n = 28;
    for i = 1:n
NL(i,:) = (rL(i,:) - min(rL(i,:)))/(max(rL(i,:)) - min(rL(i,:)));
    end

    %%
mNL = mean(NL, 1);
sNL = std(NL, [], 1);

%%
n = 28;
figure; errorbar(1:4:500, mNL, sNL/sqrt(n), 'LineWidth', 1.5);
ylim([0 1]);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized L (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')

