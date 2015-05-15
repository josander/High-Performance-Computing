%% LAPACK - HPC
clc
clf
clear all

% [n, time, nbrOperations, Gflops]
refData = dlmread('RefData.txt');
netlibData = dlmread('NLData.txt');
oBlas1Data = dlmread('oBlas1TData.txt');
oBlas2Data = dlmread('oBlas2TData.txt');
oBlas3Data = dlmread('oBlas3TData.txt');
oBlas4Data = dlmread('oBlas4TData.txt');
lapac1Data = dlmread('lapackData.txt');
lapacOB4Data = dlmread('lapackoBlas4TData.txt');
%%
plot(refData(:, 1), refData(:, 4),refData(:, 1), netlibData(:, 4),refData(:, 1), oBlas1Data(:, 4),refData(:, 1), oBlas2Data(:, 4),refData(:, 1), oBlas3Data(:, 4),refData(:, 1), oBlas4Data(:, 4),refData(:, 1), lapac1Data(:, 4),refData(:, 1), lapacOB4Data(:, 4))
legend('Ref', 'Netlib', 'OB1','OB2','OB3','OB4', 'llapack1', 'llapackOB4')
%% Nice plot

set(gcf,'renderer','painters','PaperPosition',[-0.3 -0 16 12]);

plot(data(:, 1), data(:, 2))
x = xlabel('n');
y = ylabel('Time');

title('Relative difference in signal');
set(y, 'Units', 'Normalized', 'Position', [-0.085, 0.5, 0]);
set(x, 'Units', 'Normalized', 'Position', [0.5, -0.085, 0]);
plotTickLatex2D
print(gcf,'-depsc2','lapack.eps')

