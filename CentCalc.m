
% Script Name: CentCalc
% Author: Fatemeh Delavari
% Version: 1.0
% Description: This script calculates eigevector centrality in the connectivity graphs

clear; clc;  % Clear workspace and command window
tic

%% load the calculated PLV
for d = 3:30 % Subject you want to work on...
    load(sprintf('plvdn%d.mat', d));
    plvt(d-2, :, :, :) = plvThetaBand;
end

%% calculate eigenvector for all subjects and time points
cntev= zeros(125, 192);
tr = .5;
for d = 1:28
    for s = 1:125
        plvs = squeeze(plvt(d, s, :, :));
        tplv = plvs;
        tplv(plvs>tr) = 1;
        tplv(plvs<tr) = 0;
        tplv(plvs==tr) = 1;
        G = graph(tplv, 'upper');
        cntev(s, :) =  centrality(G,'eigenvector');
    end
    cntevd(:, :, d) = cntev;
end

%%
save('cent.mat', 'cntevd');

%% Nodes (sensors) in each brain region
cFrontal =[2	3	4	5	6	9	10	11	12	13	14	16	17	18	19	20	21	22	23	24	25	26	27	28	29	30	31	32	33	34	35	40	41	42	183	184	185	187	188	189	191	192];
cOccipital = [88	 89	92	93	94	95	96	97	98	99	101	102	103	104	105	106	107	108	114	115	116	117	118	119	120	121	126	127	128	129	130	131	132	136	137	138	139	140	141	145	146	147	148	153	154	165	166	177];
cTemporal = [149	150	151	152	155	156	157	158	159	160	167	168	169	170	171	172	173	178	179	180	181	182	48	52	53	54	57	58	59	60	61	62	63	69	70	76	77	78	84	85	86	87 1 39 46 47 186 190];
cParietal = [7	8	15	36	37	38	43	44	45	49	50	51	55	56	64	65	66	67	68	71	72	73	74	75	79	80	81	82	83	90	91	100	109	110	111	112	113	122	123	124	125	133	134	135	142	143	144	161	162	163	164	174	175	176];

%% Calculate the average centrality of each region
mlstf = mean(reshape(cntevd(:, cFrontal, :), 125, []), 2);
slstf = std(reshape(cntevd(:, cFrontal, :), 125, []), [], 2)/sqrt(28*42);
mlstt = mean(reshape(cntevd(:, cTemporal, :), 125, []), 2);
slstt = std(reshape(cntevd(:, cTemporal, :), 125, []), [], 2)/sqrt(28*48);
mlstp = mean(reshape(cntevd(:, cParietal, :), 125, []), 2);
slstp = std(reshape(cntevd(:, cParietal, :), 125, []), [], 2)/sqrt(28*54);
mlsto = mean(reshape(cntevd(:, cOccipital, :), 125, []), 2);
slsto = std(reshape(cntevd(:, cOccipital, :), 125, []), [], 2)/sqrt(28*48);

%% plot the centrality time series
figure; errorbar(1:4:500, mlstf, slstf, 'LineWidth', 2, 'Color', 'k');
hold on; errorbar(1:4:500, mlstt, slstt, 'LineWidth', 2, 'Color', 'm');
hold on; errorbar(1:4:500, mlstp, slstp, 'LineWidth', 2, 'Color', 'g');
hold on; errorbar(1:4:500, mlsto, slsto, 'LineWidth', 2, 'Color', 'b');
xlabel('Time (ms)','FontSize',14,'fontweight', 'bold');
ylabel('Eigenvector Centrality (Mean+/-SEM)','FontSize',14,'fontweight', 'bold')
set(gca,'FontSize',14,'fontweight','bold')

%% Calculate the average Centrality of each lobe and perform statistical analysis
sf = reshape(mean(mean(cntevd(:, cFrontal, :), 2), 1), [], 1);
st = reshape(mean(mean(cntevd(:, cTemporal, :), 2), 1), [], 1);
sp = reshape(mean(mean(cntevd(:, cParietal, :), 2), 1), [], 1);
so = reshape(mean(mean(cntevd(:, cOccipital, :), 2), 1), [], 1);
[~,~,stats] = anova1([sf; st; sp; so], [ones(size(sf)); 2*ones(size(st)); 3*ones(size(sp)); 4*ones(size(so))]);
[c,~,~,gnames] = multcompare(stats);

