clc

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
    X(:, k) = x;  % was terrible in R2010 an earlier
  end
toc

tic
  X = [];
  for k = 1:p
    X = [X, x];  % same speed as this one
  end
toc
%%
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
%%

n = 30000;
m = 150;
tic
  X = sparse(n, n);
  for j = 1:m:n       % one can try loop interchange as well
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
      X(j, k) = 2;  % but not the elements
    end
  end
toc

tic
  X = sparse(rows, cols, ones(size(rows)));
toc