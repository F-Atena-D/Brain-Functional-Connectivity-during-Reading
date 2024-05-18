
% Script Name: ConnPercent
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates the percentage of connections
% with a significant increase in connectivity in each region. 

clear; clc;  % Clear workspace and command window
tic

%% 
% Load the calculated PLV
% Calculate the average connnectivity during middle, beginnig, and end of reading the word
% And perform statistical analysis
for d = 3:30
   dn = d-2;
   load(sprintf('plvdn%d.mat', d))
   s =47:52;
   tplvdm = squeeze(plvThetaBand(s, :, :));
   s =6:10;
   tplvdb = squeeze(plvThetaBand(s, :, :));
   s =96:100;
   tplvde = squeeze(plvThetaBand(s, :, :));

for p = 1:192
   for q = p+1:192
at5 = squeeze(tplvdb(:,p,q));
at50 = squeeze(tplvdm(:,p,q));
[pval, h] = ranksum(at5, at50, 'alpha', 0.05);
testresultbm(p, q, d) = h;
   end
end

for p = 1:192
   for q = p+1:192
at5 = squeeze(tplvdb(:,p,q));
at50 = squeeze(tplvde(:,p,q));
[pval, h] = ranksum(at5, at50, 'alpha', 0.05);
testresultbe(p, q, d) = h;
   end
end

for p = 1:192
   for q = p+1:192
at5 = squeeze(tplvdm(:,p,q));
at50 = squeeze(tplvde(:,p,q));
[pval, h] = ranksum(at5, at50, 'alpha', 0.05);
testresultme(p, q, d) = h;
   end
end
end

%% Remove the edges that exist in beginning to end from beginning to middle and middle to end
for d = 3:30
    dn = d-2;
    for p = 1:192
        for q = p+1:192
            if testresultbe(p, q, d)==1
                testresultbm(p, q, d)=0;
                testresultme(p, q, d)=0;
            end
        end
    end
end

%% Nodes (sensors) in each brain region
cFrontal =[2	3	4	5	6	9	10	11	12	13	14	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	40	41	42	183	184	185	187	188	189	191	192];
cOccipital = [88	 89	92	93	94	95	96	97	98	99	101	102	103	104	105	106	107	108	114	115	116	117	118	119	120	121	126	127	128	129	130	131	132	136	137	138	139	140	141	145	146	147	148	153	154	165	166	177];
cTemporal = [149	150	151	152	155	156	157	158	159	160	167	168	169	170	171	172	173	178	179	180	181	182	48	52	53	54	57	58	59	60	61	62	63	69	70	76	77	78	84	85	86	87 1 39 46 47 186 190];
cParietal = [7	8	15	36	37	38	43	44	45	49	50	51	55	56	64	65	66	67	68	71	72	73	74	75	79	80	81	82	83	90	91	100	109	110	111	112	113	122	123	124	125	133	134	135	142	143	144	161	162	163	164	174	175	176];

%% Count the edges in each region and between regions
clf = cFrontal;
for d =3:30
    countbmc1(d) = sum(squeeze(testresultbm(clf(1:end-1), clf, d)), 'all');
    countmec1(d) = sum(squeeze(testresultme(clf(1:end-1), clf, d)), 'all');
    countbec1(d) = sum(squeeze(testresultbe(clf(1:end-1), clf, d)), 'all');
end

%
clf = cTemporal;
for d =3:30
    countbmc2(d) = sum(squeeze(testresultbm(clf(1:end-1), clf, d)), 'all');
    countmec2(d) = sum(squeeze(testresultme(clf(1:end-1), clf, d)), 'all');
    countbec2(d) = sum(squeeze(testresultbe(clf(1:end-1), clf, d)), 'all');
end

%
clf = cParietal;
for d =3:30
    countbmc3(d) = sum(squeeze(testresultbm(clf(1:end-1), clf, d)), 'all');
    countmec3(d) = sum(squeeze(testresultme(clf(1:end-1), clf, d)), 'all');
    countbec3(d) = sum(squeeze(testresultbe(clf(1:end-1), clf, d)), 'all');
end

%
clf = cOccipital;
for d =3:30
    countbmc4(d) = sum(squeeze(testresultbm(clf(1:end-1), clf, d)), 'all');
    countmec4(d) = sum(squeeze(testresultme(clf(1:end-1), clf, d)), 'all');
    countbec4(d) = sum(squeeze(testresultbe(clf(1:end-1), clf, d)), 'all');
end

