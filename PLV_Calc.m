
% Script Name: PLV_Calc
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script calculates PLV connectivity of preprocessed EEG

clear; clc;  % Clear workspace and command window
tic

%%
% Load the preprocessed EEG data
d = 30; % Subject you want to work on...
load(sprintf('EEG_intpol_%d.mat', d), sprintf("EEG_intpol_%d", d));
% Remove facial channels (Using pop_select from EEGLAB
EEG = pop_select(eval(sprintf("EEG_intpol_%d", d)), 'nochannel',{'E1','E10','E18','E25','E31','E32','E37','E46','E54','E61','E67','E68','E73','E82','E83','E91','E92','E93','E102','E145','E165','E174','E208','E209','E210','E211','E216','E217','E218','E219','E220','E221','E225','E226','E227','E228','E229','E230','E231','E232','E233','E234','E235','E236','E237','E238','E239','E240','E241','E242','E243','E244','E245','E246','E247','E248','E249','E250','E251','E252','E253','E254','E255','E256'});

%%
% Filter the data in the frequency band of interest and Calculate Phase Locking Value
eegData = EEG.data;
srate = 250; %Hz
%%
filtSpec.order = 150; % theta -Hz
filtSpec.range = [4 8]; % theta -Hz
[plvThetaBand] = eegPLV(eegData(:,:,:), srate, filtSpec);
%%
filtSpec.order = 100; % alpha -Hz
filtSpec.range = [8 12]; % alpha -Hz
[plvAlphaBand] = eegPLV(eegData(:,:,:), srate, filtSpec);
%%
filtSpec.order = 50; % beta -Hz
filtSpec.range = [12 30];  % beta -Hz
[plvBetaBand] = eegPLV(eegData(:,:,:), srate, filtSpec);
%%
filtSpec.order = 25; % gamma -Hz
filtSpec.range = [30 50]; % gamma -Hz
[plvGammaBand] = eegPLV(eegData(:,:,:), srate, filtSpec);

% Save the calculated PLV
save(sprintf('plvdn%d.mat', d), 'plvThetaBand', 'plvAlphaBand', 'plvBetaBand', 'plvGammaBand')

toc
