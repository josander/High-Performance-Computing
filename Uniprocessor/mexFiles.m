%% MEX-files
% Script that calls dgbmv.f using a MEX-file, in order to compute y = A * x. 
% Three matrixes of different sizes are tested.

clc
clear all


mex -f ./mexopts.sh dgbmvTestMEX.c dgbmv.f -lblas



A = [3 3 0 0; 1 2 1 0; 0 8 10 2; 0 0 5 5]
klA = 1;
kuA = 1;

x = [1 2 1 2]';
y1 = zeros(4, 1);
y2 = zeros(4, 1);

tic
y1 = A * x
toc

% Try the MEX-function
tic
y2 = dgbmvTestMEX(klA, kuA, A, x)
toc

error = sum(y1 - y2);

if(error ~= 0)
   disp('Error for matrix A!') 
end

%--------------------------------------------------------------------------

clear all

B = [2 2 1 1 0; 0 2 3 6 1; 0 0 5 4 1; 0 0 0 12 2; 0 0 0 0 9]
klB = 0;
kuB = 3;

x = [1 2 1 2 1]';
y1 = zeros(5, 1);
y2 = zeros(5, 1);

tic
y1 = B * x
toc

% Try the MEX-function
tic
y2 = dgbmvTestMEX(klB, kuB, B, x)
toc

error = sum(y1 - y2);

if(error ~= 0)
   disp('Error for matrix B!') 
end

%--------------------------------------------------------------------------

clear all

C = [2 2 1 1 0 0; 1 2 3 6 1 0; 1 1 5 4 1 1; 0 1 1 12 2 2; 0 0 1 1 9 1; 0 0 0 1 1 4]
klC = 2;
kuC = 3;

x = [1 2 1 2 1 2]';
y1 = zeros(6, 1);
y2 = zeros(6, 1);

tic
y1 = C * x
toc

% Try the MEX-function
tic
y2 = dgbmvTestMEX(klC, kuC, C, x)
toc

error = sum(y1 - y2);

if(error ~= 0)
   disp('Error for matrix C!') 
end
