%% MEX-files
clc
clear all


mex -f ./mexopts.sh dgbmvTestMEX.c dgbmv.f -lblas

n = 20;
A = [1 2 3 0; 0 1 4 1; 0 0 3 4; 0 0 0 1]
x = randn(n, 1);
y = zeros(n, 1);

y = dgbmvTestMEX(size(A,1), size(A,2), A, x)


tic
y = A * x
toc


% Try the MEX-function
tic
y = dgbmvTestMEX(size(A,1), size(A,2), A, x)
toc

