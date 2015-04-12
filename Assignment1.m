%% Matlab-assignment
% Dynamic memory allocation

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

%% Using ()

clc
clear all

n = 1000;
v = randn(n, 1);
a = randn(n, 1);
loops = 100;

tic
for j = 1:loops
    A = v * v';
    y = A * a;
end
toc

tic
for j = 1:loops
    y = v * v' * a;
end
toc

tic
for j = 1:loops
    y = v * (v' * a);
end
toc

%% Avoiding details

clc
clear all

n = 100000;
x = 0.5 - rand(n, 1);
y = 0.5 - rand(n, 1);
loops = 1000;

tic
for j = 1:loops
    for k = 1:n
        y(k) = 1.2345e-3 * y(k) + 2.2e-3 * x(k) + x(k) * y(k);
    end
end
toc

tic
for j = 1:loops
    y = 1.2345e-3 * y + 2.2e-3 * x + x .* y;
end
toc
