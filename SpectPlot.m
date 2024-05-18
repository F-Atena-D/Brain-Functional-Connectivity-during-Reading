
% Script Name: SpectPlot
% Author: Fatemeh Delavari
% Version: 1.0
% Description: This script plots Scalogram for an instance word in an instance subject

clear; clc;  % Clear workspace and command window
tic

%% Load the instance subject and select the instance word
EEG = pop_loadset('zde_004_PF.set'); 
EEG = pop_select(EEG, 'nochannel',{'E1','E10','E18','E25','E31','E32','E37','E46','E54','E61','E67','E68','E73','E82','E83','E91','E92','E93','E102','E145','E165','E174','E208','E209','E210','E211','E216','E217','E218','E219','E220','E221','E225','E226','E227','E228','E229','E230','E231','E232','E233','E234','E235','E236','E237','E238','E239','E240','E241','E242','E243','E244','E245','E246','E247','E248','E249','E250','E251','E252','E253','E254','E255','E256'});
Data = EEG.data;
E = double(squeeze(Data(:, :,2395))');

%% calculate the scalogram
for i=1: size(E,2)
    [wt,f] = cwt(E(:,i),'amor',250,'FrequencyLimits',[1 50]);
    wti(i,:,:) = wt;
    fi(i,:) = f;
end

%% plot the scalogram
figure; pcolor(4:4:500, f, squeeze(sum(abs(wti),1)));
shading interp;
cb = colorbar;
ylabel(cb,'Power (dB)','FontSize',18,'fontweight','bold');
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
ylabel('Frequency (Hz)','FontSize',18,'fontweight','bold')
set(gca, 'YScale', 'log')
set(gca,'FontSize',14,'fontweight','bold')
