%% Matlab-assignment

clc
clear all

n = 1000;
p = 2000;
x = rand(n, 1);

tic 
    X = zeros(n, p);
    for k = 1:p
        X(:, k) = x;
    end
toc

tic
    X = [];
    for k = 1:p
        X(:, k) = x;
    end
toc

tic
    X = [];
    for k = 1:p
        X = [X, x];
    end
toc

%--------------------------------------------------------------------------

x = x';

tic 
    X = zeros(p, n);
    for k = 1:p
        X(k, :) = x;
    end
toc

tic
    X = [];
    for k = 1:p
        X(k, :) = x;
    end
toc

tic
    X = [];
    for k = p:-1:1
        X(k, :) = x;
    end
toc