%
clf1 = cFrontal;
clf2 = cTemporal;
for d =3:30
    countbmc12(d) = sum(squeeze(testresultbm(clf2, clf1, d)), 'all');
    countmec12(d) = sum(squeeze(testresultme(clf2, clf1, d)), 'all');
    countbec12(d) = sum(squeeze(testresultbe(clf2, clf1, d)), 'all');
end 

%
clf1 = cFrontal;
clf3 = cParietal;
for d =3:30
    countbmc13(d) = sum(squeeze(testresultbm(clf3, clf1, d)), 'all');
    countmec13(d) = sum(squeeze(testresultme(clf3, clf1, d)), 'all');
    countbec13(d) = sum(squeeze(testresultbe(clf3, clf1, d)), 'all');
end 

%
clf1 = cFrontal;
clf4 = cOccipital;
for d =3:30
    countbmc14(d) = sum(squeeze(testresultbm(clf4, clf1, d)), 'all');
    countmec14(d) = sum(squeeze(testresultme(clf4, clf1, d)), 'all');
    countbec14(d) = sum(squeeze(testresultbe(clf4, clf1, d)), 'all');
end 

%
for d =3:30
    countbmc23(d) = sum(squeeze(testresultbm(clf2, clf3, d)), 'all');
    countmec23(d) = sum(squeeze(testresultme(clf2, clf3, d)), 'all');
    countbec23(d) = sum(squeeze(testresultbe(clf2, clf3, d)), 'all');
end 

%
for d =3:30
    countbmc24(d) = sum(squeeze(testresultbm(clf2, clf4, d)), 'all');
    countmec24(d) = sum(squeeze(testresultme(clf2, clf4, d)), 'all');
    countbec24(d) = sum(squeeze(testresultbe(clf2, clf4, d)), 'all');
end 

%
for d =3:30
    countbmc34(d) = sum(squeeze(testresultbm(clf3, clf4, d)), 'all');
    countmec34(d) = sum(squeeze(testresultme(clf3, clf4, d)), 'all');
    countbec34(d) = sum(squeeze(testresultbe(clf3, clf4, d)), 'all');
end 


