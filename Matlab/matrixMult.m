%% Matrix multiplication

clc
clear all

A = randn(3000);

tic
  for k = 1:10
    C = A' * A;
  end
toc

C(1:5,1:5)

tic
  for k = 1:10
    C = (A * A')';
  end
toc

C(1:5,1:5)

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