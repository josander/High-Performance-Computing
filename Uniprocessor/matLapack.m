%% LAPACK - HPC
clc
clf
clear all

% [n, time, nbrOperations, Gflops]
data = dlmread('lapackData.txt');

plot(data(:, 1), data(:, 2))

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

