%% LAPACK - HPC
clc
clf
clear all
set(0,'defaulttextinterpreter','latex')

% [n, time, nbrOperations, Gflops]
refData = dlmread('RefData.txt');
netlibData = dlmread('NLData.txt');
oBlas1Data = dlmread('oBlas1TData.txt');
oBlas2Data = dlmread('oBlas2TData.txt');
oBlas3Data = dlmread('oBlas3TData.txt');
oBlas4Data = dlmread('oBlas4TData.txt');
lapac1Data = dlmread('lapackData.txt');

%% Nice plot

set(gcf,'renderer','painters','PaperPosition',[-0.3 -0 16 12]);

plot(refData(:, 1), refData(:, 4),refData(:, 1), netlibData(:, 4),refData(:, 1), oBlas1Data(:, 4),refData(:, 1), oBlas2Data(:, 4),refData(:, 1), oBlas3Data(:, 4),refData(:, 1), oBlas4Data(:, 4),refData(:, 1), lapac1Data(:, 4))

x = xlabel('Size of matrix n x n');
y = ylabel('Speed [Gflop/s] ');

l = legend('Our \texttt{DPOTRF}', 'Netlib \texttt{DPOTRF}', 'OpenBlas 1 thread','OpenBlas 2 threads','OpenBlas 3 threads','OpenBlas 4 threads', 'Linux Lapack');
title('Speed of \texttt{DPOTRF}', 'FontSize', 14);
%set(y, 'Units', 'Normalized', 'Position', [-0.085, 0.5, 0]);
%set(x, 'Units', 'Normalized', 'Position', [0.5, -0.15, 0]);
plotTickLatex2D
set(l,'interpreter', 'latex')
print(gcf,'-depsc2','lapack.eps')

%%
set(gcf,'renderer','painters','PaperPosition',[-0.3 -0 16 12]);

loglog(refData(:, 1), refData(:, 2),refData(:, 1), netlibData(:, 2),refData(:, 1), oBlas1Data(:, 2),refData(:, 1), oBlas2Data(:, 2),refData(:, 1), oBlas3Data(:, 2),refData(:, 1), oBlas4Data(:, 2),refData(:, 1), lapac1Data(:, 2))

x = xlabel('Size of matrix n x n');
y = ylabel('Time [s] ');

l = legend('Our \texttt{DPOTRF}', 'Netlib \texttt{DPOTRF}', 'OpenBlas 1 thread','OpenBlas 2 threads','OpenBlas 3 threads','OpenBlas 4 threads', 'Linux Lapack');
title('Speed of \texttt{DPOTRF}', 'FontSize', 14);
%set(y, 'Units', 'Normalized', 'Position', [-0.085, 0.5, 0]);
%set(x, 'Units', 'Normalized', 'Position', [0.5, -0.15, 0]);
%axis([0 5000 0 10])
plotTickLatex2D
set(l,'interpreter', 'latex', 'location', 'NorthWest')
print(gcf,'-depsc2','lapackTime.eps')

