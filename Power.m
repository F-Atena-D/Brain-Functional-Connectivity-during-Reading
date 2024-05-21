
% Script Name: Power
% Author: Fatemeh Delavari
% Version: 1.0
% Description: This script calculates and plots power in the theta and alpha bands

clear; clc;  % Clear workspace and command window
tic

%% Load the EEG data
for d = 3:30
    load(sprintf('EEG_intpol_%d.mat', d), sprintf("EEG_intpol_%d", d));
    % Remove facial channels (Using pop_select from EEGLAB)
    EEG = pop_select(eval(sprintf("EEG_intpol_%d", d)), 'nochannel',{'E1','E10','E18','E25','E31','E32','E37','E46','E54','E61','E67','E68','E73','E82','E83','E91','E92','E93','E102','E145','E165','E174','E208','E209','E210','E211','E216','E217','E218','E219','E220','E221','E225','E226','E227','E228','E229','E230','E231','E232','E233','E234','E235','E236','E237','E238','E239','E240','E241','E242','E243','E244','E245','E246','E247','E248','E249','E250','E251','E252','E253','E254','E255','E256'});
    Data = EEG.data;

    D = zeros(125, 192, size(Data,3));
    for j=1:125
        D(j,:,:) = Data(:,j,:);
    end

    %% Calculate power using wavelet transform in each frequeny band
    E = reshape(D,125,[]);
    Pwr_t = zeros(size(E));
    Pwr_a = zeros(size(E));
    Pwr = zeros(size(E));

    for i=1:size(E,2)
        [wt,f] = cwt(E(:,i),'amor',250,'FrequencyLimits',[1 50]);
        Pwr_t(:,i) = sum(abs(wt(f>=4 & f<8,:)),1)';
        Pwr_a(:,i) = sum(abs(wt(f>=8 & f<12,:)),1)';
        Pwr(:,i) = sum(abs(wt(f>=1 & f<50,:)),1)';
    end

    eval(['Pwr_t_' num2str(d) ' = Pwr_t;']);
    eval(['Pwr_a_' num2str(d) ' = Pwr_a;']);
    eval(['Pwr_' num2str(d) ' = Pwr;']);
end

%% when you have calculated power for all subject, calculate average power for each subject
for d= 3:30
    mpwrt(:,d)= mean(eval(sprintf('Pwr_t_%d', d))./eval(sprintf('Pwr_%d', d)), 2);
    mpwra(:,d)= mean(eval(sprintf('Pwr_a_%d', d))./eval(sprintf('Pwr_%d', d)), 2);
end

%%
mpwrt(:, 2) = [];
mpwrt(:, 1) = [];
%
mpwra(:, 2) = [];
mpwra(:, 1) = [];

%% normalize the power in each frequency band
n = 28;
for i = 1:n
    Nmpwrt(:, i)= (mpwrt(:, i) - min(mpwrt(:, i)))/(max(mpwrt(:, i)) - min(mpwrt(:, i)));
    Nmpwra(:, i)= (mpwra(:, i) - min(mpwra(:, i)))/(max(mpwra(:, i)) - min(mpwra(:, i)));
end

%% Calculate the average and standard deviation
mmpwrt = mean(Nmpwrt, 2);
smpwrt = std(Nmpwrt, [], 2);
mmpwra = mean(Nmpwra, 2);
smpwra = std(Nmpwra, [], 2);

%% plot
figure;
% colororder({'b','m'})
yyaxis left
errorbar(4:4:500, mmpwrt, smpwrt/sqrt(n), 'LineWidth', 1.5);
set(gca, 'YColor', 'k')
ylabel('Normalized Theta Power (Mean+/-SEM)','FontSize',18,'fontweight','bold', 'color', [0 0.4470 0.7410])
xlim([0 500]);
ylim([0 1]);
yyaxis right
errorbar(4:4:500, mmpwra, smpwra/sqrt(n), 'LineWidth', 1.5, 'color', [0.4940 0.1840 0.5560]);
xlabel('Time (ms)','FontSize',18,'fontweight','bold');
set(gca, 'YColor', 'k')
ylabel('Normalized Alpha Power (Mean+/-SEM)','FontSize',18,'fontweight','bold', 'color', [0.4940 0.1840 0.5560] )
set(gca,'FontSize',14,'fontweight','bold')

toc
