
% Script Name: TopoPlot
% Author: Fatemeh Delavari 
% Version: 1.0
% Description: This script plots Scalp EEG Topographic Plot

clear; clc;  % Clear workspace and command window
tic

%% Load the preprocessed EEG data
d = 30; % Subject you want to work on...
load(sprintf('EEG_intpol_%d.mat', d), sprintf("EEG_intpol_%d", d));
% Remove facial channels (Using pop_select from EEGLAB)
EEG = pop_select(eval(sprintf("EEG_intpol_%d", d)), 'nochannel',{'E1','E10','E18','E25','E31','E32','E37','E46','E54','E61','E67','E68','E73','E82','E83','E91','E92','E93','E102','E145','E165','E174','E208','E209','E210','E211','E216','E217','E218','E219','E220','E221','E225','E226','E227','E228','E229','E230','E231','E232','E233','E234','E235','E236','E237','E238','E239','E240','E241','E242','E243','E244','E245','E246','E247','E248','E249','E250','E251','E252','E253','E254','E255','E256'});

%% Get the locations of the EEG channels
ChLoc = struct2cell(EEG.chanlocs); 
thet = squeeze(pi/180*cell2mat(ChLoc(12,1,:)));
rho = squeeze(cell2mat(ChLoc(13,1,:)));
% Convert from Polar to Cartesian
[x, y] = pol2cart(thet, rho);

%% plot the sensors
figure;
plot(y, x ,'.','Color','r','MarkerSize', 15);

%% Plot the head and Nose :)
hold on;
% Draw a circle centered at (0,0) with radius 0.5
rectangle('Position',[-0.5, -0.5, 1, 1], 'Curvature',[1,1], 'EdgeColor','k', 'FaceColor', 'none');
% Coordinates for the triangle
XX = [0, 0.1, -0.1, 0];
YY = [0.6, 0.5, 0.5, 0.6];
% Draw a triangle at the top
line(XX, YY, 'Color', 'k');
% Setting equal axis to ensure the circle is not skewed
axis equal;
axis off;


