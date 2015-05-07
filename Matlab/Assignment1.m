%% High performance computing
% Dynamic memory allocation

clc
clear all

n = 1000;
p = 2000;

x = randn(n, 1);

tic
X = zeros(n, p);
for k = 1:p
    X(:, k) = x;
end
toc

tic
X = [];
for k = 1:p
    X(:, k) = x; % was terrible in R2010 an earlier
end
toc

tic
X = [];
for k = 1:p
    X = [X, x]; % same speed as this one
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
for j = 1:m:n % one can try loop interchange as well
    for k = 1:m:n
        X(j, k) = 1;
    end
end
toc

% Suppose we know the sparsity structure
[rows, cols] = find(X);

tic
X = sparse(rows, cols, ones(size(rows)));
for j = 1:m:n
    for k = 1:m:n
        X(j, k) = 2; % but not the elements
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

n = 10000;
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

%% Fetch, read and run strange.m

clc
clear all

% Are you surprised by the times?
% Think about the time for s2.

n = 1000000;
a = randn(1, n);

tic
s1 = 0;
for k = 1:n
    s1 = s1 + a(k);
end
toc

tic
s2 = 0;
for k = a
    s2 = s2 + k;
end
toc

tic
s3 = 0;
k  = 1;
while k <= n
    s3 = s3 + a(k);
    k  = k + 1;
end
toc

tic
s4 = sum(a);
toc

err = [s1 s2 s3] - s4

%% Matrix multiplication

clc
clear all

A = randn(3000);

tic
  for k = 1:10
    C = A' * A;
  end
toc

tic
  for k = 1:10
    C = A * A';
  end
toc

tic
  for k = 1:10
    C = A * A;
  end
toc

%--------------------------------------------------------------------------

A = rand(3000);
B = rand(3000);

tic
  for k = 1:10
    C = A * B;
  end
toc

A = single(A);
B = single(B);

tic
  for k = 1:10
    C = A * B;
  end
toc


%%

clc
clear all

n = 100000;
a = randn(n, 1);
b = a;
c = a;
loops = 200;
a_save = a;

tic
for j = 1:loops
    for k = 1:length(a)
        if a_save(k) < 0
            a(k) = 0;
        end
    end
end
toc

% Using logical indices instead (b < 0 is an array of 1 and 0, true
% and false).
tic
for j = 1:loops
    b(a_save < 0) = 0;
end
toc

% In some applications it is more useful to get the actual indices.
tic;
for j = 1:loops
    indx = find(a_save < 0);
    c(indx) = 0;
end
toc
