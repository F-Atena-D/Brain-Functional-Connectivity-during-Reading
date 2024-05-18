
% Script Name: DensityPic
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates the normalized density of the connectivity graph
% to the template graph for the picture naming task

clear; clc;  % Clear workspace and command window
tic

%% first rendomly chosen subject
d = 7;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
DensJ(s) = sum(rtrplv);
end

dn = 1; 
DensityJT(dn,:)=DensJ;


%% Second
d = 8;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
DensJ(s) = sum(rtrplv);
end

dn = 2; 
DensityJT(dn,:)=DensJ;

%% Third
d = 19;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
DensJ(s) = sum(rtrplv);
end

dn = 3; 
DensityJT(dn,:)=DensJ;

%% Fourth
d = 21;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
DensJ(s) = sum(rtrplv);
end

dn = 4; 
DensityJT(dn,:)=DensJ;

%% Fifth
d = 23;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;
    
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
DensJ(s) = sum(rtrplv);
end

dn = 5; 
DensityJT(dn,:)=DensJ;

%% Normalize and Plot
DEd = DensityJT;
  n = 5;
    for i = 1:n
NDEd(i,:) = (DEd(i,:) - min(DEd(i,:)))/(max(DEd(i,:)) - min(DEd(i,:)));
    end

mDEd = mean(NDEd, 1);
sDEd = std(NDEd, [], 1);

n = 5;
figure; 
hold on;
errorbar(1:500, mDEd, sDEd/sqrt(n), 'LineWidth', 0.1);
xlabel('Time (ms)','FontSize',14);
ylabel('Normalized Density (Mean+/-SEM)','FontSize',14)
set(gca,'FontSize',14,'fontweight','bold')

