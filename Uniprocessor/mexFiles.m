%% MEX-files
clc
clear all


mex -f ./mexopts.sh dgbmvTestMEX.c dgbmv.f -lblas

<<<<<<< HEAD
A = [3 2 0 0; 1 2 1 0; 0 1 10 2; 0 0 1 6]
x = [1 2 3 4]';
y = zeros(4, 1);
kl = 1;
ku = 1;
=======

A = [3 1 0 0; 1 2 1 0; 0 1 10 2; 0 0 1 6]
klA = 1;
kuA = 1;
>>>>>>> 3c74a40408849a195aac7727550e1f7a8857ef65

x = [1 2 1 2]';
y = zeros(4, 1);

%%
tic
y = A * x
toc

% Try the MEX-function
tic
y = dgbmvTestMEX(klA, kuA, A, x)
toc

%--------------------------------------------------------------------------

B = [2 2 1 1 0; 0 2 3 6 1; 0 0 5 4 1; 0 0 0 12 2; 0 0 0 0 9]
klB = 0;
kuB = 3;

x = [1 2 1 2 1]';
y = zeros(5, 1);

tic
y = B * x
toc

% Try the MEX-function
tic
y = dgbmvTestMEX(klB, kuB, B, x)
toc


%--------------------------------------------------------------------------

C = [2 2 1 1 0 0; 1 2 3 6 1 0; 1 1 5 4 1 1; 0 1 1 12 2 2; 0 0 1 1 9 1; 0 0 0 1 1 4]
klC = 2;
kuC = 3;

x = [1 2 1 2 1 2]';
y = zeros(6, 1);

tic
y = C * x
toc

% Try the MEX-function
tic
y = dgbmvTestMEX(klC, kuC, C, x)
toc

