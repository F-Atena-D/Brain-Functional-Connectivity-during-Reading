
% Script Name: Density_FreqBand
% Author: Fatemeh Delavari
% Version: 1.0
% Description: This script calculates density of connectivity graphs in
% different frequency bands

clear; clc;  % Clear workspace and command window
tic

%% Calculate the density in Alpha band
for d = 3:30 % Subject you want to work on...
    load(sprintf('plvdn%d.mat', d))

    NE = zeros(125, 1);
    DE = zeros(125, 1);
    tr = 0.7;
    for s = 1:125
        plvs = squeeze(plvAlphaBand(s, :, :));
        tplv = plvs;
        tplv(plvs>tr) = 1;
        tplv(plvs<tr) = 0;
        tplv(plvs==tr) = 1;
        G = graph(tplv, 'upper');
        NE(s, 1) = numedges(G);
        DE(s, 1) = NE(s, 1)/(192*191/2);
    end
    DEd(:, d) = DE;
end
%
DEd(DEd==0) = [];
rDEd = reshape(DEd, 125, []);
%
DEdt = rDEd';
%
n = 28;
for i = 1:n
    NDEd(i,:) = (DEdt(i,:) - min(DEdt(i,:)))/(max(DEdt(i,:)) - min(DEdt(i,:)));
end
NDEA = NDEd;
%
mDEd = mean(NDEd, 1);
sDEd = std(NDEd, [], 1);
%
figure;
errorbar(1:4:500, mDEd, sDEd/sqrt(n), 'LineWidth', 1.5, 'Color', [0.4940 0.1840 0.5560]);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized Density (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')

%% Calculate the density in Beta band
clear DEd
for d = 3:30 % Subject you want to work on...
    load(sprintf('plvdn%d.mat', d))

    NE = zeros(125, 1);
    DE = zeros(125, 1);
    tr = 0.7;
    for s = 1:125
        plvs = squeeze(plvBetaBand(s, :, :));
        tplv = plvs;
        tplv(plvs>tr) = 1;
        tplv(plvs<tr) = 0;
        tplv(plvs==tr) = 1;
        G = graph(tplv, 'upper');
        NE(s, 1) = numedges(G);
        DE(s, 1) = NE(s, 1)/(192*191/2);
    end
    DEd(:, d) = DE;
end
%
DEd(DEd==0) = [];
rDEd = reshape(DEd, 125, []);
%
DEdt = rDEd';
%
n = 28;
for i = 1:n
    NDEd(i,:) = (DEdt(i,:) - min(DEdt(i,:)))/(max(DEdt(i,:)) - min(DEdt(i,:)));
end
NDEB = NDEd;
%
mDEd = mean(NDEd, 1);
sDEd = std(NDEd, [], 1);
%
hold on;
errorbar(1:4:500, mDEd, sDEd/sqrt(n), 'LineWidth', 1.5);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized Density (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')

%% Calculate the density in Gamma band
clear DEd
for d = 3:30 % Subject you want to work on...
    load(sprintf('plvdn%d.mat', d))

    NE = zeros(125, 1);
    DE = zeros(125, 1);
    tr = 0.7;
    for s = 1:125
        plvs = squeeze(plvGammaBand(s, :, :));
        tplv = plvs;
        tplv(plvs>tr) = 1;
        tplv(plvs<tr) = 0;
        tplv(plvs==tr) = 1;
        G = graph(tplv, 'upper');
        NE(s, 1) = numedges(G);
        DE(s, 1) = NE(s, 1)/(192*191/2);
    end
    DEd(:, d) = DE;
end
%
DEd(DEd==0) = [];
rDEd = reshape(DEd, 125, []);
%
DEdt = rDEd';
%
n = 28;
for i = 1:n
    NDEd(i,:) = (DEdt(i,:) - min(DEdt(i,:)))/(max(DEdt(i,:)) - min(DEdt(i,:)));
end
NDEG = NDEd;
%
mDEd = mean(NDEd, 1);
sDEd = std(NDEd, [], 1);
%
hold on;
errorbar(1:4:500, mDEd, sDEd/sqrt(n), 'LineWidth', 1.5);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Normalized Density (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')

%%
save("NDEd_FB.mat", "NDEG", "NDEB", "NDEA");