%% The number of possible edges for calculating the percentages
cl = [42, 48, 54, 48, 90, 96, 90, 102, 96, 102];
cll = diag(cl'*(cl-1)/2);

%% Calculate the in region percentages and between region counts
cbm_ir = [countbmc1/cll(1); countbmc2/cll(2); countbmc3/cll(3); countbmc4/cll(4)];
cbm_br =[countbmc12; countbmc13; countbmc14; countbmc23; countbmc24; countbmc34];
cme_ir = [countmec1/cll(1); countmec2/cll(2); countmec3/cll(3); countmec4/cll(4)];
cme_br = [countmec12; countmec13; countmec14; countmec23; countmec24; countmec34];
cbm_ir(:,2) = [];
cbm_ir(:,1) = [];
cbm_br(:,2) = [];
cbm_br(:,1) = [];
cme_ir(:,2) = [];
cme_ir(:,1) = [];
cme_br(:,2) = [];
cme_br(:,1) = [];
Mcbm_br = mean(cbm_br, 2);
Scbm_br = std(cbm_br, [], 2)/sqrt(28);
Mcbm_ir = mean(cbm_ir, 2);
Scbm_ir = std(cbm_ir, [], 2)/sqrt(28);
Mcme_br = mean(cme_br, 2);
Scme_br = std(cme_br, [], 2)/sqrt(28);
Mcme_ir = mean(cme_ir, 2);
Scme_ir = std(cme_ir, [], 2)/sqrt(28);

%% Plot the corresponding Bar Plots
figure; bar(100*Mcbm_ir); hold on; errorbar(100*Mcbm_ir, 100*Scbm_ir,"LineStyle","none", 'LineWidth', 2);
ylabel('Percentage (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')
xticklabels({'F', 'T', 'P', 'O'});

%
figure; bar(-100*Mcme_ir); hold on; errorbar(-100*Mcme_ir, 100*Scme_ir,"LineStyle","none", 'LineWidth', 2);
ylabel('Number of Connections (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')
xticklabels({'F', 'T', 'P', 'O'});

%
figure; bar(100*Mcbm_br); hold on; errorbar(100*Mcbm_br, 100*Scbm_br,"LineStyle","none", 'LineWidth', 2);
ylabel('Percentage (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')
xticklabels({'F-T', 'F-P', 'F-O', 'T-P', 'T-O', 'P-O'});

%
figure; bar(-100*Mcme_br); hold on; errorbar(-100*Mcme_br, 100*Scme_br,"LineStyle","none", 'LineWidth', 2);
ylabel('Number of Connections (Mean+/-SEM)','FontSize',18,'fontweight','bold')
set(gca,'FontSize',14,'fontweight','bold')
xticklabels({'F-T', 'F-P', 'F-O', 'T-P', 'T-O', 'P-O'});

%% Write the corresponding percentages on the bar plots
text(0.5, -0.7e4, append('F=', string(round(100*(Mcbm(1)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(0.5, -1e4, append('T=', string(round(100*(Mcbm(1)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');

text(1.5, -0.9e4, append('F=', string(round(100*(Mcbm(2)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(1.5, -1.2e4, append('P=', string(round(100*(Mcbm(2)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(2.5, -0.7e4, append('F=', string(round(100*(Mcbm(3)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(2.5, -1e4, append('O=', string(round(100*(Mcbm(3)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(3.5, -1.5e4, append('T=', string(round(100*(Mcbm(4)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(3.5, -1.8e4, append('P=', string(round(100*(Mcbm(4)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(4.5, -1.7e4, append('T=', string(round(100*(Mcbm(5)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(4.5, -2e4, append('O=', string(round(100*(Mcbm(5)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(5.5, -2.8e4, append('P=', string(round(100*(Mcbm(6)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');
text(5.5, -3.1e4, append('O=', string(round(100*(Mcbm(6)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

%%
text(0.5, 1e4, append('F=', string(round(100*(Mcbm(1)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(0.5, 0.7e4, append('T=', string(round(100*(Mcbm(1)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');

text(1.5, 1.2e4, append('F=', string(round(100*(Mcbm(2)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(1.5, 0.9e4, append('P=', string(round(100*(Mcbm(2)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(2.5, 1e4, append('F=', string(round(100*(Mcbm(3)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(2.5, 0.7e4, append('O=', string(round(100*(Mcbm(3)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(3.5, 1.8e4, append('T=', string(round(100*(Mcbm(4)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(3.5, 1.5e4, append('P=', string(round(100*(Mcbm(4)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(4.5, 2e4, append('T=', string(round(100*(Mcbm(5)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(4.5, 1.7e4, append('O=', string(round(100*(Mcbm(5)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(5.5, 3.1e4, append('P=', string(round(100*(Mcbm(6)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');
text(5.5, 2.8e4, append('O=', string(round(100*(Mcbm(6)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');


%%
text(0.5, 1.5e4, append('F=', string(round(100*(Mcbm(1)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(0.5, 1.2e4, append('T=', string(round(100*(Mcbm(1)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');

text(1.5, 1.7e4, append('F=', string(round(100*(Mcbm(2)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(1.5, 1.4e4, append('P=', string(round(100*(Mcbm(2)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(2.5, 1.4e4, append('F=', string(round(100*(Mcbm(3)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(2.5, 1.1e4, append('O=', string(round(100*(Mcbm(3)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(3.5, 2.4e4, append('T=', string(round(100*(Mcbm(4)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(3.5, 2.1e4, append('P=', string(round(100*(Mcbm(4)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(4.5, 2.9e4, append('T=', string(round(100*(Mcbm(5)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(4.5, 2.6e4, append('O=', string(round(100*(Mcbm(5)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(5.5, 4e4, append('P=', string(round(100*(Mcbm(6)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');
text(5.5, 3.7e4, append('O=', string(round(100*(Mcbm(6)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

%%
text(0.5, -1.5e4, append('F=', string(round(100*(Mcbm(1)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(0.5, -1.2e4, append('T=', string(round(100*(Mcbm(1)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');

text(1.5, -1.7e4, append('F=', string(round(100*(Mcbm(2)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(1.5, -1.4e4, append('P=', string(round(100*(Mcbm(2)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(2.5, -1.4e4, append('F=', string(round(100*(Mcbm(3)/cll(1)))), '%'),'FontSize',12,'fontweight','bold');
text(2.5, -1.1e4, append('O=', string(round(100*(Mcbm(3)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(3.5, -2.4e4, append('T=', string(round(100*(Mcbm(4)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(3.5, -2.1e4, append('P=', string(round(100*(Mcbm(4)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');

text(4.5, -2.9e4, append('T=', string(round(100*(Mcbm(5)/cll(2)))), '%'),'FontSize',12,'fontweight','bold');
text(4.5, -2.6e4, append('O=', string(round(100*(Mcbm(5)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

text(5.5, -4e4, append('P=', string(round(100*(Mcbm(6)/cll(3)))), '%'),'FontSize',12,'fontweight','bold');
text(5.5, -3.7e4, append('O=', string(round(100*(Mcbm(6)/cll(4)))), '%'),'FontSize',12,'fontweight','bold');

