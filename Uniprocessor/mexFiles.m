%% MEX-files
clc
clear all


mex -f ./mexopts.sh dgbmvTestMEX.c dgbmv.f -lblas

A = [3 2 0 0; 1 2 1 0; 0 1 10 2; 0 0 1 6]
x = [1 2 3 4]';
y = zeros(4, 1);
kl = 1;
ku = 1;


tic
y = A * x
toc


% Try the MEX-function
tic
y = dgbmvTestMEX(kl, ku, A, x)
toc

