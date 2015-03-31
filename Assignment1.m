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

%--------------------------------------------------------------------------

n = 30000;
m = 150;

tic
    X = sparse(n, n);
    for j = 1:m:n
        for k = 1:m:n
            X(j, k) = 1;
        end
    end
toc

[rows, cols] = find(X);

tic
    X = sparse(rows, cols, ones(size(rows)));
    for j = 1:m:n
        for k = 1:m:n
            X(j, k) = 2;
        end
    end
toc

tic
    X = sparse(rows, cols, ones(size(rows)));
toc