%% MEX-files
clc
clear all


mex -f ./mexopts.sh dgbmvTestMEX.c dgbmv.f -lblas

A = [3 1 1 0; 1 4 1 1; 0 1 10 2; 0 0 1 4]
x = [1 2 3 4]';
y = zeros(4, 1);


tic
y = A * x
toc

%%
% Try the MEX-function
tic
y = dgbmvTestMEX(size(A,1), size(A,2), A, x)
toc

