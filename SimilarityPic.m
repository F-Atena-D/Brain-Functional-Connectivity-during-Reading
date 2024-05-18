
% Script Name: SimilarityPic
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates the normalized similarity of the connectivity graph
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

strplvt = squeeze(sum(trplvt,1)/500);
strplvt(strplvt<1) = 0;

PLVTemplate = strplvt;

rtrplvt1 = reshape(PLVTemplate,[],1);
Similarm = sum(rtrplvt1,'all');

SimilarJ = ones(500,1);
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtrplvt1==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtrplvt1==1)));
end

dn = 1; 
SimilarJT(dn,:)=SimilarJ;


%% Second
d = 8;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

strplvt = squeeze(sum(trplvt,1)/500);
strplvt(strplvt<1) = 0;

PLVTemplate = strplvt;

rtrplvt1 = reshape(PLVTemplate,[],1);
Similarm = sum(rtrplvt1,'all');

SimilarJ = ones(500,1);
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtrplvt1==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtrplvt1==1)));
end

dn = 2; 
SimilarJT(dn,:)=SimilarJ;

%% Third
d = 19;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

strplvt = squeeze(sum(trplvt,1)/500);
strplvt(strplvt<1) = 0;

PLVTemplate = strplvt;

rtrplvt1 = reshape(PLVTemplate,[],1);
Similarm = sum(rtrplvt1,'all');

SimilarJ = ones(500,1);
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtrplvt1==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtrplvt1==1)));
end

dn = 3; 
SimilarJT(dn,:)=SimilarJ;

%% Fourth
d = 21;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

strplvt = squeeze(sum(trplvt,1)/500);
strplvt(strplvt<1) = 0;

PLVTemplate = strplvt;

rtrplvt1 = reshape(PLVTemplate,[],1);
Similarm = sum(rtrplvt1,'all');

SimilarJ = ones(500,1);
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtrplvt1==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtrplvt1==1)));
end

dn = 4; 
SimilarJT(dn,:)=SimilarJ;

%% Fifth
d = 23;
load(sprintf('plvPicdn%d.mat', d))

tr = .7;
    tplv = plvThetaBand;

    tplv(tplv>tr) = 1;
    tplv(tplv<tr) = 0;
    tplv(tplv==tr) = 1;
    trplvt = tplv;

strplvt = squeeze(sum(trplvt,1)/500);
strplvt(strplvt<1) = 0;

PLVTemplate = strplvt;

rtrplvt1 = reshape(PLVTemplate,[],1);
Similarm = sum(rtrplvt1,'all');

SimilarJ = ones(500,1);
for s = 1:500
rtrplv = reshape(trplvt(s,:,:),[],1);
SimilarJ(s) = sum(rtrplv(rtrplvt1==1))/(Similarm + sum(rtrplv) - sum(rtrplv(rtrplvt1==1)));
end

dn = 5; 
SimilarJT(dn,:)=SimilarJ;

%% Normalize and Plot
SEd = SimilarJT;
  n = 5;
    for i = 1:n
NSEd(i,:) = (SEd(i,:) - min(SEd(i,:)))/(max(SEd(i,:)) - min(SEd(i,:)));
    end

mSEd = mean(NSEd, 1);
sSEd = std(NSEd, [], 1);

n = 5;
figure; 
hold on;
errorbar(1:500, mSEd, sSEd/sqrt(n), 'LineWidth', 0.1);
xlabel('Time (ms)','FontSize',14);
ylabel('Normalized Similarity (Mean+/-SEM)','FontSize',14)
set(gca,'FontSize',14,'fontweight','bold')

